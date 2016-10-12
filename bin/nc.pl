#! /usr/bin/perl
# Poor man's Netcat, the famous "TCP/IP swiss army knife"
# Only the basic functions are replicated : 
# - TCP only
# - only : "hostname port" or "-l" with "-p port" 

use strict;
use warnings;

use IO::Socket;
use Getopt::Long;

my $help;
my $verbose;

my $local_port;
my $listen;

$SIG{CHLD} = 'IGNORE';

my $result = GetOptions(
        "help|h" => \$help,
        "verbose|v" => \$verbose,

        "local-port|p=i" => \$local_port,
        "listen|l" => \$listen,
);

if ($help) {
        print STDERR "Perl loose port of netcat(1)\n";
        print STDERR "usage : $0 [-p local_port] hostname port (client)\n";
        print STDERR "   or : $0 -l -p local_port (server)\n";
        exit(1);
}
        
# No need to close the socks as they are closed 
# when going out-of-scope
if ($listen) {
        if (! $local_port) {
                die "You must specify the port to listen to in server mode\n";
        }

        # server mode
        my $l_sock = IO::Socket::INET->new(
                Proto => "tcp",
                LocalPort => $local_port,
                Listen => 1,
                Reuse => 1,
        ) or die "Could not create socket: $!";

        my $a_sock = $l_sock->accept(); 
        $l_sock->shutdown(SHUT_RDWR);
        copy_data_bidi($a_sock);
} else {
        if (scalar @ARGV < 2) {
                die "You must specify where to connect in client mode\n";
        }

        my ($remote_host, $remote_port) = @ARGV;

        # client mode
        my $c_sock = IO::Socket::INET->new(
                Proto => "tcp",
                LocalPort => $local_port,
                PeerAddr => $remote_host,
                PeerPort => $remote_port,
        ) or die "Could not create socket: $!";

        copy_data_bidi($c_sock);
}

sub copy_data_bidi {
        my ($socket) = @_;
        my $child_pid = fork();
        if (! $child_pid) {
                close(STDIN);
                copy_data_mono($socket, *STDOUT);
                $socket->shutdown(SHUT_RD);
                exit(); # exits the child helper process
        } else {
                close(STDOUT);
                copy_data_mono(*STDIN, $socket);
                $socket->shutdown(SHUT_WR);
                kill("TERM", $child_pid);
        }
}

sub copy_data_mono {
        my ($src, $dst) = @_;

        my $buf;
        while (my $read_len = sysread($src, $buf, 4096)) {
                my $write_len = $read_len;
                while ($write_len) {
                        my $written_len = syswrite($dst, $buf);
                        return unless $written_len; # $dst is closed
                        $write_len -= $written_len;
                }
        }
}


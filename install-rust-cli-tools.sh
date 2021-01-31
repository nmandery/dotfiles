#!/bin/bash

set -eu

# resources:
# - https://zaiste.net/posts/shell-commands-rust/


function ci {
    # install via git
    cargo install --root $HOME $*
    echo "----------------"
}

# bat is a cat clone with syntax highlighting and Git integration
# ... lots of git submodules in clone
ci bat

# exa is a modern replacement for ls, the default command-line 
# program in Unix/Linux for listing directory contents.
ci exa # https://github.com/ogham/exa.git

# fd is a fast and user-friendly alternative to find, the built-in 
# command-line program in Unix/Linux for walking a file hierarchy. 
# fd provides opinionated defaults for the most common use cases.
ci fd-find #--git https://github.com/sharkdp/fd.git

# procs is a modern replacement for ps, the default command-line program
# in Unix/Linux for getting information about processes. It provides
# convenient, human-readable (and colored) output format by default.
ci procs #--git https://github.com/dalance/procs.git

# sd is an intuitive find & replace command-line tool, it is an
# alternative to sed, the built-in command-line program in Unix/Linux for
# parsing and transforming text (). sd has simpler syntax for replacing
# all occurrences and it uses the convenient regex syntax that you already
# know from JavaScript and Python. sd is also 2x-11x faster than sed.
ci sd #--git https://github.com/chmln/sd.git

# dust is a more intuitive version of du, the built-in command-line
# program in Unix/Linux for displaying disk usage statistics. By default
# dust sorts the directories by size.
ci du-dust # --git https://github.com/bootandy/dust.git

# ripgrep is an extremely fast alternative to grep
ci ripgrep #--git https://github.com/BurntSushi/ripgrep.git
ln -sf ~/bin/rg ~/bin/ripgrep

# hyperfine is a command-line benchmarking tool. Among many features,
# it provides statistical analysis across multiple runs, support for
# arbitrary shell commands, constant feedback about the benchmark progress
# and current estimates and more.
ci hyperfine #--git https://github.com/sharkdp/hyperfine.git

# tokei is a program that displays statistics about your code. It shows
# the number of files, total lines within those files and code, comments,
# and blanks grouped by language.
ci tokei # --git https://github.com/XAMPPRocky/tokei.git

# ytop is an alternative to top, the built-in command-line program in
# Unix/Linux for displaying information about processes.
ci ytop 

# bandwhich is a CLI utility for displaying current network utilization
# by process, connection and remote IP or hostname.
ci bandwhich #--git https://github.com/imsnif/bandwhich.git

# grex is a command-line tool and library for generating regular
# expressions from user-provided test cases.
ci grex #--git https://github.com/pemistahl/grex.git

# A new way to see and navigate directory trees
ci broot #--git https://github.com/Canop/broot.git

# Svgbob is an ascii to svg converter
#ci --git https://github.com/ivanceras/svgbob.git

# nushell is a new type of shell, written in Rust. Its goal is to create
# a modern shell alternative that's still based on the Unix philosophy,
# but adapted to the current era. It supports piping and filtering in a
# way similar to awk and sed with a column view so that you can combine
# operations like in SQL.
ci nu --features "stable" #--git https://github.com/nushell/nushell.git

# Half of our life is spent on navigation: files, lines, commands…
# You need skim! It is a general fuzzy finder that saves you time.
ci skim #--git https://github.com/lotabout/skim.git

# dua (-> Disk Usage Analyzer) is a tool to conveniently learn about the
# usage of disk space of a given directory. It's parallel by default and
# will max out your SSD, providing relevant information as fast as possible.
ci dua-cli #--git https://github.com/Byron/dua-cli.git

# The minimal, blazing-fast, and infinitely customizable prompt for any shell! 
ci starship
nu <<EOF
config set use_starship \$true
EOF

# Pueue is a command-line task management tool for sequential and parallel
# execution of long-running tasks.
#
# Simply put, it's a tool that processes a queue of shell commands. On top of
# that, there are a lot of convenience features and abstractions.
ci pueue

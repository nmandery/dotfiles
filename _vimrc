
"
" Links:
" - http://mislav.uniqpath.com/2011/12/vim-revisited/


"
" Syntax Highlighting
"


"set t_Co=256
"let g:zenburn_high_Contrast = 1
"colorscheme zenburn
"hi search ctermbg=223 ctermfg=238
"hi incsearch ctermbg=216 ctermfg=242

if has("gui_running")
  "switch toolbar off
  set tb=
  set guioptions-=T

  colorscheme fruity
  "set guifont=Monaco:h12
else
   colorscheme desert
endif

" utf-8 default encoding
" ----------------------
set enc=utf-8

" My PC is fast enough, do syntax highlight syncing from start
autocmd BufEnter * :syntax sync fromstart
syntax on

" create a timestamped backup in <F12>
map <F12> :!cp % %.bak_at_$(date +"\%H\%M\%S")<CR><CR>

" remove excess space at line endings
map <F11> :%s/[ \t]*$//g<CR>:noh<CR>

" nerdtree plugin http://www.vim.org/scripts/script.php?script_id=1658
map <F2> :NERDTreeToggle<cr>

" taglist plugin http://sourceforge.net/projects/vim-taglist/files/
map <F3> :TlistToggle<cr>

" 
" +----------------------------------------------------------------------+
" |  Text Formating -- common settings                                   |
" |  ... are sometimes replaced depended on the programming language     |
" |  see below.
" +----------------------------------------------------------------------+
set ai " autoindent
set si " smartindent 
" set cindent " do c-style indenting
set tabstop=4 " tab spacing (settings below are just to unify it)
set softtabstop=4 " unify
set shiftwidth=4 " unify 
set backspace=indent,eol,start
" set noexpandtab " real tabs please!
set expandtab " real tabs please!
set nowrap " do not wrap lines  
set smarttab " use tabs at the start of a line, spaces elsewhere


"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" spacing highlighting
"highlight BadSpacing term=standout ctermbg=cyan
"augroup Spacing
"    autocmd!
    " Highlight tabulators and trailing spaces (nasty bastards)
    " autocmd BufNewFile,BufReadPre * match BadSpacing /\(\t\|  *$\)/
    " Highlight trailing spaces
    " autocmd BufNewFile,BufReadPre * match BadSpacing /\(  *$\)/
    " Only highlight trailing space in tab-filled formats
"    autocmd FileType help,make match BadSpacing /  *$/
"augroup END




filetype on
filetype plugin on


" +----------------------------------------------------------------------+
" |  python support                                                      |
" +----------------------------------------------------------------------+
"  don't highlight exceptions and builtins. I love to override them in local
"  scopes and it sucks ass if it's highlighted then. And for exceptions I
"  don't really want to have different colors for my own exceptions ;-)
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 cindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType python let python_highlight_all=1
autocmd FileType python let python_highlight_exceptions=0
autocmd FileType python let python_highlight_builtins=0
if exists("+omnifunc")
  autocmd FileType python set omnifunc=pythoncomplete#Complete
endif

" interpret waf build scripts as python code
autocmd BufNewFile,BufRead wscript setlocal ft=python
" fabric files
autocmd BufNewFile,BufRead fabfile setlocal ft=python

" syntax checking
"autocmd FileType python setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd FileType python setlocal makeprg=pyflakes\ %
autocmd FileType python setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd FileType python map <F10> :make<CR>

" header for python scripts
autocmd FileType python iab hdr 
\<CR>#!/usr/bin/env python
\<CR># -*- coding: utf-8 -*-
\<CR>"""
\<CR>... desription of file ...
\<CR>"""

" +----------------------------------------------------------------------+
" |  php support                                                         |
" +----------------------------------------------------------------------+
autocmd BufNewFile,BufRead *.phtml setlocal ft=php
autocmd BufNewFile,BufRead *.php.dist setlocal ft=php
if exists("+omnifunc")
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
endif

" syntax checking
autocmd FileType php setlocal makeprg=php\ -l\ %
autocmd FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l
autocmd FileType php map <F10> :make<CR>

" phpmd
autocmd FileType php map <F9> :! phpmd % text codesize,unusedcode,naming<CR>

" tab settings for php
autocmd FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4

" abbrewations. important: space after name. i.e. 'iab X '
autocmd FileType php iab cls 
\<CR>/**
\<CR>* Short description for class
\<CR>*
\<CR>* Long description for class (if any)...
\<CR>*
\<CR>* Space between paragraphs.  Lines wrap at 80 characters.  Long paragraphs are
\<CR>*     indented with four extra spaces.  Lorem ipsum dolor sit amet,
\<CR>*     consectetuer adipiscing elit. Phasellus ornare.  Integer luctus lectus
\<CR>*     sed est.  Suspendisse potenti.  Aliquam nec mi. Sed nec sapien.
\<CR>*
\<CR>*/

autocmd FileType php iab fnc 
\<CR>/**
\<CR>* Does something interesting
\<CR>*
\<CR>* @param  Place    $where  Where something interesting takes place
\<CR>* @param  integer  $repeat How many times something interesting should happen
\<CR>* @throws Some_Exception_Class If something interesting cannot happen
\<CR>* @return Status
\<CR>*/ 

autocmd FileType php iab hdr 
\<CR>/**
\<CR>* Short description for file
\<CR>*
\<CR>* Long description for file (if any)...
\<CR>*
\<CR>* @copyright  2012 geOps
\<CR>* @link       http://www.geops.de
\<CR>*/

" convert short tags to their long counterparts
"autocmd FileType php iab <?= <?php echo
autocmd FileType php iab <? <?php

" +----------------------------------------------------------------------+
" |  CSS                                                                 |
" +----------------------------------------------------------------------+
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
if exists("+omnifunc")
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
endif


" +----------------------------------------------------------------------+
" |  rst                                                                 |
" +----------------------------------------------------------------------+
autocmd BufNewFile,BufRead *.txt setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4


" +----------------------------------------------------------------------+
" |  vim                                                                 |
" +----------------------------------------------------------------------+
autocmd FileType vim setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4


" +----------------------------------------------------------------------+
" |  Javascript                                                          |
" +----------------------------------------------------------------------+
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript let javascript_enable_domhtmlcss=1
if exists("+omnifunc")
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
endif


" +----------------------------------------------------------------------+
" |  D                                                                   |
" +----------------------------------------------------------------------+
autocmd FileType d setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=2


" +----------------------------------------------------------------------+
" |  HTML                                                                |  
" +----------------------------------------------------------------------+
if exists("+omnifunc")
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
endif
autocmd FileType html map <F9> :%! tidy -i -f /tmp/htmlerrors.txt<CR>
autocmd FileType html map <F8> :%! html2text -utf8<CR>


" +----------------------------------------------------------------------+
" |  XML, XSLT                                                           |
" +----------------------------------------------------------------------+
if exists("+omnifunc")
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
endif
" validate xml -- needs libxml2-utils
autocmd FileType xml map <F10> :! xmllint --valid --noout %<CR>
autocmd FileType xslt map <F10> :! xmllint --valid --noout %<CR>
" format xml -- needs libxml2-utils
autocmd FileType xml map <F9> :%! xmllint --format --nowarning --recover -<CR>
autocmd FileType xslt map <F9> :%! xmllint --format --nowarning --recover -<CR>


" +----------------------------------------------------------------------+
" |  SQL                                                                 | 
" +----------------------------------------------------------------------+
if exists("+omnifunc")
  autocmd FileType sql set omnifunc=sqlcomplete#Complete
endif

autocmd FileType sql iab fnc 
\<CR>/**
\<CR>* Description 
\<CR>* 
\<CR>* Copyright  2010 geOps
\<CR>* License    http://www.geops.de/license.txt
\<CR>* Bug        Bug 666
\<CR>* Link       http://www.geops.de 
\<CR>**/


autocmd FileType sql iab sec 
\<CR>--------------------------------------------------------------
\<CR>-- 
\<CR>--------------------------------------------------------------<up><right><right>

" no byte order makr in sql files -- causes problems with pgsql
autocmd FileType sql set nobomb

" +----------------------------------------------------------------------+
" |  C                                                                   |
" +----------------------------------------------------------------------+
if exists("+omnifunc")
  autocmd FileType c set omnifunc=ccomplete#Complete
endif


" +----------------------------------------------------------------------+
" |  Lua                                                                 |
" +----------------------------------------------------------------------+

autocmd FileType lua map <F10> :!luac -p %<CR>


" +----------------------------------------------------------------------+
" |  Vala                                                                |
" +----------------------------------------------------------------------+
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

" +----------------------------------------------------------------------+
" |  Protobuf                                                            |
" +----------------------------------------------------------------------+
au BufRead,BufNewFile *.proto            setfiletype proto

" +----------------------------------------------------------------------+
" |  INI-Files                                                           |
" +----------------------------------------------------------------------+

autocmd BufNewFile,BufRead *.ini.dist setlocal ft=dosini

" +----------------------------------------------------------------------+
" |  go language                                                         |
" +----------------------------------------------------------------------+
au BufRead,BufNewFile *.go            setfiletype go


"
" NERDTree config
"
" ignore some file types
let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$']


" 
"

if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
  \       if &omnifunc == "" |
  \               setlocal omnifunc=syntaxcomplete#Complete |
  \       endif
endif


function FormatXml()
    %s:\(\S\)\(<[^/]\)\|\(>\)\(</\):\1\3\r\2\4:g
    set filetype=xml
    normal gg=G
endfunction
command FormatXml :call FormatXml()



" ack plugin
let g:ackprg="ack-grep -H --nocolor --nogroup --column"


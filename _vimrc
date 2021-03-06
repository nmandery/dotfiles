
"
" Stuff to remember
" =================
"
" Autocomplete: ctrl-p or ctrl-n for a menu
" Convert tabs -> spaces: :retab
"
" Links:
" -----
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
endif

colorscheme desert

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
set modeline " enable modelines - allows storing vim settings in the files edited.
" modeline example (to be stored in a comment block ):
" // vim: tabstop=2 shiftwidth=2 


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

set ruler "Always show current position

" Match version control conflict markers.
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" No sound on errors and no visual flashes
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

filetype on
filetype plugin on

" autocomlete on tab-press for vim commands (like :e)
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*.pyo,*.so,*.sw*,__pycache__


" rainbow_parentheses
" https://github.com/kien/rainbow_parentheses.vim
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0


" surround plugin
" https://github.com/tpope/vim-surround
"
" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML
" tags, and more. The plugin provides mappings to easily delete, change and
" add such surroundings in pairs.
"
" It's easiest to explain with examples. Press cs"' inside
"
" "Hello world!"
"
" to change it to
"
" 'Hello world!'
"
" Now press cs'<q> to change it to
"
" <q>Hello world!</q>
"
" To go full circle, press cst" to get
"
" "Hello world!"
"
" To remove the delimiters entirely, press ds".
"
" Hello world!
"
" Now with the cursor on "Hello", press ysiw] (iw is a text object).
"
" [Hello] world!
"
" Let's make that braces and add some space (use } instead of { for no space):
" cs]{
"
" { Hello } world!
"
" Now wrap the entire line in parentheses with yssb or yss).
"
" ({ Hello } world!)
"
" Revert to the original text: ds{ds)
"
" Hello world!
"
" Emphasize hello: ysiw<em>
"
" <em>Hello</em> world!
"
" Finally, let's try out visual mode. Press a capital V (for linewise visual
" mode) followed by S<p class="important">.
"
" <p class="important">
"   <em>Hello</em> world!
"   </p>
"
"

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
if executable("pyflakes")
    autocmd FileType python setlocal makeprg=pyflakes\ %
    autocmd FileType python setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    autocmd FileType python map <F10> :make<CR>
endif

" header for python scripts
autocmd FileType python iab hdr 
\#!/usr/bin/env python
\<CR># -*- coding: utf-8 -*-
\<CR>"""
\<CR>... desription of file ...
\<CR>"""


" +----------------------------------------------------------------------+
" |  CSS                                                                 |
" +----------------------------------------------------------------------+
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4


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

" +----------------------------------------------------------------------+
" |  D                                                                   |
" +----------------------------------------------------------------------+
autocmd FileType d setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=2


" +----------------------------------------------------------------------+
" |  HTML                                                                |  
" +----------------------------------------------------------------------+
if executable("tidy")
    autocmd FileType html map <F9> :%! tidy -i -f /tmp/htmlerrors.txt<CR>
endif
if executable("html2text")
    autocmd FileType html map <F8> :%! html2text -utf8<CR>
endif

" +----------------------------------------------------------------------+
" |  XML, XSLT                                                           |
" +----------------------------------------------------------------------+
" validate xml -- needs libxml2-utils
if executable("xmllint")
    autocmd FileType xml map <F10> :! xmllint --valid --noout %<CR>
    autocmd FileType xslt map <F10> :! xmllint --valid --noout %<CR>
    " format xml -- needs libxml2-utils
    autocmd FileType xml map <F9> :%! xmllint --format --nowarning --recover -<CR>
    autocmd FileType xslt map <F9> :%! xmllint --format --nowarning --recover -<CR>
endif


" +----------------------------------------------------------------------+
" |  SQL                                                                 | 
" +----------------------------------------------------------------------+

" format depends on psqlchunks
if executable("psqlchunks")
    autocmd FileType sql map <F9> :%! psqlchunks -F echo  -<CR>
endif

autocmd FileType sql iab fnc 
\<CR>/**
\<CR>* Description 
\<CR>* 
\<CR>* Copyright  2012 geOps
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


" +----------------------------------------------------------------------+
" |  Lua                                                                 |
" +----------------------------------------------------------------------+
if executable("luac")
    autocmd FileType lua map <F10> :!luac -p %<CR>
endif



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
autocmd FileType go setlocal noet ts=4 sw=4 sts=4

" +----------------------------------------------------------------------+
" |  clojure language                                                    |
" +----------------------------------------------------------------------+
au BufRead,BufNewFile *.clj           setfiletype clojure
autocmd FileType clojure RainbowParenthesesLoadRound
autocmd FileType clojure RainbowParenthesesLoadBraces
autocmd FileType clojure RainbowParenthesesLoadSquare
autocmd FileType clojure RainbowParenthesesToggle
autocmd FileType clojure setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2


" +----------------------------------------------------------------------+
" |  rust                                                                |
" +----------------------------------------------------------------------+
au BufRead,BufNewFile *.rs            setlocal filetype=rust




"
" NERDTree config
" nerdtree plugin http://www.vim.org/scripts/script.php?script_id=1658
"
" ignore some file types
let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$']
map <F2> :NERDTreeToggle<cr>


" 
"

" if has("autocmd") && exists("+omnifunc")
"  autocmd Filetype *
"  \       if &omnifunc == "" |
"  \               setlocal omnifunc=syntaxcomplete#Complete |
"  \       endif
" endif


"function FormatXml()
"    %s:\(\S\)\(<[^/]\)\|\(>\)\(</\):\1\3\r\2\4:g
"    set filetype=xml
"    normal gg=G
"endfunction
"command FormatXml :call FormatXml()


" ack plugin
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" line numbering relative to current line
" use Ctrl+L to toggle the line number counting method
function! g:ToggleNuMode()
  if &nu == 1
     set rnu
  else
     set nu
  endif
endfunction

" show line numbers
set number
if has('rnu')
    set rnu
    nnoremap <silent><C-L> :call g:ToggleNuMode()<cr>
endif



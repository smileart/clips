se nocp
set t_ut=""
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/gruvbox/colors/gruvbox.vim'
runtime plugin/netrwPlugin.vim
if exists('g:loaded_rstacruz_vim_opinion') || &compatible
  finish
else
  let g:loaded_rstacruz_vim_opinion = 1
endif

set autowrite
set autowriteall

"
" Options
"

set history=50                  "hi:    keep 50 lines of command line history
set ruler                       "ru:    show the cursor position all the time
set showcmd                     "sc:    display incomplete commands
set hidden                      "hid:   don't care about closing modified buffers
set winminheight=0              "wmh:   allow showing windows as just status bars
set mouse=a                     "       Enable the use of a mouse
set nowrap                      "       soft-wrapping is off by default

"
" Folding
"

set foldmethod=syntax           "fdm:   fold by the indentation by default
set foldnestmax=10              "fdn:   deepest fold is 10 levels
set nofoldenable                "nofen: don't fold by default
set foldlevel=1

"
" Search
"

set incsearch                   "is:    automatically begins searching as you type
set ignorecase                  "ic:    ignores case when pattern matching
set smartcase                   "scs:   ignores ignorecase when pattern contains uppercase characters
set hlsearch                    "hls:   highlights search results; ctrl-n or :noh to unhighlight
set gdefault                    "gd:    Substitute all matches in a line by default

"
" Programming
"

syntax on                       "syn:   syntax highlighting
set cindent                     "cin:   enables automatic indenting c-style
set cinoptions=l1,j1            "cino:  affects the way cindent reindents lines
set showmatch                   "sm:    flashes matching brackets or parenthasis
set matchtime=3                 "mat:   How long to flash brackets

"
" Tabs
"

set tabstop=2                   "ts:    number of spaces that a tab renders as
set shiftwidth=2                "sw:    number of spaces to use for autoindent
set softtabstop=2               "sts:   number of spaces that tabs insert
set smarttab                    "sta:   helps with backspacing because of expandtab
set expandtab                   "et:    uses spaces instead of tab characters

"
" Backups
"

set nobackup                    "nobk:  in this age of version control, who needs it
set nowritebackup               "nowb:  don't make a backup before overwriting
set noswapfile                  "noswf: don't litter swap files everywhere
set directory=/tmp              "dir:   directory for temp files

"
" Hud and status info
"

set number                      "nu:    numbers lines
set numberwidth=5               "nuw:   width of number column
set showmode                    "smd:   shows current vi mode in lower left
set cmdheight=1                 "ch:    make a little more room for error messages
set scrolloff=4                 "so:    places a couple lines between the current line and the screen edge
set sidescrolloff=2             "siso:  places a couple lines between the current column and the screen edge
set laststatus=2                "ls:    makes the status bar always visible
set ttyfast                     "tf:    improves redrawing for newer computers
set lazyredraw                  "lz:    will not redraw the screen while running macros (goes faster)

"
" Encryption
"

if has('cryptv')
  if v:version > 704 || v:version == 704 && has('patch399')
    set cryptmethod=blowfish2   "cm:    make encryption the most secure
  elseif v:version >= 703
    set cryptmethod=blowfish    "cm:    make encryption more secure than pkzip
  endif
endif

if has('linebreak')
  try
    set breakindent             "bri:   visually indent wrapped lines
    let &showbreak='↳'
  catch /E518:/
    " Unknown option: breakindent
  endtry
endif

"
" Menu compilation
"

set wildmenu                    "wmnu:  enhanced ed command completion
set wildignore+=*.~             "wig:   ignore compiled objects and backups
set wildignore+=*.o,*.obj,*.pyc
set wildignore+=.sass-cache,tmp
set wildignore+=node_modules
set wildignore+=log,logs
set wildignore+=vendor
set wildmode=longest:full,list:full

"
" Shell (neovim)
"

if $SHELL !=# "" | set shell=$SHELL | endif
" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 'yes'
endif

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options
set viewoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" vim:set ft=vim et sw=2:
" sleuth.vim - Heuristically set buffer options
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.1
" GetLatestVimScripts: 4375 1 :AutoInstall: sleuth.vim

if exists("g:loaded_sleuth") || v:version < 700 || &cp
  finish
endif
let g:loaded_sleuth = 1

function! s:guess(lines) abort
  let options = {}
  let heuristics = {'spaces': 0, 'hard': 0, 'soft': 0}
  let ccomment = 0
  let podcomment = 0
  let triplequote = 0
  let backtick = 0
  let xmlcomment = 0
  let softtab = repeat(' ', 8)

  for line in a:lines
    if !len(line) || line =~# '^\s*$'
      continue
    endif

    if line =~# '^\s*/\*'
      let ccomment = 1
    endif
    if ccomment
      if line =~# '\*/'
        let ccomment = 0
      endif
      continue
    endif

    if line =~# '^=\w'
      let podcomment = 1
    endif
    if podcomment
      if line =~# '^=\%(end\|cut\)\>'
        let podcomment = 0
      endif
      continue
    endif

    if triplequote
      if line =~# '^[^"]*"""[^"]*$'
        let triplequote = 0
      endif
      continue
    elseif line =~# '^[^"]*"""[^"]*$'
      let triplequote = 1
    endif

    if backtick
      if line =~# '^[^`]*`[^`]*$'
        let backtick = 0
      endif
      continue
    elseif &filetype ==# 'go' && line =~# '^[^`]*`[^`]*$'
      let backtick = 1
    endif

    if line =~# '^\s*<\!--'
      let xmlcomment = 1
    endif
    if xmlcomment
      if line =~# '-->'
        let xmlcomment = 0
      endif
      continue
    endif

    if line =~# '^\t'
      let heuristics.hard += 1
    elseif line =~# '^' . softtab
      let heuristics.soft += 1
    endif
    if line =~# '^  '
      let heuristics.spaces += 1
    endif
    let indent = len(matchstr(substitute(line, '\t', softtab, 'g'), '^ *'))
    if indent > 1 && (indent < 4 || indent % 2 == 0) &&
          \ get(options, 'shiftwidth', 99) > indent
      let options.shiftwidth = indent
    endif
  endfor

  if heuristics.hard && !heuristics.spaces
    return {'expandtab': 0, 'shiftwidth': &tabstop}
  elseif heuristics.soft != heuristics.hard
    let options.expandtab = heuristics.soft > heuristics.hard
    if heuristics.hard
      let options.tabstop = 8
    endif
  endif

  return options
endfunction

function! s:patterns_for(type) abort
  if a:type ==# ''
    return []
  endif
  if !exists('s:patterns')
    redir => capture
    silent autocmd BufRead
    redir END
    let patterns = {
          \ 'c': ['*.c'],
          \ 'html': ['*.html'],
          \ 'sh': ['*.sh'],
          \ 'vim': ['vimrc', '.vimrc', '_vimrc'],
          \ }
    let setfpattern = '\s\+\%(setf\%[iletype]\s\+\|set\%[local]\s\+\%(ft\|filetype\)=\|call SetFileTypeSH(["'']\%(ba\|k\)\=\%(sh\)\@=\)'
    for line in split(capture, "\n")
      let match = matchlist(line, '^\s*\(\S\+\)\='.setfpattern.'\(\w\+\)')
      if !empty(match)
        call extend(patterns, {match[2]: []}, 'keep')
        call extend(patterns[match[2]], [match[1] ==# '' ? last : match[1]])
      endif
      let last = matchstr(line, '\S.*')
    endfor
    let s:patterns = patterns
  endif
  return copy(get(s:patterns, a:type, []))
endfunction

function! s:apply_if_ready(options) abort
  if !has_key(a:options, 'expandtab') || !has_key(a:options, 'shiftwidth')
    return 0
  else
    for [option, value] in items(a:options)
      call setbufvar('', '&'.option, value)
    endfor
    return 1
  endif
endfunction

function! s:detect() abort
  if &buftype ==# 'help'
    return
  endif

  let options = s:guess(getline(1, 1024))
  if s:apply_if_ready(options)
    return
  endif
  let c = get(b:, 'sleuth_neighbor_limit', get(g:, 'sleuth_neighbor_limit', 20))
  let patterns = c > 0 ? s:patterns_for(&filetype) : []
  call filter(patterns, 'v:val !~# "/"')
  let dir = expand('%:p:h')
  while isdirectory(dir) && dir !=# fnamemodify(dir, ':h') && c > 0
    for pattern in patterns
      for neighbor in split(glob(dir.'/'.pattern), "\n")[0:7]
        if neighbor !=# expand('%:p') && filereadable(neighbor)
          call extend(options, s:guess(readfile(neighbor, '', 256)), 'keep')
          let c -= 1
        endif
        if s:apply_if_ready(options)
          let b:sleuth_culprit = neighbor
          return
        endif
        if c <= 0
          break
        endif
      endfor
      if c <= 0
        break
      endif
    endfor
    let dir = fnamemodify(dir, ':h')
  endwhile
  if has_key(options, 'shiftwidth')
    return s:apply_if_ready(extend({'expandtab': 1}, options))
  endif
endfunction

setglobal smarttab

if !exists('g:did_indent_on')
  filetype indent on
endif

function! SleuthIndicator() abort
  let sw = &shiftwidth ? &shiftwidth : &tabstop
  if &expandtab
    return 'sw='.sw
  elseif &tabstop == sw
    return 'ts='.&tabstop
  else
    return 'sw='.sw.',ts='.&tabstop
  endif
endfunction

augroup sleuth
  autocmd!
  autocmd FileType *
        \ if get(b:, 'sleuth_automatic', get(g:, 'sleuth_automatic', 1))
        \ | call s:detect() | endif
  autocmd User Flags call Hoist('buffer', 5, 'SleuthIndicator')
augroup END

command! -bar -bang Sleuth call s:detect()

" vim:set et sw=2:

" Theme and Colours Config
let $TERM='screen-256color'
set background=dark    " Setting dark mode
set t_Co=256
syntax on
set termguicolors

" Theme Specific Settings
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

" Bottom border of the inactive window
set fillchars+=stlnc:\ 


" General: Notes
"
" Author: Samuel Roeca
" Date: August 15, 2017
" TLDR: vimrc minimum viable product for Python programming
"
" I've noticed that many vim/neovim beginners have trouble creating a useful
" vimrc. This file is intended to get a Python programmer who is new to vim
" set up with a vimrc that will enable the following:
"   1. Sane editing of Python files
"   2. Sane defaults for vim itself
"   3. An organizational skeleton that can be easily extended
"
" Notes:
"   * When in normal mode, scroll over a folded section and type 'za'
"       this toggles the folded section
"
" Initialization:
"   1. Follow instructions at https://github.com/junegunn/vim-plug to install
"      vim-plug for either Vim or Neovim
"   2. Open vim (hint: type vim at command line and press enter :p)
"   3. :PlugInstall
"   4. :PlugUpdate
"   5. You should be ready for MVP editing
"
" Updating:
"   If you want to upgrade your vim plugins to latest version
"     :PlugUpdate
"   If you want to upgrade vim-plug itself
"     :PlugUpgrade
" General: Leader mappings -------------------- {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}
" General: global config ------------ {{{

"A comma separated list of options for Insert mode completion
"   menuone  Use the popup menu also when there is only one match.
"            Useful when there is additional information about the
"            match, e.g., what file it comes from.

"   longest  Only insert the longest common text of the matches.  If
"            the menu is displayed you can use CTRL-L to add more
"            characters.  Whether case is ignored depends on the kind
"            of completion.  For buffer text the 'ignorecase' option is
"            used.

"   preview  Show extra information about the currently selected
"            completion in the preview window.  Only works in
"            combination with 'menu' or 'menuone'.
set completeopt=menuone,longest,preview

" Enable buffer deletion instead of having to write each buffer
set hidden

" Mouse: enable GUI mouse support in all modes
set mouse=a

" Set column to light grey at 80 characters
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

" Remove query for terminal version
" This prevents un-editable garbage characters from being printed
" after the 80 character highlight line
set t_RV=

filetype plugin indent on

set spelllang=en_us

set showtabline=2

set autoread

" When you type the first tab hit will complete as much as possible,
" the second tab hit will provide a list, the third and subsequent tabs
" will cycle through completion options so you can complete the file
" without further keys
set wildmode=longest,list,full
set wildmenu

" Turn off complete vi compatibility
set nocompatible

" Enable using local vimrc
set exrc

" Make sure numbering is set
set number

" Redraw window whenever I've regained focus
augroup redraw_on_refocus
  au FocusGained * :redraw!
augroup END

set foldmethod=indent
set nofoldenable
set foldnestmax=10


" }}}
" General: Plugin Install --------------------- {{{

call plug#begin('~/.vim/plugged')

" Commands run in vim's virtual screen and don't pollute main shell
Plug 'fcpg/vim-altscreen'

" Basic coloring
Plug 'NLKNguyen/papercolor-theme'

" Utils
Plug 'tpope/vim-commentary'

" Language-specific syntax
Plug 'hdima/python-syntax'

" Indentation
Plug 'hynek/vim-python-pep8-indent'

" Macro repeater
Plug 'ckarnell/Antonys-macro-repeater'

" File system explorer for vim
Plug 'scrooloose/nerdtree'

" Jedi-vim
Plug 'davidhalter/jedi-vim'

" Vim rooter
Plug 'airblade/vim-rooter'

" Ctrl P
Plug 'kien/ctrlp.vim'

call plug#end()

" }}}
" General: Indentation (tabs, spaces, width, etc)------------- {{{

augroup indentation_sr
  autocmd!
  autocmd Filetype * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype yaml setlocal indentkeys-=<:>
augroup END

" }}}
" General: Folding Settings --------------- {{{

augroup fold_settings
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevelstart=0
  autocmd FileType * setlocal foldnestmax=1
augroup END

" }}}
" General: Trailing whitespace ------------- {{{

" This section should go before syntax highlighting
" because autocommands must be declared before syntax library is loaded
function! TrimWhitespace()
  if &ft == 'markdown'
    return
  endif
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

highlight EOLWS ctermbg=red guibg=red
match EOLWS /\s\+$/
augroup whitespace_color
  autocmd!
  autocmd ColorScheme * highlight EOLWS ctermbg=red guibg=red
  autocmd InsertEnter * highlight EOLWS NONE
  autocmd InsertLeave * highlight EOLWS ctermbg=red guibg=red
augroup END

augroup fix_whitespace_save
  autocmd!
  autocmd BufWritePre * call TrimWhitespace()
augroup END

" }}}
" General: Syntax highlighting ---------------- {{{

" Papercolor: options
let g:PaperColor_Theme_Options = {}
let g:PaperColor_Theme_Options['theme'] = {
      \     'default': {
      \       'transparent_background': 1
      \     }
      \ }
let g:PaperColor_Theme_Options['language'] = {
      \     'python': {
      \       'highlight_builtins' : 1
      \     },
      \     'cpp': {
      \       'highlight_standard_library': 1
      \     },
      \     'c': {
      \       'highlight_builtins' : 1
      \     }
      \ }

" Python: Highlight self and cls keyword in class definitions
augroup python_syntax
  autocmd!
  autocmd FileType python syn keyword pythonBuiltinObj self
  autocmd FileType python syn keyword pythonBuiltinObj cls
augroup end

" Syntax: select global syntax scheme
" Make sure this is at end of section
try
  set t_Co=256 " says terminal has 256 colors
  set background=dark
  colorscheme PaperColor
catch
endtry

" }}}
"  Plugin: Configure ------------ {{{

" Python highlighting
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1

" NERD Tree
let g:NERDTreeMapOpenInTab = '<C-t>'
let g:NERDTreeMapOpenSplit = '<C-s>'
let g:NERDTreeMapOpenVSplit = '<C-v>'
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeCaseSensitiveSort = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 31
let g:NERDTreeAutoDeleteBuffer = 2
let g:NERDTreeIgnore=['venv$[[dir]]', '__pycache__$[[dir]]', 'node_modules$[[dir]]']
nnoremap <silent> <space>h :NERDTreeToggle %<CR>

" Jedi-vim
" Python:
" Open module, e.g. :Pyimport os (opens the os module)
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0
let g:jedi#auto_close_doc = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#force_py_version = 3

" CtrlP
let g:ctrlp_working_path_mode = 'rw' " start from cwd
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" open first in current window and others as hidden
let g:ctrlp_open_multiple_files = '1r'
let g:ctrlp_use_caching = 0

" mappings
" auto_vim_configuration creates space between where vim is opened and
" closed in my bash terminal. This is annoying, so I disable and manually
" configure. See 'set completeopt' in my global config for my settings
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_command = "<C-]>"
let g:jedi#documentation_command = "<leader>sd"
let g:jedi#usages_command = "<leader>su"
let g:jedi#rename_command = "<leader>r"

"  }}}
" General: Key remappings ----------------------- {{{

" Put your key remappings here
" Prefer nnoremap to nmap, inoremap to imap, and vnoremap to vmap

nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>

" }}}
" General: Cleanup ------------------ {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless they’re owned by you.
set secure

" ShowCommand: turn off character printing to vim status line
set noshowcmd

" }}}

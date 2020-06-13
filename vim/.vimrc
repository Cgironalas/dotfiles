" General: Notes
  "
  " Based On: Samuel Roeca dotfiles (https://github.com/pappasam/dotfiles)
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
  "
  " Updating:
  "   If you want to upgrade your vim plugins to latest version
  "     :PlugUpdate
  "   If you want to upgrade vim-plug itself
  "     :PlugUpgrade

" General: Leader mappings {{{
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

  " Case insensitive matching unless a capital leter is used
  set ignorecase
  set smartcase

  " Enable buffer deletion instead of having to write each buffer
  set hidden

  " Disable swap files
  set nobackup
  set noswapfile

  " Enable filetype detection, plugins and indentation
  filetype plugin indent on

  " Single spaces after periods
  set nojoinspaces

  " Always display tabline
  set showtabline=2

  " Improve key timeout behaviour
    " don't timeout on mappings
    set notimeout
    " do timeout on terminal key codes
    set ttimeout

  " Explicitely set shell
  set shell=$SHELL

  " Mouse: enable GUI mouse support in all modes
  set mouse=a

  " Remove query for terminal version
  " This prevents un-editable garbage characters from being printed
  " after the 80 character highlight line
  set t_RV=

  set autoread

  " When you type the first tab hit will complete as much as possible,
  " the second tab hit will provide a list, the third and subsequent tabs
  " will cycle through completion options so you can complete the file
  " without further keys
  set wildmode=longest,list,full
  set wildmenu

  " Turn off complete vi compatibility
  set nocompatible

  " Enable using local vimrc ('.nvimrc', '_nvimrc', '.exrc')
  set exrc

  " Make sure numbering is set
  set number

  " Redraw window whenever I've regained focus
  augroup redraw_on_refocus
    autocmd!
    autocmd FocusGained * :redraw!
  augroup END

  " Enable Truecolor if applicable
  if $COLORTERM ==# 'truecolor'
    set termguicolors
  else
    set guicursor=
  endif

  " Configure Update time: time vim waits to do something after I stop moving
  set updatetime=750

  " Spelling
  " set spellang=es " for spanish
  set spelllang=en_us
  " set spell
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

    " Vim rooter
    Plug 'airblade/vim-rooter'

    " Ctrl P
    Plug 'kien/ctrlp.vim'

    " Vim-Toml
    Plug 'cespare/vim-toml'

    " For Svelte
    Plug 'evanleck/vim-svelte' "svelte highlights
    Plug 'davidroeca/coc-svelte-language-tools', {
      \ 'do': 'yarn install --frozen-lockfile && yarn build'
      \ }

    " For Rust
    Plug 'rust-lang/rust.vim' "rust highlights

    " Filetype formatter
    Plug 'pappasam/vim-filetype-formatter'

    " Web Close Tag
    Plug 'alvan/vim-closetag'

    " Vue JS
    Plug 'posva/vim-vue'

    " JSX highlights
    Plug 'maxmellon/vim-jsx-pretty'

    " Jenkinsfile syntax
    Plug 'khalliday7/Jenkinsfile-vim-syntax'

    " Typescript syntax highlight
    Plug 'leafgarland/typescript-vim'

    " Golang
    Plug 'fatih/vim-go', { 'do': 'GoUpdateBinaries' }

    " COC
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'Shougo/neco-vim'

    Plug 'autozimu/LanguageClient-neovim', {
          \ 'branch': 'next',
          \ 'do': 'bash install.sh',
          \ }

    " Nvim repl
    Plug 'tpope/vim-repeat'
    Plug 'pappasam/nvim-repl'

    for coc_plugin in [
            \ 'git@github.com:coc-extensions/coc-svelte.git',
            \ 'git@github.com:fannheyward/coc-markdownlint.git',
            \ 'git@github.com:josa42/coc-docker.git',
            \ 'git@github.com:neoclide/coc-css.git',
            \ 'git@github.com:neoclide/coc-html.git',
            \ 'git@github.com:neoclide/coc-json.git',
            \ 'git@github.com:neoclide/coc-pairs.git',
            \ 'git@github.com:neoclide/coc-rls.git',
            \ 'git@github.com:neoclide/coc-snippets.git',
            \ 'git@github.com:neoclide/coc-tsserver.git',
            \ 'git@github.com:neoclide/coc-yaml.git',
            \ 'git@github.com:pappasam/coc-jedi.git',
            \ ]
        Plug coc_plugin, {
              \ 'do': 'yarn install --frozen-lockfile && yarn build',
              \ }
      endfor

  call plug#end()
" }}}

" COC: for IDE stuff ------------ {{{
  for coc_plugin in [
        \ 'git@github.com:coc-extensions/coc-svelte.git',
        \ 'git@github.com:fannheyward/coc-markdownlint.git',
        \ 'git@github.com:josa42/coc-docker.git',
        \ 'git@github.com:neoclide/coc-css.git',
        \ 'git@github.com:neoclide/coc-html.git',
        \ 'git@github.com:neoclide/coc-json.git',
        \ 'git@github.com:neoclide/coc-pairs.git',
        \ 'git@github.com:neoclide/coc-rls.git',
        \ 'git@github.com:neoclide/coc-snippets.git',
        \ 'git@github.com:neoclide/coc-tsserver.git',
        \ 'git@github.com:neoclide/coc-yaml.git',
        \ 'git@github.com:pappasam/coc-jedi.git',
        \ ]
  endfor

  function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
      execute 'help ' . expand('<cword>') 
    else
      call CocAction('doHover')
    endif
  endfunction

  function! s:coc_diagnostic_disable()
    cal coc#config('diagnostic.enable', v:false)
    let g:coc_custom_diagnostic_enabled = v:false
    silent CocRestart
    echom 'Disabled: Coc Diagnostics'
  endfunction

  function! s:coc_diagnostic_enable()
    cal coc#config('diagnostic.enable', v:true)
    let g:coc_custom_diagnostic_enabled = v:true
    echom 'Enabled: Coc Diagnostics'
  endfunction

  function! s:coc_diagnostic_toggle()
    if g:coc_custom_diagnostic_enabled == v:true
      call s:coc_diagnostic_disable()
    else
      call s:coc_diagnostic_enable()
    endif
  endfunction

  function! s:coc_init()
    let g:coc_custom_diagnostic_enabled = v:false
  endfunction

  augroup coc_initialization
    autocmd!
    autocmd VimEnter * call s:coc_init()
  augroup end

  command! CocDiagnosticToggle call s:coc_diagnostic_toggle()
  command! CocDiagnosticEnable call s:coc_diagnostic_enable()
  command! CocDiagnosticDisable call s:coc_diagnostic_disable()

  " coc-pairs to auto indent braces, parentheses, etc
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" }}}

" General: Filetype recognition ------------ {{{
  augroup filetype_recognition
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
    autocmd BufNewFile,BufRead,BufEnter *.hql,*.q set filetype=hive
    autocmd BufNewFile,BufRead,BufEnter *.config,.cookiecutterrc set filetype=yaml
    autocmd BufNewFile,BufRead,BufEnter .jrnl_config,*.bowerrc,*.babelrc,*.eslintrc,*.slack-term
          \ set filetype=json
    autocmd BufNewFile,BufRead,BufEnter *.asm set filetype=nasm
    autocmd BufNewFile,BufRead,BufEnter *.handlebars set filetype=html
    autocmd BufNewFile,BufRead,BufEnter *.m,*.oct set filetype=octave
    autocmd BufNewFile,BufRead,BufEnter *.jsx set filetype=javascript
    autocmd BufNewFile,BufRead,BufEnter *.gs set filetype=javascript
    autocmd BufNewFile,BufRead,BufEnter *.cfg,*.ini,.coveragerc,*pylintrc
          \ set filetype=dosini
    autocmd BufNewFile,BufRead,BufEnter *.tsv set filetype=tsv
    autocmd BufNewFile,BufRead,BufEnter *.toml set filetype=toml
    autocmd BufNewFile,BufRead,BufEnter Dockerfile.* set filetype=Dockerfile
    autocmd BufNewFile,BufRead,BufEnter Makefile.* set filetype=make
    autocmd BufNewFile,BufRead,BufEnter poetry.lock set filetype=toml
    autocmd BufNewFile,BufRead,BufEnter .gitignore,.dockerignore
          \ set filetype=conf
    autocmd BufNewFile,BufRead,BufEnter *.go set filetype=go
  augroup END
" }}}

" General: Indentation (tabs, spaces, width, etc)------------- {{{
  " Note -> apparently BufRead, BufNewFile trumps Filetype
  " Eg, if BufRead,BufNewFile * ignores any Filetype overwrites
  " This is why default settings are chosen with Filetype *
  set expandtab shiftwidth=2 softtabstop=2 tabstop=8
  augroup indentation_sr
    autocmd!
    autocmd Filetype python,c,haskell,markdown,rust,rst,kv,nginx,asm,nasm,gdscript3
          \ setlocal shiftwidth=4 softtabstop=4 tabstop=8
    autocmd Filetype dot setlocal autoindent cindent
    autocmd Filetype make,tsv,votl,go
          \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
    " Prevent auto-indenting from occuring
    autocmd Filetype yaml setlocal indentkeys-=<:>

    autocmd Filetype ron setlocal cindent
          \ cinkeys=0{,0},0(,0),0[,0],:,0#,!^F,o,O,e
          \ cinoptions+='(s,m2'
          \ cinoptions+='(s,U1'
          \ cinoptions+='j1'
          \ cinoptions+='J1'
  augroup END
" }}}

" Writing: Mainly for markdown {{{
  " augroup writing
  "  autocmd!
  "  " autocmd VimEnter * call s:abolish_correct()
  "  autocmd FileType markdown,rst,text,gitcommit
  "        \ setlocal wrap linebreak nolist
  "        \ | call textobj#sentence#init()
  "  autocmd FileType requirements setlocal nospell
  "  autocmd BufNewFile,BufRead *.html,*.tex setlocal wrap
  "  autocmd FileType markdown nnoremap <buffer> <leader>f :TableFormat<CR>
  " augroup END
" }}}

" General: Colorcolumn --------------- {{{
  " Set column to light grey at 80 characters
  set colorcolumn=80
  augroup colorcolumn_configuration
    autocmd!
    autocmd FileType gitcommit setlocal colorcolumn=73 textwidth=72
    autocmd FileType html, text, markdown,rst setlocal colorcolumn=0
  augroup END
" }}}

" General: Folding Settings --------------- {{{
  set foldmethod=indent
  set foldnestmax=10
  set nofoldenable

  augroup fold_settings
    autocmd!
    autocmd FileType * setlocal foldlevelstart=0
    " autocmd FileType vim,tmux,bash,zsh,sh
    "       \ setlocal foldmethod=marker foldlevelstart=0 foldnestmax=1
    autocmd FileType markdown, rst
          \ setlocal nofoldenable
  augroup END
" }}}

" General: Trailing whitespace ------------- {{{
  function! s:trim_whitespace()
    let l:save = winsaveview()
      if &ft == 'markdown'
        " Replace lines with only trailing spaces
        %s/^\s\+$//e
        " Replace lines with exactly one trailing space with no trailing spaces
        %g/\S\s$/s/\s$//g
        " Replace lines with more than 2 trailing spaces with 2 trailing spaces
        %s/\s\s\s\+$/  /e
      else
        " Remove all trailing spaces
        %s/\s\+$//e
      endif
    call winrestview(l:save)
  endfunction()

  command! TrimWhitespace call <SID>trim_whitespace()

  augroup fix_whitespace_save
    autocmd!
    autocmd BufWritePre *TrimWhitespace
  augroup END
" }}}

" General: Syntax highlighting ---------------- {{{
  " Papercolor: options
    let g:PaperColor_Theme_Options = {}
    let g:PaperColor_Theme_Options.theme = {}
  " Bold And Italics:
    let g:PaperColor_Theme_Options.theme.default = {
          \ 'allow_bold': 1,
          \ 'allow_italic': 1,
          \ }
  " Folds And Highlights:
    let g:PaperColor_Theme_Options.theme['default.dark'] = {}
    let g:PaperColor_Theme_Options.theme['default.dark'].override = {
          \ 'folded_bg': ['gray22', '0'],
          \ 'folded_fg': ['gray69', '0'],
          \ 'visual_fg': ['gray12', '0'],
          \ 'visual_bg': ['gray', '6'],
          \ }
  " Language Specific Overrides:
    let g:PaperColor_Theme_Options.language = {
          \   'python': {
          \     'highlight_builtins': 1,
          \   },
          \   'cpp': {
          \     'highlight_standard_library': 1,
          \   },
          \   'c': {
          \     'highlight_builtins': 1,
          \   }
          \ }
  " Load:
    try
      colorscheme PaperColor
    catch
      echo 'An error occured while configuring Papercolor'
    endtry

  " Python: Highlight self and cls keyword in class definitions
    augroup python_syntax
      autocmd!
      autocmd FileType python syn keyword pythonBuiltinObj self
      autocmd FileType python syn keyword pythonBuiltinObj cls
    augroup end
" }}}

"  Plugin: Configure ------------ {{{
  " Python highlighting
    let g:python_highlight_space_errors = 0
    let g:python_highlight_all = 1

  " NERD Tree:
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif 

    let g:NERDTreeShowHidden = 1
    let g:NERDTreeMapOpenInTab = '<C-t>'
    let g:NERDTreeMapOpenSplit = '<C-s>'
    let g:NERDTreeMapOpenVSplit = '<C-v>'
    let g:NERDTreeShowLineNumbers = 1
    let g:NERDTreeCaseSensitiveSort = 0
    let g:NERDTreeWinPos = 'right'
    let g:NERDTreeWinSize = 35
    let g:NERDTreeAutoDeleteBuffer = 2
    let g:NERDTreeIgnore=[
      \'.env$[[dir]]',
      \'.env$[[file]]',
      \'.git$[[dir]]',
      \'.mypy_cache$[[dir]]',
      \'.pyc$[[file]]',
      \'.pytest_cache$[[dir]]',
      \'.tox$[[dir]]',
      \'__pycache__$[[dir]]',
      \'node_modules$[[dir]]'
      \'pip-wheel-metadata$[[dir]]',
      \'venv$[[dir]]',
      \'\.xlsx$[[file]]',
      \]
    nnoremap <silent> <space>h :NERDTreeToggle %<CR>

  " Jedi:
    " Python:
    " Open module, e.g. :Pyimport os (opens the os module)
    let g:jedi#popup_on_dot = 0
    let g:jedi#show_call_signatures = 0
    let g:jedi#auto_close_doc = 0
    let g:jedi#smart_auto_mappings = 0
    let g:jedi#force_py_version = 3

  " CtrlP:
    let g:ctrlp_working_path_mode = 'rw' " start from cwd
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
    " open first in current window and others as hidden
    let g:ctrlp_open_multiple_files = '1r'
    let g:ctrlp_use_caching = 0

  " Mappings:
    " auto_vim_configuration creates space between where vim is opened and
    " closed in my bash terminal. This is annoying, so I disable and manually
    " configure. See 'set completeopt' in my global config for my settings
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#goto_command = "<C-]>"
    let g:jedi#documentation_command = "<leader>sd"
    let g:jedi#usages_command = "<leader>su"
    let g:jedi#rename_command = "<leader>r"

  " Web Close Tag:
    " These are the file extensions where this plugin is enabled.
    "
    let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx, *.vue'

    " filetypes like xml, html, xhtml, ...
    " These are the file types where this plugin is enabled.
    "
    let g:closetag_filetypes = 'html,xhtml,javascript,javascript.jsx,jsx,vue'

    " integer value [0|1]
    " This will make the list of non-closing tags case-sensitive
    " (e.g. `<Link>` will be closed while `<link>` won't.)
    "
    let g:closetag_emptyTags_caseSensitive = 1

    " dict
    " Disables auto-close if not in a "valid" region (based on filetype)
    "
    let g:closetag_regions = {
        \ 'typescript.tsx': 'jsxRegion,tsxRegion',
        \ 'javascript': 'jsxRegion',
        \ 'javascript.jsx': 'jsxRegion',
        \ }

    " Shortcut for closing tags, default is '>'
    "
    let g:closetag_shortcut = '>'

    " Add > at current position without closing the current tag, default is ''
    "
    let g:closetag_close_shortcut = '<leader>>'

  " Code Formatter:
    " let g:vim_filetype_formatter_verbose = 1
    let g:vim_filetype_formatter_commands = {
          \ 'python': 'black - -q --line-length 79',
          \ 'css': 'npx -q prettier --parser css --stdin',
          \ 'less': 'npx -q prettier --parser less --stdin',
          \ 'html': 'npx -q prettier --parser html --stdin',
          \ }

    augroup mapping_vim_filetype_formatter
      autocmd FileType python,javascript,javascript.jsx,css,less,json,html
            \ nnoremap <silent> <buffer> <leader>f :FiletypeFormat<cr>
      autocmd FileType python,javascript,javascript.jsx,css,less,json,html
            \ vnoremap <silent> <buffer> <leader>f :FiletypeFormat<cr>
    augroup END

  " LSP LanguageClient:
    let g:LanguageClient_serverCommands = {
          \ 'haskell': ['stack', 'exec', 'hie-wrapper'],
          \ 'javascript': ['npx', '--no-install', '-q', 'flow', 'lsp'],
          \ 'javascript.jsx': ['npx', '--no-install', 'flow', 'lsp'],
          \ 'python': ['jedi-language-server'],
          \ 'python.jinja2': ['jedi-language-server'],
          \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
          \ 'ruby': ['solargraph', 'stdio'],
          \ 'rust': ['~/cargo/bin/rustup', 'run', 'stable', 'rls'],
          \ 'typescript': ['npx', '--no-install', '-q', 'typescript-language-server', '--stdio'],
          \ }

    let g:LanguageClient_rootMarkers = {
          \ 'go': ['go.mod', 'go.sum'],
          \ 'gomod': ['go.mod', 'go.sum'],
          \ 'python': ['pyproject.toml', 'poetry.lock'],
          \ }

  " Language Client Configuration:
    let g:LanguageClient_autoStart = v:true
    let g:LanguageClient_hoverPreview = 'Always'
    let g:LanguageClient_diagnosticsEnable = v:false
    let g:LanguageClient_selectionUI = 'quickfix'

    function! CustomLanguageClientConfig()
      nnoremap <buffer> <C-]> :call LanguageClient#textDocument_definition()<CR>
      " nnoremap <buffer> <C-k> :call LanguageClient#textDocument_hover()<CR>
      nnoremap <buffer> <leader>sd :call LanguageClient#textDocument_hover()<CR>
      nnoremap <buffer> <leader>sr :call LanguageClient#textDocument_rename()<CR>
      nnoremap <buffer> <leader>sf :call LanguageClient#textDocument_formatting()<CR>
      nnoremap <buffer> <leader>su :call LanguageClient#textDocument_references()<CR>
      nnoremap <buffer> <leader>sa :call LanguageClient#textDocument_codeAction()<CR>
      nnoremap <buffer> <leader>ss :call LanguageClient#textDocument_documentSymbol()<CR>
      nnoremap <buffer> <leader>sc :call LanguageClient_contextMenu()<CR>
      setlocal omnifunc=LanguageClient#complete
    endfunction

    augroup languageclient_on_vim_startup
      autocmd!
      execute 'autocmd FileType '
            \ . join(keys(g:LanguageClient_serverCommands), ',')
            \ . ' call CustomLanguageClientConfig()'
    augroup END
"  }}}

" General: Key remappings ----------------------- {{{
  " Put your key remappings here
  " Prefer nnoremap to nmap, inoremap to imap, and vnoremap to vmap

  function! DefaultKeyMappings()
    " nnoremap <silent> <C-k> :wincmd k<CR>
    nnoremap <silent> <C-j> :wincmd j<CR>
    nnoremap <silent> <C-l> :wincmd l<CR>
    nnoremap <silent> <C-h> :wincmd h<CR>

    " FiletypeFormat: remap leader f to do filetype formatting TODO
      nnoremap <silent> <leader>f <cmd>FiletypeFormat<cr>
      vnoremap <silent> <leader>f :FiletypeFormat<cr>

    " Disable Ex Mode: to avoid opening it by mistake
      nnoremap Q <nop>

    " Disable Arrow Keys: to better get used to vim movement
      nnoremap <Up> <nop>
      nnoremap <Down> <nop>
      nnoremap <Left> <nop>
      nnoremap <Right> <nop>
      " inoremap <Up> <nop>
      " inoremap <Down> <nop>
      " inoremap <Left> <nop>
      " inoremap <Right> <nop>
      vnoremap <Up> <nop>
      vnoremap <Down> <nop>
      vnoremap <Left> <nop>
      vnoremap <Right> <nop>

    " Copy With System Clipboard:
      vnoremap <leader>y "+y
      nnoremap <leader>y "+y

    " Paste From System Clipboard: easier paste
      " Normal mode paste checks whether the current line has text if yes,
      " insert new line, if no, start paste on current line
      nnoremap <expr> <leader>p
            \ len(getline('.')) == 0 ? '"+p' : 'o<esc>"+p'

    " Select Tab By Number:
      " MoveTabs: goto tab number. Same as Firefox
      nnoremap <A-1> 1gt
      nnoremap <A-2> 2gt
      nnoremap <A-3> 3gt
      nnoremap <A-4> 4gt
      nnoremap <A-5> 5gt
      nnoremap <A-6> 6gt
      nnoremap <A-7> 7gt
      nnoremap <A-8> 8gt
      nnoremap <A-9> 9gt

    " Escape Also Clears Highlighting:
      nnoremap <silent> <esc> :noh<return><esc>

    " Bad J is bad
      " unmap J in normal mode unless range explicitely specified
      nnoremap <silent> <expr> J v:count == 0 ? '<esc>' : 'J'

    " Search Backward: remap comma to single quote
      nnoremap ' ,

    " MoveVisual: up and down visually only if count is specified before
    " Otherwise, you want to move up lines numerically
      nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
      vnoremap <expr> k v:count == 0 ? 'gk' : 'k'
      nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
      vnoremap <expr> j v:count == 0 ? 'gj' : 'j'

    " Substitute: replace word under cursor
      nnoremap <leader><leader>s yiw:%s/\<<C-R>0\>//gc<Left><Left><Left>
      vnoremap <leader><leader>s y:%s/<C-R>0//gc<Left><Left><Left>

    " Relative Numbers: uses custom functions TODO
      nnoremap <silent> <leader>R <cmd>ToggleNumber<CR>
      nnoremap <silent> <leader>r <cmd>ToggleRelativeNumber<CR>

    " Choose Window: just like tmux TODO
      nnoremap <C-w>q <cmd>ChooseWin<CR>

    " Indent Lines: toggle if indent lines is visible TODO
      nnoremap <silent> <leader>i <cmd>IndentLinesToggle<CR>

    " Resize Window: up and down; relies on custom functions TODO
      nnoremap <silent> <leader><leader>h <cmd>ResizeWindowHeight<CR>
      nnoremap <silent> <leader><leader>w <cmd>ResizeWindowWidth<CR>

    " COC: settings for coc.nvim
        nmap <silent> <C-]> <Plug>(coc-definition)
        nmap <silent> <2-LeftMouse> <Plug>(coc-defintion)
      " Use <c-space> to trigger completion
        inoremap <silent><expr> <c-space> coc#refresh()
        nnoremap <silent> <C-K> :call <SID>show_documentation()<CR>
      " Scroll in floating windows
        nnoremap <expr><C-e> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-e>"
        nnoremap <expr><C-y> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-y>"
      " Toggle Diagnostics
        nnoremap <silent> <leader>a :CocDiagnosticToggle<CR>

    " Repl: my very own repl plugin
      nnoremap <leader><leader>e :ReplToggle<CR>
      nmap <leader>e <Plug>ReplSendLine
      vmap <leader>e <Plug>ReplSendVisual

    " Mouse Configuration: remaps mouse to work better in terminal
      " Out Jump List: <C-RightMouse> already mapped to something like <C-t>
      nnoremap <RightMouse> <C-o>

    " Format JSON Files:
      nnoremap <leader>fj :%!json_xs -f json -t json-pretty<CR>
      inoremap <leader>fj :%!json_xs -f json -t json-pretty<CR>

  endfunction
  call DefaultKeyMappings()
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

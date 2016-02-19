set nocompatible              " be iMproved, required
filetype off                  " required
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
:noremap <C-]> :YcmCompleter GoToDefinition<CR>
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'mattn/emmet-vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'kien/ctrlp.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'klen/python-mode'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'burnettk/vim-angular'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""
"" Janus setup
""

" Define paths
if has('win32') || has('win64') || has('win32unix')
  let g:janus_path = expand("~/.vim/janus/vim")
  let g:janus_vim_path = expand("~/.vim/janus/vim")
else
  let g:janus_path = escape(fnamemodify(resolve(expand("<sfile>:p")), ":h"), ' ')
  let g:janus_vim_path = escape(fnamemodify(resolve(expand("<sfile>:p" . "vim")), ":h"), ' ')
endif
let g:janus_custom_path = expand("~/.janus")

" emmet config
let g:user_emmet_mode='a'

" jedi-vim config
let g:jedi#goto_definitions_command ='<C-]>'
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = 'right'
let g:jedi#completions_enabled = 0

" python-mode config
let g:pymode_rope = 0
let g:pymode_doc = 0
let g:pymode_lint = 1
let g:pymode_lint_checker = 'pyflakes,pep8'
let g:pymode_lint_write = 1
let g:pymode_virtualenv = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<C-B>'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_folding = 0
let g:pymode_options_max_line_length = 120

" YouCompleteMe config
let g:ycm_goto_buffer_command = "same-buffer"
let g:ycm_min_num_of_chars_for_completion = 99

" Source janus's core
exe 'source ' . g:janus_vim_path . '/core/before/plugin/janus.vim'

" You should note that groups will be processed by Pathogen in reverse
" order they were added.
call janus#add_group("tools")
call janus#add_group("langs")
call janus#add_group("colors")

""
"" Customisations
""

if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif


" Disable plugins prior to loading pathogen
exe 'source ' . g:janus_vim_path . '/core/plugins.vim'

""
"" Pathogen setup
""

" Load all groups, custom dir, and janus core
call janus#load_pathogen()
colorscheme molokai

" .vimrc.after is loaded after the plugins have loaded
fun! TrimWhitespace()
  let l:save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfun
autocmd BufWritePre * :call TrimWhitespace()

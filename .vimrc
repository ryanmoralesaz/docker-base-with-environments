" ============================
" Vim Configuration File (.vimrc)
" ============================

" ** 1. Basic Settings **

" Disable Vim compatibility mode to enable Vim-specific features
set nocompatible
" set paste
set nofixeol
" set binary
" Enable file type detection, plugins, and indentation
filetype on
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

" ** 2. Editing Preferences **

" Enable automatic indentation
set autoindent

" Set indentation and tab preferences
set shiftwidth=4        " Number of spaces to use for each step of (auto)indent
set tabstop=4           " Number of spaces that a <Tab> in the file counts for
set expandtab           " Use spaces instead of tabs

" Enable line numbers and relative line numbers (optional)
set number              " Show absolute line numbers
" set relativenumber    " Uncomment to enable relative line numbers

" Highlight the current line
set cursorline
" set cursorcolumn     " Uncomment to highlight the current column

" ** 3. Search and Navigation **

" Enable incremental search
set incsearch

" Ignore case in search patterns
set ignorecase

" Override 'ignorecase' if the search pattern contains uppercase letters
set smartcase

" Highlight search matches
set hlsearch

" Show matching parentheses and brackets
set showmatch

" Show partial commands in the last line of the screen
set showcmd

" Show the current mode (e.g., -- INSERT --) in the last line
set showmode

" Keep 10 lines visible above and below the cursor when scrolling
set scrolloff=10

" Do not wrap long lines
set wrap

" ** 4. History and Completion **

" Increase the history size
set history=1000

" Enable enhanced command-line completion
set wildmenu
set wildmode=list:longest

" Ignore specific file patterns in file completion
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" ** 5. Clipboard and Mouse Support **

" Use the system clipboard for all yank, delete, change and put operations
set clipboard=unnamedplus

" Enable mouse support in all modes
set mouse=a
" ** 6. Backup and File Formats **

" Disable backup files
set nobackup

" Set file formats to Unix and DOS for compatibility
set fileformats=unix,dos
set fileformat=unix

" ** 7. Visual Enhancements **

" Set the color of comments to dark gray
highlight Comment ctermfg=darkgray

" Enable visual bell instead of beeping
set visualbell
set t_vb=
set belloff=all    " Disable all bell sounds

" ** 8. Mappings **
nnoremap <C-L> :nohlsearch<CR>
" Remap 'hh' in insert mode to escape to normal mode and move cursor right
inoremap hh <Esc>l

" Remap Emmet leader key from <C-Y> to <C-Z>
"let g:user_emmet_leader_key='<TAB>'
autocmd FileType html,css,php,blade imap <buffer> <Tab> <C-Y>,
let g:user_emmet_settings = {
    \'syntax_extensions': {
    \'php':'html',
    \'blade':'html',
    \},
    \}
" ** 9. Plugins **

" Initialize vim-plug plugin manager
call plug#begin('~/.vim/plugged')

" === Language Syntax Highlighting Plugins ===
Plug 'ziglang/zig.vim'                   " Zig syntax highlighting
Plug 'StanAngeloff/php.vim'               " PHP syntax highlighting and tools
Plug 'pangloss/vim-javascript'            " JavaScript syntax highlighting and tools
Plug 'leafgarland/typescript-vim'         " TypeScript syntax highlighting
Plug 'sheerun/vim-polyglot'               " Comprehensive language pack covering multiple languages

" === Utility Plugins ===
Plug 'mattn/emmet-vim'                    " Emmet support for HTML & CSS
Plug 'terryma/vim-multiple-cursors'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
" === Optional Enhanced Syntax Plugins ===
" Plug 'HerringtonDarkholme/yats.vim'    " Yet another TypeScript syntax
" Plug 'mxw/vim-jsx'                      " Enhanced JSX syntax highlighting

" === Color Schemes ===
Plug 'morhetz/gruvbox'                    " Gruvbox color scheme
Plug 'joshdick/onedark.vim'               " One Dark color scheme
Plug 'arcticicestudio/nord-vim'           " Nord color scheme

" Initialize plugin system
call plug#end()

let g:NERTCreateDefaultMappings = 1
nmap ,/ <Plug>NERDCommenterToggle
vmap ,/ <Plug>NERDCommenterToggle<CR>gv
let NERDTreeShowHidden=1
command! NTT NERDTreeToggle
" ** 10. Color Scheme Configuration **

" Choose your preferred color scheme by uncommenting one of the following lines:
colorscheme gruvbox
" colorscheme onedark
" colorscheme nord

" Set background to dark or light based on your preference
set background=dark        " or 'light'

" ** 11. Clipboard Configuration **

" Ensure clipboard settings are correctly set for system clipboard integration
if has('unnamedplus')
    set clipboard+=unnamedplus
endif

" ** 12. Cursor Shape and Color Configuration **

" Change cursor shape and color based on mode
if &term =~? 'rxvt' || &term =~? 'xterm' || &term =~? 'st-' || &term =~? 'tmux'
    " Blinking block in insert mode
    let &t_SI .= "\<Esc>[6 q"
    " Solid block in normal mode
    let &t_EI .= "\<Esc>[2 q"

    " Attempt to change cursor color to red in insert mode
    let &t_SI .= "\<Esc>]12;red^G"
    " Attempt to change cursor color back to white in normal mode
    let &t_EI .= "\<Esc>]12;white^G"
endif

" GUI Vim cursor settings (if applicable)
if has('gui_running')
    " Normal, Visual, and Command modes: block cursor
    set guicursor=n-v-c:block-Cursor
    " Insert mode: vertical bar cursor with 25% width
    set guicursor+=i:ver25-Cursor
    " Replace mode: horizontal bar cursor with 20% height
    set guicursor+=r:hor20-Cursor
else
    " Console Vim cursor settings
    if &term =~ "xterm\\|rxvt"
        " Use an orange cursor in insert mode
        let &t_SI = "\<Esc>]12;orange\x7"
        " Use a red cursor otherwise
        let &t_EI = "\<Esc>]12;red\x7"

        " Reset cursor color when Vim exits
        autocmd VimLeave * silent !echo -ne "\033]112\007"

        " Blinking block in insert mode
        let &t_SI .= "\<Esc>[6 q"
        " Solid block in normal mode
        let &t_EI .= "\<Esc>[2 q"
    endif
endif
" remove DOS carriage returns on paste
" Better paste handling
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
" ** 13. Auto Commands **

" Disable auto comments when creating new lines
"autocmd FileType * set formatoptions-=cro

" Turn off certain format options to prevent automatic insertion of comment leaders
"set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set formatoptions-=c
set formatoptions-=r
set formatoptions-=o

set viminfo^=!
set viminfofile=~/.vim/viminfo
" ============================
" End of .vimrc Configuration
" ============================

source $VIM/bundles.vim
" Vim 标准常规配置

"------------------------------------------------
" 可以在locale和文件编码不同时自动检测并选择正确编码 
" Encoding setting
"------------------------------------------------
if has("multi_byte")
    " Set fileencoding priority
    if getfsize(expand("%")) > 0
        " encoding dectection
        set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
    else
        set fileencodings=cp936,big5,euc-jp,euc-kr,latin1
    endif

    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif

    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " Use cp936 to support GBK, euc-cn == gb2312
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=utf-8
    elseif v:lang =~ "^zh_TW"
        " cp950, big5 or euc-tw
        " Are they equal to each other?
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
   " elseif v:lang =~ "^ko"
   "     " Copied from someone's dotfile, untested
   "     set encoding=euc-kr
   "     set termencoding=euc-kr
   "     set fileencoding=euc-kr
   " elseif v:lang =~ "^ja_JP"
   "     " Copied from someone's dotfile, unteste
   "     set encoding=euc-jp
   "     set termencoding=euc-jp
   "     set fileencoding=euc-jp
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif

" 设置宽度不明的文字为双宽度文本
"if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
"    set ambiwidth=double
"endif

set nobomb


"-------------------
" Vim UI
"-------------------
if has("win32") || has("win32unix")
    let g:OS#name = "win"
    let g:OS#win = 1
    let g:OS#mac = 0
    let g:OS#unix = 0
elseif has("mac")
    let g:OS#name = "mac"
    let g:OS#mac = 1
    let g:OS#win = 0
    let g:OS#unix = 0
elseif has("unix")
    let g:OS#name = "unix"
    let g:OS#unix = 1
    let g:OS#win = 0
    let g:OS#mac = 0
endif
if has("gui_running")
    let g:OS#gui = 1
else
    let g:OS#gui = 0
endif

if g:OS#win
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

" window 
set columns=90
set lines=30 

" color scheme
if g:OS#gui
  colorscheme desert
  set wrap
else
  colorscheme zellner
  set background=dark
  set wrap
endif

" 默认字体设置
if g:OS#win
    set guifont=Courier_New:h12:cANSI
elseif g:OS#mac
    set guifont=Courier_New:h16
elseif g:OS#unix
endif

"解决中文菜单乱码
set langmenu=zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"---------------------------------------
" file  setting
"---------------------------------------
" auto backup setting
set backup
set backupext=.bak
if g:OS#win
    set backupdir=$VIM\backup
else
    set backupdir=~/.backup
endif

" swrap file
if g:OS#win
    set directory=$VIM\tmp
else
    set directory=~/.tmp
endif

" 持久化撤销设置。
if has("persistent_undo")
    set undofile
    set undolevels=1000

    if g:OS#win
        set undodir=$VIM\undodir
        au BufWritePre undodir/* setlocal noundofile
    else
        set undodir=~/.undodir
        au BufWritePre ~/.undodir/* setlocal noundofile
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible  " 关闭与VI的兼容
set history=1000
set nofoldenable  "disable folding
set confirm       " prompt when existing from an unsaved file
"set foldmethod=syntax
"set foldlevel=6
"set foldcolumn=0


" enable filetype dectection and ft specific plugin/indent
filetype plugin on
filetype indent on
filetype on

" enable syntax hightlight and completion
if !exists("syntax_on") 
	syntax on
endif


set backspace=indent,eol,start     " More powerful backspaceing
set t_Co=256       " Explicitly tell vim that the terminal has 256 colors
set mouse=a        " use mouse in all modes
set report=0       " always report number of lines changed
set nowrap         " dont wrap lines
"set whichwrap=b,s,<,>,[,]
set scrolloff=5    " 5 lines above/below cursor when scrolling

set number          " show line nubers
set ruler           " 打开状态栏标尺
set cursorline      "突出显示当前行
set showmatch       " show matching bracket (briefly jump)
set showcmd         " show typed command in status bar
set title           " show file in titlebar
set laststatus=2    " use 2 lines for the status bar
set matchtime=2     " show matching bracket for 0.2 seconds
set matchpairs+=<:> " specially for html

" Default Indectation
set expandtab      " expand tab to space
set tabstop=4      "设置tab width 为 4
set softtabstop=4 
set shiftwidth=4   " 换行时行间交错使用4个空格
set smarttab
set smartindent    " 智能对齐方式
set autoindent     " 使用自动缩进

" search
set ignorecase     " 搜索时不区分达小区 set noic 为区分
set incsearch      " 搜索时自动定位
set hlsearch       " 高亮搜索

set autochdir      " 自动切换工作目录
set magic

set splitright
"set splitbelow

" 文件格式，默认 ffs=dos,unix
set fileformat=unix
set fileformats=unix,dos,mac

autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120

" syntax support
autocmd Syntax javascript set syntax=jquery    " JQuery syntax support

" js
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


" 清除当前文件的所有尾随空格
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>


" quickly open my vimrc file in a vertically split window
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nmap <leader>sv :so $MYVIMRC<cr>

set autoread            " 文件被外部改变时自动重新读取

" 自动载入 _vimrc, 修改后不需重启
autocmd! bufwritepost _vimrs source %
"-------------------------------------------------------------------
" Plugin setting
"-------------------------------------------------------------------

" fencview
"-----------------------------
"自动检测encoding插件 fencview
let g:fencview_autodetect = 0

" NeoComplCache
"--------------------------------------
let g:neocomplcache_enable_at_startup=1
let g:neoComplcache_disableautocomplete=1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
set completeopt-=preview

imap <C-k> <Plug>(neocomplcache_snippets_force_expand)
smap <C-k> <Plug>(neocomplcache_snippets_force_expand)
imap <C-l> <Plug>(neocomplcache_snippets_force_jump)
smap <C-l> <Plug>(neocomplcache_snippets_force_jump)

" Enable omni completion.
"------------------------------------------------------------
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType c setlocal omnifunc=ccomplete#Complete
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.erlang = '[a-zA-Z]\|:'

" easy-motion
"-------------------------------------
let g:EasyMotion_leader_key = '<Leader>'

" SuperTab
"----------------------------------------
" let g:SuperTabDefultCompletionType='context'
let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
let g:SuperTabRetainCompletionType=2

" tabbar
"------------------------
let g:Tb_maxSize = 2
let g:Tb_TabWrap = 1

hi Tb_Normal guifg=white ctermfg=white
hi Tb_Changed guifg=green ctermfg=green
hi Tb_VisibleNormal ctermbg=252 ctermfg=235
hi Tb_VisibleChanged guifg=green ctermbg=252 ctermfg=white

" Tagbar
"----------------------------------
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_autofocus =1
let g:tagbar_sort = 0
let g:tagbar_compact = 1

" Nerd Tree
"----------------------------
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$','\.pyc$','\.swp$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"

" powerline
" let g:Powerline_symbols = 'fancy'

" Keybindings for plugin toggle
"-----------------------------------
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
nmap <F5> :TagbarToggle<cr>
nmap <F6> :NERDTreeToggle<cr>
nmap <F3> :GundoToggle<cr>
nmap <F4> :IndentGuidesToggle<cr>
nmap <D-/> :
nnoremap <leader>a :Ack
nnoremap <leader>v V`]
autocmd FileType python map <F12> :!python %<CR>

" vimwiki config
"-------------------------------------------
if has("win32")
    let $VIMFILES = $VIM.'/vimfiles'
else
    let $VIMFILES = $HOME.'/.vim'
endif

let g:vimwiki_list = [{'path': 'D:/My Dropbox/MyWiki/VimWiki/',
\ 'diary_link_count': 5}]

let g:vimwiki_menu = ''
" 是否在计算字串长度时用特别考虑中文字符
let g:vimwiki_CJK_length = 1
" 标记为完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
" 打开wiki日记文件
map <Leader>d <Plug>VimwikiMakeDiaryNote
" tab 打开wiki日记文件
map <Leader>dt <Plug>VimwikiTabMakeDiaryNote
" 切换列表项的开关（选中/反选）<C-Space>是中文输入法切换热键，故重新映射
map <Leader>tt <Plug>VimwikiToggleListItem

" "    zencoding 设置
" "-----------------------------------
" let g:user_zen_leader_key = '<c-y>'
" "let g:use_zen_complete_tag = 1  "自动补全
" let g:SuperTabDefaultCompletionType = '<c-p>'

"------------------
" Useful Functions
"------------------

" easier navigation between split windows
"-------------------------------------------
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \ exe "normal g'\"" |
      \ endif |
      \ endif

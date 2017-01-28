""" View Setting """
""""""""""""""""""""
set fileencoding=utf-8
set number
set title "Show filename
set showmatch "Show matched braces
syntax on

set expandtab "convert tabs to spaces
set cursorline "highlight current line
set smartindent "do auto-indent
set autoindent
set tabstop=2 "set tab to size-2-spaces
set shiftwidth=2 "set auto-indent-size to 2
set softtabstop=2
set textwidth=0 "自動的に改行が入るのを無効化
set colorcolumn=80

highlight StatusLine term=none cterm=none ctermfg=gray ctermbg=gray
" set list "不可視文字の可視化
" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
" set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

""" Movement Setting """
""""""""""""""""""""""""
set backspace=start,eol,indent
" backspace setting:
"   start:  Enable to delete chars using Backspace in InsertMode
"   eol:    Enable to delete to previous line when Backspace on the head of line
"   indent: Enable to delete indent
set mouse=a
set ttymouse=xterm2

""" Search Setting """
""""""""""""""""""""""
set ignorecase "ignore upper/lower case
set smartcase "distinguish if upper case included in queries
set wrapscan "go to begening after the final match
set hlsearch "highlight matched items
set wildmenu wildmode=list:full "list up candidates when using commandlineMode

""" Key Map """
"""""""""""""""
"<Esc><Esc> to make no highlight
nmap <silent> <Esc><Esc> :nohlsearch<CR>

"<v><v> to select to end of line
vnoremap v $h

"w!! to save as super user
cmap w!! w !sudo tee > /dev/null %

"<CR> to insert line in normal mode
noremap <CR> O<Down><Esc>

"<Del> and <C-h> to delete left charactor
noremap <BS> <Left><Del>
noremap <C-h> <Left><Del>

" ZS to save
noremap <silent> ZS :w<CR>

""" over.vim """
""""""""""""""""
" start over.vim
nnoremap <silent> ,m :OverCommandLine<CR>

" カーソル下の単語をハイライト付きで置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

" コピーした文字列をハイライト付きで置換
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!','g')<CR>!!gI<Left><Left><Left>
""" over.vim """

" 上下移動を一段ずつ
nnoremap j gj
nnoremap k gk

" Tab setting
"" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
"" Tab jump
"" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tl 次のタブ
map <silent> [Tag]l :tabnext<CR>
" th 前のタブ
map <silent> [Tag]h :tabprevious<CR>

" enable :Rename to rename the file that are now editing
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))


""" NeoBundle Scripts """
"""""""""""""""""""""""""
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/pzhang/.vim/bundle/neobundle.vim/ "FIX the path if needed

" Required:
call neobundle#begin(expand('/home/pzhang/.vim/bundle')) "FIX the path if needed

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Settings of lightline
NeoBundle 'itchyny/lightline.vim'
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'modified': 'MyModified',
  \   'readonly': 'MyReadonly',
  \   'fugitive': 'MyFugitive',
  \   'filename': 'MyFilename',
  \   'fileformat': 'MyFileformat',
  \   'filetype': 'MyFiletype',
  \   'fileencoding': 'MyFileencoding',
  \   'mode': 'MyMode'
  \ }
\ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'unite' ? unite#get_status_string() :
    \  &ft == 'vimshell' ? vimshell#get_status_string() :
    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" Vim template
NeoBundle 'thinca/vim-template'
"" テンプレート中に含まれる特定文字列を置き換える
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
    silent! %s/<+FILENAME+>/\=expand('%:r')/g
endfunction
"" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動 autocmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |   silent! execute 'normal! "_da>'
    \ | endif

" Colorize Indent
NeoBundle 'nathanaelkane/vim-indent-guides'

" Automaticaly Turn On vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

" Change Tab colors
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236

" Easily Comment
"" select and <C--><C--> to commentout/discommentout
NeoBundle 'tomtom/tcomment_vim'

" NerdTree
"" :NERDTree to call nerdtree
NeoBundle 'scrooloose/nerdtree'

" vim-over
"" Use MacVim.app/Contents/MacOS/Vim or it will not loaded because of erorr
NeoBundle 'osyo-manga/vim-over'

" gist-vim
NeoBundle 'mattn/gist-vim'

" multiple-cursors
NeoBundle 'terryma/vim-multiple-cursors'

" easy to insert brackets
NeoBundle 'tpope/vim-surround'

" very simple vim plugin for easy resizing of your vim windows
NeoBundle 'simeji/winresizer'
let g:winresizer_start_key = '<C-W><C-W>'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


""" Additional Setting """
""""""""""""""""""""""""""
colorscheme Tomorrow-Night-Eighties

autocmd FileType python setlocal tabstop=2
autocmd FileType python setlocal shiftwidth=2
autocmd FileType python setlocal softtabstop=2

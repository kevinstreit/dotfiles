" __     __               _ _
" \ \   / /   _ _ __   __| | | ___
"  \ \ / / | | | '_ \ / _` | |/ _ \
"   \ V /| |_| | | | | (_| | |  __/
"    \_/  \__,_|_| |_|\__,_|_|\___|

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Tagbar'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'flazz/vim-colorschemes'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'xolox/vim-misc'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'Shougo/vimproc.vim'
Plugin 'tpope/vim-speeddating'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-surround'
Plugin 'Superbil/llvm.vim'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'vim-scripts/cscope.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'Rip-Rip/clang_complete'
Plugin 'klen/python-mode'
Plugin 'tristen/vim-sparkup'
Plugin 'tpope/vim-dispatch'
Plugin 'vim-scripts/L9'
Plugin 'c.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'junegunn/vim-easy-align'
Plugin 'pbrisbin/html-template-syntax'

call vundle#end()
filetype plugin indent on

"   ____                           _   ____       _   _   _
"  / ___| ___ _ __   ___ _ __ __ _| | / ___|  ___| |_| |_(_)_ __   __ _ ___
" | |  _ / _ \ '_ \ / _ \ '__/ _` | | \___ \ / _ \ __| __| | '_ \ / _` / __|
" | |_| |  __/ | | |  __/ | | (_| | |  ___) |  __/ |_| |_| | | | | (_| \__ \
"  \____|\___|_| |_|\___|_|  \__,_|_| |____/ \___|\__|\__|_|_| |_|\__, |___/
"                                                                 |___/

set nocompatible

let os = substitute(system('uname'), "\n", "", "")

if v:progname =~? "evim"
	finish
endif

noremap <C-W>u <C-W>s
noremap <C-W>i <C-W>v
noremap <C-W>d <C-W>c
noremap <C-W>g <C-W>h

nnoremap <Space> :noh<CR>
set backspace=indent,eol,start
set nobackup
set history=50
set ruler
set showcmd
set incsearch
set spl=en,de
set ignorecase
set smartcase
set autoread
set sh=/usr/bin/zsh
map Q gq
inoremap <C-U> <C-G>u<C-U>
set t_Co=256

if &t_Co > 2 || has("gui_running")
  if has("gui_gtk2")
    set guifont=Source\ Code\ Pro\ for\ Powerline\ Semi-Light\ 7
  endif

	syntax on

  if exists('+colorcolumn')
    set colorcolumn=80
  else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
  endif

	set hlsearch
	set background=dark
  colorscheme mustang
endif
map <leader>rw :%s/\s\+$//g<CR>

function! CheckFileEncoding()
  if exists('b:fenc_at_read') && &fileencoding != b:fenc_at_read
    exec 'e! ++enc=' . &fileencoding
    unlet b:fenc_at_read
  endif
endfunction
au BufRead     *.txt let b:fenc_at_read=&fileencoding
au BufWinEnter *.txt call CheckFileEncoding()

let g:agprg="ag --column --smart-case --ignore 'tags*'"
let g:ctrlp_root_markers = ['.pvimrc', '.project', '.clang_complete']
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 128

nnoremap <C-f>l :NERDTreeToggle<cr>
nnoremap <C-b>l :CtrlPBuffer<cr>

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  " Use this line instead of the above to match matches spanning across lines
  "let @/ = '\V' . substitute(escape(@@, '\'), '\_s\+', '\\_s\\+', 'g')
  call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
  let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>

"  _____                __  __       _   _
" | ____|__ _ ___ _   _|  \/  | ___ | |_(_) ___  _ __
" |  _| / _` / __| | | | |\/| |/ _ \| __| |/ _ \| '_ \
" | |__| (_| \__ \ |_| | |  | | (_) | |_| | (_) | | | |
" |_____\__,_|___/\__, |_|  |_|\___/ \__|_|\___/|_| |_|
"                 |___/

map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)
map  <leader>n <Plug>(easymotion-next)
map  <leader>N <Plug>(easymotion-prev)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0

"     _    _      _ _
"    / \  (_)_ __| (_)_ __   ___
"   / _ \ | | '__| | | '_ \ / _ \
"  / ___ \| | |  | | | | | |  __/
" /_/   \_\_|_|  |_|_|_| |_|\___|
"
let g:airline_powerline_fonts=1
let g:airline_inactive_collapse=1
let g:airline#extensions#whitespace#enabled=1
let g:airline#extensions#tagbar#flags = 'f'

let g:bufferline_echo=0

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

set shell=/usr/bin/zsh

set exrc
set secure
set sb
set spr
set title
set number
set ts=2
set sw=2
set sta
set et

set hidden

set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"   ____ _                      ______          _ _
"  / ___| | __ _ _ __   __ _   / / ___|___   __| (_)_ __   __ _
" | |   | |/ _` | '_ \ / _` | / / |   / _ \ / _` | | '_ \ / _` |
" | |___| | (_| | | | | (_| |/ /| |__| (_) | (_| | | | | | (_| |
"  \____|_|\__,_|_| |_|\__, /_/  \____\___/ \__,_|_|_| |_|\__, |
"                      |___/                              |___/

augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

augroup filetype
  au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

if has('conceal')
  set conceallevel=0 concealcursor=i
endif

let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'

let g:clang_user_options='-std=c++11 -stdlib=libc++ || exit 0'
let g:clang_close_preview=1
let g:clang_complete_auto=0
let g:clang_auto_select=0
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_snippets=1
let g:clang_conceal_snippets=1

au VimLeave * silent !sed -i "/^-'/d" ~/.viminfo
if filereadable('/usr/lib/libclang.so')
  let g:clang_library_path='/usr/lib/'
elseif filereadable('/usr/lib64/libclang.so')
  let g:clang_library_path='/usr/lib64/'
elseif filereadable('/usr/lib64/llvm/libclang.so')
  let g:clang_library_path='/usr/lib64/llvm/'
elseif filereadable('/home/streit/Work/LLVM-Sambamba/build/Release+Asserts/lib/libclang.so')
  let g:clang_library_path='/home/streit/Work/LLVM-Sambamba/build/Release+Asserts/lib/'
endif

set completeopt=menuone,menu,longest
set pumheight=15

map <C-C><C-F> :pyf ~/.dotfiles/utils/bin/clang-format.py<CR>
imap <C-C><C-F> <ESC>:pyf ~/.dotfiles/utils/bin/clang-format.py<CR>i

nnoremap <C-W>p :pclose<CR>

inoremap <C-C> <C-X><C-U>
nnoremap <C-B>d :BD<CR>
nnoremap <C-B>n :bn<CR>
nnoremap <C-B>p :bp<CR>
nnoremap <C-B>b :BB<CR>
nnoremap <C-B>f :BF<CR>
nnoremap <leader>m :Make<CR>

nnoremap <C-c>o :cc<CR>
nnoremap <C-c>n :cn<CR>
nnoremap <C-c>p :cp<CR>
nnoremap <C-c>N :cN<CR>
nnoremap <C-c>l :Copen<CR>
nnoremap <C-c>c :ccl<CR>

nnoremap dol :diffget //2<CR>:diffupdate<CR>
nnoremap dor :diffget //3<CR>:diffupdate<CR>

"  _              _ _     _                     _
" | |_ __ _  __ _| (_)___| |_    __ _ _ __   __| |
" | __/ _` |/ _` | | / __| __|  / _` | '_ \ / _` |
" | || (_| | (_| | | \__ \ |_  | (_| | | | | (_| |
"  \__\__,_|\__, |_|_|___/\__|  \__,_|_| |_|\__,_|
"           |___/
"
"   ___ ___  ___ ___  _ __   ___
"  / __/ __|/ __/ _ \| '_ \ / _ \
" | (__\__ \ (_| (_) | |_) |  __/
"  \___|___/\___\___/| .__/ \___|
"                    |_|

map yo :TagbarOpenAutoClose<CR>
map yc :TagbarClose<CR>

if has("cscope")
    set cscopetag
    set csprg=gtags-cscope

    if has('quickfix')
      set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help

    if filereadable("./GTAGS")
      silent! cs add ./GTAGS
    endif

    command -nargs=0 Cscope cs add $VIMSRC/src/GTAGS $VIMSRC/src

    map yg :!ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q .<CR>:!gtags<CR>:cscope reset<CR><CR>
else
    map yg :!ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
endif

let g:tagbar_width=80
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_compact=1

map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

let g:tagbar_type_tex = {
            \ 'ctagstype' : 'latex',
            \ 'kinds'     : [
                \ 's:sections',
                \ 'u:subsections',
                \ 'b:subsubsections'
            \ ],
            \ 'sort'    : 0
        \ }

"      _             _   _  __
"  ___| |_ __ _ _ __| |_(_)/ _|_   _
" / __| __/ _` | '__| __| | |_| | | |
" \__ \ || (_| | |  | |_| |  _| |_| |
" |___/\__\__,_|_|   \__|_|_|  \__, |
"                              |___/

autocmd FileType startify setlocal buftype=
let g:ctrlp_reuse_window = 'startify'
let g:startify_list_order = [
      \ ['   Recently modified files in this directory'], 'dir',
      \ ['   Bookmarks'], 'bookmarks',
      \ ['   Saved sessions'], 'sessions',
      \ ['   Recently used files'], 'files'
      \ ]
let g:startify_session_persistence = 1
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_restore_position = 1
let g:startify_relative_path = 1
let g:startify_custom_header = map(split(system('fortune -s | cowsay -W 76'), '\n'), '" ". v:val') +
      \ ['^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'] +
      \ ['']

if  filereadable("./.pvimrc")
    so ./.pvimrc
endif

let g:gitgutter_max_signs=4096

"""" for NeoBundle
set nocompatible               " Be iMproved

set runtimepath^=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'tpope/vim-fugitive'

" my bundles
NeoBundle 'drmikehenry/vim-fontsize.vim'


NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tomasr/molokai'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


"""" my configurations

set guioptions-=T
set guioptions-=r
set laststatus=2

" auto select into clipboard
:set guioptions+=a  " when GUI
:set clipboard+=autoselect  " unless GUI

"" indent with spaces
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

"" visual
set guifont=Ricty\ 13.5
set guifontwide=Ricty\ 13.5
set columns=95
set lines=40
colorscheme molokai

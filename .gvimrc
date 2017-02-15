""" settings for GUI

set columns=110
set lines=45

set guioptions-=T
set guioptions-=r

" auto select into clipboard
:set guioptions+=a  " when GUI

colorscheme molokai

if has("unix")
    set guifont=Ricty\ 13.5
    set guifontwide=Ricty\ 13.5
elseif has("mac")
    set guifont=Ricty\ Regular:h14
    set guifontwide=Ricty\ Regular:h14
endif

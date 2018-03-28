syntax enable
set ruler
set hls is ic scs
filetype plugin indent on
autocmd BufNewFile,BufRead *.{module,install,profile,test} set filetype=php
autocmd BufNewFile,BufRead *.{info,make} set filetype=dosini
autocmd BufNewFile,BufRead *.{geojson,json} set filetype=json

set encoding=utf8
try
    lang en_US
catch
endtry

set history=10000
set visualbell
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set number
set numberwidth=4

set go-=T " hide toolbar


" code_complete
" needs this ctags invocation:
" ctags -R --c-kinds=+p --fields=+S


" ctags and taglist stuff
set tags=./tags;/
map <A-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <silent> <F4> :TlistToggle<CR>
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
"let Tlist_Auto_Open=1 " obsoleted by winmanager 
let Tlist_Show_Menu=1
"let Tlist_Use_Right_Window=1
"let Tlist_Enable_Fold_Column=0
let Tlist_Show_One_File=1 " especially with this one 
"let Tlist_Compact_Format=1 
set updatetime=1000 
let Tlist_Process_File_Always=1
let Tlist_Sort_Type='name'
"let Tlist_WinWidth=30 " obsoleted by winmanager
"let Tlist_Inc_Winwidth=0 " obsoleted by winmanager
"let Tlist_Exit_OnlyWindow=1 " obsoleted by winmanager
let Tlist_Max_Tag_Length=100
let Tlist_Use_SingleClick = 1


"Tlist_Set_App("winmanager")






"let g:winManagerWindowLayout = 'FileExplorer|TagsExplorer'
let g:winManagerWindowLayout = 'FileExplorer|TagList'
let g:winManagerWidth = 30

"WMToggle

" why ever this doesn't work for the normal 'terminal' vim
if has("gui_macvim")
"  Tlist_Set_App("winmanager")
"  WMToggle
endif




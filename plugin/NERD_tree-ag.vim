" ============================================================================
" File:        NERD_tree-ag.vim
" Description: Adds searching capabilities to NERD_Tree with the silver searcher
" Original Author:  Mohammad Satrio <wolfaeon at gmail dot com>
" Maintainer:  Taian Su<taiansu at gmail dot com>
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" ============================================================================


" don't load multiple times
if exists("g:loaded_nerdtree_ag")
    finish
endif

let g:loaded_nerdtree_ag = 1

" ============================================================================
call NERDTreeAddMenuItem({
    \ 'text': 'search directory all (f)iles',
    \ 'shortcut': 'f',
    \ 'callback': 'NERDTreeAg' })

function! NERDTreeAg()
    let cd = g:NERDTreeDirNode.GetSelected().path.str()

    let pattern = input("(FILES) >>> ")
    if pattern == ''
        return
    endif
    exec "Ag! '".pattern."' ".cd
endfunction

" ============================================================================
call NERDTreeAddMenuItem({
    \ 'text': '(s)earch dir only cpp/hpp/cc/hh files (case insensitive)',
    \ 'shortcut': 's',
    \ 'callback': 'NERDTreeAgCppFiles' })

function! NERDTreeAgCppFiles()
    let cd = g:NERDTreeDirNode.GetSelected().path.str()
    let include_files = "\\.(c|h|cpp|cc|hpp|hh)$"
    let pattern = input("directory ".cd."\n(CPP FILES) >>> ")
    if pattern == ''
        return
    endif
    exec "Ag! -i -G '".include_files."' '".pattern."' ".cd
    set nospell
endfunction

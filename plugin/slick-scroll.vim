" slick-scroll
" Version: 0.0.1
" Author: 
" License: 

if exists('g:loaded_slick_scroll')
  finish
endif
let g:loaded_slick_scroll = 1

let s:save_cpo = &cpo
set cpo&vim

noremap <script> <Plug>(slick_scroll_scroll_down)    :call <SID>scroll('d', &scroll)<CR>
noremap <script> <Plug>(slick_scroll_scroll_up)      :call <SID>scroll('u', &scroll)<CR>
noremap <script> <Plug>(slick_scroll_scroll_forward) :call <SID>scroll('d', winheight(0))<CR>
noremap <script> <Plug>(slick_scroll_scroll_back)    :call <SID>scroll('u', winheight(0))<CR>

nmap <c-d> <Plug>(slick_scroll_scroll_down)
nmap <c-u> <Plug>(slick_scroll_scroll_up)
nmap <c-f> <Plug>(slick_scroll_scroll_forward)
nmap <c-b> <Plug>(slick_scroll_scroll_back)

" functions {{{
function! s:scroll(dir,height)
    let frames = 8 " number of frames per scroll

    let vels = map(range(frames), 0)
    for i in range(0, a:height - 1)
        let vels[i % frames] += 1
    endfor
    call filter(vels, 'v:val != 0')

    let win_y = winline()

    for i in range(0, len(vels) - 1)
        if a:dir ==# 'd'
            if line('w0') == line('$') | break | endif
            exe "normal " . vels[i] . "\<c-e>"
            if winline() < win_y && line('.') != line('$')
                exe "normal " . vels[i] . "j"
            end
        else
            if line('w0') == 1 | break | endif
            exe "normal " . vels[i] . "\<c-y>"
            if winline() > win_y && line('.') != 1
                exe "normal " . vels[i] . "k"
            end
        endif
        redraw
    endfor
endfunction
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:et:fdm=marker

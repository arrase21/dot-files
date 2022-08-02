
"if !exists('g:floatterm') | finish | endif
let g:floaterm_keymap_new = '<Leader>ft'
let g:floaterm_keymap_toggle = '<Leader>t'
let g:floaterm_height = 0.8
let g:floaterm_width = 0.8
let g:floaterm_position = 'center'

au FileType javascript nmap <buffer> <Leader>r :w<esc>:FloatermNew ! deno run % <CR>
au FileType c nmap <buffer> <Leader>r :w<esc>:FloatermNew ! gcc % && ./a.out && rm a.out <CR>
au FileType cpp nmap <buffer> <Leader>r :w<esc>:FloatermNew ! g++ % && ./a.out && rm a.out <CR>
au FileType python nmap <buffer> <Leader>r :w<esc>:FloatermNew ! python3 %<CR>
" au FileType java nmap <buffer> <Leader>r :w<esc>:FloatermNew ! java %:t:r<CR>
au FileType java nmap <buffer> <Leader>r :w<esc>:FloatermNew ! java %<CR>
nmap <Leader>c :cd %:p:h <CR>:!javac %:t<CR>

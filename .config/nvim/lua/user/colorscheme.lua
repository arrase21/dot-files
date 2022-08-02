
vim.cmd [[
try
  syntax on
  "colorscheme darkplus
  "colorscheme default
  set background=dark

  set termguicolors
  set t_CO=256
  set winblend=0
  set wildoptions =pum
  "let g:neosolarized_termtrans=0
  let g:dracula_colorterm = 1
  "colorscheme monokai_soda
  "colorscheme dracula
  "colorscheme github_dark_default
  "colorscheme pinkmare
  "colorscheme NeoSolarized
  "colorscheme gruvbox
  let g:sonokai_style = 'andromeda'
  let g:sonokai_better_performance = 1
  "colorscheme sonokai
  "colorscheme synthwave84
  
  hi Normal guibg=none ctermbg=none
  "hi LineNr guibg=NONE ctermbg=NONE
  "hi EndOfBuffer guibg=NONE ctermbg=NONE


lua << EOF
  require('molokai').setup({
    comment_italics = true,
  })
EOF
endtry
]]

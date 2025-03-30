vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.cmd("set mouse =")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")
vim.cmd("set expandtab")
vim.cmd("set nocompatible")
vim.cmd("filetype plugin on")
vim.cmd("syntax on")
-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"

-- Change vimwiki syntak to markdown
vim.cmd("let g:vimwiki_list = [{'path': '~/vimwiki/',  'syntax': 'markdown', 'ext': 'md'}]")

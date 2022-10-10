require('plugins')
local utils = require('utils')
utils.set_options
{
	autochdir = true,

	--indentation
	autoindent = true,
	tabstop = 4,
	shiftwidth = 4,

	--search
	hlsearch = true,
	ignorecase = true,
	smartcase = true,

	--text rendering
	scrolloff = 1,

	--UI Options
	number = true,
	relativenumber = true,
	mouse = "a",
	laststatus = 2,

	--Miscellaneous Options
	autoread = true,
	autowrite = true,
	backup = false,
	confirm = true,
	errorbells = false,
	undofile = true,
	clipboard = "unnamedplus",
	completeopt = 'menu,menuone,noselect',
	updatetime = 300,
	wildignore = '*.o,*~,*.pyc',
	wildmode = 'longest,full',
	wrap = false,
}

--leader key mapping
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--netrw config
--vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 2
vim.g.netrw_winsize = 20

local map = utils.map
local nmap = utils.nmap
local imap = utils.imap
local vmap = utils.vmap

-- Navigation
nmap('k', 'gk')
nmap('j', 'gj')
nmap("H", "^")
nmap("L", "$")
imap('jk', '<esc>l')

-- Clipboard
vmap('<leader>x', '"+x') --cut
vmap('<leader>y', '"+y') --copy
nmap('<leader>p', '"+p') --paste
nmap('<leader>a', 'ggVG$') -- Select all

-- Tabs
nmap('<C-t>', '<cmd>tabnew<cr>') --new tab

-- Search
nmap('<leader>ch', "<cmd>noh<cr>") --clear highlight

-- Misc
nmap('<leader>s', 'ea<C-X><C-S>') -- Spellcheck
map({ 'n', 'v', 'i' }, '<C-S>', '<cmd>w<cr>') -- Save
vim.cmd [[
" Make all parent directories and save the file
augroup FileCommands
  autocmd!

  " Change the title string to just the file name
  autocmd BufEnter * let &titlestring = expand("%:t")

  " Save whenever focus is lost
  autocmd BufLeave,FocusLost * silent! wall
augroup END

augroup autoread_load
  au!
  au FocusGained,BufEnter * silent! checktime
augroup end

augroup set_jenkins_groovy
  au!
  au BufNewFile,BufRead *.jenkinsfile,*.Jenkinsfile,Jenkinsfile,jenkinsfile setf groovy
augroup END

" Vim
]]

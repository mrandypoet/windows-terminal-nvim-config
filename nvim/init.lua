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
	swapfile = false,
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
map({ 'n', 'v' }, '<tab>', '%')
imap("{<CR>", "{<CR>}<esc>O")

-- Clipboard
vmap('<leader>x', '"+x')   --cut
vmap('<leader>y', '"+y')   --copy
nmap('<leader>p', '"+p')   --paste
nmap('<leader>a', 'ggVG$') -- Select all

-- Tabs
nmap('<C-t>', '<cmd>tabnew<cr>')   --new tab
nmap('<C-x>', '<cmd>tabclose<cr>') -- close current tab

-- Search
nmap('<leader>ch', "<cmd>noh<cr>") --clear highlight
nmap('n', 'nzz')                   -- Center on search
nmap('N', 'Nzz')

-- Misc
nmap('<leader>s', 'ea<C-X><C-S>')             -- Spellcheck
map({ 'n', 'v', 'i' }, '<C-S>', '<cmd>w<cr>') -- Save
nmap('<leader>cr', '<Cmd>lua ChangeToGitRoot()<CR>')
nmap('<leader>cx', '<Cmd>lua vim.cmd("cd ..")<CR>')

-- cast the parentheses to the current word or selection
nmap('<leader>cp', 'viwc()<Esc>P')
vmap('<leader>cp', 'c()<Esc>P')

-- Disable functionality
nmap('<leader>ef', ':set eventignore=BufWritePre<cr>')
nmap('<leader>ed', '<cmd>lua vim.diagnostic.enable()<cr>')
nmap('<leader>ee', '<cmd>lua vim.diagnostic.disable()<cr>')

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

-- colourscheme
vim.cmd [[colorscheme tokyonight-moon]]

-- use nvim as lazygit editor
if vim.fn.has('nvim') == 1 and vim.fn.executable('nvr') == 1 then
	vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

-- Change current dir to git root
local function findGitRoot(startingDir)
	local currentDir = startingDir or vim.fn.getcwd()
	local maxTry = 10
	local currTries = 0
	while currTries < maxTry do
		if vim.fn.isdirectory(currentDir .. '/.git') == 1 then
			return currentDir
		end
		currentDir = currentDir .. "/.."
		currTries = currTries + 1
	end

	return nil
end

function ChangeToGitRoot()
	local gitRoot = findGitRoot()
	if gitRoot then
		vim.cmd('cd ' .. gitRoot)
		print('Changed to Git root directory: ' .. gitRoot)
	else
		print('No Git root directory found.')
	end
end

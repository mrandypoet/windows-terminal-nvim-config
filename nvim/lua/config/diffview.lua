local nmap = require('utils').nmap

require('diffview').setup({
	hooks = {
		diff_buf_read = function(bufnr)
			-- Change local options in diff buffers
			vim.opt_local.wrap = false
			vim.opt_local.list = false
			vim.opt_local.colorcolumn = { 80 }
		end,
	},
})

nmap('<leader>fh', '<cmd>DiffviewFileHistory %<cr>')
nmap('<leader>cd', '<cmd>DiffviewClose<cr>')
vim.cmd [[
	hi DiffAdd ctermfg=48 ctermbg=28 guifg=None guibg=#004d39 blend=70
	hi DiffChange ctermfg=39 ctermbg=24 guifg=None guibg=None blend=70
	hi DiffDelete ctermfg=203 ctermbg=124 guifg=#FF6E6E guibg=None blend=70
	hi DiffText ctermfg=229 ctermbg=178 guifg=None guibg=#6B6B34 blend=70
]]

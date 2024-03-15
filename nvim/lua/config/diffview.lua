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

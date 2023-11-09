local nmap = require('utils').nmap
local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup {
	defaults = {
		mappings = {
			i = {
				['<ESC>'] = actions.close,
			},
		},
		file_ignore_patterns = {
			'build.*/.*',
			'env.*/.*',
		},
	},
	pickers = {
		default = {
			layout_config = { width = 0.9 },
			path_display = { "truncate" },
		},
		find_files = {
			-- layout_config = { width = 0.6 },
			path_display = { "truncate" },
		},
		buffers = {
			-- layout_config = { width = 0.9 },
			path_display = { "truncate" },
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
		}
	}
}

telescope.load_extension('fzf')
telescope.load_extension('ag')

nmap('<C-P>', '<cmd>Telescope find_files<CR>')
nmap('<leader>b', '<cmd>Telescope buffers<CR>')
nmap('gr', '<cmd>Telescope lsp_references<CR>')
nmap('gd', '<cmd>Telescope lsp_definitions<CR>')
nmap('<leader>v', '<cmd>Telescope lsp_document_symbols<CR>')
nmap('<leader>d', '<cmd>Telescope diagnostics bufnr=0<CR>')
nmap('<leader>D', '<cmd>Telescope diagnostics<CR>')
nmap('<leader>gs', '<cmd>Telescope grep_string<CR>')
nmap('<leader>lg', '<cmd>Telescope live_grep<CR>')

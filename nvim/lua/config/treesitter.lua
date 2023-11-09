require("nvim-treesitter.configs").setup {
	ensure_installed = { "c", "cpp", "lua", "cmake", "latex", "json", "python", "markdown" },
	sync_install = false,
	highlight = {
		enable = true,
		disable = { "c" }
	},
	playground = {
		enable = true,
	},
}

require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

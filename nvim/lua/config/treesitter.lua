vim.filetype.add({
	extension = {
		comp = "glsl", -- Treat .comp files as GLSL
	},
})

require("nvim-treesitter.configs").setup {
	ensure_installed = { "c", "cpp", "lua", "cmake", "latex", "json", "python", "markdown", "glsl" },
	sync_install = false,
	highlight = {
		enable = true,
		disable = { "c" }
	},
	playground = {
		enable = true,
	},
	fold = { enable = true },
}

require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

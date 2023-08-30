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

-- vim.cmd [[
--   set foldmethod=expr
--   set foldlevelstart=99
--   set foldexpr=nvim_treesitter#foldexpr()
--   highlight! Function ctermfg=221
--   highlight! TSPunctBracket ctermfg=74
--   highlight! Comment ctermfg=65
--   highlight! TSKeyword ctermfg=74
--   highlight! link TSKeywordReturn Statement
--   highlight! String ctermfg=172
--   highlight! Statement ctermfg=177
--   highlight! Number ctermfg=114
--   highlight! TSOperator ctermfg=white
--   highlight! Type ctermfg=78
--   highlight! link TSFuncBuiltin TSFunction
--   highlight! link TSTextReference Type
--   highlight! link TSKeywordFunction Type
--   highlight! link TSNamespace Type
--  ]]

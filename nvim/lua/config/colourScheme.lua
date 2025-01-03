require('tokyonight').setup({
	style = "storm",
	styles = {
		floats = 'normal',
		sidebars = "normal"
	}
})

vim.cmd [[
	highlight! Normal guibg=None ctermbg=None
	highlight! link Float Normal
	highlight! link NormalNC Normal
	highlight! link NormalFloat Normal
	highlight! link FloatBorder Normal
	highlight! link FloatTitle Normal
	highlight! link TelescopeNormal Normal
	highlight! link TelescopeBorder FloatBorder
]]

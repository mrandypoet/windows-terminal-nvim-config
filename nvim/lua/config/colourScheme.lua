require("tokyonight").setup({
  style = "moon",
  styles = {
    floats = "normal",
    sidebars = "normal",
  },
})

vim.cmd.colorscheme("tokyonight")

local function set_transparent()
  vim.cmd([[
    highlight! Normal guibg=NONE ctermbg=NONE
    highlight! link NormalNC Normal
    highlight! link NormalFloat Normal

    highlight! link FloatBorder WinSeparator
    highlight! link FloatTitle Title

    highlight! link TelescopeBorder FloatBorder
    highlight! link TelescopeNormal NormalFloat

    highlight! link TelescopePromptBorder FloatBorder
    highlight! link TelescopePromptNormal NormalFloat
    highlight! link TelescopePromptTitle FloatTitle

    highlight! link TelescopeResultsBorder FloatBorder
    highlight! link TelescopeResultsNormal NormalFloat
    highlight! link TelescopeResultsTitle FloatTitle

    highlight! link TelescopePreviewBorder FloatBorder
    highlight! link TelescopePreviewNormal NormalFloat
    highlight! link TelescopePreviewTitle FloatTitle
  ]])
end

set_transparent()

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_transparent,
})

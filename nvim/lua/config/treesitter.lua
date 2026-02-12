vim.filetype.add({
  extension = {
    comp = "glsl", -- Treat .comp files as GLSL
    cu = "cuda",
    cuh = "cuda",
  },
})

-- Don't hard-crash if treesitter isn't available yet
local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

configs.setup({
  ensure_installed = { "c", "cpp", "lua", "cmake", "latex", "json", "python", "markdown", "glsl", "cuda" },
  sync_install = false,
  auto_install = false, -- prevents "always trying to install" behavior
  highlight = {
    enable = true,
    disable = { "c" },
  },
  -- playground module removed/unsupported in recent treesitter; use :InspectTree instead
})

-- Prefer clang first, fallback to gcc
local ok_install, install = pcall(require, "nvim-treesitter.install")
if ok_install then
  install.compilers = { "clang", "gcc" }
end

-- Optional: enable treesitter-based folding (this replaces your fold = { enable = true })
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- don't fold by default

vim.cmd([[
  autocmd BufRead,BufNewFile *.cl set filetype=glsl
]])

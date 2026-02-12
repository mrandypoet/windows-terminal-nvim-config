require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "clangd", "neocmake", "jedi_language_server", "pyright", "rust_analyzer", "marksman" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.didChangeWatchedFiles = {
  dynamicRegistration = true,
  relative_pattern_support = true,
}

local util = require("utils")
local nmap = util.nmap
local buf_nmap = util.buf_nmap

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    source = "if_many",
  },
  virtual_lines = false, -- keep off unless you want multi-line inline
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
  },
})

nmap("<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

local function mason_bin(cmd)
  return vim.fn.stdpath("data") .. "/mason/bin/" .. cmd
end

local function on_attach(client, bufnr)
  buf_nmap(bufnr, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  buf_nmap(bufnr, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  buf_nmap(bufnr, "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  buf_nmap(bufnr, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

  if client:supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--header-insertion=iwyu",
    "--query-driver=/usr/bin/g++,/usr/bin/clang++,/usr/local/cuda/bin/nvcc",
  },
  root_markers = { "compile_commands.json", ".clangd", ".git" },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "gh", function()
      local params = { uri = vim.uri_from_bufnr(bufnr) }
      vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", params, function(err, result)
        if err then return vim.notify(err.message, vim.log.levels.ERROR) end
        if not result then return vim.notify("No corresponding source/header", vim.log.levels.WARN) end
        vim.cmd.edit(vim.uri_to_fname(result))
      end)
    end, { buffer = bufnr, silent = true })

    on_attach(client, bufnr)
  end,
  flags = { debounce_text_changes = 150 },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  -- offsetEncodings = "utf-8",
})

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("neocmake", {
  cmd = { mason_bin("neocmakelsp"), "stdio" },
  filetypes = { "cmake" },
  root_markers = { "CMakeLists.txt", ".git" },
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    neocmake = {
      diagnostics = {
        lineLength = false,
      },
    },
  },
})

vim.lsp.config("pyright", {
  cmd = { mason_bin("pyright-langserver"), "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("rust_analyzer", {
  cmd = { mason_bin("rust-analyzer") },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      assist = { importEnforceGranularity = true, importPrefix = "crate" },
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
      inlayHints = { locationLinks = false },
      diagnostics = { enable = true },
    },
  },
})

vim.lsp.config("marksman", {
  cmd = { mason_bin("marksman") },
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.enable({ "clangd", "lua_ls", "neocmake", "pyright", "rust_analyzer", "marksman" })

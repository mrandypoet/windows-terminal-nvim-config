require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "clangd", "cmake", "jedi_language_server" }
})

local lspconfig = require('lspconfig')
local util = require('utils')
local nmap = util.nmap
local buf_nmap = util.buf_nmap

nmap('<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
nmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nmap('<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

local function on_attach(client, bufnr)
	buf_nmap(bufnr, 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
	buf_nmap(bufnr, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
	buf_nmap(bufnr, '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
	buf_nmap(bufnr, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

lspconfig.clangd.setup {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=bundled",
		"--cross-file-rename",
		"--header-insertion=iwyu",
	},
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		buf_nmap(bufnr, 'gh', '<cmd>ClangdSwitchSourceHeader<CR>')
		on_attach(client, bufnr)
	end,
	flags = {
		debounce_text_changes = 150,
	},
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlighting = true,
	},
	offsetEncodings = 'utf-8'
}

lspconfig.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

lspconfig.cmake.setup {}

lspconfig.jedi_language_server.setup {}

lspconfig.rust_analyzer.setup {
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
	end,
	settings =
	{
		["rust-analyzer"] = {
			assist = {
				importEnforceGranularity = true,
				importPrefix = 'crate',
			},
			cargo = {
				allFeatures = true,
			},
			checkOnSave = {
				command = 'clippy',
			},
			inlayHints = { locationLinks = false },
			diagnostics = {
				enable = true,
				-- experimental = {
				-- 	enable = true,
				-- },
			},
		}
	}
}

lspconfig.marksman.setup {}

vim.cmd [[
augroup lsp_actions
  autocmd!
  autocmd CursorHold * silent lua vim.diagnostic.open_float(nil, {underline=false, focus=false})
augroup end
]]

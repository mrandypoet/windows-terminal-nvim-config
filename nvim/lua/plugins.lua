-- ~/.config/nvim/lua/plugins.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Plugin manager (optional to keep listed)
  { "folke/lazy.nvim" },

  -- Core deps
  { "nvim-lua/plenary.nvim" },

  -- Classic vim plugins
  { "tpope/vim-eunuch" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "vim-scripts/vim-gradle" },

  -- Theme
  {
    "folke/tokyonight.nvim",
    config = function()
      require("config.colourScheme")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.lualine")
    end,
  },

  -- Treesitter (+ context, playground)
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- load at startup to avoid module-not-found
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Sessions
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kelly-lin/telescope-ag",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("config.telescope")
    end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
  },

  -- EditorConfig
  {
    "editorconfig/editorconfig-vim",
    init = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
    end,
  },

  -- Navigation
  {
    "phaazon/hop.nvim",
    config = function()
      require("config.hop")
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true, -- <-- this enables labels during / and ?
        },
      },
      search = {
        multi_window = false,
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
      { "r", mode = "o",               function() require("flash").remote() end },
    },
  },

  -- Diffs
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.diffview")
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
    },
    config = function()
      require("config.cmp")
    end,
  },

  -- LSP (+ mason)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("config.lsp")
    end,
  },

  -- none-ls (null-ls successor)
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.null-ls")
    end,
  },

  -- ctags
  { "ludovicchabant/vim-gutentags" },

  -- latex
  {
    "lervag/vimtex",
    init = function()
      -- (typo fix: genral -> general)
      vim.g.vimtex_view_general_viewer = "mupdf"
    end,
  },

  -- LazyGit telescope extension
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },

  -- DAP
  { "mfussenegger/nvim-dap" },

  -- Rust tools
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
  },

  -- Codex
  {
    "johnseth97/codex.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("codex").setup({
        keymaps = {
          toggle = nil,
          quit = "<C-q>",
        },
        border = "rounded",
        width = 0.8,
        height = 0.8,
        autoinstall = true,
        panel = true,
        use_buffer = false,
      })
    end,
  },
})

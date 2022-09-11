local packer_install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_install


if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then --if packer not installed, install it
	print("packer not installed, installing parcker ...")
	packer_install = vim.fn.system(
	{'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
	packer_install_path}
	)
	print("packer installed")
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]


return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
    use "nvim-lua/plenary.nvim"
	use 'tpope/vim-eunuch'
	use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'vim-scripts/vim-gradle'

  	use {
    	'nvim-lualine/lualine.nvim',
  		config = [[require('config.lualine')]]
  	}

	use {
    	'nvim-treesitter/nvim-treesitter',
    	run = ':TSUpdate',
    	config = [[require('config.treesitter')]],
  	}

	use {
    	'nvim-treesitter/playground',
    	requires = 'nvim-treesitter/nvim-treesitter',
  	}

	use {
    	'numToStr/Comment.nvim',
    	config = function()
        	require('Comment').setup()
    	end
	} 
	use {
    	'rmagatti/auto-session',
    	config = function()
      	require('auto-session').setup {
        	log_level = 'info',
        	auto_session_suppress_dirs = { '~/', '~/workspace' }
      	}
    	end
  	}

  	use {
    	'nvim-telescope/telescope.nvim',
    	requires = {
			'nvim-lua/plenary.nvim',
			'kelly-lin/telescope-ag',
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
		},
		config = [[require('config.telescope')]],
	}
	
	use {
    	"iamcco/markdown-preview.nvim",
    	run = function() vim.fn["mkdp#util#install"]() end,
  	}

	use {
    	'editorconfig/editorconfig-vim',
    	config = [[vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}]]
  	}

	  -- Navigation
	use {
		'phaazon/hop.nvim',
		config = [[require('config.hop')]],
	}

	  -- Diffs
  	use {
    	'sindrets/diffview.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = [[require('config.diffview')]],
	}

	  -- Completion
  	use {
		'hrsh7th/nvim-cmp',
		requires = {
		  'hrsh7th/vim-vsnip',
		  'hrsh7th/cmp-nvim-lsp',
		  'hrsh7th/cmp-nvim-lsp-signature-help',
		  { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
		  { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
		  { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
		  { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
		},
		config = [[require('config.cmp')]],
	}
	  -- LSP
	use {
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		after = 'nvim-cmp',
		config = [[require('config.lsp')]]
	}

	use {
		'jose-elias-alvarez/null-ls.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = [[require('config.null-ls')]],
	}



end)



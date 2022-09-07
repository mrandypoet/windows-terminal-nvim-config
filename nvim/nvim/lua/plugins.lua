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
    	'nvim-telescope/telescope.nvim',
    	requires = {
			'nvim-lua/plenary.nvim',
			'kelly-lin/telescope-ag',
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
		},
		config = [[require('config.telescope')]],
	}

	
end)



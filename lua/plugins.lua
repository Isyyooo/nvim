local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

-- packer.nvim configuration
local conf = {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}
require('packer').init(conf)

vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'yianwillis/vimcdoc'

  -- Beter icon
  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup { default = true }
    end
  }

  -- Color
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd("colorscheme tokyonight")
    end
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
    config = function()
      require('conf.lualine').setup()
    end
  }

  -- Bufferline
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('conf.bufferline').setup()
    end
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('conf.treesitter').setup()
    end
  }

  -- IndentLine
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("conf.indentblankline").setup()
    end,
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('conf.luasnip').setup()
        end
      },
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('conf.cmp').setup()
    end
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    wants = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "mason-tool-installer.nvim",
      "cmp-nvim-lsp"
    },
    config = function()
      require("conf.lsp").setup()
    end,
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    }
  }

  -- Nvim tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly',
    config = function()
      require("conf.nvimtree").setup()
    end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

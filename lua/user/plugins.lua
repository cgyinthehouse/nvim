local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
  use  "wbthomason/packer.nvim" -- Have packer manage itself
  use  "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use  "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "windwp/nvim-ts-autotag"
  use  "numToStr/Comment.nvim"
  use  "JoosepAlviste/nvim-ts-context-commentstring"
  use  "kyazdani42/nvim-web-devicons"
  use  "kyazdani42/nvim-tree.lua"
  use  "akinsho/bufferline.nvim"
  use  "moll/vim-bbye"
  use  "nvim-lualine/lualine.nvim"
  use  "akinsho/toggleterm.nvim"
  use  "ahmedkhalf/project.nvim"
  use  "lewis6991/impatient.nvim"
  use  "lukas-reineke/indent-blankline.nvim"
  use  "goolord/alpha-nvim"
  use "folke/which-key.nvim"
  use 'simrat39/symbols-outline.nvim'  -- Symbols outliner
  use {"uga-rosa/ccc.nvim",config = function() require("ccc").setup() end }   -- Color Picker
  use  "petertriho/nvim-scrollbar"              -- Scroll bar
  use  {"rcarriga/nvim-notify", config = function () vim.notify = require("notify") end }
  use "folke/zen-mode.nvim"
  -- use {'karb94/neoscroll.nvim', config = function() require("neoscroll").setup() end }

   -- Add/change/delete surrounding delimiter pairs with ease
  use  { "kylechui/nvim-surround", tag = "*", config = function() require("nvim-surround").setup() end } -- Use for stability; omit to use `main` branch for the latest features

	-- Colorschemes
  use {"folke/tokyonight.nvim",config = function () require("tokyonight").setup({
    style = "night",
    dim_inactive = true,
    on_highlights = function(hl, colors)
      hl.NvimTreeFolderIcon = { fg = colors.yellow }
    end
  })
  end
  }
  use "lunarvim/darkplus.nvim"
  use {'navarasu/onedark.nvim', config = function() require("onedark").setup( {
    toggle_style_key = "<leader>ts",
    style = "darker",
    code_style = { keywords = "italic" }
  }) end }
  use {"EdenEast/nightfox.nvim", config = function() require("nightfox").setup({options = {dim_inactive=true}}) end }

	-- Cmp 
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

	-- Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

	-- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use  "williamboman/mason.nvim" -- simple to use language server installer
  use  "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "RRethy/vim-illuminate"
  use  "folke/trouble.nvim"
  use { "rmagatti/goto-preview", config = function() require("goto-preview").setup{ default_mappings = true } end }
  use { "smjonas/inc-rename.nvim", config = function() require("inc_rename").setup() end }
  use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }
  use  "ray-x/lsp_signature.nvim"

	-- Telescope
  use "nvim-telescope/telescope.nvim"

	-- Treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "p00f/nvim-ts-rainbow"

	-- Git
  use "lewis6991/gitsigns.nvim"

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

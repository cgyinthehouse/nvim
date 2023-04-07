local tokyonight = require("tokyonight")
local onedark = require("onedark")
local nightfox = require("nightfox")

-- colors
local breadcrumbText = '#9ee4b8'
local breadcrumbSeperator = '#a2a2cd'
local nvimTreeFolderIcon = '#e0af68'

nightfox.setup({
  options = {
    transparent = false,
    styles = {
      comments = "italic",
      keywords = "italic"
    },
  },
  groups = {
    all = {
      NvimTreeFolderIcon = { fg = nvimTreeFolderIcon },
      NavicText = { fg = breadcrumbText },
      NavicSeparator = { fg = breadcrumbSeperator }
    }
  }
})

onedark.setup({
  transparent = false,
  toggle_style_key = "<leader>ts",
  style = "darker",
  code_style = {
    keywords = "italic",
    comments = 'italic'
  },
  highlights = {
    ["NvimTreeFolderIcon"] = { fg = nvimTreeFolderIcon },
    ["NavicText"] = { fg = breadcrumbText },
    ["NavicSeparator"] = { fg = breadcrumbSeperator },
    ['Search'] = { bg = '#c0a064' }
  },
  lualine = { transparent = true }
})

tokyonight.setup({
  style = "night",
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "normal"
  },
  sidebars = { "nvim-tree", "help" },
  on_highlights = function(hl, colors)
    hl.NvimTreeFolderIcon = { fg = colors.yellow }
    hl.NavicText = { fg = breadcrumbText }
    hl.NavicSeparator = { fg = breadcrumbSeperator }
  end
})

local colorscheme = "tokyonight-night"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = nvimTreeFolderIcon })
vim.api.nvim_set_hl(0, "NavicSeparator", { fg = breadcrumbSeperator })
vim.api.nvim_set_hl(0, "NavicText", { fg = breadcrumbText })

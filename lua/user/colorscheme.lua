local tokyonight = require("tokyonight")
local onedark = require("onedark")
local nightfox = require("nightfox")

nightfox.setup({
  options = {
    transparent = true,
    styles = {
      comments = "italic",
      keywords = "italic"
    },
    groups = {
      all = {
        NvimTreeFolderIcon = { fg = "#e0af68" }
      }
    }
  }
})

onedark.setup({
  transparent = true,
  toggle_style_key = "<leader>ts",
  style = "darker",
  code_style = {
    keywords = "italic",
    comments = 'italic'
  },
  highlights = {
    ["NvimTreeFolderIcon"] = { fg = '#e0af68' },
    ['Search'] = { bg = '#c0a064' }
  },
  lualine = { transparent = true }
})

tokyonight.setup({
  style = "night",
  transparent = true,
  styles = {
    sidebars = "normal",
    floats =  "normal"
  },
  on_highlights = function(hl, colors)
    hl.NvimTreeFolderIcon = { fg = colors.yellow }
  end
})

local colorscheme = "tokyonight-night"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

vim.api.nvim_set_hl(0,"NvimTreeFolderIcon",{fg = "#e0af68" })

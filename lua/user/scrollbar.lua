local status_ok, scrollbar = pcall(require, "scrollbar")
if not status_ok then
  return
end

-- local colors = require("tokyonight.colors").setup()
scrollbar.setup({
  excluded_filetypes = {
      "NvimTree",
      "prompt",
      "TelescopePrompt",
      "noice"
  },
  -- handle ={ color = colors.bg_hightlight },
  -- marks = {
  --   Search = { color = colors.orange },
  --   Error = { color = colors.error },
  --   Warn = { color = colors.warning },
  --   Info = { color = colors.info },
  --   Hint = { color = colors.hint },
  --   Misc = { color = colors.purple }
  -- }
})

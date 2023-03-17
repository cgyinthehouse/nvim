local rt = require('rust-tools')

rt.setup({
  tools = {
    hover_actions = {
      auto_focus = true
    }
  },
  server = {
    on_attach = function(_,bufnr)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = bufnr})
    vim.keymap.set("n", "gh", rt.hover_actions.hover_actions, {buffer = bufnr})
	vim.keymap.set("n", "ga", rt.code_action_group.code_action_group, {buffer = bufnr})
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = bufnr})
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {buffer = bufnr})
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", {buffer = bufnr})
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, {buffer = bufnr})
    end
  }
})

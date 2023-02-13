local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

notify.setup({
	top_down = false,
	max_width = 80,
	background_colour = "#000000",
})

vim.notify = notify

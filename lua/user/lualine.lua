local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local status_ok2, navic = pcall(require, "nvim-navic")
if not status_ok2 then
	return
end

local breadcrumbs = {
	function()
		return navic.get_location()
	end,
	cond = function()
		return navic.is_available()
	end,
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
	colored = true,
	update_in_insert = false,
	always_visible = false,
}

local active_lsp = {
	-- Lsp server name .
	function()
		local servers = vim.lsp.get_active_clients({ bufnr = 0 })
		local names = {}
		if next(servers) == nil then
			return "No Active Lsp"
		end
		for _, server in pairs(servers) do
			table.insert(names, server.name)
		end
		return "[" .. table.concat(names, " ") .. "]"
	end,
	icon = "",
	color = { fg = "#58a8c2" },
}

local diff = {
	"diff",
	source = diff_source,
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local mode = {
	"mode",
	color = { gui = "bold" },
	-- fmt = function(str)
	-- 	return "-- " .. str .. " --"
	-- end,
}

local filetype = {
	"filetype",
	icons_enabled = true,
}

local filetype_icon = {
	"filetype",
	icon_only = true,
	color = { bg = "transparent" },
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	function()
		local line = vim.fn.line(".")
		local col = vim.fn.virtcol(".")
		local total_lines = vim.fn.line("$")
		local progress = string.format("%d%%%%", math.floor(line / total_lines * 100))
		if line == 1 then
			progress = "Top"
		elseif line == total_lines then
			progress = "Bot"
		end
		return string.format("%d/%-d:%-d %s", line, total_lines, col, progress)
	end,
    color = { gui = 'bold' }
}

local filename = {
	"filename",
	color = { bg = "transparent", gui = "bold" },
	padding = 0,
	path = 1,
	-- 0: Just the filename
	-- 1: Relative path
	-- 2: Absolute path
	-- 3: Absolute path, with tilde as the home directory
	newfile_status = true,
	symbols = {
		-- modified = '[+]',      -- Text to show when the file is modified.
		readonly = "", -- Text to show when the file is non-modifiable or readonly.
		-- unnamed = '[No Name]', -- Text to show for unnamed buffers.
		-- newfile = '[New]',     -- Text to show for new created file before first writting
	},
}

-- cool function for progress
-- local progress = function()
-- 	local current_line = vim.fn.line(".")
-- 	local total_lines = vim.fn.line("$")
-- 	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
-- 	local line_ratio = current_line / total_lines
-- 	local index = math.ceil(line_ratio * #chars)
-- 	return chars[index]
-- end

local spaces = function()
	return "󰞔 " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			"alpha",
			"dashboard",
			"NvimTree",
            "Trouble",
			winbar = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
		},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch, diagnostics },
		lualine_c = { diff },
		lualine_x = { active_lsp, spaces, "encoding", "fileformat" },
		lualine_y = { filetype },
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = { filetype },
		lualine_y = { "location" },
		lualine_z = {},
	},
	tabline = {},
	winbar = {
		lualine_c = { filetype_icon, filename, breadcrumbs },
	},
	inactive_winbar = {
		lualine_c = { filetype_icon, filename, breadcrumbs },
	},
	extensions = { "symbols-outline" },
})

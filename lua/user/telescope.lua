local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local trouble = require("trouble.providers.telescope")
local undo_actions = require "telescope-undo.actions"

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = "cycle_history_next",
        ["<C-p>"] = "cycle_history_prev",

        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",

        ["<esc>"] = "close",

        ["<Down>"] = "move_selection_next",
        ["<Up>"] = "move_selection_previous",

        ["<CR>"] = "select_default",
        ["<C-x>"] = "select_horizontal",
        ["<C-v>"] = "select_vertical",
        ["<C-t>"] = "select_tab",

        ["<C-u>"] = "preview_scrolling_up",
        ["<C-d>"] = "preview_scrolling_down",

        ["<PageUp>"] = "results_scrolling_up",
        ["<PageDown>"] = "results_scrolling_down",

        ["<C-l>"] = "complete_tag",
        ["<C-_>"] = "which_key", -- keys from pressing <C-/>
        -- ["<C-T>"] = trouble.open_with_trouble
      },

      n = {
        ["<esc>"] = "close",
        ["<CR>"] = "select_default",
        ["<C-x>"] = "select_horizontal",
        ["<C-v>"] = "select_vertical",
        ["<C-t>"] = "select_tab",

        ["j"] = "move_selection_next",
        ["k"] = "move_selection_previous",
        ["H"] = "move_to_top",
        ["M"] = "move_to_middle",
        ["L"] = "move_to_bottom",

        ["<Down>"] = "move_selection_next",
        ["<Up>"] = "move_selection_previous",
        ["gg"] = "move_to_top",
        ["G"] = "move_to_bottom",

        ["<C-u>"] = "preview_scrolling_up",
        ["<C-d>"] = "preview_scrolling_down",

        ["<PageUp>"] = "results_scrolling_up",
        ["<PageDown>"] = "results_scrolling_down",

        ["<S-t>"] = trouble.open_with_trouble,

        ["?"] = "which_key",
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    colorscheme = {
      enable_preview = true
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    undo = {
      use_delta = true,
      side_by_side = true,
      scroll_strategy = "limit",
      layout_strategy = "vertical",
      layout_config = {
        width = .85,
        preview_height = 0.75,
      },
      mappings = {
        i = {
          ["<A-y>"] = undo_actions.yank_additions,
          ["<A-d>"] = undo_actions.yank_deletions,
          ["<A-r>"] = undo_actions.restore,
        },
        n = {
          ["<A-y>"] = undo_actions.yank_additions,
          ["<A-d>"] = undo_actions.yank_deletions,
          ["<A-r>"] = undo_actions.restore,
        }
      }
    },
    packer = {
        -- mappings: (Note: INSERT mode)
        -- C-o: open online repos 
        -- C-f: open with find_files 
        -- C-b: open with **telescope-file-browser**
        -- C-g: open with live_grep
        layout_strategy = "flex",
        layout_config = {
          height = .8,
          flip_columns = 120,
          horizontal = {
            width = 0.8,
            height = 0.8,
            preview_width = 0.6
          },
          vertical = {
            horizontal = 0.8,
            height = 0.9,
            preview_height = 0.65
          }
        }
      },
    zoxide = {
      -- <C-e> ==> :edit <path>
      -- <C-s> ==> :sp <path>
      -- <C-v> ==> :vs <path>
      -- <C-b> ==> :Telescope file_browser
      -- <C-f> ==> :Telescope find_files
        mappings = {
          default = {
            after_action = function(selection)
              print("Directory changed to " .. selection.path .. " (Score: " .. selection.z_score .. ")")
            end
          },
          ["<C-b>"] = {
          keepinsert = true,
          action = function(selection)
            telescope.extensions.file_browser.file_browser({ cwd = selection.path })
          end
        },
      },
    }
  },
}
telescope.load_extension('notify')
telescope.load_extension('fzf')
telescope.load_extension('undo')
telescope.load_extension('packer')
telescope.load_extension('zoxide')
telescope.load_extension('file_browser')

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-n>"] = require("telescope.actions").cycle_history_next,
            ["<C-p>"] = require("telescope.actions").cycle_history_prev,
            ["<C-c>"] = require("telescope.actions").close,
          },
          n = {
            ["<C-c>"] = require("telescope.actions").close,
          },
        },
      },
    },
    pickers = {
      -- Default configuration for built-in pickers can be overridden here
    },
    extensions = {
      fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
      },
    },
		config = function(_, opts)
      require("telescope").setup(opts)
			local builtin = require("telescope.builtin")
      require("telescope").load_extension("fzf")
			vim.keymap.set("n", "f", builtin.find_files, {})
			vim.keymap.set("n", "F", builtin.live_grep, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
    dependencies = { "telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}

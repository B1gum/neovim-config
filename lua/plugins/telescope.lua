return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = " ",
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-c>"] = actions.close,
            },
            n = {
              ["<C-c>"] = actions.close,
            },
          },
        },
          ["ui-select"] = require("telescope.themes").get_dropdown({}),
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
			local builtin = require("telescope.builtin")
      require("telescope").load_extension("fzf")
			vim.keymap.set("n", "f", builtin.find_files, {})
			vim.keymap.set("n", "F", builtin.live_grep, {})
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}


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
			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Picker: find files" })
			vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Picker: live grep" })
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


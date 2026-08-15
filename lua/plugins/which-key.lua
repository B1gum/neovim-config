return {
  "folke/which-key.nvim",
  opts = {},
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>c", group = "code" },
      { "<leader>p", group = "pickers" },
      { "<leader>s", group = "spelling" },
      { "<leader>w", group = "windows" },
    })
  end,
}

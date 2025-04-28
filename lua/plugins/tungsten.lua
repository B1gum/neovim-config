return {
  dir = vim.loop.os_homedir() .. "/.config/nvim/lua/tungsten",
  config = function()
    require("tungsten").setup()
  end,
  ft = { "tex" },
}

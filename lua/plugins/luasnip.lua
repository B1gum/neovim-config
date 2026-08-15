return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build   = "make install_jsregexp",
    event   = "VeryLazy",
    -- no external snippet sources
    config = function()
      local ls = require("luasnip")

      -- 1) LuaSnip core config
      ls.config.set_config {
        history              = true,
        updateevents         = "TextChanged,TextChangedI",
        store_selection_keys = "<C-s>",
      }

      -- 2) Load your own Lua snippets only
      require("luasnip.loaders.from_lua").lazy_load {
        paths = vim.fn.expand("~/.config/nvim/lua/snippets"),
      }

      -- 3) Auto-reload your Lua snippets on save
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = vim.fn.expand("~/.config/nvim/lua/snippets/*.lua"),
        callback = function()
          ls.cleanup()
          require("luasnip.loaders.from_lua").lazy_load {
            paths = vim.fn.expand("~/.config/nvim/lua/snippets"),
          }
          print("LuaSnip snippets reloaded!")
        end,
      })

      -- 4) Interaction keymaps are owned by nvim-cmp so Tab/Shift-Tab and
      -- Ctrl-N/Ctrl-P have exactly one canonical implementation.
    end,
  },
}


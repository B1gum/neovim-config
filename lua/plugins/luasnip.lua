-- lua/plugins/luasnip.lua
return {
  {
    "L3MON4D3/LuaSnip",
    version      = "v2.*",
    build        = "make install_jsregexp",
    event        = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",  -- install and make available
    },
    config = function()
      local ls = require("luasnip")

      -- 1) LuaSnip core config
      ls.config.set_config {
        history            = true,
        updateevents       = "TextChanged,TextChangedI",
        store_selection_keys = "<Ctrl>",
      }

      -- 2) Load friendly-snippets (VSCode format) *lazily*
      require("luasnip.loaders.from_vscode").lazy_load()

      -- 3) Load your own Lua snippets
      require("luasnip.loaders.from_lua").lazy_load {
        paths = "~/.config/nvim/lua/snippets",
      }

      -- 4) Auto-reload your Lua snippets on save
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "~/.config/nvim/lua/snippets/*.lua",
        callback = function()
          ls.cleanup()  -- clear out old snippets
          require("luasnip.loaders.from_lua").lazy_load {
            paths = "~/.config/nvim/lua/snippets",
          }
          print("LuaSnip snippets reloaded!")
        end,
      })

      -- 5) Tab‐based expand/jump
      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        return require("luasnip").expand_or_jumpable()
          and "<cmd>lua require('luasnip').expand_or_jump()<CR>"
          or vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
      end, { expr = true, silent = true })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        return require("luasnip").jumpable(-1)
          and "<cmd>lua require('luasnip').jump(-1)<CR>"
          or vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
      end, { expr = true, silent = true })

      -- 6) Choice‐node navigation
      vim.keymap.set("i", "<C-E>", function()
        if ls.choice_active() then ls.change_choice(1) end
      end)

      for _, mode in ipairs({ "i", "s" }) do
        vim.keymap.set(mode, "<C-n>", function()
          if ls.choice_active() then ls.change_choice(1) end
        end, { silent = true })
        vim.keymap.set(mode, "<C-p>", function()
          if ls.choice_active() then ls.change_choice(-1) end
        end, { silent = true })
      end
    end,
  },
}


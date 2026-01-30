return {
  {
    "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP source
    "hrsh7th/cmp-buffer",       -- Buffer words
    "hrsh7th/cmp-path",         -- File paths
    "hrsh7th/cmp-cmdline",      -- :cmdline completions
    "L3MON4D3/LuaSnip",         -- Snippet engine
    },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    require("luasnip.loaders.from_lua").lazy_load {
  paths = "~/.config/nvim/lua/snippets",}

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
    mapping = cmp.mapping.preset.insert({
          ["¨"] = cmp.mapping.complete(),
          ["<CR>"]     = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]    = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"]  = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip"  },
          { name = "path"     },
        }, {
          { name = "buffer"   },
        }),
        experimental = {
          ghost_text = true,
        },
      })

      -- cmdline completions
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path"    },
        }, {
          { name = "cmdline" },
        }),
      })

      -- ensure web-dev filetypes get the same sources
      for _, ft in ipairs({
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "html", "css",
      }) do
        cmp.setup.filetype(ft, {
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip"  },
            { name = "path"     },
          }, {
            { name = "buffer"   },
          }),
        })
      end

      cmp.setup.filetype( "tex", { enabled = false })
    end,
  },
}

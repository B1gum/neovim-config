return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
          "lua_ls",
          "texlab",
          "ts_ls",
          "html",
          "cssls",
          "emmet_ls",
          "jsonls",
          "tailwindcss",
        },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Enable diagnostics virtual text and signs globally
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
			})

			-- Configure lua_ls (for Lua language)
			lspconfig.lua_ls.setup({})

			-- Configure texlab (for LaTeX)
			lspconfig.texlab.setup{
				settings = {
					texlab = {
						lint = {
							onChange = true,
						},
						forwardSearch = {
							executable = "skim",
							args = { "--synctex-forward", "%l:1:%f", "%p" },
						},
					},
				},
			}

      -- Condigure TypeScript / JavaScript / React / Next.js
      lspconfig.ts_ls.setup({})

      -- HTML
      lspconfig.html.setup({})

      -- CSS
      lspconfig.cssls.setup({})

      -- Emmet (in HTML/CSS/JSX/TSX)
      lspconfig.emmet_ls.setup({
        filetypes = {
          "html", "css", "javascriptreact", "typescriptreact",
          "vue", "svelte",
        },
        init_options = {},
      })

			-- Set key mappings for LSP
			vim.keymap.set("n", "D", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "CA", vim.lsp.buf.code_action, {})
		end,
	},
}

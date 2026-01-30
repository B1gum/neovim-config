return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        version = "1.32.0",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "texlab",
                    "html",
                    "marksman",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
            })


            vim.lsp.enable("lua_ls")

            vim.lsp.config("texlab", {
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
            })
            vim.lsp.enable("texlab")

            vim.lsp.enable("html")

            vim.lsp.enable("marksman")

            vim.lsp.config("emmet_ls", {
                filetypes = {
                    "html", "css", "javascriptreact", "typescriptreact",
                    "vue", "svelte",
                },
                init_options = {},
            })
            vim.lsp.enable("emmet_ls")

            vim.keymap.set("n", "D", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "CA", vim.lsp.buf.code_action, {})
        end,
    },
}

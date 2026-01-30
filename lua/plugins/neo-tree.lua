return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>ee", ":Neotree filesystem toggle left<CR>", {silent=true})

		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = false, -- You can toggle between showing hidden items
					hide_by_pattern = { -- Hide specific files
						"*.aux",
						"*.log",
						"*.fls",
						"*.fdb_latexmk",
						"*.synctex.gz",
            "*.pdf",
            "*.out",
            "*.sty",
            "*.synctex(busy)",
            "*.toc",
            "*.latexmain",
					},
				},
			},
		})
	end,
}

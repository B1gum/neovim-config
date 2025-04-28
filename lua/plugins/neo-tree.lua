return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>ee", ":Neotree filesystem toggle left<CR>", {silent=true})

		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = false, -- You can toggle between showing hidden items
					hide_dotfiles = true, -- Hide dotfiles by default
					hide_gitignored = true, -- Hide files ignored by git
					hide_by_pattern = { -- Hide specific files
						"*.aux",
						"*.log",
						"*.fls",
						"*.fdb_latexmk",
						"*.synctex.gz",
            "*.pdf",
            "*.out",
            "*.sagetex.sage",
            "*.sagetex.sage.py",
            "*.sagetex.scmd",
            "*.sagetex.sout",
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

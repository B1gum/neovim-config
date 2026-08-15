return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
			},
      sections = {
        lualine_c = {
          { "filename", path = 1 },
          "vimtex#StatusLine()",
          "lsp_progress",
        },
      }
		})
	end,
}

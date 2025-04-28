return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
			},
      sections_c = {
      { 'filename', path = 1},
        'vimtex#StatusLine()', -- display current compilation status
        'lsp_progress', -- display lsp-progress
      }
		})
	end,
}

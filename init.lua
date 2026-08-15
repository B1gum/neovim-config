local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("keymappings")
require("lazy").setup("plugins")

vim.opt.runtimepath:prepend(
    vim.fn.expand("~/.config/noah-inkscape/nvim")
)

require("noah-inkscape").setup()
require("course_context")

local python3 = vim.fn.exepath("python3")
if python3 ~= "" then
    vim.g.python3_host_prog = python3
end

package.path = package.path .. ';' .. vim.fn.expand("~/.config/lua/tungsten") .. "/?.lua"

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

vim.g.python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.12/bin/python3'

vim.env.PATH = vim.fn.system("echo -n $PATH")

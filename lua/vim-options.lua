local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.colorcolumn = "120"
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.swapfile = false
opt.timeout = true
opt.timeoutlen = 500

vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.cmd("let g:netrw_liststyle = 3")

local spell_group = vim.api.nvim_create_augroup("tex_spelling", { clear = true })
local spellfile = vim.fn.stdpath("config") .. "/spell/custom.utf-8.add"

vim.api.nvim_create_autocmd("FileType", {
  group = spell_group,
  pattern = "tex",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en,da"
    vim.opt_local.spellfile = spellfile
  end,
})

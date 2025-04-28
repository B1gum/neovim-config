-- Remap Caps Lock to Escape in Insert mode
vim.keymap.set("i", "<leader>jj", "<Esc>", { noremap = true, silent = true })

-- Remap Caps Lock to Escape in Normal mode
vim.keymap.set("n", "<leader>jj", "<Esc>", { noremap = true, silent = true })

-- Remap Caps Lock to Escape in Visual mode
vim.keymap.set("v", "<leader>jj", "<Esc>", { noremap = true, silent = true })

-- Remap Caps Lock to Escape in Command-line mode
vim.keymap.set("c", "<leader>jj", "<Esc>", { noremap = true, silent = true })

-- Auto-recenter after n
vim.keymap.set("n", "n", "nzz")

-- Auto-recenter after N
vim.keymap.set("n", "N", "NZZ")

vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal Split" })

-- Giles Castelle figures
vim.cmd [[
  inoremap <C-f> <Esc>:silent exec '.!inkscape-figures create "' . getline('.') . '" "' . b:vimtex.root . '/figures/"'<CR><CR>:w<CR>
  nnoremap <C-f> :silent exec '!inkscape-figures edit "' . b:vimtex.root . '/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
]]

-- Luasnip choice node jumps
vim.api.nvim_set_keymap("i", "<leader>ø", "<Plug>luasnip-next-choice", { desc = "Luasnip-next-choice" })
vim.api.nvim_set_keymap("s", "<leader>ø", "<Plug>luasnip-next-choice", { desc = "Luasnip-next-choice" })
vim.api.nvim_set_keymap("i", "<leader>æ", "<Plug>luasnip-prev-choice", { desc = "Luasnip-prev-choice" })
vim.api.nvim_set_keymap("s", "<leader>æ", "<Plug>luasnip-prev-choice", { desc = "Luasnip-prev-choice" })

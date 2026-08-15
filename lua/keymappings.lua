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
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal Split" })

-- Noah Inkscape workflow (Inspired by Gilles Castel's 2nd Blog post)
vim.keymap.set("n", "<C-f>", "<cmd>Figure<CR>", {
    noremap = true,
    silent = true,
    desc = "Figure: New",
})

-- Fix previous misspelled word with first suggestion
vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", {
  silent = true,
  desc = "Fix previous misspelling",
})

local function add_prev_bad_word()
  local view = vim.fn.winsaveview()
  vim.cmd("silent! normal! [s")

  local bad = vim.fn.spellbadword()[1]
  if bad == "" then
    vim.fn.winrestview(view)
    vim.notify("No previous misspelled word found", vim.log.levels.INFO)
    return
  end

  vim.cmd("silent! normal! zg")
  vim.fn.winrestview(view)
  vim.notify(("Added '%s' to spellfile"):format(bad), vim.log.levels.INFO)
end

vim.keymap.set("n", "<C-k>", add_prev_bad_word, {
  silent = true,
  desc = "Add previous misspelling to wordlist",
})

vim.keymap.set("i", "<C-k>", function()
  add_prev_bad_word()
  vim.cmd("startinsert")
end, {
  silent = true,
  desc = "Add previous misspelling to wordlist",
})

-- Luasnip choice node jumps
vim.api.nvim_set_keymap("i", "<leader>ø", "<Plug>luasnip-next-choice", { desc = "Luasnip-next-choice" })
vim.api.nvim_set_keymap("s", "<leader>ø", "<Plug>luasnip-next-choice", { desc = "Luasnip-next-choice" })
vim.api.nvim_set_keymap("i", "<leader>æ", "<Plug>luasnip-prev-choice", { desc = "Luasnip-prev-choice" })
vim.api.nvim_set_keymap("s", "<leader>æ", "<Plug>luasnip-prev-choice", { desc = "Luasnip-prev-choice" })


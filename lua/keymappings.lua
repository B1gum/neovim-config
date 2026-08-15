-- Fast Insert-mode escape without consuming native Normal/Visual motions.
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })

-- Keep search matches centered.
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", {
  silent = true,
  desc = "Clear search highlight",
})

-- Window namespace.
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", {
  silent = true,
  desc = "Window: vertical split",
})
vim.keymap.set("n", "<leader>wh", ":split<CR>", {
  silent = true,
  desc = "Window: horizontal split",
})

-- Figure workflow. The picker owns both opening and creating figures.
vim.keymap.set("n", "<leader>f", "<cmd>Figure<CR>", {
  noremap = true,
  silent = true,
  desc = "Figures",
})

local function fix_prev_bad_word()
  local view = vim.fn.winsaveview()
  vim.cmd("silent! normal! [s1z=")
  vim.fn.winrestview(view)
end

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

-- Spelling namespace.
vim.keymap.set("n", "<leader>sf", fix_prev_bad_word, {
  silent = true,
  desc = "Spelling: fix previous word",
})
vim.keymap.set("i", "<leader>sf", function()
  vim.cmd("stopinsert")
  fix_prev_bad_word()
  vim.cmd("startinsert")
end, {
  silent = true,
  desc = "Spelling: fix previous word",
})

vim.keymap.set("n", "<leader>sa", add_prev_bad_word, {
  silent = true,
  desc = "Spelling: add previous word",
})
vim.keymap.set("i", "<leader>sa", function()
  vim.cmd("stopinsert")
  add_prev_bad_word()
  vim.cmd("startinsert")
end, {
  silent = true,
  desc = "Spelling: add previous word",
})

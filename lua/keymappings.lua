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


-- Keymap to run Tungsten tests
vim.keymap.set("n", "T", function()
  local tungsten_root = vim.fn.expand("~/.config/nvim/lua/tungsten")

  local original_cwd = vim.fn.getcwd()

  vim.cmd("cd " .. tungsten_root)
  vim.notify("Changed directory to: " .. tungsten_root, vim.log.levels.INFO)

  local cmd_to_run = "PlenaryBustedDirectory ./tests/"
  local status_ok, err_msg = pcall(vim.cmd, cmd_to_run)

  if not status_ok then
    vim.notify("Error running tests: " .. tostring(err_msg), vim.log.levels.ERROR)
  else
    vim.notify("Running tests for Tungsten plugin...", vim.log.levels.INFO)
  end

  vim.cmd("cd " .. original_cwd)
end, { noremap = true, silent = true, desc = "Run Tungsten plugin tests" })

vim.keymap.set("n", "t", function()
  local current_file_path = vim.fn.expand('%:p')

  if current_file_path == '' then
    vim.notify("No file open to test.", vim.log.levels.WARN)
    return
  end

  local cmd_to_run = "PlenaryBustedFile " .. vim.fn.fnameescape(current_file_path)

  vim.notify("Running tests for: " .. current_file_path, vim.log.levels.INFO)

  local status_ok, err_msg = pcall(vim.cmd, cmd_to_run)

  if not status_ok then
    vim.notify("Error running test file command: " .. tostring(err_msg), vim.log.levels.ERROR)
  else
  end
end, { noremap = true, silent = true, desc = "Run tests for current file (Plenary)" })



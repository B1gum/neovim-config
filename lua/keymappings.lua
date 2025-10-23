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


local function get_tungsten_project_root_personal()
  local known_tungsten_root = "/Users/noahhansen/.config/nvim/lua/tungsten" -- YOUR PATH
  if not vim.fn.isdirectory(known_tungsten_root) then
    vim.notify("Tungsten root not found: " .. known_tungsten_root, vim.log.levels.ERROR)
    return nil
  end
  return known_tungsten_root
end

-- Keymap to run all Tungsten tests
vim.keymap.set("n", "T", function()
  local tungsten_root = get_tungsten_project_root_personal()
  if not tungsten_root then return end

  vim.env.TUNGSTEN_PROJECT_ROOT = tungsten_root

  local test_dir_raw = tungsten_root .. "/tests"
  local test_target_for_ex_cmd = vim.fn.fnameescape(vim.fn.fnamemodify(test_dir_raw, ":p"))

  local minimal_init_path_raw = tungsten_root .. "/tests/minimal_init.lua"
  local abs_minimal_init_path_shell_escaped = vim.fn.fnameescape(vim.fn.fnamemodify(minimal_init_path_raw, ":p"))

  local nvim_executable_shell = vim.fn.fnameescape(vim.v.progpath)

  local ex_command_payload = string.format("PlenaryBustedDirectory %s { exit = true }", test_target_for_ex_cmd)
  local c_argument_shell_escaped = vim.fn.shellescape(ex_command_payload)

  local shell_cmd = string.format("%s --headless -u %s -c %s",
                                  nvim_executable_shell,
                                  abs_minimal_init_path_shell_escaped,
                                  c_argument_shell_escaped)

  vim.notify("Keybinding 'T': Running all tests. Shell: " .. shell_cmd, vim.log.levels.INFO)
  print("Keybinding 'T': Executing: " .. shell_cmd)
  vim.cmd("vsplit | terminal " .. shell_cmd)
end, { noremap = true, silent = true, desc = "Run all Tungsten plugin tests" })


-- Keymap to run tests for the current file
vim.keymap.set("n", "t", function()
  local current_file_path_raw = vim.fn.expand('%:p')
  if current_file_path_raw == '' or not string.match(current_file_path_raw, "_spec%.lua$") then
    vim.notify("Not a Tungsten spec file, or no file open.", vim.log.levels.WARN)
    return
  end

  local tungsten_root = get_tungsten_project_root_personal()
  if not tungsten_root then return end

  vim.env.TUNGSTEN_PROJECT_ROOT = tungsten_root

  local test_target_for_ex_cmd = vim.fn.fnameescape(vim.fn.fnamemodify(current_file_path_raw, ":p"))

  local minimal_init_path_raw = tungsten_root .. "/tests/minimal_init.lua"
  local abs_minimal_init_path_shell_escaped = vim.fn.fnameescape(vim.fn.fnamemodify(minimal_init_path_raw, ":p"))

  local nvim_executable_shell = vim.fn.fnameescape(vim.v.progpath)

  local ex_command_payload = string.format("PlenaryBustedFile %s", test_target_for_ex_cmd)
  local c_argument_shell_escaped = vim.fn.shellescape(ex_command_payload)

  local shell_cmd = string.format("%s --headless -u %s -c %s",
                                  nvim_executable_shell,
                                  abs_minimal_init_path_shell_escaped,
                                  c_argument_shell_escaped)

  vim.notify("Keybinding 't': Running current file. Shell: " .. shell_cmd, vim.log.levels.INFO)
  print("Keybinding 't': Executing: " .. shell_cmd)
  vim.cmd("vsplit | terminal " .. shell_cmd)
end, { noremap = true, silent = true, desc = "Run current Tungsten spec file" })



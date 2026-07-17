-- Switch to command line mode without pressing a shift key
vim.keymap.set({ "n", "v" }, ";", ":")

-- Exit terminal mode by ESC key
vim.keymap.set("t", "<ESC>", function()
  return vim.bo.filetype == "fzf" and "<ESC>" or "<C-\\><C-n>"
end, { expr = true, silent = true })

-- Quickfix
vim.keymap.set("n", "]q", ":cnext<CR>")
vim.keymap.set("n", "[q", ":cprev<CR>")
vim.keymap.set("n", "qt", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end)

-- Diagnostics
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.api.nvim_create_user_command("DiagSetLocList", vim.diagnostic.setloclist, {})

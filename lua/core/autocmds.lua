-- Disable number in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("terminal", {}),
  command = "setlocal nonumber signcolumn=no",
})

local enabled = {
  "lua_ls",
  "ts_ls",
  "eslint",
  "jsonls",
}

return {
  enabled = enabled,
  managed = vim.list_extend(vim.deepcopy(enabled), { "jdtls" }),
}

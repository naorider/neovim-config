local M = {}

function M.setup()
  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  require("config.lsp.servers.lua").setup()
  require("config.lsp.servers.typescript").setup()
  require("config.lsp.servers.json").setup()

  vim.lsp.enable({
    "lua_ls",
    "ts_ls",
    "eslint",
    "jsonls",
  })

  require("config.lsp.keymaps").setup()
end

return M

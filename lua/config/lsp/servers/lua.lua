local M = {}

function M.setup()
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })
end

return M

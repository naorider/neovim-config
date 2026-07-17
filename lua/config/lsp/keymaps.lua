local typescript = require("config.lsp.servers.typescript")

local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
      local opts = { buffer = ev.buf, silent = true }

      vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client then
        typescript.on_attach(client, ev.buf)
      end
    end,
  })
end

return M

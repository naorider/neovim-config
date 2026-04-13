return {
  {
    'b0o/schemastore.nvim',
    init = function()
      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })
    end
  }
}

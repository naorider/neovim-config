local servers = require("config.lsp.servers")

return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = servers.managed,
      automatic_enable = false,
    },
  },
}

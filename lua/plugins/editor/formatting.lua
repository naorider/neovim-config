return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      local js_fmt = { "prettierd", "prettier", stop_after_first = true }

      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          rust = { "rustfmt", lsp_format = "fallback" },
          javascript = js_fmt,
          typescript = js_fmt,
          javascriptreact = js_fmt,
          typescriptreact = js_fmt,
        },
        format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
      })

      vim.keymap.set({ "n", "x" }, "<leader>fm", function()
        require("conform").format({ async = true })
      end, { silent = true })
    end,
  },
}

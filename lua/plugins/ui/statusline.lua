return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.o.laststatus = 3
    end,
    config = function()
      require("lualine").setup({
        options = { globalstatus = true },
      })
    end,
  },
}

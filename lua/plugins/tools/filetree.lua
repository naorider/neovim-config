return {
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
    config = true,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({ sort = { sorter = "case_sensitive" } })
    end,
    init = function()
      vim.keymap.set("n", "<leader>ee", function()
        vim.cmd("NvimTreeFindFileToggle")
      end)
    end,
  },
}

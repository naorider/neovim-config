return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "diff",
        "lua",
        "vim",
        "html",
        "javascript",
        "typescript",
        "tsx",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "vim", "html", "javascript", "typescript", "typescriptreact" },
        callback = function()
          -- Highlighting
          vim.treesitter.start()
          -- Folding
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
          -- Indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  -- Auto close/rename tags
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = true,
  },
}

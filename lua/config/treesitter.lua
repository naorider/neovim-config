local M = {}

function M.setup()
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
      vim.treesitter.start()
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M

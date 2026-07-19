return {
  {
    "junegunn/vim-easy-align",
    init = function()
      vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)")
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  "tpope/vim-abolish",
  "matze/vim-move",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}

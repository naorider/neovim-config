return {
  { 'morhetz/gruvbox' },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_colors = function(colors)
        colors.border = colors.blue
      end,
    },
    init = function() vim.cmd "colorscheme tokyonight" end
  },
}

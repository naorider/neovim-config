return {
  { "wesQ3/vim-windowswap" },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      local neoscroll = require("neoscroll")
      neoscroll.setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>" },
      })
      local keymap = {
        ["<C-u>"] = function()
          neoscroll.ctrl_u({ duration = 125 })
        end,
        ["<C-d>"] = function()
          neoscroll.ctrl_d({ duration = 125 })
        end,
        ["<C-b>"] = function()
          neoscroll.ctrl_b({ duration = 250 })
        end,
        ["<C-f>"] = function()
          neoscroll.ctrl_f({ duration = 250 })
        end,
      }
      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },
  {
    "haya14busa/vim-edgemotion",
    init = function()
      vim.keymap.set("", "<C-j>", "<Plug>(edgemotion-j)")
      vim.keymap.set("", "<C-k>", "<Plug>(edgemotion-k)")
    end,
  },
}

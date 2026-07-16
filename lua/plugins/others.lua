return {
  -- Swap windows by <Leader>ww
  { "wesQ3/vim-windowswap" },
  -- Fonts
  { "nvim-tree/nvim-web-devicons" },
  -- Diff blocks
  "adie/BlockDiff",
  -- Visualize indent
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  -- Status line
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
  -- Folding
  -- Uncomment until the 'curwin_col_off' issue is resolved.
  --    https://github.com/anuvyklack/pretty-fold.nvim/pull/41
  -- {
  --   'anuvyklack/pretty-fold.nvim',
  --   config = function()
  --     require('pretty-fold').setup({
  --       keep_indentation = false,
  --       fill_char = '━',
  --       sections = {
  --         left = {
  --           '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
  --         },
  --         right = {
  --           '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
  --         }
  --       }
  --     })
  --   end
  -- },
  { "anuvyklack/keymap-amend.nvim" },
  -- Colorlize color code (e.g #00BBCC)
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
  -- Easymotion
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      -- {
      --   "s",
      --   mode = { "n", "x", "o" },
      --   function()
      --     require("flash").jump()
      --   end,
      --   desc = "Flash",
      -- },
      -- {
      --   "S",
      --   mode = { "n", "x", "o" },
      --   function()
      --     require("flash").treesitter()
      --   end,
      --   desc = "Flash Treesitter",
      -- },
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
  -- Smooth scroll
  {
    "karb94/neoscroll.nvim",
    config = function()
      local neoscroll = require("neoscroll")
      neoscroll.setup({
        -- Disable <C-e>, <C-y> because I faced a performance issue in a small
        -- window.
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
  -- Move cursor by text block
  {
    "haya14busa/vim-edgemotion",
    init = function()
      vim.keymap.set("", "<C-j>", "<Plug>(edgemotion-j)")
      vim.keymap.set("", "<C-k>", "<Plug>(edgemotion-k)")
    end,
  },
  -- Align text
  {
    "junegunn/vim-easy-align",
    init = function()
      vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)")
    end,
  },
  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  -- Replace quickfix
  "thinca/vim-qfreplace",
  -- snake <-> camel
  -- cr_: snake_case
  -- crp: PascalCase
  -- cr-: kebab-case
  "tpope/vim-abolish",
  -- Move selected lines by <a-k>,<a-j>
  "matze/vim-move",
  -- Package manager
  { "williamboman/mason.nvim", config = true },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
    config = true,
  },
  -- File tree
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
  -- Preview quickfix list
  { "kevinhwang91/nvim-bqf" },
  -- "stevearc/dressing.nvim"
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      input = { enabled = true },
    },
  },
  {
    "jannis-baum/vivify.vim",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}

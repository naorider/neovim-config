return {
  -- Swap windows by <Leader>ww
  { 'wesQ3/vim-windowswap',        cond = not IsVSCode() },
  -- Fonts
  { 'nvim-tree/nvim-web-devicons', cond = not IsVSCode() },
  -- Diff blocks
  'adie/BlockDiff',
  -- Visualize indent
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    cond = not IsVSCode()
  },
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      vim.o.laststatus = 3
    end,
    config = function()
      require('lualine').setup({
        options = { globalstatus = true }
      })
    end
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
  { 'anuvyklack/keymap-amend.nvim' },
  -- Preview folding by pressing 'h'
  {
    'anuvyklack/fold-preview.nvim',
    dependencies = { 'anuvyklack/keymap-amend.nvim' },
    config = true
  },
  -- Colorlize color code (e.g #00BBCC)
  { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end },
  -- Easymotion
  {
    'phaazon/hop.nvim',
    config = true,
    init = function()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
    end
  },
  -- Smooth scroll
  {
    'karb94/neoscroll.nvim',
    config = function()
      local neoscroll = require('neoscroll')
      neoscroll.setup({
        -- Disable <C-e>, <C-y> because I faced a performance issue in a small
        -- window.
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>' }
      })
      local keymap = {
        ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 125 }) end,
        ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 125 }) end,
        ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 250 }) end,
        ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 250 }) end,
      }
      local modes = { 'n', 'v', 'x' }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end
  },
  -- Move cursor by text block
  {
    'haya14busa/vim-edgemotion',
    init = function()
      vim.keymap.set('', '<C-j>', '<Plug>(edgemotion-j)')
      vim.keymap.set('', '<C-k>', '<Plug>(edgemotion-k)')
    end
  },
  -- Align text
  {
    'junegunn/vim-easy-align',
    init = function()
      vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)')
    end
  },
  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true
  },
  -- Replace quickfix
  'thinca/vim-qfreplace',
  -- snake <-> camel
  -- cr_: snake_case
  -- crp: PascalCase
  -- cr-: kebab-case
  'tpope/vim-abolish',
  -- Move selected lines by <a-k>,<a-j>
  'matze/vim-move',
  -- Package manager
  { "williamboman/mason.nvim", config = true },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-tree.lua' },
    config = true
  },
  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end,
    init = function()
      vim.keymap.set('n',
        '<leader>ee',
        function() vim.cmd("NvimTreeFindFileToggle") end
      )
    end
  },
  -- Preview quickfix list
  { 'kevinhwang91/nvim-bqf' },
}

-- vim: foldmethod=marker foldcolumn=auto

-- Global {{{

-- Disable netrw. Instead, use NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

vim.o.number = true
vim.cmd.filetype('plugin indent on')
vim.cmd.syntax('enable')

-- Tab indent
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- Always display sign column
vim.o.signcolumn = 'yes'

-- Search setting
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.virtualedit = 'block'

-- Text width
vim.o.textwidth = 80
vim.o.colorcolumn = '+1'

-- wordwrap
vim.o.showbreak = '+++ '
vim.o.breakindent = true
vim.o.breakindentopt = 'sbr'

-- Visualize white-space, line-break
vim.o.list = true
vim.o.listchars = 'tab:» ,eol:«,trail:-'

-- Completion setting in command line
vim.o.wildmode = 'longest,list,full'

-- Undo
vim.o.undofile = true
vim.o.undodir = vim.env.HOME .. '/.neovim/undo'

-- Enable mouse controll in all mode
vim.o.mouse = 'a'

-- Line concatenation setting
-- j: Remove a comment leader when joining lines
-- m: Also break at a multibyte character above 255
-- M: When joining lines, don't insert a space before or after a multibyte character
vim.o.formatoptions = 'jmM'

-- Scroll
vim.o.scrolloff = 5

-- Duration for CursorHold event is fired
vim.o.updatetime = 500

-- Diff
vim.o.diffopt = vim.o.diffopt .. ',vertical'

-- Color
vim.o.termguicolors = true

-- }}}

-- Keymap & Auto commands {{{

-- Switch to command line mode without pressing a shift key
vim.keymap.set({ 'n', 'v' }, ';', ':')

-- Exit terminal mode by ESC key
vim.keymap.set('t',
  '<ESC>',
  function()
    return vim.g.filetype == 'fzf' and '<ESC>' or '<C-\\><C-n>'
  end,
  { expr = true, silent = true }
)

-- Quickfix
vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', '[q', ':cprev<CR>')
-- Toggle quickfix list
vim.keymap.set('n', 'qt', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end)

-- Diagnostics
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)
vim.api.nvim_create_user_command('DiagSetLocList', vim.diagnostic.setloclist, {})

-- Auto commands

-- Disable number in terminal
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('terminal', {}),
  command = 'setlocal nonumber signcolumn=no'
})

-- Format on save
-- https://github.com/neovim/nvim-lspconfig/issues/1792#issuecomment-1352782205
vim.g.format_on_save = 1
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup('FormatOnSave', {}),
  callback = function()
    if vim.g.format_on_save == 1 then
      vim.lsp.buf.format { async = false }
    end
  end
})

-- }}}

require('config.lazy')

-- Disable netrw. Instead, use NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.number = true

-- Tab indent
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- Always display sign column
vim.o.signcolumn = "yes"

-- Search setting
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.virtualedit = "block"

-- Text width
vim.o.textwidth = 80
vim.o.colorcolumn = "+1"

-- wordwrap
vim.o.showbreak = "+++ "
vim.o.breakindent = true
vim.o.breakindentopt = "sbr"

-- Visualize white-space, line-break
vim.o.list = true
vim.o.listchars = "tab:» ,eol:«,trail:-"

-- Completion setting in command line
vim.o.wildmode = "longest,list,full"

-- Undo
local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
vim.o.undofile = true
vim.o.undodir = undodir

-- Enable mouse controll in all mode
vim.o.mouse = "a"

-- Line concatenation setting
-- j: Remove a comment leader when joining lines
-- m: Also break at a multibyte character above 255
-- M: When joining lines, don't insert a space before or after a multibyte character
vim.o.formatoptions = "jmM"

-- Scroll
vim.o.scrolloff = 5

-- Duration for CursorHold event is fired
vim.o.updatetime = 500

-- Diff
vim.o.diffopt = vim.o.diffopt .. ",vertical"

-- Color
vim.o.termguicolors = true

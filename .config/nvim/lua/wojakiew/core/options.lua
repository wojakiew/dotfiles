vim.g.have_nerd_font = true

vim.o.wrap = false

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

vim.o.cursorline = true -- Show which line your cursor is on

-- tabs & indentation
vim.o.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.o.shiftwidth = 2 -- 2 spaces for indent width
vim.o.expandtab = true -- expand tab to spaces
vim.o.autoindent = true -- copy indent from current line when starting new one

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- search settings
vim.o.ignorecase = true
vim.o.smartcase = true

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- turn on termguicolors
vim.o.termguicolors = true
vim.o.background = "dark" -- colorschemes that can be light or dark will be made dark

-- backspace
vim.o.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- split windows
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

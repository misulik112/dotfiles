-- Use 'vim.opt' to set options conveniently
local opt = vim.opt

-- Enable autoindentation
opt.autoindent = true

-- Enable break indent
opt.breakindent = true

-- Access system clipboard
opt.clipboard = "unnamedplus"

-- Set command-line height to minimum
opt.cmdheight = 0

-- Use a combination of menu and keyboard for completion
opt.completeopt = "menuone,noselect"

-- Disable concealing characters
opt.conceallevel = 0

-- Confirm before closing unsaved changes
opt.confirm = true

-- Highlight current cursor line
opt.cursorline = true

-- Expand tabs to spaces
opt.expandtab = true

-- Set fill characters for end-of-buffer, folds, etc.
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Set the width of fold column
opt.foldcolumn = "1" -- '0' is not bad

-- Enable folding
opt.foldenable = true

-- Set the default fold level
opt.foldlevel = 99

-- Set the initial fold level
opt.foldlevelstart = 99

-- Set format options for auto-formatting
opt.formatoptions = "jqlnt" -- tcqj

-- Enable buffer hiding
opt.hidden = true

-- Disable highlighting search matches
opt.hlsearch = false

-- Ignore case when searching
opt.ignorecase = true

-- Incremental live preview of commands
opt.inccommand = "nosplit"

-- Do not insert spaces after joining lines
opt.joinspaces = false

-- Set the type of status line
opt.laststatus = 3

-- Show non-printable characters
opt.list = false 

-- Enable mouse support in all modes
opt.mouse = "a"

-- Show line numbers
opt.number = true

-- Set transparency for popup menu
opt.pumblend = 10

-- Set the maximum height of popup menu
opt.pumheight = 10

-- Show relative line numbers
opt.relativenumber = true

-- Set the maximum number of lines to remember in the scrollback buffer
opt.scrollback = 100000

-- Set the minimum number of lines to keep above/below the cursor during scrolling
opt.scrolloff = 8

-- Specify options to save in the session
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

-- Round indent to shiftwidth
opt.shiftround = true

-- Set the number of spaces for each level of indentation
opt.shiftwidth = 2

-- Suppress various kinds of messages
opt.shortmess:append { W = true, I = true, c = true, C = true }

-- Hide command-line message showing current command
opt.showcmd = false

-- Hide mode message
opt.showmode = false

-- Set the minimum number of columns to scroll horizontally
opt.sidescrolloff = 8

-- Control the display of the sign column
opt.signcolumn = "yes"

-- Enable smart case sensitivity for searches
opt.smartcase = true

-- Enable smart indentation
opt.smartindent = true

-- Open new split below the current one
opt.splitbelow = true

-- Keep splits open when closing a buffer
opt.splitkeep = "screen"

-- Open new split to the right of the current one
opt.splitright = true

-- Set the number of spaces for a tab character
opt.tabstop = 2

-- Enable true color support in the terminal
opt.termguicolors = true

-- Set the time in milliseconds to wait for a key code sequence to complete
opt.timeoutlen = 300

-- Set the title of the window to the value of 'titlestring'
opt.title = true

-- Enable persistent undo
opt.undofile = true

-- Set the time interval for writing to the swap file
opt.updatetime = 200

-- Set the behavior of wildcards in command-line completion
opt.wildmode = "longest:full,full"

-- Set leader key for key mappings
vim.g.mapleader = " "

-- Set local leader key for key mappings
vim.g.maplocalleader = ","

-- Disable recommended markdown styles
vim.g.markdown_recommended_style = 0

-- Set key mappings to no operation for normal and visual modes when pressing space
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })


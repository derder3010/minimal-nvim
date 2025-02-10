vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
-- Disable guicursor to make the cursor a block in all modes
vim.opt.guicursor = ""


vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50
vim.o.showmode = false
vim.o.showcmd = false

vim.opt.termguicolors = true
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- NETRW config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_set_var('t_Cs', '\\e[4:3m')
vim.api.nvim_set_var('t_Ce', '\\e[4:0m')

vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- customize lazygit popup window border characters
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = '' -- custom config file path

vim.opt.shortmess:append "c" -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-" -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use

vim.opt.foldenable = false


vim.opt.updatetime = 100
vim.g.skip_ts_context_commentstring_module = true


-- vim.opt.list = true
-- vim.opt.listchars = {
-- 	space = "·",
-- 	tab = "..",
-- 	-- trail = "·",
-- 	-- extends = "→",
-- 	-- precedes = "←",
-- 	-- eol = "↲"
-- }
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#4C566A", bg = "NONE", nocombine = true })
vim.api.nvim_set_hl(0, "NonText", { fg = "#4C566A", bg = "NONE", nocombine = true })

vim.opt.pumheight = 10

vim.o.title = true

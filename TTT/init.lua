---@diagnostic disable: undefined-global

--#042328
--#012b36
--#282828 #404040 #292929


vim.api.nvim_set_hl(0, "Normal",       { bg = "#042328" })
vim.api.nvim_set_hl(0, "StatusLine",   { bg = "#042328" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#042328" })

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("USERPROFILE") .. "/vimfiles/undodir"
vim.opt.undofile = true
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.list = true
vim.opt.inccommand = "split"
vim.o.showtabline = 0

vim.opt.shada = ""
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.number = true
vim.o.relativenumber = true
vim.o.virtualedit = "none"
vim.o.guicursor = "n-v-c:block"
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.o.cindent = true
vim.opt.breakindent = true
vim.o.copyindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.smartcase = true

vim.opt.updatetime = 300
vim.opt.iskeyword:append("-")
vim.opt.syntax = 'on'
vim.opt.timeoutlen = 300
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }
vim.o.statusline = "%<  %F %m %= %l,%L     "


vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>")
vim.api.nvim_set_keymap("n", "<C-E>", "7<C-E>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Y>", "7<C-Y>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "^", "0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "0", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "p", '"_dP', {})

vim.keymap.set("n", "k", function()
	return vim.fn.line(".") == 1 and "O<Esc>" or "k"
end, { expr = true })

vim.keymap.set("n", "j", function()
	return vim.fn.line(".") == vim.fn.line("$") and "o<Esc>" or "j"
end, { expr = true })

vim.keymap.set("n", "o", "ox<BS>", { noremap = true, silent = true})
vim.keymap.set("n", "O", "Ox<BS>", { noremap = true, silent = true})
vim.keymap.set("n", "i", "ix<BS>", { noremap = true, silent = true})
vim.keymap.set("n", "a", "ax<BS>", { noremap = true, silent = true})
vim.keymap.set("i", "<CR>", "<CR>x<BS>", { noremap = true, silent = true})


vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	command = "silent! filetype detect | silent! checktime"
})

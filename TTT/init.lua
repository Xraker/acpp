local color = {"#042328", "#101022", "#262626", "#012b36", "#1b1b1b", "#000000", "#1f292b"}
local bg_color = color[5]


vim.cmd("silent! source " .. vim.fn.stdpath("config") .. "/gruvbox.vim")
--vim.cmd("colorscheme blue")
--vim.cmd("colorscheme habamax")
--vim.cmd("colorscheme lunaperche")
--vim.cmd("colorscheme morning")
--vim.cmd("colorscheme retrobox")
--vim.cmd("colorscheme shine")

vim.api.nvim_set_hl(0, "Normal",       { bg = bg_color })
vim.api.nvim_set_hl(0, "StatusLine",   { bg = bg_color })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = bg_color })
vim.api.nvim_set_hl(0, "ModeMsg",      { bg = bg_color })
vim.api.nvim_set_hl(0, "CursorLine",   { bg = bg_color })
vim.api.nvim_set_hl(0, "Constant",     { bg = bg_color }) 

vim.opt.fillchars = { vert = "│", horiz = "─" }
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#414141" })
vim.api.nvim_set_hl(0, "LineNr",       { fg = "#555555"})
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFFFF"})

--vim.api.nvim_set_hl(0, "Whitespace",   { fg = bg_color })



vim.lsp.enable({"clangd"})
vim.diagnostic.config({
	--signs = false,
	--underline = false,
	virtual_text = true,
})

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("USERPROFILE") .. "/AppData/Local/nvim/undodir"
vim.opt.undofile = true
vim.opt.list = true
vim.opt.inccommand = "split"
vim.o.showtabline = 0
vim.opt.cursorline = true
vim.opt.laststatus = 2

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
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.o.statusline = "%<  %F %m %= %l,%L     "


vim.keymap.set("n", "<leader>q", ":wa | qa<CR>")
vim.keymap.set("n", "<leader><leader>", ":b#<CR>",{ silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "gD", "gDzz", {noremap = true})
vim.keymap.set("n", "N", "Nzz", {noremap = true})
vim.keymap.set("n", "n", "nzz", {noremap = true})
vim.keymap.set("n", "#", "*", {noremap = true})
vim.keymap.set("n", "*", "#", {noremap = true})
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

local sessionpath = os.getenv("USERPROFILE") .. "/AppData/Local/nvim/sessions/temp.vim"
local sessionpath_fn = vim.fn.fnameescape(os.getenv("USERPROFILE") .. "/AppData/Local/nvim/sessions/temp.vim")
vim.api.nvim_create_autocmd({"VimLeavePre", "BufWritePost"}, {
	callback = function()
		vim.cmd("mksession! " .. sessionpath_fn)
	end
})
if vim.fn.filereadable(sessionpath) == 1 then
	vim.cmd("silent! source " .. sessionpath_fn)
end

--##########################################################--
--##########################################################--
--##########################################################--

vim.keymap.set("n", "<leader>tt", function()
	local hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	local new_bg = hl.bg and "NONE" or bg_color
	vim.api.nvim_set_hl(0, "Normal", { bg = new_bg })

	local hl = vim.api.nvim_get_hl(0, { name = "StatusLine", link = false })
	local new_bg = hl.bg and "NONE" or bg_color
	vim.api.nvim_set_hl(0, "StatusLine", { bg = new_bg })

	local hl = vim.api.nvim_get_hl(0, { name = "StatusLineNC", link = false })
	local new_bg = hl.bg and "NONE" or bg_color
	vim.api.nvim_set_hl(0, "StatusLineNC", { bg = new_bg })
end)


local term = {buf = nil, win = nil, job = nil, toggle = 0}
function ToggleFloatTerm()
	local width = 123
	local height = 74
	local row = 0
	local col = 0
	
	local opts = {
    width = width,
    height = height,
    row = row,
    col = col,
    relative = "editor",
    style = "minimal",
    border = "none",
    }

	if term.toggle == 0 then
		vim.cmd("wa")
		term.buf = vim.api.nvim_create_buf(false, true)
		term.win = vim.api.nvim_open_win(term.buf, true, opts)
		term.job = vim.fn.termopen("cmd")
		vim.api.nvim_chan_send(vim.b.terminal_job_id, "s\r\n")
		--vim.api.nvim_chan_send(vim.b.terminal_job_id, "cls\r\n")
		vim.api.nvim_chan_send(vim.b.terminal_job_id, "b\r\n")
		vim.cmd("startinsert")
		
		term.toggle = term.toggle + 1
		
	elseif term.toggle % 2 == 0 then
		term.win = vim.api.nvim_open_win(term.buf, true, opts)
		vim.cmd("wa")
		--raddbg --ipc //interacts with the existing instance
		--raddbg --ipc kill_all
		--raddbg --ipc run
		vim.api.nvim_chan_send(vim.b.terminal_job_id, "raddbg --ipc kill_all && b\r\n")
		vim.cmd("startinsert")
		
		term.toggle = term.toggle + 1
	else
		vim.api.nvim_win_close(term.win, true)
		term.toggle = term.toggle + 1
	end
end

vim.api.nvim_set_keymap("n", "<leader>1", ":lua ToggleFloatTerm()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>1", "<C-\\><C-n>:lua ToggleFloatTerm()<CR>", { noremap = true, silent = true })

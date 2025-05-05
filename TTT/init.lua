--[[
leader c
leader e
leader w
leader rr
leader tt
leader 1 2 3 4 5


]]

vim.env.LANG = 'en_US.UTF-8'
vim.env.LC_ALL = 'en_US.UTF-8'
vim.opt.shada = ""
vim.cmd([[autocmd FileType cpp setlocal cindent]])
---@diagnostic disable: undefined-global

vim.g.mapleader = " "
vim.g.maplocalleader = "  "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.guicursor = "n-v-c:block"

vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.o.cindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.o.copyindent = true

vim.opt.signcolumn = "no"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.background = "dark"
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("USERPROFILE") .. "/vimfiles/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 0
vim.opt.updatetime = 50
vim.opt.completeopt = { "menuone", "noselect" }
vim.cmd([[set iskeyword+=-]])

vim.api.nvim_set_hl(0, "Normal", { bg = "#282828" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#404040" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#292929" })
vim.o.statusline = "%<  %F %m %= %l,%L     "

vim.opt.syntax = 'on'
vim.opt.wrap = true
vim.opt.timeoutlen = 300
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

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
--vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


vim.api.nvim_set_keymap("i", "{", "{<CR>}<Esc>O", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", '"', '""<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "(", "()<Left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "[", "[]<Left>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<", "<><Left>", { noremap = true, silent = true })

----------------------------------
----------------------------------
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', {clear = true}),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
        vim.cmd("startinsert")
        vim.api.nvim_chan_send(vim.b.terminal_job_id, "cls\r\n")
    end,
})
vim.keymap.set("t", "<leader>e", function()
    local filename = vim.g.terminal_file or "unknown_file"
    local command = "g++ -std=c++98 -fno-exceptions -fno-rtti -o " .. filename .. ".exe " .. filename .. ".cpp\r\n"
    local command2 = ".\\" .. filename .. ".exe\r\n"

    vim.api.nvim_chan_send(vim.b.terminal_job_id, command)
    vim.api.nvim_chan_send(vim.b.terminal_job_id, command2)
end, { noremap = true, silent = true })

vim.g.terminal_pos = { width = math.floor(vim.o.columns * 0.5), height = math.floor(vim.o.lines * 0.5), row = (vim.o.lines - math.floor(vim.o.lines * 0.5)) / 2, col = (vim.o.columns - math.floor(vim.o.columns * 0.5)) / 2 }
function terminal() -- 1. Removed key mapping and made it a standalone function
    
    vim.g.terminal_file = vim.fn.expand("%:t"):gsub("%.cpp$", "")
    if vim.g.mywin and vim.api.nvim_win_is_valid(vim.g.mywin) then
        vim.api.nvim_win_hide(vim.g.mywin)
        vim.g.mywin = nil
    else
        local buf = vim.g.mybuf or vim.api.nvim_create_buf(false, true)
        vim.g.mybuf = buf
        local width = math.floor(vim.o.columns * 0.5)
        local height = math.floor(vim.o.lines * 0.5)
        local opts = {
            relative = "editor",
            width = vim.g.terminal_pos.width,
            height = vim.g.terminal_pos.height,
            row = vim.g.terminal_pos.row,
            col = vim.g.terminal_pos.col,
            style = "minimal",
            border = ""
        }
        vim.g.mywin = vim.api.nvim_open_win(buf, true, opts)
        vim.cmd("startinsert")
        if vim.api.nvim_buf_line_count(buf) == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
            vim.g.myjob = vim.fn.termopen(vim.o.shell, {
                on_exit = function()
                    vim.g.mybuf = nil
                    vim.g.myjob = nil
                end
            })
            
        end
    end
end
vim.cmd("autocmd QuitPre * if g:myjob | call jobstop(g:myjob) | endif")


local function set_terminal_position(width, height, row, col)
    vim.g.terminal_pos = { width = width, height = height, row = row, col = col }
end

vim.keymap.set({"n", "t"}, "<leader>1", function()
    set_terminal_position(
    math.floor(vim.o.columns * 0.4), 
    vim.o.lines, 
    0, 
    vim.o.columns - math.floor(vim.o.columns * 0.4)
    )
    terminal()
end, { noremap = true, silent = true })

vim.keymap.set({"n", "t"}, "<leader>2", function()
    set_terminal_position(
    math.floor(vim.o.columns * 0.4), 
    vim.o.lines, 
    0, 
    0
    )
    terminal()
end, { noremap = true, silent = true })

vim.keymap.set({"n", "t"}, "<leader>3", function()
    set_terminal_position(
    vim.o.columns, 
    math.floor(vim.o.lines * 0.4),
    0, 
    0
    )
    terminal()
end, { noremap = true, silent = true })

vim.keymap.set({"n", "t"}, "<leader>4", function()
    set_terminal_position(
    vim.o.columns, 
    math.floor(vim.o.lines * 0.4), 
    vim.o.lines - math.floor(vim.o.lines * 0.4), 
    0
    )
    terminal()
end, { noremap = true, silent = true })

vim.keymap.set({"n", "t"}, "<leader>5", function()
    set_terminal_position(
    math.floor(vim.o.columns * 0.5),
    math.floor(vim.o.lines * 0.5),
    (vim.o.lines - math.floor(vim.o.lines * 0.5)) / 2,
    (vim.o.columns - math.floor(vim.o.columns * 0.5)) / 2
    )
    terminal()
end, { noremap = true, silent = true })

vim.keymap.set({"t"}, "<leader>w", function()
    terminal()
end, { noremap = true, silent = true })

vim.keymap.set({"n"}, "<leader>w", function()
    vim.cmd("w")
    terminal()
end, { noremap = true, silent = true })

vim.keymap.set({"n"}, "<leader>rr", function()
    vim.cmd("w")
    vim.cmd("luafile $MYVIMRC")
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>tt", function()
    local hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local new_bg = hl.bg and "NONE" or "#282828"
    vim.api.nvim_set_hl(0, "Normal", { bg = new_bg })

    local hl = vim.api.nvim_get_hl(0, { name = "StatusLine", link = false })
    local new_bg = hl.bg and "NONE" or "#282828"
    vim.api.nvim_set_hl(0, "StatusLine", { bg = new_bg })

    local hl = vim.api.nvim_get_hl(0, { name = "StatusLineNC", link = false })
    local new_bg = hl.bg and "NONE" or "#282828"
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = new_bg })

end)

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "k", function()
	if vim.fn.line(".") == 1 then
		return "O<Esc>"
	end
	return "k"
end, { expr = true })

vim.keymap.set("n", "j", function()
	if vim.fn.line(".") == vim.fn.line("$") then
		return "o<Esc>"
	end
	return "j"
end, { expr = true })

vim.keymap.set("n", "<leader>c", ":e C:/Users/aa/AppData/Local/nvim/init.lua<CR>")






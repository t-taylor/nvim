-- General
vim.cmd([[
    syntax on
    filetype indent plugin on
]])
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.modeline = true
vim.opt.ruler = true
vim.opt.backspace = "2"
vim.opt.encoding = "utf-8"
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.clipboard = "unnamedplus"
vim.opt.inccommand = "split"
vim.opt.winwidth = 80
vim.opt.list = true

HOME = os.getenv("HOME")

vim.opt.undofile = true
vim.opt.undodir = HOME .. "/.local/share/nvim/undo"
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = true
vim.opt.startofline = false
vim.opt.laststatus = 2
vim.opt.confirm = true
vim.opt.cmdheight = 1
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 200
vim.opt.signcolumn = "yes"

vim.opt.joinspaces = false

vim.opt.updatetime = 300
vim.opt.shortmess:append({ c = true })

vim.opt.mouse = "a"

vim.cmd([[
set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm
]])

vim.opt.shell = bash

vim.opt.ttimeoutlen = 150

vim.g.python_host_prog = "python2"
vim.g.python3_host_prog = "python3"

-- mappings
function map(mode, shortcut, command)
	vim.keymap.set(mode, shortcut, command, { noremap = true })
end

function nmap(shortcut, command)
	map("n", shortcut, command)
end

function imap(shortcut, command)
	map("i", shortcut, command)
end

map("", "Y", "y$")
map("n", ":", ";")
map("n", ";", ":")
map("v", ":", ";")
map("v", ";", ":")
map("", ";", ":")

map("i", "jk", "<Esc>")
map("i", "jl", "<Esc>:w<cr>")
map("t", "jk", "<C-\\><C-n>")
map("n", "go", ":tabedit")

vim.g.mapleader = ","
map("n", "<space>", "<nop>")
vim.g.maplocalleader = " "

-- function + mappings

function qf_toggle()
	for i = 1, vim.fn.winnr("$"), 1 do
		bnum = vim.fn.winbufnr(i)
		if vim.fn.getbufvar(bnum, "&buftype") == "quickfix" then
			vim.cmd.cclose()
		else
			vim.cmd.copen()
		end
	end
end

map("n", "yoq", qf_toggle)

-- sessions
vim.cmd([[function! MakeSession()
  let b:sessiondir = $HOME . "/.local/share/nvim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction
]])

vim.cmd([[
function! LoadSession()
  let b:sessiondir = $HOME . "/.local/share/nvim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction
]])

map("n", "<leader>ss ;call", "LoadSession()<cr>")
map("n", "<leader>sS ;call", "MakeSession()<cr>")
map("n", "<C-L> :nohl<CR><C-L>:syntax sync", "minlines=10000<cr>")

local remember_folds = vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = "*",
	group = remember_folds,
	command = "silent! mkview",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "*",
	group = remember_folds,
	command = "silent! loadview",
})

require("plugins")

if vim.fn.has("termguicolors") then
	vim.opt.termguicolors = true
end

vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox-material")

vim.opt.completeopt = "menu"
vim.opt.omnifunc = "syntaxcomplete#Complete"

vim.g.indentLine_char = ">"

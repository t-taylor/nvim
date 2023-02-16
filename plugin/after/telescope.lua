require("telescope").setup()

local builtin = require("telescope.builtin")
vim.keymap.set("n", "fzf", builtin.find_files, {})
vim.keymap.set("n", "fz/", builtin.live_grep, {})
vim.keymap.set("n", "fz*", builtin.grep_string, {})
vim.keymap.set("n", "fzb", builtin.buffers, {})
vim.keymap.set("n", "fzh", builtin.help_tags, {})
vim.keymap.set("n", "fz;", builtin.commands, {})

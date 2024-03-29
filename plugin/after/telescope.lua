local telescope = require("telescope").setup({
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})
require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "fzf", builtin.find_files, {})
vim.keymap.set("n", "fzg", builtin.live_grep, {})
vim.keymap.set("n", "fz*", builtin.grep_string, {})
vim.keymap.set("n", "fzb", builtin.buffers, {})
vim.keymap.set("n", "fzh", builtin.help_tags, {})
vim.keymap.set("n", "fz;", builtin.commands, {})

function FuzzyFindFiles()
    builtin.grep_string({
        path_display = { "smart" },
        only_sort_text = true,
        word_match = "-w",
        search = "",
    })
end

vim.keymap.set("n", "fz/", FuzzyFindFiles, {})

require("telescope").load_extension("projects")

vim.keymap.set("n", "fzp", require("telescope").extensions.projects.projects, {})

function FuzzyLines()
    builtin.live_grep({
        prompt_title = "find string in open buffers...",
        grep_open_files = true,
    })
end

vim.keymap.set("n", "fzl", FuzzyLines, {})

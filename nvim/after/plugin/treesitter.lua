local configs = require("nvim-treesitter.configs")
configs.setup {
    ensure_installed = "lua", "vim", "vimdoc", "query",
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {
        "markdown"
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,

    },
    indent = {
        enable = true,
        disable = { "yaml" }
    },
}

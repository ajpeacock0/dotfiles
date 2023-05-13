require('kanagawa').setup({
    commentStyle = { italic = false },
    keywordStyle = { italic = false},
    statementStyle = { bold = true },
    colors = {
        palette = {
            -- Comments
            fujiGray = "#88867d",

            -- Class Names, Type, Imports
            waveAqua2 = "#61ad6b",

            -- Variables
            carpYellow = "#E6C384",

            -- Function Names
            crystalBlue= "#f3c03f",
        },
    },
})

vim.cmd("colorscheme kanagawa")

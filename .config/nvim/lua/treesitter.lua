local treesitter = require('nvim-treesitter.configs')

treesitter.setup({
    playground = {
        enable = false,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    highlight = { enable = true },
    textobjects = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
    ensure_installed = {
        'bash',
        'comment',
        'cmake',
        'cpp',
        'css',
        'go',
        'html',
        'javascript',
        'python',
        'rust',
        'toml',
        'tsx',
        'typescript',
        'yaml',
    },
})

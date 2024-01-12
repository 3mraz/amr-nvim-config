require("toggleterm").setup{
    open_mapping = '<c-j>',
    autochdir = true,
    shade_terminals = true,
    start_in_insert = true,
    persist_mode = true,
    direction = 'float',
    shell = 'zsh',
    auto_scroll = true,
    float_opts = {
        border = 'curved',
        width = 100,
        height = 30,
        inblend = 3,
        zindex = 1,
    },
}

return {
    "akinsho/bufferline.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            mode = "tabs",
            numbers = "ordinal",
            show_buffer_icons = true, -- disable filetype icons for buffers
            get_element_icon = function(element)
                -- element consists of {filetype: string, path: string, extension: string, directory: string}
                -- This can be used to change how bufferline fetches the icon
                -- for an element e.g. a buffer or a tab.
                -- e.g.
                -- local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
                local icon, hl = require("mini.icons").get('extension', element.filetype)
                return icon, hl
            end,
        },
    },
}

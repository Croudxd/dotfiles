return {
    {
        'echasnovski/mini.surround',
        version = false,
        lazy = false,  -- load immediately
        config = function()
            require('mini.surround').setup({
                -- You can customize key mappings here if you want
                mappings = {
                    add = 'sa',       -- Add surrounding
                    delete = 'sd',    -- Delete surrounding
                    replace = 'sr',   -- Replace surrounding
                    find = 'sf',      -- Find surrounding (to the right)
                    find_left = 'sF', -- Find surrounding (to the left)
                    highlight = 'sh', -- Highlight surrounding
                    update_n_lines = 'sn', -- Update `n_lines`
                    suffix_last = 'l', -- Last
                    suffix_next = 'n', -- Next
                }
            })
        end
    }
}


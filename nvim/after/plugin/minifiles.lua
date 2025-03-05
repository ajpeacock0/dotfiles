require('mini.files').setup()

local map_split = function(buf_id, lhs, direction)
    local rhs = function()
        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(
            MiniFiles.get_explorer_state().target_window,
            function()
                vim.cmd(direction .. ' split')
                new_target_window = vim.api.nvim_get_current_win()
            end
        )

        MiniFiles.set_target_window(new_target_window)
        MiniFiles.go_in()
    end

    -- Adding `desc` will result into `show_help` entries
    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

local map_new_tab = function(buf_id, lhs)
    local rhs = function()
        -- Open the selected file in a new tab
        local entry = MiniFiles.get_fs_entry()
        if entry and entry.fs_type == 'file' then
            vim.cmd('tabnew ' .. vim.fn.fnameescape(entry.path))
        end
    end

    -- Adding `desc` will result in `show_help` entries
    local desc = 'Open in new tab'
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        local buf_id = args.data.buf_id

        map_split(buf_id, '<C-x>', 'belowright horizontal')
        map_split(buf_id, '<C-v>', 'belowright vertical')
        map_new_tab(buf_id, 't')
    end,
})

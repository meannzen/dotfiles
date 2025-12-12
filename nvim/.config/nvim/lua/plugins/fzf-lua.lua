return {
    'ibhagwan/fzf-lua',
    config = function()
        -- stop putting a giant window over my editor
        require'fzf-lua'.setup{
            winopts = {
                split = "belowright 10new",
                preview = {
                    hidden = true,
                }
            },
            grep = {
                rg_opts = "--column --line-number --no-heading --color=always --smart-case --glob '!.git' --glob '!target' --glob '!node_modules'",
            },
            files = {
                -- file icons are distracting
                file_icons = false,
                -- git icons are nice
                git_icons = true,
                -- but don't mess up my anchored search
                _fzf_nth_devicons = true,
            },
            buffers = {
                file_icons = false,
                git_icons = true,
                -- no nth_devicons as we'll do that
                -- manually since we also use
                -- with-nth
            },
            fzf_opts = {
                -- no reverse view
                ["--layout"]    = "default",
            },
        }
        -- when using C-p for quick file open, pass the file list through
        --
        --   https://github.com/jonhoo/proximity-sort
        --
        -- to prefer files closer to the current file.
        vim.keymap.set('', '<C-p>', function()
            opts = {}
            opts.cmd = 'fd --color=never --hidden --type f --type l --exclude .git'
            local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
            if base ~= '.' then
                -- if there is no current file,
                -- proximity-sort can't do its thing
                opts.cmd = opts.cmd .. (" | proximity-sort %s"):format(vim.fn.shellescape(vim.fn.expand('%')))
            end
            opts.fzf_opts = {
                  ["--scheme"]    = "path",
                  ["--tiebreak"]  = "index",
                  ["--layout"]    = "default",
            }
            require'fzf-lua'.files(opts)
        end)
        -- use fzf to search buffers as well
        vim.keymap.set('n', '<leader>;', function()
            require'fzf-lua'.buffers({
                -- just include the paths in the fzf bits, and nothing else
                -- https://github.com/ibhagwan/fzf-lua/issues/2230#issuecomment-3164258823
                fzf_opts = {
                  ["--with-nth"]      = "{-3..-2}",
                  ["--nth"]           = "-1",
                  ["--delimiter"]     = "[:\u{2002}]",
                  ["--header-lines"]  = "false",
                },
            header = false,
            })
        end)
    end
}
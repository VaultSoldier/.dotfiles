local picker = require 'snacks.picker'
local builtin = require 'telescope.builtin'
local map = vim.keymap.set

-- Find --
map('n', '<leader><leader>', picker.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>,', picker.smart, { desc = '[,] Smart Find Files' })
map('n', '<leader>f:', picker.command_history, { desc = '[:] Command History' })
map('n', '<leader>f.', picker.recent, { desc = '[.] Recent Files' })
map('n', '<leader>fg', picker.grep, { desc = '[g]rep' })
map('n', '<leader>fj', picker.jumps, { desc = '[j]ump' })
map('n', '<leader>fl', picker.loclist, { desc = '[l]oclist' })
map('n', '<leader>ff', picker.files, { desc = '[f]iles' })
map('n', '<leader>fi', picker.icons, { desc = '[i]cons' })
map('n', '<leader>fk', picker.keymaps, { desc = '[k]eymaps' })
map('n', '<leader>fm', picker.man, { desc = '[m]an' })
map('n', '<leader>fh', picker.help, { desc = '[h]elp' })
map('n', '<leader>fd', picker.diagnostics, { desc = '[d]iagnostics' })
map('n', '<leader>fr', picker.resume, { desc = '[r]esume' })
map('n', '<leader>fu', picker.undo, { desc = '[u]ndo' })
map('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = '[t]odo all' })
map('n', '<leader>fT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', { desc = '[T]odo/Fix/Fixme' })
map({ 'n', 'x' }, '<leader>fw', picker.grep_word, { desc = '[w] current word' })

map('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, { desc = '[s] Document symbols' })
map('n', '<leader>fS', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[S] Workspace symbols' })

map('n', '<leader>fn', function()
  picker.files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[n]eovim Config' })

-- Slightly advanced example of overriding default behavior and theme
map('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

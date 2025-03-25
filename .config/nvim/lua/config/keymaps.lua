local map = vim.keymap.set
local builtin = require 'telescope.builtin'

map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

map('n', ';', ':', { desc = 'CMD enter command mode' })
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('i', 'jj', '<Esc>')

map('v', '<Tab>', '>gv', { noremap = true, silent = true })
map('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
map('i', '<Tab>', '<C-t>', { noremap = true, silent = true })
map('i', '<S-Tab>', '<C-d>', { noremap = true, silent = true })

-- CTRL+<hjkl> to switch between windows
-- See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('i', '<C-h>', '<Left>', { noremap = true, silent = true })
map('i', '<C-j>', '<Down>', { noremap = true, silent = true })
map('i', '<C-k>', '<Up>', { noremap = true, silent = true })
map('i', '<C-l>', '<Right>', { noremap = true, silent = true })

map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('x', '<leader>p', '"_dP')

-- File operations
map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<C-q>', '<cmd>wq<CR>', { desc = 'Save and exit' })
map('n', '<C-x>', ':confirm q<CR>', { desc = 'Exit' })

-- Buffers
-- map('n', '<leader>b', '<cmd>tabnew<CR>', { desc = 'tab new' })
map('n', '<leader>x', '<cmd>tabclose<CR>', { desc = 'tab close' })
map('n', '<Tab>', ':bnext<CR>', { silent = true })
map('n', '<S-Tab>', ':bprev<CR>', { silent = true })

-- Buffer Navigation
map('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })

-- Buffer Movement (requires plugin like 'famiu/bufdelete.nvim' or custom function)
map('n', '[B', ':BufMoveLeft<CR>', { desc = 'Move buffer left' }) -- Requires plugin
map('n', ']B', ':BufMoveRight<CR>', { desc = 'Move buffer right' }) -- Requires plugin

-- Code
map('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- See `:help telescope.builtin`
map('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
map('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
map('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
map('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
map('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
map('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [G]rep' })
map('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
map('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
map('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Slightly advanced example of overriding default behavior and theme
map('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
map('n', '<leader>f/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[F]ind [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
map('n', '<leader>fn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[F]ind [N]eovim files' })

-- Switch to buffer 1-9 with Alt+1-9
for i = 1, 9 do
  map('n', string.format('<A-%s>', i), function()
    require('bufferline').go_to(i)
  end)
end

-- Switch to tab 1-9 with Ctrl+1-9
for i = 1, 9 do
  map('n', string.format('<C-%s>', i), '<cmd>' .. i .. 'tabnext<CR>')
end

map('t', '<C-x>', '<C-\\><C-N>', { desc = 'terminal escape terminal mode' })

-- command mode alt+jk
map('c', '<A-j>', '<Down>')
map('c', '<A-k>', '<Up>')

map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
map('v', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('v', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('v', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('v', '<down>', '<cmd>echo "Use j to move!!"<CR>')

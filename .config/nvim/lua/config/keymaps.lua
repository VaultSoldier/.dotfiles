local map = vim.keymap.set
local builtin = require 'telescope.builtin'
local picker = Snacks.picker
local snacks = Snacks

map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

map('n', ';', ':', { desc = 'CMD enter command mode' })
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('i', 'jj', '<Esc>')

map('v', '<Tab>', '>gv', { noremap = true, silent = true })
map('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
-- map('i', '<Tab>', '<C-t>', { noremap = true, silent = true })
-- map('i', '<S-Tab>', '<C-d>', { noremap = true, silent = true })

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

-- File operations --
map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<C-q>', '<cmd>wq<CR>', { desc = 'Save and exit' })
map('n', '<C-x>', ':confirm q<CR>', { desc = 'Exit' })
map('n', '<leader>e', ':Neotree reveal<CR>', { desc = 'File Explorer', silent = true })
map('n', '<leader>ar', snacks.rename.rename_file, { desc = '[R]ename File' })

-- Buffers --
map('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer', silent = true })
map('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer', silent = true })
map('n', '<leader>x', '<cmd>bd<CR>', { desc = 'buffer close' })

-- Buffer Movement (requires plugin like 'famiu/bufdelete.nvim' or custom function)
map('n', '[B', ':BufMoveLeft<CR>', { desc = 'Move buffer left' }) -- Requires plugin
map('n', ']B', ':BufMoveRight<CR>', { desc = 'Move buffer right' }) -- Requires plugin

-- Switch to buffer 1-9 with Alt+1-9
for i = 1, 9 do
  map('n', string.format('<A-%s>', i), function()
    require('bufferline').go_to(i)
  end)
end

-- Tabs --
-- map('n', '<leader>b', '<cmd>tabnew<CR>', { desc = 'tab new' })
map('n', '<Tab>', ':tabnext<CR>', { silent = true })
map('n', '<S-Tab>', ':tabprevious<CR>', { silent = true })

-- Toggle --
map('n', 'tn', snacks.notifier.hide, { desc = 'Dismiss All [N]otifications' })

-- Git --
map('n', '<leader>gb',  picker.git_branches, { desc = '[G]it [B]ranches' })
map('n', '<leader>gl',  picker.git_log, { desc = '[G]it [L]og' })
map('n', '<leader>gl',  picker.git_log_line, { desc = '[G]it Log [L]ine' })
map('n', '<leader>gs',  picker.git_status, { desc = '[G]it [S]tatus' })
map('n', '<leader>gS',  picker.git_stash, { desc = '[G]it [S]tash' })
map('n', '<leader>gd',  picker.git_diff, { desc = '[G]it [D]iff' })
map('n', '<leader>gf',  picker.git_log_file, { desc = '[G]it Log [F]ile' })
map({ 'n', 'v' }, '<leader>gB',  snacks.gitbrowse, { desc = '[G]it [B]rowse' })

-- Code --
map('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

map('n', '<leader><leader>',  picker.buffers,         { desc = '[ ] Find existing buffers' })
map('n', '<leader>,',         picker.smart,           { desc = '[,] Smart Find Files'})
map('n', '<leader>:',         picker.command_history, { desc = '[:] Command History' })
map('n', '<leader>f.',        picker.recent,          { desc = '[F]ind Recent Files ("." for repeat)' })
map('n', '<leader>fp',        picker.projects,        { desc = '[F]ind [P]rojects' })
map('n', '<leader>fg',        picker.grep,            { desc = '[F]ind [G]rep'})
map('n', '<leader>fj',        picker.jumps,           { desc = '[F]ind [J]ump' })
map('n', '<leader>fj',        picker.loclist,         { desc = '[F]ind [L]oclist' })
map('n', '<leader>ff',        picker.files,           { desc = '[F]ind [F]iles' })
map('n', '<leader>fi',        picker.icons,           { desc = '[F]ind [I]cons' })
map({'n', 'x'}, '<leader>fw', picker.grep_word,       { desc = '[F]ind current [W]ord' })
map('n', '<leader>fk',        picker.keymaps,         { desc = '[F]ind [K]eymaps' })
map('n', '<leader>fm',        picker.man,             { desc = '[F]ind [M]an' })
map('n', '<leader>fh',        picker.help,            { desc = '[F]ind [H]elp' })
map('n', '<leader>fd',        picker.diagnostics,     { desc = '[F]ind [D]iagnostics' })
map('n', '<leader>fr',        picker.resume,          { desc = '[F]ind [R]esume' })
map('n', '<leader>fu',        picker.undo,            { desc = '[F]ind [U]ndo' })

map('n', '<leader>fn', function() picker.files
  { cwd = vim.fn.stdpath 'config' }
end, { desc = '[F]ind [N]eovim Config' })

-- Slightly advanced example of overriding default behavior and theme
map('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

map('n', '<leader>n', snacks.notifier.show_history, { desc = '[N]otification history' })

map('t', '<C-x>', '<C-\\><C-N>', { desc = 'terminal escape terminal mode' })

-- command mode alt+jk
map('c', '<A-j>', '<Down>')
map('c', '<A-k>', '<Up>')

map({'v', 'n', 'i'}, '<left>', '<cmd>echo "Use h to move!!"<CR>')
map({'v', 'n', 'i'}, '<right>', '<cmd>echo "Use l to move!!"<CR>')
map({'v', 'n', 'i'}, '<up>', '<cmd>echo "Use k to move!!"<CR>')
map({'v', 'n', 'i'}, '<down>', '<cmd>echo "Use j to move!!"<CR>')


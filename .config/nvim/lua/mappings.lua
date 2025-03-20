local map = vim.keymap.set
local builtin = require 'telescope.builtin'
map('n', ';', ':', { desc = 'CMD enter command mode' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('i', 'jj', '<Esc>')

map('v', '<Tab>', '>gv', { noremap = true, silent = true })
map('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
map('i', '<Tab>', '<C-t>', { noremap = true, silent = true })
map('i', '<S-Tab>', '<C-d>', { noremap = true, silent = true })

map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
map('v', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('v', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('v', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('v', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('x', '<leader>p', '"_dP')

-- Comment
map('n', '<C-_>', 'gcc', { desc = 'toggle comment' })
map('v', '<C-_>', 'gc', { desc = 'toggle comment' })

-- File operations
map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<C-q>', '<cmd>wq<CR>', { desc = 'Save and exit' })
map('n', '<C-x>', ':q!<CR>', { desc = 'Exit' })

-- Buffers
map('n', '<leader>b', '<cmd>tabnew<CR>', { desc = 'buffer new' })
map('n', '<leader>x', '<cmd>tabclose<CR>', { desc = 'buffer close' })
map('n', '<tab>', '<cmd>tabnext<CR>', { desc = 'buffer goto next' })
map('n', '<S-tab>', '<cmd>tabprevious<CR>', { desc = 'buffer goto prev' })

-- Code
map('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    map('n', '<leader>cr', ':!python %<CR>', { noremap = true, silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function()
    map('n', '<leader>cr', ':!open %<CR>', { noremap = true, silent = true, buffer = true })
  end,
})

map('n', '<leader>ct', '<cmd>Telescope git_status<CR>', { desc = 'telescope git status' })
map('n', '<leader>fm', '<cmd>Telescope marks<CR>', { desc = '[F]ind [M]arks' })
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = '[F]ind [B]uffers' })
map('n', '<leader>ft', '<cmd>Telescope terms<CR>', { desc = '[F]ind [T]erminals' })

-- See `:help telescope.builtin`
map('n', '<leader>fv', '<cmd>VenvSelect<CR>', { desc = '[S]elect [V]envs' }) -- VenvSelector.
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

-- buffer change with alt + 1 to 9
for i = 1, 9, 1 do
  map('n', string.format('<A-%s>', i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

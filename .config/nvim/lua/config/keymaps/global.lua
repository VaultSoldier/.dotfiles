local M = {}
local snacks = require 'snacks'
local picker = snacks.picker

function M.Init()
  local map = vim.keymap.set

  map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
  map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
  map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
  map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

  map('n', ';', ':', { desc = 'CMD enter command mode' })
  map('n', '<Esc>', '<cmd>nohlsearch<CR>')
  map('i', 'jj', '<Esc>')
  map('i', '<A-BS>', '<C-w>')

  map('v', '<Tab>', '>gv', { noremap = true, silent = true })
  map('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

  map('n', '<leader>tz', function()
    snacks.zen()
  end, { desc = 'Toggle Zen Mode' })

  map('n', '<leader>tZ', function()
    snacks.zen.zoom()
  end, { desc = 'Toggle Zoom' })

  map('n', '<leader>.', function()
    snacks.scratch()
  end, { desc = 'Toggle Scratch Buffer' })

  map('n', '<leader>S', function()
    snacks.scratch.select()
  end, { desc = 'Select Scratch Buffer' })

  -- See `:help wincmd` for a list of all window commands
  map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  map('i', '<C-h>', '<Left>', { noremap = true, silent = true })
  map('i', '<C-j>', '<Down>', { noremap = true, silent = true })
  map('i', '<C-k>', '<Up>', { noremap = true, silent = true })
  map('i', '<C-l>', '<Right>', { noremap = true, silent = true })

  map('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
  map('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

  map('n', 'J', 'mzJ`z')
  map('n', '<C-d>', '<C-d>zz')
  map('n', '<C-u>', '<C-u>zz')
  map('n', 'n', 'nzzzv')
  map('n', 'N', 'Nzzzv')

  map('x', '<leader>p', '"_dP')

  -- File operations --
  map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save', silent = true })
  map('n', '<C-q>', '<cmd>q<CR>', { desc = 'Close', silent = true })
  -- map('n', '<C-x>', ':confirm quitall<CR>', { desc = 'Exit', silent = true })
  map('n', '<leader>e', '<Cmd>Neotree reveal<CR>')
  map('n', '<leader>ar', snacks.rename.rename_file, { desc = '[R]ename File' })

  -- Buffers --
  map('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })
  map('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })

  map('n', '<leader>x', function()
    snacks.bufdelete()
  end, { desc = '[X] Buffer Close' })

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
  map('n', '<leader>ab', '<cmd>tabnew<CR>', { desc = 'tab new' })
  map('n', '<leader>ax', '<cmd>tabclose<CR>', { desc = 'tab close' })
  map('n', '<Tab>', ':tabnext<CR>', { silent = true })
  map('n', '<S-Tab>', ':tabprevious<CR>', { silent = true })

  map('n', '<leader>n', picker.notifications, { desc = '[N]otification history' })

  -- sessions
  map('n', '<leader>sl', function()
    require('nvim-possession').list()
  end, { desc = '📌list sessions' })

  map('n', '<leader>sn', function()
    require('nvim-possession').new()
  end, { desc = '📌create new session' })

  map('n', '<leader>su', function()
    require('nvim-possession').update()
  end, { desc = '📌update current session' })

  map('n', '<leader>sd', function()
    require('nvim-possession').delete()
  end, { desc = '📌delete selected session' })

  -- Toggle --
  map('n', 'tn', snacks.notifier.hide, { desc = 'Dismiss All [N]otifications' })
end

function M.Toggle()
  local toggle = snacks.toggle

  toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
  toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
  toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tR'
  toggle.diagnostics():map '<leader>td'
  toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>tc'
  toggle.treesitter():map '<leader>tT'
  toggle.inlay_hints():map '<leader>th'
  toggle.indent():map '<leader>ti'
  toggle.dim():map '<leader>tm'
end

return M

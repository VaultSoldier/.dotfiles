local M = {}
local snacks = require 'snacks'

function M.Init()
  local map = vim.keymap.set

  map('t', '<C-x>', '<C-\\><C-N>', { desc = 'Escape terminal mode' })

  map({ 'n', 't' }, '<A-v>', function()
    snacks.terminal.toggle(nil, { win = { position = 'bottom' }, env = { POSITION = 'bottom' } })
  end, { desc = 'Terminal toggleable vertical term' })

  map({ 'n', 't' }, '<A-i>', function()
    snacks.terminal.toggle(nil, { win = { position = 'float' }, env = { POSITION = 'float' } })
  end, { desc = 'Toggle floating terminal' })
end

function M.Lsp(map)
  -- venv-selector
  map('<leader>cps', '<cmd>VenvSelect<cr>', 'Pick venv')
  map('<leader>cpc', '<cmd>VenvSelectCached<cr>', 'Load venv from cache')

  map('<F10>', function()
    local file = vim.fn.shellescape(vim.fn.expand '%')
    local filetype = vim.bo.filetype

    local function run(cmd)
      snacks.terminal.toggle({ 'bash', '-i', '-c', cmd .. ' ' .. file .. '; $SHELL' }, {
        win = { position = 'bottom' },
      })
    end

    if filetype == 'python' then
      run 'python3'
    elseif filetype == 'sh' then
      run 'bash'
    elseif filetype == 'html' then
      vim.cmd '!live-server .'
    else
      print 'Unsupported file type'
    end
  end, 'Run current file', { 'n', 'v', 't', 'i' })

  map('<F11>', function()
    local filetype = vim.bo.filetype

    if filetype == 'python' then
      -- Search for main.py in project directories
      local main_file = vim.fn.findfile('main.py', '.;')
      if main_file ~= '' then
        -- Get absolute path of main.py and its directory
        local main_abs = vim.fn.fnamemodify(main_file, ':p')
        local main_dir = vim.fn.fnamemodify(main_abs, ':h')
        -- Construct safe shell command
        local cmd = string.format('cd %s && python3 %s', vim.fn.shellescape(main_dir), vim.fn.shellescape(main_abs))
        snacks.terminal.toggle(cmd .. '; $SHELL', { win = { position = 'bottom', interactive = true } })
      else
        print 'Error: main.py not found in project'
      end
    else
      print 'Unsupported file type'
    end
  end, 'Run project', { 'n', 'v', 't', 'i' })
end

return M

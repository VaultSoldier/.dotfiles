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
  -- Interpreter recorded by venv-selector for the current project, if any
  -- (falls back to nil when the plugin is absent or the cached venv is gone).
  local function selected_python()
    local ok, venvs = pcall(require, 'venv-selector')
    if ok then
      local python = venvs.python()
      if python and vim.fn.executable(python) == 1 then
        return python
      end
    end
  end

  map('<F10>', function()
    local file = vim.fn.shellescape(vim.fn.expand '%')
    local filetype = vim.bo.filetype

    local function run(cmd)
      snacks.terminal.toggle({ 'bash', '-i', '-c', cmd .. ' ' .. file .. '; $SHELL' }, {
        win = { position = 'bottom' },
      })
    end

    if filetype == 'python' then
      -- Use the venv-selected interpreter when available, else system python3
      local python = selected_python()
      run(python and vim.fn.shellescape(python) or 'python3')
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
      if main_file == '' then
        vim.notify('main.py not found', vim.log.levels.ERROR)
        return
      end

      -- Get absolute path and directory
      local main_abs = vim.fn.fnamemodify(main_file, ':p')
      local main_dir = vim.fn.fnamemodify(main_abs, ':h')

      -- Choose python executable (prefer the venv selected by venv-selector)
      local python = selected_python() or (vim.fn.executable 'python3' == 1 and 'python3' or 'python')

      -- Check whether flet is importable with the chosen python
      local check_cmd = {
        python,
        '-c',
        'import flet',
      }

      vim.fn.system(check_cmd)
      local has_flet = (vim.v.shell_error == 0)
      local cmd

      if has_flet then
        cmd = string.format('cd %s && flet run -r', vim.fn.shellescape(main_dir))
      else
        cmd = string.format('cd %s && %s %s', vim.fn.shellescape(main_dir), vim.fn.shellescape(python), vim.fn.shellescape(main_abs))
      end

      local cur_win = vim.api.nvim_get_current_win()

      snacks.terminal.toggle(cmd .. '; $SHELL', {
        interactive = false, -- top-level terminal option: no auto-insert/start-insert/auto-close
        win = { position = 'bottom' },
      })

      -- restore win focus
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(cur_win) then
          vim.api.nvim_set_current_win(cur_win)
        end
      end)
    else
      vim.notify('Unsupported file type', vim.log.levels.INFO)
    end
  end, 'Run project', { 'n', 'v', 't', 'i' })
end

return M

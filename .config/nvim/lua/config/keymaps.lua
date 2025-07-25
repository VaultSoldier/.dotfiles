local M = {}
local snacks = require 'snacks'
local picker = snacks.picker

function M.global()
  local builtin = require 'telescope.builtin'
  local map = vim.keymap.set

  map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
  map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
  map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
  map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

  map('n', ';', ':', { desc = 'CMD enter command mode' })
  map('n', '<Esc>', '<cmd>nohlsearch<CR>')
  map('i', 'jj', '<Esc>')

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
  -- map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save', silent = true })
  map('n', '<C-q>', '<cmd>q<CR>', { desc = 'Close', silent = true })
  -- map('n', '<C-x>', ':confirm quitall<CR>', { desc = 'Exit', silent = true })
  map('n', '<leader>e', '<Cmd>Neotree reveal<CR>')
  map('n', '<leader>ar', snacks.rename.rename_file, { desc = '[R]ename File' })

  -- Buffers --
  map('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer', silent = true })
  map('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer', silent = true })

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

  -- Terminal --
  map({ 'n', 't' }, '<A-v>', function()
    snacks.terminal.toggle(nil, { env = { NVIM_TERM_ID = '0' }, win = { position = 'bottom' } })
  end, { desc = 'Terminal toggleable vertical term' })

  map({ 'n', 't' }, '<A-i>', function()
    snacks.terminal.toggle(nil, { env = { NVIM_TERM_ID = '2' }, win = { position = 'float' } })
  end, { desc = 'Toggle floating terminal' })

  -- Toggle --
  map('n', 'tn', snacks.notifier.hide, { desc = 'Dismiss All [N]otifications' })

  -- Code --
  map('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
  map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic [Q]uickfix list' })

  map('n', '[d', function()
    vim.diagnostic.jump { count = -1 }
  end, { desc = 'Go to previous [D]iagnostic message' })

  map('n', ']d', function()
    vim.diagnostic.jump { count = 1 }
  end, { desc = 'Go to next [D]iagnostic message' })

  map('n', '<leader><leader>', picker.buffers, { desc = '[ ] Find existing buffers' })
  map('n', '<leader>,', picker.smart, { desc = '[,] Smart Find Files' })
  map('n', '<leader>:', picker.command_history, { desc = '[:] Command History' })
  map('n', '<leader>f.', picker.recent, { desc = '[F]ind Recent Files ("." for repeat)' })
  map('n', '<leader>fp', picker.projects, { desc = '[F]ind [P]rojects' })
  map('n', '<leader>fg', picker.grep, { desc = '[F]ind [G]rep' })
  map('n', '<leader>fj', picker.jumps, { desc = '[F]ind [J]ump' })
  map('n', '<leader>fJ', picker.loclist, { desc = '[F]ind [L]oclist' })
  map('n', '<leader>ff', picker.files, { desc = '[F]ind [F]iles' })
  map('n', '<leader>fi', picker.icons, { desc = '[F]ind [I]cons' })
  map('n', '<leader>fk', picker.keymaps, { desc = '[F]ind [K]eymaps' })
  map('n', '<leader>fm', picker.man, { desc = '[F]ind [M]an' })
  map('n', '<leader>fh', picker.help, { desc = '[F]ind [H]elp' })
  map('n', '<leader>fd', picker.diagnostics, { desc = '[F]ind [D]iagnostics' })
  map('n', '<leader>fr', picker.resume, { desc = '[F]ind [R]esume' })
  map('n', '<leader>fu', picker.undo, { desc = '[F]ind [U]ndo' })
  map({ 'n', 'x' }, '<leader>fw', picker.grep_word, { desc = '[F]ind current [W]ord' })

  map('n', '<leader>fn', function()
    picker.files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[F]ind [N]eovim Config' })

  -- Slightly advanced example of overriding default behavior and theme
  map('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  map('n', '<leader>n', picker.notifications, { desc = '[N]otification history' })
  map('t', '<C-x>', '<C-\\><C-N>', { desc = 'terminal escape terminal mode' })

  -- command mode alt+jk
  map('c', '<A-j>', '<Down>')
  map('c', '<A-k>', '<Up>')

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
end

function M.lsp(map)
  -- venv-selector
  map('<leader>cps', '<cmd>VenvSelect<cr>', 'Pick venv')
  map('<leader>cpc', '<cmd>VenvSelectCached<cr>', 'Load venv from cache')

  map('<F10>', function()
    local filetype = vim.bo.filetype
    if filetype == 'python' then
      snacks.terminal.open('python3 ' .. vim.fn.expand '%', { win = { position = 'bottom', interactive = true } })
    elseif filetype == 'html' then
      vim.cmd '!live-server .'
    else
      print 'Unsupported file type'
    end
  end, 'Run code', { 'n', 'v', 't', 'i' })

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
        snacks.terminal.open(cmd, { win = { position = 'bottom', interactive = true } })
      else
        print 'Error: main.py not found in project'
      end
    else
      print 'Unsupported file type'
    end
  end, 'Run main file', { 'n', 'v', 't', 'i' })

  map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  map('<leader>as', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  map('<leader>as', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
  map('<leader>cn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
end

function M.toggle(toggle)
  toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
  toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
  toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tl'
  toggle.diagnostics():map '<leader>td'
  toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>tc'
  toggle.treesitter():map '<leader>tT'
  toggle.inlay_hints():map '<leader>th'
  toggle.indent():map '<leader>ti'
  toggle.dim():map '<leader>tm'
end

function M.gitsigns(map, gitsigns)
  -- toggle git
  map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
  map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })

  -- Git --
  map('n', '<leader>gb', picker.git_branches, { desc = '[G]it [B]ranches' })
  map('n', '<leader>gl', picker.git_log, { desc = '[G]it [L]og' })
  map('n', '<leader>gl', picker.git_log_line, { desc = '[G]it Log [L]ine' })
  map('n', '<leader>gs', picker.git_status, { desc = '[G]it [S]tatus' })
  map('n', '<leader>gS', picker.git_stash, { desc = '[G]it [S]tash' })
  map('n', '<leader>gd', picker.git_diff, { desc = '[G]it [D]iff' })
  map('n', '<leader>gf', picker.git_log_file, { desc = '[G]it Log [F]ile' })

  map({ 'n', 'v' }, '<leader>gB', function()
    snacks.gitbrowse()
  end, { desc = '[G]it [B]rowse' })

  -- git hunk
  map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
  map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
  map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
  map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
  map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
  map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
  map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
  map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })

  map('n', '<leader>hD', function()
    gitsigns.diffthis '@'
  end, { desc = 'git [D]iff against last commit' })

  map('v', '<leader>hs', function()
    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'git [s]tage hunk' })

  map('v', '<leader>hr', function()
    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'git [r]eset hunk' })

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal { ']c', bang = true }
    else
      gitsigns.nav_hunk 'next'
    end
  end, { desc = 'Jump to next git [c]hange' })

  map('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal { '[c', bang = true }
    else
      gitsigns.nav_hunk 'prev'
    end
  end, { desc = 'Jump to previous git [c]hange' })
end

function M.todo_keys()
  return {
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next Todo Comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous Todo Comment',
      },
      { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
      { '<leader>xT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
      { '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
    },
  }
end

return M

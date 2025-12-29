local M = {}

function M.Init(map)
  local snacks = require 'snacks'
  local picker = snacks.picker
  local gitsigns = require 'gitsigns'

  -- toggle git
  map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[b] git show blame line' })
  map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[D] git show deleted' })

  -- Git --
  map('n', '<leader>gb', picker.git_branches, { desc = '[b]ranches' })
  map('n', '<leader>gl', picker.git_log, { desc = '[l]og' })
  map('n', '<leader>gL', picker.git_log_line, { desc = '[L]og line' })
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

return M

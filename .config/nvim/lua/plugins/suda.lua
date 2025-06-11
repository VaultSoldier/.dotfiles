return {
  'lambdalisue/vim-suda', -- Plugin to read/write files with sudo

  config = function()
    local function smart_suda_save()
      local file = vim.fn.expand '%'
      if vim.bo.modifiable == false or vim.bo.readonly == true or vim.fn.filewritable(file) ~= 1 then
        vim.cmd('write suda://' .. file)
      else
        vim.cmd 'write'
      end
    end

    -- Keymap: Normal mode Ctrl+S
    vim.keymap.set('n', '<C-s>', smart_suda_save, {
      noremap = true,
      silent = true,
      desc = 'Smart Save with Suda',
    })
  end,
}

return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      local original = lint.linters.terraform_validate
      lint.linters.terraform_validate = function()
        local linter = original()
        linter.cmd = 'terraform'
        return linter
      end

      lint.linters_by_ft = {
        python = { 'ruff' },
        terraform = { 'terraform_validate' },
        ['yaml.ansible'] = { 'ansible_lint' },
        ansible = { 'ansible_lint' },
        markdown = { 'markdownlint' },
        dockerfile = { 'hadolint' },
        json = { 'jsonlint' },
        text = { 'vale' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}

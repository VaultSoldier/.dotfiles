return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Override terraform_validate to use `terraform` as the command
      local original = lint.linters.terraform_validate
      lint.linters.terraform_validate = function()
        local linter = original()
        linter.cmd = 'terraform'
        return linter
      end

      lint.linters_by_ft = {
        python = { 'ruff' },
        terraform = { 'terraform_validate' },
        markdown = { 'markdownlint' },
        dockerfile = { 'hadolint' },
        json = { 'jsonlint' },
        text = { 'vale' },
      }
      lint.linters_by_ft = lint.linters_by_ft or {}

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

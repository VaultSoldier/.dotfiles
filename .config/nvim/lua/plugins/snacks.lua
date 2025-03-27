return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
  },
  keys = {
    -- {
    --   '<leader>z',
    --   function()
    --     Snacks.zen()
    --   end,
    --   desc = 'Toggle Zen Mode',
    -- },
    -- {
    --   '<leader>Z',
    --   function()
    --     Snacks.zen.zoom()
    --   end,
    --   desc = 'Toggle Zoom',
    -- },
    -- {
    --   '<leader>.',
    --   function()
    --     Snacks.scratch()
    --   end,
    --   desc = 'Toggle Scratch Buffer',
    -- },
    -- {
    --   '<leader>S',
    --   function()
    --     Snacks.scratch.select()
    --   end,
    --   desc = 'Select Scratch Buffer',
    -- },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        local snacks = Snacks
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          snacks.debug.inspect(...)
        end
        _G.bt = function()
          snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
        snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
        snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tL'
        snacks.toggle.diagnostics():map '<leader>td'
        snacks.toggle.line_number():map '<leader>tl'
        snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>tc'
        snacks.toggle.treesitter():map '<leader>tT'
        snacks.toggle.inlay_hints():map '<leader>th'
        snacks.toggle.indent():map '<leader>tg'
        snacks.toggle.dim():map '<leader>tD'
      end,
    })
  end,
}

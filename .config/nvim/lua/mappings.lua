require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set
local builtin = require("telescope.builtin")

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jj", "<Esc>")

map("v", "<Tab>", ">gv", { noremap = true, silent = true })
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
map("i", "<Tab>", "<C-t>", { noremap = true, silent = true })
map("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true })

map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
map("v", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("v", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("v", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("v", "<down>", '<cmd>echo "Use j to move!!"<CR>')

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", "\"_dP")

-- Comment
map("n", "<C-_>", "gcc", { desc = "toggle comment" })
map("v", "<C-_>", "gc", { desc = "toggle comment" })

-- Buffers
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
map("n", "<leader>a", "<cmd>lua require('configs.lsp.renamer')()<CR>", { desc = "LSP rename" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>r", ":!python %<CR>", { desc = "Run Python code" })
map("n", "<C-x>", ":q!<CR>", { desc = "Exit" })

map("n", "<leader>C", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

map("n", "<leader>ct", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>sm", "<cmd>Telescope marks<CR>", { desc = "[S]earch [M]arks" })
map("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "[S]earch [B]uffers" })
map("n", "<leader>st", "<cmd>Telescope terms<CR>", { desc = "[S]erminal [T]erminals" })

-- See `:help telescope.builtin`
map("n", "<leader>sv", "<cmd>VenvSelect<CR>", { desc = "[S]elect [V]envs"}) -- VenvSelector.
map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep" })
map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Slightly advanced example of overriding default behavior and theme
map("n", "<leader>/", function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
map("n", "<leader>s/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
map("n", "<leader>sn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- buffer change with alt + 1 to 9
for i = 1, 9, 1 do
  map("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Disable mappinge
local nomap = vim.keymap.del
nomap("n", "<leader>ff") -- telescope find files 
nomap("n", "<leader>fw") -- search by grep
nomap("n", "<leader>fo") -- find oldfiles
nomap("n", "<leader>fz") -- search current file
nomap("n", "<leader>fa") -- find all files
nomap("n", "<leader>fh") -- search help
nomap("n", "<leader>fb") -- find buffers
nomap("n", "<leader>fm") -- format files
nomap("n", "<leader>gt") -- telescope git status
nomap("n", "<leader>ma") -- find marks
nomap("n", "<leader>pt") -- pick hidden terminal
nomap("n", "<leader>v")  -- terminal new vertical window
nomap("n", "<leader>h")  -- terminal new horizontal window
nomap("n", "<leader>n") -- toggle line number
nomap("n", "<leader>ch") -- toggle cheatsheet
nomap("n", "<leader>th") -- change theme
nomap("n", "<leader>ds") -- go to LSP type definition
nomap("n", "<leader>rn") -- toggle relative number 

require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jj", "<Esc>")

map("n", "<Tab>", ">>", { noremap = true, silent = true })
map("n", "<S-Tab>", "<<", { noremap = true, silent = true })
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

map("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

map("n", "<leader>C", "<cmd>Telescope themes<CR>", { desc = "[C]hange Theme" })

map("n", "<leader>ct", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>sm", "<cmd>Telescope marks<CR>", { desc = "[S]earch [M]arks" })

map("n", "<leader>tt", "<cmd>Telescope terms<CR>", { desc = "[T]erminal [T]erminals" })

map("n", "<leader>th", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "[T]erminal [H]orizontal" })

map("n", "<leader>tv", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "[T]erminal [V]ertical" })

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

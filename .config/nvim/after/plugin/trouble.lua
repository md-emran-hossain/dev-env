require("trouble").setup {
  focus = true,
}

local map = vim.keymap.set

map("n", "<leader>pw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Workspace Diagnostics" })
map("n", "<leader>pd", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<CR>", { desc = "Document Diagnostics" })
map("n", "<leader>pq", "<cmd>Trouble qflist toggle focus=true<CR>", { desc = "Quickfix List" })
map("n", "<leader>pl", "<cmd>Trouble loclist toggle focus=true<CR>", { desc = "Location List" })
-- map("n", "<leader>xt", "<cmd>Trouble todo toggle focus=true<CR>", { desc = "TODOs" })

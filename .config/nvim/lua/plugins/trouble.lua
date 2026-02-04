return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.diagnostic.config({
			virtual_text = true, signs = true, update_in_insert = true,
		})
		require("trouble").setup({ focus = true })
		local map = vim.keymap.set
		map("n", "<leader>dw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Workspace Diagnostics" })
		map("n", "<leader>dd", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<CR>",
			{ desc = "Document Diagnostics" })
		map("n", "<leader>dq", "<cmd>Trouble qflist toggle focus=true<CR>", { desc = "Quickfix List" })
		map("n", "<leader>dl", "<cmd>Trouble loclist toggle focus=true<CR>", { desc = "Location List" })
	end
}

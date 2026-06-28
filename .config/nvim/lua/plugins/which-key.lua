return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300 -- Wait 300ms before showing the popup
	end,
	opts = {
		-- Your configuration comes here
		-- or leave it empty to use the default settings
	}
}

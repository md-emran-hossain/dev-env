return {
	"lewis6991/gitsigns.nvim",
	config = function()
		vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#81b88b" })
		vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e2c08d" })
		vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#c74e39" })
		vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#c74e39" })
		vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#e2c08d" })

		require("gitsigns").setup({
			current_line_blame = true,
			current_line_blame_opts = { delay = 200, virt_text_pos = "eol" },
		})
	end
}

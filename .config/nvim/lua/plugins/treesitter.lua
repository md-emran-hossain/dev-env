return {
	"nvim-treesitter/nvim-treesitter",
	main = "nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)
	end,
	opts = {
		ensure_installed = {
			"html", "css", "javascript", "typescript", "tsx", "json", "yaml",
			"lua", "vim", "vimdoc", "bash", "query", "markdown", "dockerfile",
			"gitignore", "markdown_inline", "php", "blade"
		},
		sync_install = false,
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true }
	}
}

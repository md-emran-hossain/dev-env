local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	conform.format({
		async = false,
		lsp_fallback = true, -- use LSP formatter if Prettier is not configured
	})
end, { desc = "Format file/selection" })

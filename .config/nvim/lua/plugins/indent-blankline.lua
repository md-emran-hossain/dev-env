return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		-- Rose Pine's "muted" color! Used for code comments
		local function set_scope_hl()
			vim.api.nvim_set_hl(0, "IblScopeCustom", { fg = "#6e6a86", nocombine = true })
		end
		set_scope_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_scope_hl })

		require("ibl").setup({
			indent = {
				char = "▏",
			},
			scope = {
				-- Apply your custom subtle color
				highlight = "IblScopeCustom",
				-- Disable the underlines at the top/bottom of the scope block
				show_start = false,
				show_end = false,
			}
		})
	end
}

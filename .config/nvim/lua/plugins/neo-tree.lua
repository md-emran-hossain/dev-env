return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree (right sidebar)" },
		{ "<leader>o", "<cmd>Neotree focus<CR>",  desc = "Focus Neo-tree" },
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			hijack_cursor = true,
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "*",
				},
				git_status = {
					symbols = {
						added = "+",
						modified = "~",
						deleted = "x",
						renamed = "r",
						untracked = "?",
						ignored = "!",
						unstaged = "U",
						staged = "S",
						conflict = "C",
					},
				},
			},
			window = {
				position = "right",
				width = 45,
				mappings = {
					["<space>"] = false,
					["<cr>"] = "open",
					["<2-LeftMouse>"] = "open",
					["<esc>"] = "cancel",
					["R"] = "refresh",
					["a"] = { "add", config = { show_path = "none" } },
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["?"] = "show_help",
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				window = {
					mappings = {
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["f"] = "filter_on_submit",
						["<C-x>"] = "clear_filter",
					},
				},
			},
		})

		-- Rose Pine + transparent bg highlights for neo-tree
		local rp = require("rose-pine.palette")

		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none", fg = rp.subtle })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none", fg = rp.subtle })
		vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none", fg = rp.overlay })

		vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = rp.text })
		vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = rp.rose })

		-- Git highlights matching your gitsigns palette
		vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#81b88b" })
		vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#e2c08d" })
		vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#c74e39" })
		vim.api.nvim_set_hl(0, "NeoTreeGitRenamed", { fg = "#e2c08d" })
		vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#c74e39", bold = true })
		vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = rp.iris })
		vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = rp.overlay, italic = true })

		-- Window border and title
		vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = rp.overlay, bg = "none" })

		-- Winbar for neo-tree windows
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "neo-tree",
			callback = function()
				vim.wo.winbar = "%#NeoTreeTitle#  Files"
			end,
		})

		vim.api.nvim_set_hl(0, "NeoTreeTitle", { fg = rp.rose, bg = "none", bold = true })
	end,
}

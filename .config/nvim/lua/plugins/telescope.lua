return {
	"nvim-telescope/telescope.nvim",
	branch = "master",

	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		if vim.treesitter.language and not vim.treesitter.language.ft_to_lang then
			vim.treesitter.language.ft_to_lang = function(ft)
				return vim.treesitter.language.get_lang(ft) or ft
			end
		end

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>pf', function()
			builtin.find_files({
				hidden = true,
				no_ignore = true,
				file_ignore_patterns = { "node_modules/.*", "%.git/.*" },
			})
		end, { desc = 'Telescope find/project files' })
		vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({
				search = vim.fn.input("Grep > "),
				additional_args = function()
					return {
						"--hidden",
						"--no-ignore",
						"--glob", "!**/node_modules/*",
						"--glob", "!**/.git/*"
					}
				end,
			})
		end, { desc = 'Telescope grep project files' })
	end
}

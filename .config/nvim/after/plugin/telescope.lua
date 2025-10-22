local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', function()
	builtin.find_files({
		hidden = true,
		file_ignore_patterns = { "^node_modules/", "^%.git/" }
	})
end, { desc = 'Telescope find/project files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

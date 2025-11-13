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

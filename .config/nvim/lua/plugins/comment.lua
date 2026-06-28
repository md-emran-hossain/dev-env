return {
	"numToStr/Comment.nvim",
	config = function()
		require('Comment').setup()
		vim.keymap.set('n', '<C-/>', 'gcc', { remap = true, desc = 'Toggle comment line' })
		vim.keymap.set('v', '<C-/>', 'gc', { remap = true, desc = 'Toggle comment selection' })
	end
}

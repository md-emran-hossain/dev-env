return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v4.x",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local lsp_zero = require('lsp-zero')

		-- lsp_attach is where you enable features that only work
		-- if there is a language server active in the file
		local lsp_attach = function(client, bufnr)
			local opts = { buffer = bufnr }

			vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
			vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
			vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
			vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
			vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
			vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
			vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
			vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
			vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
			vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
			vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
		end

		lsp_zero.extend_lspconfig({
			sign_text = true,
			lsp_attach = lsp_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
		})

		require('mason').setup({})
		require('mason-lspconfig').setup({
			ensure_installed = { 'html', 'cssls', 'emmet_ls', 'ts_ls', 'intelephense', 'lua_ls' },
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end,
				lua_ls = function()
					require('lspconfig').lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { 'vim' }
								}
							}
						}
					})
				end,
			}
		})

		local cmp = require('cmp')
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		-- this is the function that loads the extra snippets to nvim-cmp
		require('luasnip.loaders.from_vscode').lazy_load()

		cmp.setup({
			sources = {
				{ name = 'path' },
				{ name = 'nvim_lsp' },
				{ name = 'luasnip', keyword_length = 2 },
				{ name = 'buffer',  keyword_length = 3 },
			},
			mapping = cmp.mapping.preset.insert({
				['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				['<C-y>'] = cmp.mapping.confirm({ select = true }),
				['<C-Space>'] = cmp.mapping.complete(),
			}),
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
		})
	end
}

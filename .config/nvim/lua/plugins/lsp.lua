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
			local map = vim.keymap.set

			map('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
			map('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
			map('n', '<leader>vws', vim.lsp.buf.workspace_symbol, { buffer = bufnr, desc = "Search workspace symbols" })
			map('n', '<leader>vd', vim.diagnostic.open_float, { buffer = bufnr, desc = "View diagnostic float" })
			map('n', '[d', vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
			map('n', ']d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Prev diagnostic" })
			map('n', '<leader>vca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
			map('n', '<leader>vrr', vim.lsp.buf.references, { buffer = bufnr, desc = "Find references" })
			map('n', '<leader>vrn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
			map('n', '<F2>', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
			map('i', '<C-h>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
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
				intelephense = function()
					require('lspconfig').intelephense.setup({
						filetypes = { "php", "blade" }
					})
				end
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

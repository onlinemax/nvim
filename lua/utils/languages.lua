local languages = {
	lua_ls = {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
				runtime = {
					-- Tell the language server which version of Lua you're using (most
					-- likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
					-- Tell the language server how to find Lua modules same way as Neovim
					-- (see `:h lua-module-load`)
					path = {
						'lua/?.lua',
						'lua/?/init.lua',
					},
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME
						-- Depending on the usage, you might want to add additional paths
						-- here.
						-- '${3rd}/luv/library'
						-- '${3rd}/busted/library'
					}
					-- Or pull in all of 'runtimepath'.
					-- NOTE: this is a lot slower and will cause issues when working on
					-- your own configuration.
					-- See https://github.com/neovim/nvim-lspconfig/issues/3189
					-- library = {
					--   vim.api.nvim_get_runtime_file('', true),
					-- }
				}
			})
		end,
		settings = {
			Lua = {}
		}
	},
	denols = {
		root_dir = function(bufnr, on_dir)
			root_file = vim.fs.root(0, 'deno.json')
			if root_file ~= nil then
				on_dir(vim.fs.root(0, 'deno.json'))
			end
		end
	},
	jsonls = {
		settings = {
			json = {
				validate = { enable = true },
				schemas = {
					{
						description = "NPM configuration file",
						fileMatch = { "package.json" },
						name = "package.json",
						url = "https://www.schemastore.org/package.json"
					},
					{
						description = "TypeScript compiler configuration file",
						fileMatch = { "tsconfig*.json" },
						name = "tsconfig.json",
						url = "https://www.schemastore.org/tsconfig.json"
					}
				}
			}
		}
	},
	ts_ls = {
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = 'all',
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	}
}



local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}


vim.lsp.config('*', {
	capabilities = capabilities
})

for language, opts in pairs(languages) do
	vim.lsp.config(language, opts)
	vim.lsp.enable(language)
end

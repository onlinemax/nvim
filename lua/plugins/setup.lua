-- This file setups all the plugins which are not lazy loaded
local benchmark = require('benchmark')


local function setup_mini()
	--TODO: Please learn about how to use it perfectly
	require("mini.ai").setup()
	require("mini.surround").setup()
	require("mini.indentscope").setup()
	require("mini.cursorword").setup()
	require("mini.hipatterns").setup()
	require("mini.icons").setup()
	require("mini.git").setup()
	require("mini.diff").setup()
	require('mini.statusline').setup()
end

local function setup_peek()
	require("peek").setup()
	vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
	vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end

local function setup_snip()
	local luasnip = require("luasnip")
	local cmp = require("cmp")

	cmp.setup({
		-- ... Your other configuration ...
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'path' },
			{ name = 'nvim_lsp_signature_help' },
		}, { { name = 'buffer' } }),
		mapping = {
			-- ... Your other mappings ...
			['<CR>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					if luasnip.expandable() then
						luasnip.expand()
					else
						cmp.confirm({
							select = true,
						})
					end
				else
					fallback()
				end
			end),

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),

			-- ... Your other mappings ...
		},
		experimental = {
			ghost_text = true
		},

		-- ... Your other configuration ...
	})

	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

	-- `:` cmdline setup.
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		}),
		matching = { disallow_symbol_nonprefix_matching = false }
	})
end







local end_bench = benchmark:start_bench("Setup nvim-ts-autotag")

require("nvim-ts-autotag").setup({
	opts = {
		-- Defaults
		enable_close = true,        -- Auto close tags
		enable_rename = true,       -- Auto rename pairs of tags
		enable_close_on_slash = false -- Auto close on trailing </
	},
	-- Also override individual filetype configs, these take priority.
	-- Empty by default, useful if one of the "opts" global settings
	-- doesn't work well in a specific filetype
	per_filetype = {
		["html"] = {
			enable_close = false
		}
	}
}
);
end_bench()

end_bench = benchmark:start_bench("Setup fzf-lua")

require("fzf-lua").setup({
	keymap = {
		fzf = {
			["tab"] = "down",
			["btab"] = "up"
		}
	}
})
local mason_lspconfig_opts = {
	{
		ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "pyright", "svelte", "emmet_language_server", "qmlls", "clangd@snapshot_20260222" },

		automatic_enable = {
			exclude = { "lua_ls", "denols", "jsonls" }
		}
	},
}

local image_opts = {
	backend = "ueberzug",
	integrations = {
		typst = {
			enabled = false
		}
	}
}

local conform_opts = {
	lua = { "stylua" },
	python = { "isort", "black" },
	rust = { "rustfmt", lsp_format = "fallback" },
	javascript = { "prettierd", "prettier", stop_after_first = true },
	typescript = { "prettierd", "prettier", stop_after_first = true },
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},

}

end_bench()
end_bench = benchmark:start_bench("Setup nvim-treesitter")

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	auto_install = true,
	-- For latexmk it conflicts with tree-sitter for its own reasons. see :help vimtex-faq-treesitter
	ignore_install = { "latex" },
	highlight = {
		enable = true
	}
})

end_bench()

local plugins_setup = {
	"trouble", "treesitter-context", "ufo", "unimpaired", "which-key", "mason", "leetcode", "nvim-autopairs", { "mason-lspconfig", mason_lspconfig_opts }, { "image", image_opts }, { "conform", conform_opts }
}
vim.g.vimtex_view_method = 'zathura';
for _, plugin in ipairs(plugins_setup) do
	if vim.isarray(plugin) then
		end_bench = benchmark:start_bench('Setup ' .. plugin[1])
		require(plugin[1]).setup(plugin[2])
	else
		end_bench = benchmark:start_bench('Setup ' .. plugin)
		require(plugin).setup()
	end
	end_bench()
end

end_bench = benchmark:start_bench('Setup luasnip')
setup_snip()
end_bench()
end_bench = benchmark:start_bench('Setup mini')
setup_mini()
end_bench()
end_bench = benchmark:start_bench('Setup peek')
setup_peek()
end_bench()

local function setup_mini()
	--TODO: Please learn about how to use it perfectly
	require("mini.ai").setup()
	require("mini.pairs").setup()
	require("mini.surround").setup()
	require("mini.indentscope").setup()
	require("mini.cursorword").setup()
	require("mini.hipatterns").setup()
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
		ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "pyright", "svelte", "emmet_language_server", "qmlls" },

		automatic_enable = {
			exclude = { "lua_ls", "denols", "jsonls" }
		}
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
local image_opts = {
	backend = "ueberzug",
}

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	auto_install = true,
	highlight = {
		enable = true
	}
})

local plugins_setup = {
	"trouble", "treesitter-context", "ufo", "unimpaired", "which-key", "mason", "leetcode", { "mason-lspconfig", mason_lspconfig_opts }, { "image", image_opts }
}

for _, plugin in ipairs(plugins_setup) do
	if vim.isarray(plugin) then
		require(plugin[1]).setup(plugin[2])
	else
		require(plugin).setup()
	end
end

setup_snip()
setup_mini()
setup_peek()

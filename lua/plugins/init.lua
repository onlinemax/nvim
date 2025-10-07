function install(names, load)
	local specs = vim.tbl_map(function(x) 
		if (type(x) == "string") then
			return "https://github.com/".. x
		end
		x.src = "https://github.com/" .. x.src
		return x
	end
, names)
	vim.pack.add(specs, {load = load, confirm = false})
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

install({"windwp/nvim-ts-autotag", "neovim/nvim-lspconfig", "ibhagwan/fzf-lua", "mason-org/mason-lspconfig.nvim", "mason-org/mason.nvim"})
install({{src="L3MON4D3/LuaSnip", name="luasnip"}, { src = "hrsh7th/nvim-cmp", name="cmp"}, 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-nvim-lsp-signature-help'}, function (plug_data)
	if plug_data.name ~= "Luasnip" then
		return;
	end
	local build_routine = coroutine.create(function(data) 
			vim.system({"make", "install_jsregexp"}, {cwd = data.path}, function(o)
				if o.code ~= 0 then
					vim.print("Couln't execute command: " .. o.stderr);
				end	
			end)
		end)
		coroutine.resume(build_routine, plug_data)
	end
)



vim.print("This is happening")

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
require("fzf-lua").setup({})
require("mason").setup({})
require("mason-lspconfig").setup({
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
})

for i, spec in ipairs(vim.pack.get()) do
	vim.cmd("packadd " .. spec.spec.name)
end


setup_snip()

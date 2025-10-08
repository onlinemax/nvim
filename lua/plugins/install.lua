-- This file installs all the plugins
local function install(names, load)
	local specs = vim.tbl_map(function(x)
		if (type(x) == "string") then
			return "https://github.com/" .. x
		end
		x.src = "https://github.com/" .. x.src
		return x
	end
	, names)
	vim.pack.add(specs, { load = load, confirm = false })
end


install({ "windwp/nvim-ts-autotag", "neovim/nvim-lspconfig", "ibhagwan/fzf-lua", "mason-org/mason-lspconfig.nvim",
	"mason-org/mason.nvim", "echasnovski/mini.nvim", "folke/tokyonight.nvim", "nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context", "folke/trouble.nvim", 'kevinhwang91/nvim-ufo', 'kevinhwang91/promise-async',
	"tummetott/unimpaired.nvim", "folke/which-key.nvim", "nvim-neo-tree/neo-tree.nvim", "nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons",
	"folke/which-key.nvim", "kawre/leetcode.nvim" })

-- Those plugins require special configuration
install(
	{ { src = "L3MON4D3/LuaSnip", name = "luasnip" }, { src = "hrsh7th/nvim-cmp", name = "cmp" }, 'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-nvim-lsp-signature-help' },
	function(plug_data)
		if plug_data.name ~= "Luasnip" then
			return;
		end
		local build_routine = coroutine.create(function(data)
			vim.system({ "deno", "task", "--quiet", "build:fast" }, { cwd = data.path }, function(o)
				if o.code ~= 0 then
					vim.print("Couln't execute command: " .. o.stderr);
				end
			end)
		end)
		coroutine.resume(build_routine, plug_data)
	end
)

install({ "toppair/peek.nvim" }, function(plug_data)
	local build_routine = coroutine.create(function(data)
		vim.system({ "deno", "task", "--quiet", "build:fast" }, { cwd = data.path }, function(o)
			if o.code ~= 0 then
				vim.print("Couln't execute command: " .. o.stderr);
			end
		end)
	end)
	coroutine.resume(build_routine, plug_data)
end)

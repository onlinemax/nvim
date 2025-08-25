return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "pyright", "svelte", "emmet_language_server", "qmlls" },

		automatic_enable = {
			exclude = { "lua_ls" }
		}
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	config = function()
		local opts = {
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
			auto_install = true,
			highlight = {
				enable = true
			}
		}
		require("nvim-treesitter.configs").setup(opts)
	end,
	build = ":TSUpdate"
}

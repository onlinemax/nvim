return {
	'echasnovski/mini.nvim',
	version = '*',
	config = function()
		--TODO: Please learn about how to use it perfectly
		require("mini.ai").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.indentscope").setup()
		require("mini.cursorword").setup()
		require("mini.hipatterns").setup()
	end

}

require("typst-preview").setup({
	dependencies_bin = { ['tinymist'] = 'tinymist' },
	open_cmd = 'brave --new-window --kiosk --app=%s'
})
vim.cmd(':TypstPreview')

vim.api.nvim_create_autocmd('VimLeavePre', {
	pattern = "*",
	callback = function()
		vim.cmd(':TypstPreviewStop')
	end
})

-- Neotree operner
vim.keymap.set("n", '\\', ':Neotree toggle<CR>', { desc = "Show file tree (Neotree) " })

vim.keymap.set("n", '<C-h>', '<C-w>h', { desc = "Go to the window at the left" })
vim.keymap.set("n", '<C-j>', '<C-w>j', { desc = "Go to the window at the bottom" })
vim.keymap.set("n", '<C-k>', '<C-w>k', { desc = "Go to the window at the top" })
vim.keymap.set("n", '<C-l>', '<C-w>l', { desc = "Go to the window at the right" })

vim.keymap.set("n", '<leader>f', vim.lsp.buf.format, { desc = "Format Buffer" })
-- Fzf Requirements
vim.keymap.set("n", "<leader>sf", require("fzf-lua").files, { desc = "Seach files" })
vim.keymap.set("n", "<leader>sg", require("fzf-lua").live_grep, { desc = "Seach files" })
vim.keymap.set("n", "<leader>sh", require("fzf-lua").helptags, { desc = "Seach help" })
vim.keymap.set("n", "<leader>sm", require("fzf-lua").manpages, { desc = "Seach Man pages" })
vim.keymap.set("n", "<leader>th", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "toggle hinlay hits" })



vim.keymap.set("n", "<leader>rn", function()
	vim.ui.input({ prompt = "New Name: " }, vim.lsp.buf.rename);
end, { desc = 'Rename' })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })

-- Lsp Necesities
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover);

--- Utility to move lines with alt-key
vim.keymap.set("n", "<A-j>", "]e", { desc = "Move line down", remap = true });
vim.keymap.set("n", "<A-k>", "[e", { desc = "Move line up", remap = true });
vim.keymap.set("v", "<A-j>", "]egv", { desc = "Move lines down", remap = true });
vim.keymap.set("v", "<A-k>", "[egv", { desc = "Move lines up", remap = true });
vim.keymap.set("v", "<", "<gv");
vim.keymap.set("v", ">", ">gv");

-- Trouble keymaps
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })


-- Which Keymaps
vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

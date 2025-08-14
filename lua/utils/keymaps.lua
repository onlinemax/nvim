vim.keymap.set("n", '\\', ':Neotree toggle<CR>', { desc = "Show file tree (Neotree) " })
vim.keymap.set("n", '<C-\\>', ':Neotree toggle buffers right<CR>', { desc = 'Show Buffers' })

vim.keymap.set("n", '<C-h>', '<C-w>h', { desc = "Go to the window at the left" })
vim.keymap.set("n", '<C-j>', '<C-w>j', { desc = "Go to the window at the bottom" })
vim.keymap.set("n", '<C-k>', '<C-w>k', { desc = "Go to the window at the top" })
vim.keymap.set("n", '<C-l>', '<C-w>l', { desc = "Go to the window at the right" })

vim.keymap.set("n", '<leader>f', vim.lsp.buf.format, { desc = "Format Buffer" })

vim.keymap.set("n", "<leader>sf", require("fzf-lua").files, { desc = "Seach files" })
vim.keymap.set("n", "<leader>sg", require("fzf-lua").live_grep, { desc = "Seach files" })


vim.keymap.set("n", "<leader>rn", function()
	vim.ui.input({ prompt = "New Name: " }, vim.lsp.buf.rename);
end, { desc = 'Rename' })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })

-- Lsp things
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover);
-- Utility to move lines with alt-key
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" });
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" });
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" });
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" });
vim.keymap.set("v", "<A-j>", ":'<,'>:m .+1<CR>gv=gv", { desc = "Move lines down" });
vim.keymap.set("v", "<A-k>", ":'<,'>:m .-2<CR>gv=gv", { desc = "Move lines up" });

vim.keymap.set("n", '\\', ':Neotree toggle<CR>', { desc = "Show file tree (Neotree) " })
vim.keymap.set("n", '<C-\\>', ':Neotree toggle buffers right<CR>', { desc = 'Show Buffers' })

vim.keymap.set("n", '<C-h>', '<C-w>h', { desc = "Go to the window at the left" })
vim.keymap.set("n", '<C-j>', '<C-w>j', { desc = "Go to the window at the bottom" })
vim.keymap.set("n", '<C-k>', '<C-w>k', { desc = "Go to the window at the top" })
vim.keymap.set("n", '<C-l>', '<C-w>l', { desc = "Go to the window at the right" })

vim.keymap.set("n", '<leader>f', vim.lsp.buf.format, { desc = "Format Buffer" })

vim.keymap.set("n", "<leader>sf", require("fzf-lua").files, { desc = "Seach files" })
vim.keymap.set("n", "<leader>sg", require("fzf-lua").live_grep, { desc = "Seach files" })

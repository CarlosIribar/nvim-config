-- Mapping helper
local mapper = function(mode, key, result) vim.keymap.set(mode, key, result, { noremap = true, silent = false }) end

-- leader
vim.g.mapleader = ","

-- Normal Mode
mapper("n", "<leader>w", ":w<CR>")
mapper("n", "<leader>q", ":q<CR>")
mapper("n", "<leader>pt", ":Neotree filesystem reveal toggle<CR>")
mapper("n", "<leader>m", ":BufferLineCycleNext<CR>")
mapper("n", "<leader>n", ":BufferLineCyclePrev<CR>")
mapper("n", "<leader>bd", ":bd<CR>")
mapper("n", "<leader>p", "\"*p")
mapper("n", "<leader>y", "\"*y")

-- Visual Mode
mapper("v", "<leader>y", '"+y')

-- Telescope
mapper("n", "<leader>fa", ":Telescope find_files<CR>")
mapper("n", "<leader>ff", ":Telescope git_files<CR>")
mapper("n", "<leader>fb", ":Telescope buffers<CR>")
mapper("n", "<leader>fg", ":Telescope live_grep<CR>")
mapper("n", "<leader>fh", ":Telescope help_tags<CR>")
mapper("n", "<leader>fr", ":Telescope git_branches<CR>")
mapper("n", "<leader>fe", ":Telescope git_status<CR>")
mapper("n", "<leader>fs", ":Telescope luasnip<CR>")

-- Test
mapper("n", "<leader>tn", ":TestNearest<CR>")
mapper("n", "<leader>tf", ":TestFile<CR>")
mapper("n", "<leader>ts", ":TestSuit<CR>")
mapper("n", "<leader>tl", ":TestLast<CR>")

-- Null-ls
vim.cmd('map <Leader>ww :lua vim.lsp.buf.format()<CR>')

-- Copilot 
vim.keymap.set('i', '<C-[>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-previous)')

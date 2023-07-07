require('plugins')
require('mappings')
require('after/telescope')
require('lsp')
require('cmp_conf')
require('snippets')

vim.wo.number = true
vim.cmd [[set number relativenumber tabstop=4 shiftwidth=4 expandtab]]
vim.api.nvim_command "colorscheme catppuccin"

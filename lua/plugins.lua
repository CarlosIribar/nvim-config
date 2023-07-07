-- Neotree: Elimina los comandos obsoletos de la versión 1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- Función para asegurar que Packer está instalado
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Copilot
vim.g.copilot_node_command = "~/.nvm/versions/node/v16.17.0/bin/node"

-- Cargar plugins con Packer
local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Administrador de paquetes
    use 'f-person/git-blame.nvim' -- Git Blame
    use {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({})
  end,
}
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- Treesitter
    use { "https://github.com/tpope/vim-fugitive", run = ":TSUpdate" } -- Treesitter
    use {
        "benfowler/telescope-luasnip.nvim",
        module = "telescope._extensions.luasnip",  -- if you wish to lazy-load
    }
    -- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/nvim-lsp-installer",
        },
    }
    use { "akinsho/nvim-bufferline.lua", requires = "kyazdani42/nvim-web-devicons" } -- Bufferline
    use 'shaunsingh/nord.nvim' -- Tema Nord
    use 'https://github.com/mg979/vim-visual-multi' -- Visual Multi
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    } -- Lualine
    use { 'neowit/vim-force.com' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-surround' }
    use { 'janko-m/vim-test' }
    use { 'tpope/vim-fugitive' }
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    }
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }
    use { 'christoomey/vim-tmux-navigator' }
    use { 'jose-elias-alvarez/null-ls.nvim' } -- Null-ls
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-buffer' } -- Cmp
    use { 'hrsh7th/cmp-path' } -- Cmp
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use {
        'L3MON4D3/LuaSnip',
        dependencies = { "rafamadriz/friendly-snippets" },
        after = 'nvim-cmp',
        expand = function(args)
    	     require("luasnip").lsp_expand(args.body)
         end,
    }
    use {'rafamadriz/friendly-snippets'}
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Configuración de Bufferline
vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        indicator = {
            icon = '▎',
            style = 'underline'
        }
    }
}

-- Configuración de Nvim-treesitter
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
}

-- Configuración de Nord
require('catppuccin').setup {
    flavour = "frappe",
    background = {
        light = "frappe",
        dark = "frappe",
    },
}

vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require('gitblame')
-- Configuración de Lualine
require('lualine').setup {
    options = {
        theme = 'catppuccin',
    },
    sections = {
            lualine_c = {
                { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
            }
    }
}

-- Configuración de Null-ls (linting y formateo)
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
        require("null-ls").builtins.diagnostics.shellcheck,
        require("null-ls").builtins.code_actions.gitsigns,
        require("null-ls").builtins.code_actions.shellcheck,
        require("null-ls").builtins.formatting.npm_groovy_lint.with({
        extra_filetypes = { "java", "cls", "apexcode"},
        }),
    },
})

-- Configuración de cmp (autocompletado)
require('cmp').setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' },
    }
})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end

require("nvim-lsp-installer").setup({
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local lsp_flags = {
    debounce_text_changes = 150,
}

local nvim_lsp = require('lspconfig')

nvim_lsp['lua_ls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
nvim_lsp['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    root_dir = nvim_lsp.util.root_pattern("package.json"),
}
nvim_lsp['cssls'].setup {
    on_attach = on_attach,
    filetypes = { 'css' },
    flags = lsp_flags,
}
nvim_lsp['elixirls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
nvim_lsp['html'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
nvim_lsp['tailwindcss'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    filetypes = { "html", "elixir", "eelixir", "heex", "typescriptreact", "javascriptreact", "elixir" },
    init_options = {
        userLanguages = {
            elixir = "html-eex",
            eelixir = "html-eex",
            heex = "html-eex",
        },
    },
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    'class[:]\\s*"([^"]*)"',
                },
            },
        },
    },
}
nvim_lsp['emmet_ls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue", "heex" },
}

local apex_ls_setup = {
    on_attach = on_attach,
    flags = lsp_flags,
    apex_jar_path = '/Users/c.iribar/.vscode/extensions/salesforce.salesforcedx-vscode-apex-58.3.1/dist/apex-jorje-lsp.jar',
    root_dir = nvim_lsp.util.root_pattern('sfdx-project.json'),
    apex_enable_semantic_errors = true,
    apex_enable_completion_statistics = false,
    apex_enable_completition_details_level = 2,
    apex_sfdx_package_directories = { 'force-app', 'main', 'default' },
    apex_enable_code_actions = true,
    apex_format_debug_level = 'info',
    apex_completion_trigger_characters = { '.', ':', '<', '"', '=', '(' },
    apex_completion_filter_camelcase = true,
    apex_completion_filter_case_sensitive = false,
    apex_completion_filter_case_insensitive = true,
    filetypes = { 'apex', 'cls', 'trigger', 'st' },

}

nvim_lsp.apex_ls.setup(apex_ls_setup)

vim.treesitter.language.register('java', 'apexcode')  -- read apex code as java 
vim.treesitter.language.register('java', 'cls')  -- read apex code as java 

nvim_lsp.denols.setup {
    on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

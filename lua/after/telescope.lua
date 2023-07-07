local lst = require('telescope').extensions.luasnip
local luasnip = require('luasnip')

require('telescope').setup { 
    defaults = { 
        file_ignore_patterns = { "node_modules" }, 
        mappings= {
            n= {
                ['<c-d>'] = require('telescope.actions').delete_buffer
            },
        }, 
    },
    extensions = {
        luasnip = {
                search = function(entry)
                        return lst.filter_null(entry.context.trigger) .. " " ..
                               lst.filter_null(entry.context.name) .. " " ..
                               entry.ft .. " " ..
                               lst.filter_description(entry.context.name, entry.context.description) ..
                               lst.get_docstring(luasnip, entry.ft, entry.context)[1]
                end
        },
    }
} -- Only required if you have packer configured as `opt`

print("Loaded Telescope")
require('telescope').load_extension('luasnip')



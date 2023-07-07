local luasnip = require('luasnip')
require('luasnip/loaders/from_vscode').lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/snippets"})
require('luasnip.loaders.from_lua').load({ paths = "./snippets/liveview" })

require('luasnip').filetype_extend("elixir", { "eelixir", "heex" })

local ls = require('luasnip')

-- Key maps
vim.keymap.set({ "i", "s" }, "<c-e>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-w>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function()
  return { os.date('%Y-%m-%d') }
end

-- Custom Snippet
ls.add_snippets(nil, {
    apex = {
        snip({
            trig = "date",
            name = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
    }
})


local on_attach = function(_, _)

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {})
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {})
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, {})
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, {})
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, {})
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, {})
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, {})
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, {})
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, {})
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {})
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
require('mason').setup({})
local servers = { 'clangd', 'pyright', 'lua_ls' }
for _, lsp in ipairs(servers) do
    local lsp_setup = {
        capabilities = capabilities,
    }
    if lsp == 'pyright' then
       lsp_setup.cmd = {"node", "/home/amr/.local/share/nvim/mason/packages/pyright/node_modules/pyright/langserver.index.js", "--stdio"}
    end
    lspconfig[lsp].setup(lsp_setup)

end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

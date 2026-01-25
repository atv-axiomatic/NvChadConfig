dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

vim.lsp.config("*", {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

vim.lsp.config("solidity", {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_dir = function(fname)
    local git = vim.fs.find(".git", { path = fname, upward = true })[1]
    return git and vim.fs.dirname(git) or nil
  end,
})

local ts_default = vim.lsp.config.ts_ls
if ts_default and ts_default.on_attach then
  vim.lsp.config("ts_ls", {
    on_attach = function(client, bufnr)
      ts_default.on_attach(client, bufnr)
      M.on_attach(client, bufnr)
    end,
  })
else
  vim.lsp.config("ts_ls", {
    on_attach = M.on_attach,
  })
end

local tailwind_default = vim.lsp.config.tailwindcss
if tailwind_default and tailwind_default.filetypes then
  local filetypes = vim.tbl_extend("force", {}, tailwind_default.filetypes)
  if not vim.tbl_contains(filetypes, "htmldjango") then
    table.insert(filetypes, "htmldjango")
  end
  vim.lsp.config("tailwindcss", { filetypes = filetypes })
end

vim.lsp.enable { "lua_ls", "pyright", "ruff", "ts_ls", "eslint", "tailwindcss", "emmet_ls", "solidity" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function(args)
    if not vim.lsp.get_clients({ name = "lua_ls", bufnr = args.buf })[1] then
      vim.lsp.start(vim.lsp.config.lua_ls, { bufnr = args.buf })
    end
  end,
})


return M

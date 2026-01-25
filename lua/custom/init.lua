local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

vim.filetype.add({
  pattern = {
    [".*%.djhtml"] = "htmldjango",
    [".*%.django%.html"] = "htmldjango",
  },
})

autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    local client = vim.lsp.get_clients({ name = "eslint", bufnr = 0 })[1]
    if not client then
      return
    end

    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.fixAll.eslint" },
        diagnostics = {},
      },
    })
  end,
})

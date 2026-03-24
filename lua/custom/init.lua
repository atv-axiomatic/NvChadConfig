local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- statusline safety: avoid errors for unknown modes
vim.schedule(function()
  local ok, st = pcall(require, "nvchad.statusline.vscode_colored")
  if not ok then
    return
  end

  st.mode = function()
    if not vim.api.nvim_get_current_win or not vim.g.statusline_winid then
      return ""
    end

    if vim.api.nvim_get_current_win() ~= vim.g.statusline_winid then
      return ""
    end

    local m = vim.api.nvim_get_mode().mode
    local entry = st.modes[m] or { "UNKNOWN", "St_NormalMode" }
    return "%#" .. entry[2] .. "#" .. "  " .. entry[1] .. " "
  end
end)

vim.filetype.add({
  pattern = {
    [".*%.djhtml"] = "htmldjango",
    [".*%.django%.html"] = "htmldjango",
  },
  extension = {
    jsx = "javascriptreact",
  },
})

vim.cmd("filetype plugin indent on")

-- ensure filetype is set when opening via telescope
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.jsx",
  callback = function()
    vim.bo.filetype = "javascriptreact"
  end,
})

-- ensure python3 provider is available for remote plugins (magma)
if vim.fn.exepath("python3") ~= "" then
  vim.g.python3_host_prog = vim.fn.exepath("python3")
end

-- load remote plugin commands once if missing
vim.schedule(function()
  if vim.fn.exists(":MagmaInit") == 0 then
    vim.cmd("silent! runtime plugin/rplugin.vim")
  end
end)

-- statusline: avoid deprecated vim.lsp.get_active_clients()
vim.schedule(function()
  local ok, st = pcall(require, "nvchad.statusline.vscode_colored")
  if not ok then
    return
  end

  st.LSP_status = function()
    if rawget(vim, "lsp") then
      for _, client in ipairs(vim.lsp.get_clients()) do
        if client.attached_buffers[vim.api.nvim_win_get_buf(vim.g.statusline_winid)] and client.name ~= "null-ls" then
          return (vim.o.columns > 100 and "%#St_LspStatus# 󰄭  " .. client.name .. "  ")
            or "%#St_LspStatus# 󰄭  LSP  "
        end
      end
    end

    return ""
  end
end)

-- ensure :UpdateRemotePlugins is available

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

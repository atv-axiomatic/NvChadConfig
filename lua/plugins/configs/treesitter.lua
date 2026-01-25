local options = {
  ensure_installed = {
    "lua",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "html",
    "css",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
    disable = { "vimdoc", "query" },
  },

  indent = { enable = true },
}

return options

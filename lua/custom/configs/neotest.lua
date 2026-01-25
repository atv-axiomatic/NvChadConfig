require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-jest")({
      jestCommand = "npm test --",
      cwd = function(path)
        return require("neotest-jest").root(path)
      end,
    }),
  },
})

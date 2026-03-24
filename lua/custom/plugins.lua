local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "pyright",
        "ruff",
        "eslint-lsp",
        "prettier",
        "tailwindcss-language-server",
        "emmet-ls",
        "typescript-language-server",
      },
    }
  },
  {
    "stevearc/conform.nvim",
    -- for users those who want auto-save confirm + lazyloading!
    event = "BufWritePre",
    config = function()
      require "custom.configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "rmagatti/auto-session",
    cmd = { "AutoSession" },
    opts = {
      auto_restore_enabled = false,
      auto_save_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      bypass_session_save_file_types = { "NvimTree" },
      pre_save_cmds = { "silent! NvimTreeClose" },
      post_restore_cmds = { "silent! NvimTreeClose" },
    },
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require "custom.configs.ufo"
    end,
  },
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    dependencies = { "romgrk/fzy-lua-native", "nvim-tree/nvim-web-devicons" },
    config = function()
      require "custom.configs.wilder"
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "custom.configs.harpoon"
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    lazy = false,
    config = function()
      require "custom.configs.magma"
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    opts = function()
      return require "custom.configs.comment"
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require "custom.configs.neotest"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact", "tsx" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {
      focus = true,
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}

return plugins

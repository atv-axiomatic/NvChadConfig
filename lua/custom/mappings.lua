---@type MappingsTable
local M = {}

local function get_visual_selection()
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  local mode = vim.fn.visualmode()
  local region = vim.fn.getregion(start_pos, end_pos, { type = mode })

  if #region == 0 then
    return ""
  end

  return table.concat(region, " ")
end

local function get_neotest()
  require("lazy").load { plugins = { "neotest" } }
  local ok, neotest = pcall(require, "neotest")
  if not ok then
    return nil
  end

  local adapter_ids = neotest.state.adapter_ids()
  if not adapter_ids or #adapter_ids == 0 then
    vim.notify("Neotest: no adapters for this project.", vim.log.levels.WARN)
    return nil
  end

  return neotest
end

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float(nil, { focus = true, border = "rounded" })
      end,
      "Show floating diagnostic",
    },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "Prev diagnostic",
    },
    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "Next diagnostic",
    },
    ["<leader>rn"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "Rename symbol",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "Code action",
    },
    ["<leader>ff"] = {
      function()
        require("telescope.builtin").find_files()
      end,
      "Find files",
    },
    ["<leader>fb"] = {
      function()
        require("telescope.builtin").buffers()
      end,
      "Buffers",
    },
    ["<leader>fd"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "Diagnostics",
    },
    ["<leader>fs"] = {
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      "Document symbols",
    },
    ["<leader>xx"] = {
      "<cmd>Trouble diagnostics toggle<CR>",
      "Diagnostics (Trouble)",
    },
    ["<leader>xq"] = {
      "<cmd>Trouble qflist toggle<CR>",
      "Quickfix (Trouble)",
    },
    ["<leader>xt"] = {
      "<cmd>TodoTrouble<CR>",
      "Todo list",
    },
    ["<leader>ws"] = { "<cmd>AutoSession save<CR>", "Save session" },
    ["<leader>wr"] = { "<cmd>AutoSession restore<CR>", "Restore session" },
    ["<leader>u"] = { "<cmd>UndotreeToggle<CR>", "Undo tree" },
    ["zR"] = {
      function()
        require("lazy").load { plugins = { "nvim-ufo" } }
        local ok, ufo = pcall(require, "ufo")
        if ok then
          ufo.openAllFolds()
        end
      end,
      "Open all folds",
    },
    ["zM"] = {
      function()
        require("lazy").load { plugins = { "nvim-ufo" } }
        local ok, ufo = pcall(require, "ufo")
        if ok then
          ufo.closeAllFolds()
        end
      end,
      "Close all folds",
    },
    ["<leader>a"] = {
      function()
        require("harpoon"):list():add()
      end,
      "Harpoon add file",
    },
    ["<leader>ha"] = {
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "Harpoon menu",
    },
    ["<leader>1"] = {
      function()
        require("harpoon"):list():select(1)
      end,
      "Harpoon file 1",
    },
    ["<leader>2"] = {
      function()
        require("harpoon"):list():select(2)
      end,
      "Harpoon file 2",
    },
    ["<leader>3"] = {
      function()
        require("harpoon"):list():select(3)
      end,
      "Harpoon file 3",
    },
    ["<leader>4"] = {
      function()
        require("harpoon"):list():select(4)
      end,
      "Harpoon file 4",
    },
    ["<leader>hn"] = {
      function()
        require("harpoon"):list():next()
      end,
      "Harpoon next",
    },
    ["<leader>hp"] = {
      function()
        require("harpoon"):list():prev()
      end,
      "Harpoon prev",
    },
    ["<leader>tt"] = {
      function()
        local neotest = get_neotest()
        if neotest and neotest.run then
          neotest.run.run()
        end
      end,
      "Test nearest",
    },
    ["<leader>tf"] = {
      function()
        local neotest = get_neotest()
        if neotest and neotest.run then
          neotest.run.run(vim.fn.expand "%")
        end
      end,
      "Test file",
    },
    ["<leader>ts"] = {
      function()
        local neotest = get_neotest()
        if neotest and neotest.run then
          neotest.run.run { suite = true }
        end
      end,
      "Test suite",
    },
    ["<leader>tS"] = {
      function()
        local neotest = get_neotest()
        if neotest and neotest.run then
          neotest.run.stop()
        end
      end,
      "Stop tests",
    },
    ["<leader>to"] = {
      function()
        local neotest = get_neotest()
        if neotest and neotest.output then
          neotest.output.open { enter = true }
        end
      end,
      "Test output",
    },
    ["<leader>tp"] = {
      function()
        local neotest = get_neotest()
        if neotest and neotest.summary then
          neotest.summary.toggle()
        end
      end,
      "Test panel",
    },
    ["<leader>mi"] = { "<cmd>MagmaInit<CR>", "Magma init" },
    ["<leader>mo"] = { "<cmd>MagmaShowOutput<CR>", "Magma show output" },
    ["<leader>mD"] = { "<cmd>MagmaDelete<CR>", "Magma delete cell" },
    ["<leader>mR"] = { "<cmd>MagmaRestart!<CR>", "Magma restart kernel" },
    ["<C-b>j"] = { "<cmd>resize +2<CR>", "Resize down" },
    ["<C-b>k"] = { "<cmd>resize -2<CR>", "Resize up" },
    ["<C-b>h"] = { "<cmd>vertical resize -2<CR>", "Resize left" },
    ["<C-b>l"] = { "<cmd>vertical resize +2<CR>", "Resize right" },
  },
  v = {
    [">"] = { ">gv", "indent" },
    ["<leader>fz"] = {
      function()
        local text = get_visual_selection()
        if text ~= "" then
          require("telescope.builtin").current_buffer_fuzzy_find({ default_text = text })
        end
      end,
      "Find selection in buffer",
    },
    ["<leader>fw"] = {
      function()
        local text = get_visual_selection()
        if text == "" then
          return
        end

        vim.ui.input({ prompt = "Grep glob (e.g. *.tsx, empty = all): " }, function(glob)
          local opts = { default_text = text }
          if glob and glob ~= "" then
            opts.additional_args = function()
              return { "--fixed-strings", "--glob", glob }
            end
          else
            opts.additional_args = function()
              return { "--fixed-strings" }
            end
          end
          require("telescope.builtin").live_grep(opts)
        end)
      end,
      "Grep selection (optional glob)",
    },
    ["<leader>mv"] = { "<cmd>MagmaEvaluateVisual<CR>", "Magma eval selection" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dus"] = {
      function()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
  }
}

-- more keybinds!

return M

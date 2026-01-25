# Neovim Quick Reference (NVChad Setup)

This file is a concise but practical reference for daily use. It explains what the main
plugins do and lists the key commands that matter most for TS/React/Next.js and Django work.

---

## Core Navigation

- `Ctrl-w` + `h/j/k/l` moves between splits (left/down/up/right).
- `:q` closes the current window, `:qa` quits all.
- `:w` saves, `:wa` saves all.

---

## LSP (Built-in + nvim-lspconfig)

What it does: Provides diagnostics, go-to-definition, hover docs, rename, and code actions.

Key actions:
- `gd` go to definition
- `gD` go to declaration
- `gi` go to implementation
- `K` hover documentation
- `<leader>rn` rename symbol
- `<leader>ca` code action
- `[d` / `]d` previous/next diagnostic
- `<leader>lf` show diagnostics for current line
- `<leader>xx` Trouble diagnostics list

Tip: LSP attaches per filetype. If something does not work, verify `:LspInfo`.

---

## Completion (nvim-cmp)

What it does: Completion menu using LSP, buffer words, and snippets.

Key actions:
- `Ctrl-n` / `Ctrl-p` select next/previous
- `Enter` confirm completion
- `Tab` / `Shift-Tab` cycle items or jump snippet fields

---

## Formatting (conform.nvim)

What it does: Formats code with Prettier for JS/TS/JSON/CSS/MD and Ruff for Python.

Key actions:
- `<leader>fm` format current buffer

Notes:
- ESLint fix-on-save is enabled for JS/TS files (if ESLint is attached).
- If formatting does nothing, verify the formatter is installed in Mason.

---

## Tests (neotest)

What it does: Runs Jest/Vitest (JS/TS) and Pytest (Python) from inside Neovim.

Key actions:
- `<leader>tt` run nearest test
- `<leader>tf` run tests in current file
- `<leader>ts` run test suite
- `<leader>tS` stop tests
- `<leader>to` open test output
- `<leader>tp` toggle test summary panel

Tip: Neotest only runs if it detects a compatible project (pytest/jest config).

---

## File Search (telescope.nvim)

What it does: Fast fuzzy finder for files, text, buffers, and symbols.

Key actions:
- `<leader>ff` find files
- `<leader>fw` live grep (project search)
- `<leader>fb` list open buffers
- `<leader>fd` diagnostics search
- `<leader>fs` document symbols

---

## Git (gitsigns.nvim)

What it does: Shows git changes in the gutter and offers hunk actions.

Key actions (defaults):
- `[c` / `]c` previous/next hunk
- `<leader>hs` stage hunk
- `<leader>hr` reset hunk
- `<leader>hp` preview hunk
- `<leader>hb` blame line

---

## Harpoon (quick file jumps)

What it does: Bookmark files and jump between them quickly.

Key actions:
- `<leader>a` add file to Harpoon
- `<leader>ha` open Harpoon menu
- `<leader>1`..`<leader>4` jump to slots
- `<leader>hn` / `<leader>hp` next/previous in list

---

## Sessions (auto-session)

What it does: Save and restore layouts, buffers, and working dirs.

Key actions:
- `<leader>ws` save session
- `<leader>wr` restore session

---

## Undo Tree (undotree)

What it does: Visual history of changes for the current file.

Key actions:
- `<leader>u` toggle UndoTree

---

## Folding (nvim-ufo)

What it does: Better folds using Tree-sitter or indentation fallback.

Key actions:
- `zM` close all folds
- `zR` open all folds

---

## Command-line Completion (wilder.nvim)

What it does: Improved completion for `:` commands and searches.

Key actions:
- Works automatically in `:`, `/`, `?`

---

## Markdown Rendering (render-markdown.nvim)

What it does: Improved Markdown visuals (headings, lists, blocks).

Key actions:
- Opens automatically in Markdown buffers.

---

## Terminal Tips

- If a terminal opens inside Neovim and traps your input:
  - `Ctrl-\` then `Ctrl-n` to leave terminal mode
  - `:q` to close the terminal window


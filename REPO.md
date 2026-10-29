# Repository Map

## Purpose and Branch

This is a personal Neovim configuration derived from kickstart.nvim. **`rc2` is the owner's maintained customization branch**, where configuration choices reflect their preferences. Preserve those choices when updating dependencies or incorporating upstream changes. `master` tracks upstream; `rc2` is rebased onto it. The current upstream baseline is `8e35dbe`. Neovim 0.12+ is required for the built-in `vim.pack` plugin manager. `AGENTS.md` contains contributor instructions; this document provides a navigation map.

## Files and Directories

| Location | Purpose |
| --- | --- |
| `init.lua` | Main configuration: ten sections covering options, mappings, autocommands, `vim.pack` installation, and explicit plugin setup. |
| `lua/custom/plugins/init.lua` | Loads sibling Lua modules in unspecified order; its `require 'custom.plugins'` entry in `init.lua` is commented out. Keep dependent plugins together or require modules explicitly in order. |
| `lua/kickstart/plugins/` | Optional plugin specifications, described below. All corresponding imports are currently commented out. |
| `lua/kickstart/health.lua` | Neovim version and external-tool checks, available through `:checkhealth kickstart`. |
| `README.md` | Upstream Kickstart introduction, dependencies, installation recipes, and troubleshooting. |
| `doc/kickstart.txt` | Kickstart's built-in help document (`:help kickstart.nvim`); `doc/tags` indexes help topics. |
| `.stylua.toml` | Lua formatting: two spaces, preferred single quotes, Unix line endings, 160 columns, collapsed simple statements. |
| `.github/workflows/stylua.yml` | Runs `stylua --check .`; the job is restricted to the upstream `nvim-lua/kickstart.nvim` repository. |
| `.github/pull_request_template.md` | Reminder to select the intended PR base repository. |
| `.github/ISSUE_TEMPLATE/bug_report.md` | Bug-report checklist and reproduction template. |
| `.gitignore` | Excludes local files such as `nvim-pack-lock.json`, the legacy `lazy-lock.json`, `spell/`, and `.luarc.json`. |
| `LICENSE.md` | Repository license. |

## Navigating `init.lua`

The file executes from top to bottom, with scoped `do ... end` sections:

1. **Options:** Space leaders, disabled Nerd Font support, clipboard, search, splits, and editor behavior.
2. **Keymaps and autocommands:** Diagnostics, personal preferences, tree mappings, window navigation, and yank highlighting.
3. **Plugin manager intro:** `vim.pack` usage and `PackChanged` build hooks for Telescope's native sorter, LuaSnip, and Treesitter. The `gh` helper constructs GitHub URLs.
4. **UI / core UX:** Indentation detection, nvim-tree, Gitsigns with hunk mappings, Barbar, which-key, theme, TODO highlighting, and mini modules.
5. **Telescope:** Dependencies, search mappings, buffer pickers, and buffer-local LSP pickers.
6. **LSP:** Server definitions, Mason tool installation, `vim.lsp.config`, and `vim.lsp.enable`.
7. **Formatting:** Conform, per-filetype save formatting, and `<Leader>f`.
8. **Autocomplete and snippets:** LuaSnip and blink.cmp.
9. **Treesitter:** Parser installation, highlighting, and indentation attachment.
10. **Optional examples:** Disabled `kickstart.plugins.*` and `custom.plugins` requires.

Search for these plugin names or identifiers to locate specific features:

| Feature | Search in `init.lua` |
| --- | --- |
| Indentation detection, file explorer, buffer bar, Git signs | `guess-indent`, `nvim-tree`, `barbar`, `gitsigns` |
| Keybinding hints and fuzzy search | `which-key`, `telescope` |
| Language servers and tool installation | `LspAttach`, `local servers`, `ensure_installed`, `vim.lsp.enable` |
| Lua development | `lua_ls`, `stylua` (both explicitly configured as language servers) |
| Formatting and completion | `conform`, `formatters_by_ft`, `blink.cmp`, `LuaSnip` |
| Theme and editing helpers | `tokyonight-night`, `todo-comments`, `mini.ai`, `mini.surround`, `mini.statusline` |
| Syntax highlighting and indentation | `nvim-treesitter`, its `ensure_installed` parser list |

## Existing `rc2` Customizations

The `My key-mappings` block sets a horizontal insert-mode cursor, two-space expanded tabs, smart-case search, cursor-line highlighting, true color, a dark background, a persistent sign column, and completion-menu options. `guess-indent.nvim` can adjust indentation for individual buffers.

nvim-tree is enabled at startup with default setup and a web-devicons dependency. Use `<Leader>t` as the prefix for tree-related mappings:

- `<Space>tt`: toggle the file tree.
- `<Space>tf`: focus the file tree.
- `<Space>te`: reveal the current file in the tree (`NvimTreeFindFile`).

`<Space>fb` opens Telescope's list of open buffers. The existing `<Space><Space>` mapping opens the same picker.

`romgrk/barbar.nvim` displays open buffers in a clickable bar at startup, with spacing for the nvim-tree sidebar. It is installed through `vim.pack` with a `1.*` version range and explicit setup. File icons follow `vim.g.have_nerd_font`; close, modified, and pinned markers use plain characters when appropriate. Use `:BufferNext`, `:BufferPrevious`, or `:BufferClose` to manage buffers, or select one through Telescope.

The rebase preserves the customization commits' intent while adapting nvim-tree and Barbar to `vim.pack`. Upstream's Treesitter `main` branch setup supersedes the older custom main-module override.

## Optional Modules

These files exist but require enabling their imports in `init.lua`:

- `autopairs.lua`: automatic bracket and quote pairing.
- `debug.lua`: DAP, debugger UI, and Go/Delve setup.
- `indent_line.lua`: indentation guides through indent-blankline.
- `lint.lua`: nvim-lint with Markdown linting.
- `neo-tree.lua`: an alternative file explorer; the current active explorer is nvim-tree.

The former `gitsigns.lua` module was removed upstream; its recommended mappings now live directly in `init.lua`.

## Runtime State and Validation

Plugins and Mason-managed tools are installed outside this repository under Neovim's data directory. Inspect it with `:lua print(vim.fn.stdpath('data'))`. `vim.pack` manages `nvim-pack-lock.json`, which is ignored. Legacy lazy.nvim installations and `lazy-lock.json` are no longer used; the legacy lockfile remains ignored to preserve local state.

Use `:lua vim.pack.update(nil, { offline = true })` to inspect plugin state, `:lua vim.pack.update()` to review updates, and `:Mason`, `:ConformInfo`, and `:messages` for diagnostics. There is no application build or automated test suite. Validate edits with `stylua --check .`, a fresh Neovim 0.12+ session, `:checkhealth kickstart`, and manual feature checks. Treesitter also requires the tree-sitter CLI. Update this map when configuration locations or enabled modules change.

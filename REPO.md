# Repository Map

## Purpose and Branch

This is a personal Neovim configuration derived from kickstart.nvim. **`rc2` is the owner's maintained customization branch**, where configuration choices reflect their preferences. Preserve those choices when updating dependencies or incorporating upstream changes. `AGENTS.md` contains contributor instructions; this document provides a navigation map.

## Files and Directories

| Location | Purpose |
| --- | --- |
| `init.lua` | Main configuration: options, mappings, autocommands, plugin installation, and plugin setup. Most active configuration lives here. |
| `lua/custom/plugins/init.lua` | Personal plugin extension point; currently returns an empty table. The `custom.plugins` import in `init.lua` is commented out. |
| `lua/kickstart/plugins/` | Optional plugin specifications, described below. All corresponding imports are currently commented out. |
| `lua/kickstart/health.lua` | Neovim version and external-tool checks, available through `:checkhealth kickstart`. |
| `README.md` | Upstream Kickstart introduction, dependencies, installation recipes, and troubleshooting. |
| `doc/kickstart.txt` | Kickstart's built-in help document (`:help kickstart.nvim`); `doc/tags` indexes help topics. |
| `.stylua.toml` | Lua formatting: two spaces, preferred single quotes, Unix line endings, 160 columns. |
| `.github/workflows/stylua.yml` | Runs `stylua --check .`; the job is restricted to the upstream `nvim-lua/kickstart.nvim` repository. |
| `.github/pull_request_template.md` | Reminder to select the intended PR base repository. |
| `.github/ISSUE_TEMPLATE/bug_report.md` | Bug-report checklist and reproduction template. |
| `.gitignore` | Excludes local files such as `lazy-lock.json`, `spell/`, and `.luarc.json`. |
| `LICENSE.md` | Repository license. |

## Navigating `init.lua`

The file executes from top to bottom, with some plugin setup deferred by lazy.nvim:

1. **Globals and options:** Space is the leader; Nerd Font support is disabled by default. Configures numbers, clipboard, search, splits, and other editor behavior.
2. **Basic Keymaps / My key-mappings:** Window navigation and personal overrides, followed by the yank-highlight autocommand.
3. **Install `lazy.nvim` plugin manager:** Bootstraps lazy.nvim into `stdpath('data') .. '/lazy/lazy.nvim'` and adds it to the runtime path.
4. **Configure and install plugins:** The `require('lazy').setup` table defines active plugins and their dependencies.
5. **Optional imports and UI:** Commented module imports and lazy.nvim UI settings close the configuration.

Search for these plugin names or identifiers to locate specific features:

| Feature | Search in `init.lua` |
| --- | --- |
| Indentation detection, file explorer, buffer bar, Git signs | `guess-indent`, `nvim-tree`, `barbar`, `gitsigns` |
| Keybinding hints and fuzzy search | `which-key`, `telescope` |
| Language servers and tool installation | `LspAttach`, `local servers`, `ensure_installed`, `mason-lspconfig` |
| Lua development | `lazydev`, `lua_ls` (the only explicitly configured language server) |
| Formatting and completion | `conform`, `formatters_by_ft`, `blink.cmp`, `LuaSnip` |
| Theme and editing helpers | `tokyonight-night`, `todo-comments`, `mini.ai`, `mini.surround`, `mini.statusline` |
| Syntax highlighting and indentation | `nvim-treesitter`, its `ensure_installed` parser list |

## Existing `rc2` Customizations

The `My key-mappings` block sets a horizontal insert-mode cursor, two-space expanded tabs, smart-case search, cursor-line highlighting, true color, a dark background, a persistent sign column, and completion-menu options. `guess-indent.nvim` can adjust indentation for individual buffers.

nvim-tree is enabled at startup with default setup and a web-devicons dependency:

- `<Space>tt`: toggle the file tree.
- `<Space>tf`: focus the file tree.

`<Space>fb` opens Telescope's list of open buffers. The existing `<Space><Space>` mapping opens the same picker.

`romgrk/barbar.nvim` displays open buffers in a clickable bar at startup, with spacing for the nvim-tree sidebar. File icons follow `vim.g.have_nerd_font`; close, modified, and pinned markers use plain characters when appropriate. Use `:BufferNext`, `:BufferPrevious`, or `:BufferClose` to manage buffers, or select one through Telescope.

Recent customization commits are `76b734d` (editor preferences and a Treesitter main-module change) and `2808d63` (nvim-tree and its mappings).

## Optional Modules

These files exist but require enabling their imports in `init.lua`:

- `autopairs.lua`: automatic bracket and quote pairing.
- `debug.lua`: DAP, debugger UI, and Go/Delve setup.
- `gitsigns.lua`: additional Git hunk, blame, and diff mappings; basic Git signs are already enabled in `init.lua`.
- `indent_line.lua`: indentation guides through indent-blankline.
- `lint.lua`: nvim-lint with Markdown linting.
- `neo-tree.lua`: an alternative file explorer; the current active explorer is nvim-tree.

## Runtime State and Validation

Plugins and Mason-managed tools are installed outside this repository under Neovim's data directory. Inspect it with `:lua print(vim.fn.stdpath('data'))`. A local `lazy-lock.json` exists but is ignored by Git.

Use `:Lazy`, `:Mason`, `:ConformInfo`, and `:messages` to inspect runtime behavior. There is no application build or automated test suite. Validate configuration edits with `stylua --check .`, a fresh Neovim session, `:checkhealth kickstart`, and manual checks of the affected feature. Update this map when configuration locations or enabled modules change.

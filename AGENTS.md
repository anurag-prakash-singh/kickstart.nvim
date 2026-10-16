# Repository Guidelines

## Project Structure & Module Organization

This repository is a personal Neovim configuration based on kickstart.nvim. `init.lua` is the main entry point: it defines editor options, keymaps, lazy.nvim bootstrapping, and plugin specifications, including nvim-tree.

- `lua/kickstart/plugins/` contains optional plugin modules; enable their corresponding `require` entries in `init.lua` when needed.
- `lua/custom/plugins/` is the extension point for personal plugin specifications. Its `custom.plugins` import is currently commented out in `init.lua`; enable it before relying on these modules.
- `lua/kickstart/health.lua` implements configuration health checks.
- `doc/kickstart.txt` and `README.md` provide usage and setup documentation.
- `.github/` contains contribution templates and the StyLua workflow. There is no dedicated test or asset directory.

## Build, Test, and Development Commands

Run commands from the repository root unless stated otherwise.

- `nvim`: launch the configuration when installed at the standard Neovim config path; first startup installs plugins through lazy.nvim.
- `:Lazy`: inspect plugin installation and loading inside Neovim.
- `:checkhealth kickstart`: check Neovim compatibility and required external tools; use `:checkhealth` for broader plugin diagnostics.
- `stylua --check .`: validate Lua formatting, matching the CI command. Install StyLua or use the Mason-managed executable on your `PATH`.
- `stylua .`: format Lua files using `.stylua.toml`.

There is no application build step. Plugin installation may require Git, Make, unzip, and a C compiler; search features require ripgrep and fd.

## Coding Style & Naming Conventions

Follow `.stylua.toml`: two-space indentation, Unix line endings, a 160-column limit, preferred single quotes, and omitted optional call parentheses. Use descriptive `snake_case` local names and module filenames. Follow existing lazy.nvim plugin-table conventions and add descriptive `desc` values to keymaps. Keep changes focused and preserve the readable, documented configuration structure.

## Testing Guidelines

No automated test framework or coverage threshold is configured. For Lua changes, run the formatting check, restart Neovim, inspect `:messages`, and exercise affected mappings or plugin behavior. For LSP or formatter changes, open a representative source file and verify attachment or formatting. Record relevant health warnings and manual results in the PR.

## Commit & Pull Request Guidelines

History uses concise imperative subjects, including both plain descriptions and `fix:`/`feat:` prefixes. Match that style and keep each commit focused. PRs should describe the behavior change, validation performed, and related issues when applicable; include screenshots for visible UI changes. Follow the PR template by verifying the base repository targets the intended fork. `lazy-lock.json` is currently ignored; avoid changing lockfile tracking incidentally.

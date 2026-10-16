# Repository Guidelines

## Project Structure & Module Organization

This repository is a personal Neovim configuration based on kickstart.nvim, maintained on `rc2`. `init.lua` defines editor options, keymaps, and plugin installation/setup through Neovim's built-in `vim.pack`. Neovim 0.12+ is required.

- `lua/kickstart/plugins/` contains optional plugin modules; enable their corresponding `require` entries in `init.lua` when needed.
- `lua/custom/plugins/` is the extension point for personal plugin modules. Its `custom.plugins` loader is currently commented out in `init.lua`; enable it before relying on these modules.
- `lua/kickstart/health.lua` implements configuration health checks.
- `doc/kickstart.txt` and `README.md` provide usage and setup documentation.
- `.github/` contains contribution templates and the StyLua workflow. There is no dedicated test or asset directory.

## Build, Test, and Development Commands

Run commands from the repository root unless stated otherwise.

- `nvim`: launch the configuration from the standard Neovim config path; first startup installs plugins through `vim.pack`.
- `:lua vim.pack.update(nil, { offline = true })`: inspect plugin state and pending updates.
- `:lua vim.pack.update()`: fetch and review plugin updates.
- `:checkhealth kickstart`: check Neovim compatibility and required external tools; use `:checkhealth` for broader plugin diagnostics.
- `stylua --check .`: validate Lua formatting, matching the CI command. Install StyLua or use the Mason-managed executable on your `PATH`.
- `stylua .`: format Lua files using `.stylua.toml`.

There is no application build step. Plugin installation may require Git, Make, unzip, a C compiler, and the tree-sitter CLI; search features require ripgrep and fd.

## Coding Style & Naming Conventions

Follow `.stylua.toml`: two-space indentation, Unix line endings, a 160-column limit, preferred single quotes, omitted optional call parentheses, and collapsed simple statements. Use descriptive `snake_case` local names and module filenames. Follow existing `vim.pack.add` and explicit `setup()` patterns; install dependencies before dependents. Add descriptive `desc` values to keymaps. Preserve personal customizations and the documented section structure.

## Testing Guidelines

No automated test framework or coverage threshold is configured. For Lua changes, run the formatting check, restart Neovim, inspect `:messages`, and exercise affected mappings or plugin behavior. For LSP or formatter changes, open a representative source file and verify attachment or formatting. Record relevant health warnings and manual results in the PR.

## Commit & Pull Request Guidelines

History uses concise imperative subjects, including plain descriptions and `fix:`/`feat:` prefixes. Keep commits focused. PRs should describe behavior changes, validation, and related issues; include screenshots for UI changes. Verify the intended fork is the PR base. `nvim-pack-lock.json` is ignored; avoid changing lockfile tracking incidentally.

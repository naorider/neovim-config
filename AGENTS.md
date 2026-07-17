# Repository Guidelines

## Project Structure & Module Organization

`init.lua` is the entry point and loads core behavior before bootstrapping
`lazy.nvim`. General editor settings, mappings, and autocommands live in
`lua/core/`. Plugin specifications are grouped by purpose under
`lua/plugins/` (for example, `editor/`, `navigation/`, `languages/`, and
`ui/`). Shared setup belongs in `lua/config/`; LSP server definitions are in
`lua/config/lsp/servers/`. Filetype-specific overrides go in `ftplugin/`.
`lazy-lock.json` pins plugin revisions and should be committed when intentional
plugin updates change it.

## Development and Validation Commands

This repository has no compilation step. Use Neovim 0.11 or newer on Linux.

- `nvim` starts the configuration and installs missing plugins through
  `lazy.nvim`.
- `nvim --headless "+Lazy! sync" +qa` installs, updates, and cleans plugins
  non-interactively; review `lazy-lock.json` afterward.
- `stylua .` formats all Lua files using the repository's two-space settings.
- `stylua --check .` verifies formatting without modifying files.
- `nvim --headless +qa` provides a quick startup smoke test. Run
  `:checkhealth` interactively when changing LSP, Treesitter, or external-tool
  integrations.

## Coding Style & Naming Conventions

Write idiomatic Lua with two-space indentation, as configured in
`.stylua.toml`. Use lowercase `snake_case` for local variables and module
filenames. Keep plugin specs declarative: return a table from plugin modules,
place setup in `opts` or `config`, and group additions in the matching
`lua/plugins/<category>/` directory. Prefer small modules with one clear
responsibility. Add keymap descriptions when they help discovery, and avoid
machine-specific absolute paths.

## Testing Guidelines

There is currently no automated test suite or coverage requirement. Every
change should pass `stylua --check .` and the headless startup smoke test.
Manually exercise affected behavior in Neovim—for example, open a relevant
filetype after changing an LSP server, formatter, completion source, or
`ftplugin`. Confirm that startup produces no errors or unexpected plugin
lockfile changes.

## Commit & Pull Request Guidelines

Recent commits use concise, imperative subjects such as `Manage LSP servers
with Mason` and `Refactor plugin configuration layout`. Follow that style;
optional prefixes such as `feat:`, `fix:`, or `refactor:` also appear in older
history. Keep commits focused.

Pull requests should explain the motivation and user-visible effect, list
validation performed, and call out plugin or lockfile changes. Link related
issues when applicable. Include screenshots only for visible UI, colorscheme,
statusline, or layout changes.

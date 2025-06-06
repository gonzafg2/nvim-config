# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Overview

This is a Neovim configuration based on LazyVim
(<https://github.com/LazyVim/LazyVim>). The configuration uses Lua for all
configuration files and follows LazyVim's plugin structure.

## Common Commands

### Formatting and Linting

- **Format Lua files**: Uses stylua with configuration in `stylua.toml`
  (2 spaces, max width 120)

  ```bash
  stylua lua/
  ```

### Neovim Plugin Management

- **Update plugins**: Launch Neovim and run `:Lazy sync`
- **Check plugin health**: `:checkhealth`
- **View lazy loading status**: `:Lazy`

## Architecture

### Core Structure

- `init.lua`: Entry point that loads the lazy.nvim configuration
- `lua/config/`: Core configuration files
  - `lazy.lua`: Plugin manager setup and LazyVim bootstrap
  - `options.lua`: Neovim options
  - `keymaps.lua`: Global keymappings
  - `autocmds.lua`: Auto commands
- `lua/plugins/`: Custom plugin configurations that extend/override LazyVim
  defaults
- `lazyvim.json`: LazyVim extras configuration - defines which LazyVim modules
  are enabled

### Key Integrations

1. **AI Assistants**:

   - Claude Code integration (`claude_code.lua`) - Terminal-based Claude
     interface with file refresh
   - Code Companion (`code_companion.lua`) - Uses Copilot adapter with Claude
     Sonnet model
   - GitHub Copilot via pack directory

2. **Development Tools**:

   - LSP configurations for multiple languages (TypeScript, Python, Terraform,
     etc.)
   - ESLint and Prettier formatting
   - Git integration with gitui

3. **UI Enhancements**:
   - Render Markdown support
   - Image clipboard support (img-clip)
   - Smooth scrolling (neoscroll)
   - Obsidian integration

### Plugin Pattern

Custom plugins follow this structure:

```lua
return {
  "plugin/repo",
  dependencies = { ... },
  config = function()
    require("plugin").setup({ ... })
  end,
}
```

## Development Workflow

1. **Adding/Modifying Plugins**: Create or edit files in `lua/plugins/`
2. **Enabling LazyVim Extras**: Edit `lazyvim.json` and add to the `extras`
   array
3. **Custom Keymaps**: Add to `lua/config/keymaps.lua` or within plugin configs
4. **LSP Configuration**: Override in `lua/plugins/lspconfig.lua`

## Recent Improvements

- Reorganized plugin configurations from example.lua into individual files
- Added dedicated configurations for:
  - gruvbox.lua - Alternative colorscheme
  - trouble.lua - Diagnostics list
  - nvim-cmp.lua - Enhanced autocompletion with per-filetype sources
  - treesitter.lua - Advanced syntax highlighting and text objects
  - mason.lua - LSP/formatter/linter installer
- Enhanced ui.lua with lualine configuration
- Fixed keybinding conflicts between neoscroll and core mappings
- Improved .env file handling (diagnostics display only)

## Git Status Notes

- Main branch is `master`
- Currently has uncommitted changes to several plugin files

# ESLint LSP Troubleshooting Guide

## Problem: "ESLint library could not be resolved"

This error occurs when the vscode-eslint-language-server cannot find the ESLint library in your project.

## Solutions:

### 1. Install ESLint in Your Project

The most common solution is to ensure ESLint is installed in your project:

```bash
# Using pnpm (recommended)
pnpm add -D eslint

# Using npm
npm install --save-dev eslint

# Using yarn
yarn add -D eslint
```

### 2. Install ESLint Globally (Alternative)

If you prefer a global installation:

```bash
# Using pnpm
pnpm add -g eslint

# Using npm
npm install -g eslint

# Using yarn
yarn global add eslint
```

### 3. Configure ESLint

Create an ESLint configuration file in your project root:

```bash
# Interactive setup
pnpm eslint --init

# Or create a simple .eslintrc.json
echo '{"extends": ["eslint:recommended"]}' > .eslintrc.json
```

### 4. Verify Configuration

The updated ESLint configuration in `lua/plugins/eslint.lua` includes:

- **packageManager**: Set to "pnpm" (change if using npm/yarn)
- **workingDirectory.mode**: Set to "auto" for better config detection
- **experimental.useFlatConfig**: Enabled for ESLint 9+ flat config support
- **root_dir**: Enhanced pattern matching for various ESLint config formats

### 5. Restart Neovim

After making changes:

1. Save all files
2. Quit Neovim completely
3. Start Neovim again
4. Open a JavaScript/TypeScript file
5. Check LSP status with `:LspInfo`

### 6. Debug Commands

```vim
" Check if ESLint LSP is running
:LspInfo

" Check LSP log
:LspLog

" Restart LSP
:LspRestart eslint

" Check Mason installation
:Mason
```

### 7. Alternative: Use eslint_d

If issues persist, consider using `eslint_d` (a faster ESLint daemon):

```bash
# Already installed via Mason
# Configure in your project to use eslint_d instead
```

### 8. Project-Specific Configuration

For monorepos or complex projects, you might need to adjust the `nodePath`:

```lua
-- In eslint.lua, set a specific node path
nodePath = "/usr/local/bin", -- Example path
```

### 9. Check File Permissions

Ensure the ESLint language server has execution permissions:

```bash
chmod +x ~/.local/share/nvim/mason/bin/vscode-eslint-language-server
```

## Common Issues:

1. **Wrong package manager**: Update `packageManager` setting to match your project
2. **Missing ESLint config**: Create .eslintrc.json or eslint.config.js
3. **Monorepo issues**: Use `workingDirectory.mode = "auto"`
4. **Flat config**: Enable `experimental.useFlatConfig` for ESLint 9+

## Testing

Create a test file to verify ESLint is working:

```javascript
// test.js
const unused = "This should trigger an ESLint warning";
console.log("Hello")  // Missing semicolon (if configured)
```

Open this file in Neovim and check if ESLint diagnostics appear.
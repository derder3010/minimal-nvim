# Neovim IDE Configuration

This repository contains a comprehensive Neovim configuration designed to provide an IDE-like experience. It is built with modularity and ease of use in mind, leveraging powerful plugins and Lua scripting to optimize your development workflow.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Plugins](#plugins)
- [Key Bindings](#key-bindings)
- [Customization](#customization)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## Features

- **File Explorer:** Neo-tree for managing files and directories.
- **Code Completion:** Powered by `nvim-cmp` and Tabnine.
- **LSP Support:** Configured with Mason and native LSP.
- **Syntax Highlighting:** Tree-sitter integration.
- **Git Integration:** Git blame and signs for version control.
- **Terminal Integration:** ToggleTerm for built-in terminal management.
- **UI Enhancements:** Lualine, Bufferline, and indent guides.
- **Session Management:** Auto-session for saving and restoring sessions.
- **Rich Command Line:** Enhanced with Noice.
- **Search and Navigation:** Telescope for fuzzy finding and file navigation.
- **Error Diagnostics:** Trouble for managing LSP diagnostics.
- **Language Support:** Custom configurations for Rust and more.

## Installation

1. Clone this repository into your Neovim configuration directory:
   ```bash
   git clone https://github.com/derder3010/der-nvim.git ~/.config/nvim && nvim
   ```


2. Restart Neovim and enjoy your new IDE setup!

## Plugins

### Core Plugins
- **File Explorer:** [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- **Code Completion:** [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), [Tabnine](https://github.com/codota/tabnine-nvim)
- **LSP Management:** [Mason](https://github.com/williamboman/mason.nvim), [LSP Config](https://github.com/neovim/nvim-lspconfig)
- **Syntax Highlighting:** [Tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Git Integration:** [git-blame.nvim](https://github.com/f-person/git-blame.nvim)

### UI Enhancements
- **Statusline:** [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- **Bufferline:** [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- **Command Line:** [Noice](https://github.com/folke/noice.nvim)
- **Indent Guides:** [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

### Utility Plugins
- **Search:** [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- **Session Management:** [auto-session](https://github.com/rmagatti/auto-session)
- **Diagnostics:** [Trouble](https://github.com/folke/trouble.nvim)
- **Terminal:** [ToggleTerm](https://github.com/akinsho/toggleterm.nvim)

For the full list of plugins, see the `lua/der/plugins/` directory.

## Screenshots

*Include some screenshots of your Neovim setup here.*

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


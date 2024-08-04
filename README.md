# Dotfiles Repository

Welcome to my personal dotfiles repository! This collection includes configurations for Neovim, Tmux, and other essential tools that enhance my development environment. The goal is to streamline and optimize my workflow, making it more efficient and enjoyable.

## Overview

This repository contains tailored configuration files designed to improve your development experience. The configurations are optimized to ensure a smooth and productive workflow, whether you are a seasoned developer or just starting out.

### Included Configurations

1. **Neovim**: Customized settings to maximize the power and efficiency of text editing.
2. **Tmux**: Enhancements to boost productivity with the terminal multiplexer.
3. **Additional Tools**: Configurations for various other tools used in daily development tasks.

Feel free to explore these configurations and adapt them to suit your personal preferences.

## Prerequisites

Before setting up, ensure you have the following tool installed:

- **GNU Stow**: A symlink farm manager that helps in managing dotfiles.

You can find more information and download it here: [GNU Stow](https://www.gnu.org/software/stow/)

## Installation and Synchronization

To install and synchronize your configurations using GNU Stow, follow these steps:

1. **Move Existing Configuration**

   ```bash
   mkdir -p ~/dotfiles/nvim/.config
   mv ~/.config/nvim ~/dotfiles/nvim/.config
   ```

2. **Create Symlinks**

   ```bash
   stow -d ~/dotfiles -t ~ nvim
   ```

   This command will create symlinks for the Neovim configuration. Replace `nvim` with other tool names (like `tmux`, `wezterm`, etc.) as needed.

## Restoration

To restore your configurations from this repository, execute the following commands:

1. **Clone the Repository**

   ```bash
   git https://github.com/meanii/dotfiles.git ~/dotfiles
   ```

2. **Apply Configurations**

   ```bash
   stow -d ~/dotfiles -t ~ nvim tmux wezterm
   ```

   This command will restore the configurations for Neovim, Tmux, and Wezterm. You can adjust the command to include any other tools you wish to configure.

Feel free to adapt these steps to fit your specific needs and tools. If you have any questions or need further assistance, don't hesitate to reach out!

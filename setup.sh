#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Create config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Individual symlinks - easy to modify each line as needed
ln -sf "$DOTFILES_DIR/i3" "$HOME/.config/i3"
ln -sf "$DOTFILES_DIR/polybar" "$HOME/.config/polybar"
ln -sf "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/tmux" "$HOME/.config/tmux"
ln -sf "$DOTFILES_DIR/rofi" "$HOME/.config/rofi"

# Example of a dotfile that doesn't live in .config
# ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"

echo "Symlinks created!"

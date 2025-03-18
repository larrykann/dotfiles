# Dotfiles

This repository is a collection of my personal configuration files (dotfiles) and a reference for my Linux setup. It contains configurations for various tools and applications I use daily, making it easier to replicate my environment across different machines.

## Dependencies

These are the standard dependencies I use in my setup. Not all of them have configuration files in this repository, but they're listed here for reference when setting up a new system.

### Window Manager & Desktop
- i3-wm
- lightdm
- lightdm-gtk-greeter
- polybar
- picom
- feh
- xorg-xrandr

### Terminal & Editor
- wezterm
- neovim

### File Management
- pcmanfm

### Applications
- falkon
- rofi
- ventoy

### Package Management
- yay

### System Utilities
- mesa-utils
  - Commands:
    - `glxinfo | grep "OpenGL renderer"` (Check current GPU in use)
    - `DRI_PRIME=0 glxinfo | grep "OpenGL renderer"` (Check AMD GPU specifically)
    - `glxgears` (Test 3D rendering)

## Setup Notes

- Using feh for wallpaper management with randomization
- Using picom for window transparency effects
- Neovim uses Mason for plugin and LSP management
- AMD GPU is configured as primary when available

## Installation

Details for setting up these dotfiles on a new system will be added here in the future.

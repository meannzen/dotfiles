#!/bin/bash
# Install Nerd Fonts for terminal and editors

set -e

OS="$(uname)"

info() { echo -e "\033[1;34m[fonts]\033[0m $1"; }
ok()   { echo -e "\033[1;32m  ✓\033[0m $1 already installed"; }

# Check if JetBrainsMono Nerd Font is installed
need_jetbrains=false
if ! fc-list | grep -qi "JetBrainsMono.*Nerd"; then
    need_jetbrains=true
else
    ok "JetBrainsMono Nerd Font"
fi

# Check if Monaspace Neon is installed
need_monaspace=false
if ! fc-list | grep -qi "Monaspace.*Neon"; then
    need_monaspace=true
else
    ok "Monaspace Neon"
fi

if [ "$need_jetbrains" = false ] && [ "$need_monaspace" = false ]; then
    info "All fonts already installed."
    exit 0
fi

if [ "$OS" = "Darwin" ]; then
    if ! command -v brew &>/dev/null; then
        echo "Warning: Homebrew not found, skipping font install."
        exit 1
    fi
    brew tap homebrew/cask-fonts 2>/dev/null
    if [ "$need_jetbrains" = true ]; then
        info "Installing JetBrainsMono Nerd Font..."
        brew install --cask font-jetbrains-mono-nerd-font
    fi
    if [ "$need_monaspace" = true ]; then
        info "Installing Monaspace..."
        brew install --cask font-monaspace
    fi
elif [ "$OS" = "Linux" ]; then
    if command -v pacman &>/dev/null; then
        if [ "$need_jetbrains" = true ]; then
            info "Installing JetBrainsMono Nerd Font..."
            sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd
        fi
        if [ "$need_monaspace" = true ]; then
            info "Installing Monaspace..."
            if command -v yay &>/dev/null; then
                yay -S --noconfirm otf-monaspace
            elif command -v paru &>/dev/null; then
                paru -S --noconfirm otf-monaspace
            else
                echo "  Warning: Monaspace requires an AUR helper (yay/paru)."
            fi
        fi
    else
        echo "Warning: Unsupported Linux distro, skipping font install."
    fi
fi

info "Fonts done!"

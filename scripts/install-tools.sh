#!/bin/bash
# Install CLI dev tools for macOS and Arch Linux

set -e

OS="$(uname)"

info() { echo -e "\033[1;34m[tools]\033[0m $1"; }
ok()   { echo -e "\033[1;32m  ✓\033[0m $1 already installed"; }

install_if_missing() {
    local cmd="$1"
    local brew_pkg="$2"
    local pacman_pkg="$3"

    if command -v "$cmd" &>/dev/null; then
        ok "$cmd"
        return
    fi

    info "Installing $cmd..."
    if [ "$OS" = "Darwin" ]; then
        brew install "$brew_pkg"
    elif [ "$OS" = "Linux" ] && command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm "$pacman_pkg"
    else
        echo "  Skipping $cmd (unsupported platform)"
    fi
}

# Check package manager
if [ "$OS" = "Darwin" ] && ! command -v brew &>/dev/null; then
    echo "Error: Homebrew is required on macOS."
    echo "  Install: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

info "Installing CLI tools..."
echo ""

# Modern replacements
install_if_missing "eza"       "eza"          "eza"
install_if_missing "bat"       "bat"          "bat"
install_if_missing "rg"        "ripgrep"      "ripgrep"
install_if_missing "fd"        "fd"           "fd"
install_if_missing "zoxide"    "zoxide"       "zoxide"
install_if_missing "fzf"       "fzf"          "fzf"
install_if_missing "starship"  "starship"     "starship"
install_if_missing "delta"     "git-delta"    "git-delta"
install_if_missing "lazygit"   "lazygit"      "lazygit"
install_if_missing "tmux"      "tmux"         "tmux"
install_if_missing "stow"      "stow"         "stow"
install_if_missing "nvim"      "neovim"       "neovim"

echo ""
info "CLI tools done!"

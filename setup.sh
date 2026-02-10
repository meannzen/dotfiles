#!/bin/bash
# Main setup script — orchestrates all install scripts and stows dotfiles

set -e

DOTFILES_DIR="$HOME/dotfiles"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

header() {
    echo ""
    echo -e "\033[1;36m══════════════════════════════════════\033[0m"
    echo -e "\033[1;36m  $1\033[0m"
    echo -e "\033[1;36m══════════════════════════════════════\033[0m"
    echo ""
}

# ── Step 1: Install CLI tools ───────────────────────
header "Installing CLI tools"
bash "$SCRIPTS_DIR/install-tools.sh"

# ── Step 2: Install fonts ───────────────────────────
header "Installing fonts"
bash "$SCRIPTS_DIR/install-fonts.sh"

# ── Step 3: Install language servers ────────────────
header "Installing language servers"
bash "$SCRIPTS_DIR/install-lsp.sh"

# ── Step 4: Stow dotfiles ──────────────────────────
header "Linking dotfiles with stow"
cd "$DOTFILES_DIR" || exit 1

for folder in */; do
    folder_name="${folder%/}"
    # Skip the scripts directory
    [ "$folder_name" = "scripts" ] && continue
    echo "Stowing $folder_name..."
    if ! stow "$folder_name"; then
        echo "  Warning: Failed to stow $folder_name"
    fi
done

# ── Done ────────────────────────────────────────────
header "Setup complete!"
echo "  Restart your shell or run: exec fish"
echo "  In tmux, press prefix + I to install plugins"
echo ""

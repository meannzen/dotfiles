#!/bin/bash
# Install language servers and dev toolchains

set -e

OS="$(uname)"

info() { echo -e "\033[1;34m[lsp]\033[0m $1"; }
ok()   { echo -e "\033[1;32m  ✓\033[0m $1 already installed"; }

# ── Node.js / TypeScript ────────────────────────────
install_node_tools() {
    info "Setting up Node.js tools..."

    if ! command -v node &>/dev/null; then
        info "Installing Node.js..."
        if [ "$OS" = "Darwin" ]; then
            brew install node
        elif command -v pacman &>/dev/null; then
            sudo pacman -S --noconfirm nodejs npm
        fi
    else
        ok "node $(node -v)"
    fi

    # Global npm packages for LSP
    local npm_pkgs=(
        "typescript"
        "typescript-language-server"
        "vscode-langservers-extracted"
        "@olrtg/emmet-language-server"
        "prettier"
        "dprint"
    )

    for pkg in "${npm_pkgs[@]}"; do
        local cmd
        cmd=$(echo "$pkg" | sed 's/@.*\///' | sed 's/vscode-langservers-extracted/vscode-json-language-server/')
        if npm list -g "$pkg" &>/dev/null; then
            ok "$pkg"
        else
            info "Installing $pkg..."
            npm install -g "$pkg"
        fi
    done
}

# ── Rust ────────────────────────────────────────────
install_rust_tools() {
    info "Setting up Rust tools..."

    if ! command -v rustup &>/dev/null; then
        info "Installing Rust via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    else
        ok "rust $(rustc --version 2>/dev/null | awk '{print $2}')"
    fi

    if ! command -v rust-analyzer &>/dev/null; then
        info "Installing rust-analyzer..."
        rustup component add rust-analyzer
    else
        ok "rust-analyzer"
    fi
}

# ── C / C++ ─────────────────────────────────────────
install_c_tools() {
    info "Setting up C/C++ tools..."

    if command -v clangd &>/dev/null; then
        ok "clangd"
    else
        info "Installing clangd..."
        if [ "$OS" = "Darwin" ]; then
            brew install llvm
        elif command -v pacman &>/dev/null; then
            sudo pacman -S --noconfirm clang
        fi
    fi
}

# ── C# / .NET ──────────────────────────────────────
install_csharp_tools() {
    info "Setting up C# tools..."

    if command -v dotnet &>/dev/null; then
        ok "dotnet $(dotnet --version 2>/dev/null)"
    else
        info "Installing .NET SDK..."
        if [ "$OS" = "Darwin" ]; then
            brew install dotnet
        elif command -v pacman &>/dev/null; then
            sudo pacman -S --noconfirm dotnet-sdk
        fi
    fi

    # OmniSharp LSP
    local omnisharp_dir="$HOME/.local/bin/omnisharp"
    if [ -d "$omnisharp_dir" ]; then
        ok "omnisharp"
    else
        info "Note: Install OmniSharp manually from https://github.com/OmniSharp/omnisharp-roslyn/releases"
        info "  Extract to: $omnisharp_dir/"
    fi
}

echo ""
install_node_tools
echo ""
install_rust_tools
echo ""
install_c_tools
echo ""
install_csharp_tools
echo ""

info "Language servers done!"

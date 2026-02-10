# Dotfiles

Personal configuration files for **macOS** and **Arch Linux**, managed with [GNU Stow](https://www.gnu.org/software/stow/).

---

## What's Included

| Config | Description |
|--------|-------------|
| **fish** | Fish shell — aliases, abbreviations, PATH, zoxide/starship/fzf init |
| **git** | Global git config — rebase, delta diffs, aliases |
| **tmux** | Terminal multiplexer — vim nav, powerline status bar, session persist |
| **helix** | Modal editor — LSP configs for TS/JS, Rust, C/C++, C# |
| **starship** | Cross-shell prompt — git, language versions, command duration |
| **ghostty** | Terminal emulator (macOS) |
| **alacritty** | Terminal emulator (cross-platform) |
| **yazi** | Terminal file manager |
| **zed** | Zed editor settings |
| **hypr** | Hyprland window manager (Arch/Wayland) |
| **waybar** | Status bar for Hyprland |

---

## Quick Start

### Fresh machine setup (one command)

```bash
git clone git@github.com:senmeannrealwat/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh scripts/*.sh
./setup.sh
```

This will:
1. Install CLI tools (`eza`, `bat`, `ripgrep`, `fd`, `zoxide`, `fzf`, `starship`, `delta`, `lazygit`, `nvim`, etc.)
2. Install fonts (JetBrainsMono Nerd Font, Monaspace)
3. Install language servers (typescript-language-server, rust-analyzer, clangd, omnisharp, prettier, dprint)
4. Symlink all configs to `~/.config/` via stow

### Run individual scripts

```bash
./scripts/install-tools.sh    # CLI tools only
./scripts/install-fonts.sh    # Fonts only
./scripts/install-lsp.sh      # Language servers only
```

### Stow a single config

```bash
cd ~/dotfiles
stow fish        # just fish shell config
stow tmux        # just tmux config
stow git         # just git config
```

### Remove a config

```bash
stow -D fish     # unlink fish config
```

---

## Directory Structure

```
~/dotfiles/
├── setup.sh                          # Main setup script
├── scripts/
│   ├── install-tools.sh              # CLI tools installer
│   ├── install-fonts.sh              # Nerd Fonts installer
│   └── install-lsp.sh               # Language server installer
├── fish/.config/fish/
│   ├── config.fish                   # Aliases, PATH, abbreviations, tool init
│   └── conf.d/
│       ├── deno.fish                 # Deno environment (macOS)
│       └── rustup.fish               # Cargo/Rust environment
├── git/.config/git/
│   └── config                        # Global git config + delta
├── tmux/.config/tmux/
│   └── tmux.conf                     # Tmux config + status bar
├── helix/.config/helix/
│   ├── config.toml                   # Editor settings
│   ├── languages.toml                # LSP & formatter configs
│   ├── ignore                        # File picker ignore rules
│   └── themes/                       # Custom themes
├── starship/.config/
│   └── starship.toml                 # Prompt config
├── ghostty/.config/ghostty/
│   └── config                        # Ghostty terminal settings
├── alacritty/.config/alacritty/
│   └── alacritty.toml                # Alacritty terminal settings
├── yazi/.config/yazi/
│   └── yazi.toml                     # File manager settings
├── zed/.config/zed/
│   └── settings.json                 # Zed editor settings
├── hypr/.config/hypr/
│   └── hyprland.conf                 # Hyprland WM config (Linux)
└── waybar/.config/waybar/
    ├── config.jsonc                  # Waybar modules
    └── style.css                     # Waybar styling
```

---

## Shell Aliases & Abbreviations

### Aliases (fish)

| Alias | Command |
|-------|---------|
| `vim` / `vi` | `nvim` |
| `ls` | `eza --icons` |
| `ll` | `eza -la --icons --git` |
| `la` | `eza -a --icons` |
| `lt` | `eza --tree --icons --level=2` |
| `cat` | `bat --style=auto` |
| `grep` | `rg` |
| `tree` | `eza --tree` |
| `lg` | `lazygit` |

### Abbreviations (expand as you type)

| Abbr | Expands to |
|------|-----------|
| `gs` | `git status` |
| `gc` | `git commit` |
| `gp` | `git push` |
| `gl` | `git pull` |
| `gd` | `git diff` |
| `gco` | `git checkout` |
| `glog` | `git log --oneline --graph --decorate` |
| `cr` | `cargo run` |
| `cb` | `cargo build` |
| `ct` | `cargo test` |
| `ni` | `npm install` |
| `nr` | `npm run` |
| `nd` | `npm run dev` |
| `dc` | `docker compose` |

---

## Git Aliases

| Alias | Command |
|-------|---------|
| `git co` | `checkout` |
| `git br` | `branch` |
| `git sw` | `switch` |
| `git st` | `status -sb` |
| `git cm "msg"` | `commit -m "msg"` |
| `git lg` | Pretty log graph |
| `git undo` | `reset --soft HEAD~1` |
| `git wip` | Stage all + commit "wip" |
| `git last` | Show last commit |
| `git amend` | Amend last commit |
| `git unstage` | Restore staged files |

---

## Tmux Keybindings

Prefix is `Ctrl+s`.

| Key | Action |
|-----|--------|
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + H/J/K/L` | Resize panes |
| `prefix + \|` | Vertical split |
| `prefix + -` | Horizontal split |
| `prefix + c` | New window (current path) |
| `prefix + s` | Session picker |
| `prefix + r` | Reload config |
| `prefix + I` | Install tpm plugins |

Sessions auto-save and restore via `tmux-resurrect` + `tmux-continuum`.

---

## Helix Language Support

| Language | LSP | Formatter |
|----------|-----|-----------|
| TypeScript / TSX | typescript-language-server, eslint, emmet | dprint |
| JavaScript / JSX | typescript-language-server, eslint, emmet | dprint |
| HTML | vscode-html-language-server, emmet | prettier |
| CSS | vscode-css-language-server, tailwindcss-ls | prettier |
| JSON | vscode-json-language-server | — |
| Rust | rust-analyzer | — |
| C / C++ | clangd | clang-format |
| C# | omnisharp | — |

---

## Platform Notes

| Component | macOS | Arch Linux |
|-----------|-------|------------|
| Terminal | Ghostty / Alacritty | Alacritty |
| Shell | Fish | Fish |
| Window Manager | — | Hyprland |
| Status Bar | — | Waybar |
| Package Manager | Homebrew | pacman / yay / paru |

---

## Dependencies

All installed automatically by `./setup.sh`:

**CLI tools:** `eza` `bat` `ripgrep` `fd` `zoxide` `fzf` `starship` `git-delta` `lazygit` `tmux` `stow` `neovim`

**Fonts:** JetBrainsMono Nerd Font, Monaspace

**Language servers:** `typescript-language-server` `vscode-langservers-extracted` `emmet-language-server` `rust-analyzer` `clangd` `dotnet` `prettier` `dprint`

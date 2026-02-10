# ── Environment ──────────────────────────────────────
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx LANG en_US.UTF-8

# ── PATH ─────────────────────────────────────────────
fish_add_path -g $HOME/.local/bin
fish_add_path -g $HOME/.cargo/bin
fish_add_path -g $HOME/.deno/bin
fish_add_path -g $HOME/.npm-global/bin

# ── Aliases ──────────────────────────────────────────
alias vim="nvim"
alias vi="nvim"
alias cat="bat --style=auto"
alias grep="rg"
alias tree="eza --tree"
alias lg="lazygit"

# ls → eza
if command -q eza
    alias ls="eza --icons"
    alias ll="eza -la --icons --git"
    alias la="eza -a --icons"
    alias lt="eza --tree --icons --level=2"
end

# ── Abbreviations (expand inline as you type) ───────
# git
abbr -a gs   "git status"
abbr -a gc   "git commit"
abbr -a gca  "git commit --amend"
abbr -a gp   "git push"
abbr -a gl   "git pull"
abbr -a gd   "git diff"
abbr -a gco  "git checkout"
abbr -a gsw  "git switch"
abbr -a gb   "git branch"
abbr -a glog "git log --oneline --graph --decorate"

# cargo
abbr -a cr   "cargo run"
abbr -a cb   "cargo build"
abbr -a ct   "cargo test"
abbr -a cw   "cargo watch -x run"

# npm / node
abbr -a ni   "npm install"
abbr -a nr   "npm run"
abbr -a nd   "npm run dev"

# docker
abbr -a dc   "docker compose"
abbr -a dcu  "docker compose up -d"
abbr -a dcd  "docker compose down"

# ── Tool Init ────────────────────────────────────────
# zoxide (smart cd)
if command -q zoxide
    zoxide init fish | source
end

# starship prompt
if command -q starship
    starship init fish | source
end

# fzf keybindings
if command -q fzf
    fzf --fish | source
end

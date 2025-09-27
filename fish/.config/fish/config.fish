if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g PATH /opt/homebrew/bin $PATH
set -g PATH /opt/homebrew/bin/nvim $PATH
#starship init fish | source
alias vim=nvim

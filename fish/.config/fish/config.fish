if status is-interactive
    # Commands to run in interactive sessions can go here
end
if test "$(uname)" = Drawin
    set -g PATH /opt/homebrew/bin $PATH
    set -g PATH /opt/homebrew/bin/nvim $PATH
end

if test "$(uname)" = Linux
    alias hx="helix"
end

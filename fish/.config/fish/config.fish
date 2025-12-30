if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    # Set cursor to blinking bar
    printf '\033[5 q'

    # Reset cursor shape on every prompt
    function reset_cursor --on-event fish_prompt
        printf '\033[5 q'
    end

end

function fish_greeting
	fastfetch
end

# # tmux auto start ( NOT SAFE )
# if status is-interactive
#     and not set -q TMUX
#     exec tmux new -s default
# end

# tmux start manully
function t
    tmux new-session -A -s default
end

# tmux start with dyanmic session
function tt
	tmux new-session -A -s "$(basename $(pwd))"
end

# enviorment for volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

source $HOME/.local/bin/env.fish 2>/dev/null

# alias of !!
function last_history_item
    echo $history[1]
end

# aliad of !$
function last_history_without_exec
    echo $history[1] | awk '{$1= ""; print $0}'
end

abbr -a !! --position anywhere --function last_history_item
abbr -a !!! --position anywhere --function last_history_without_exec

# vscode
set -x PATH "$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# bob - nvim version manager
set -x PATH "$PATH:/Users/anil/.local/share/bob/nvim-bin"

# golang bin path
set -x PATH "$PATH:/Users/anil/go/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anil/.gcloud/google-cloud-sdk/path.fish.inc' ]
    . '/Users/anil/.gcloud/google-cloud-sdk/path.fish.inc'
end

# pnpm
set -gx PNPM_HOME /Users/anil/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# android enviorment
set -x JAVA_HOME "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
set -x ANDROID_HOME "$HOME/Library/Android/sdk"
set -x PATH "$PATH:$ANDROID_HOME/emulator"
set -x PATH "$PATH:$ANDROID_HOME/platform-tools"

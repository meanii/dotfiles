if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
end

printf '\033[5 q'


# enviorment for volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

source $HOME/.local/bin/env.fish

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
if [ -f '/Users/anil/.gcloud/google-cloud-sdk/path.fish.inc' ]; . '/Users/anil/.gcloud/google-cloud-sdk/path.fish.inc'; end

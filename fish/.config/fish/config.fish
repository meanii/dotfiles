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

# tmux start manully
function t
    tmux new-session -A -s default
end

# tmux start with dyanmic session
function tt
	tmux new-session -A -s "$(basename $(pwd))"
end

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

# settinh up paths got bins
## golang bin
set -x PATH $PATH /usr/local/go/bin

## volta
set -x VOLTA_HOME $PATH $HOME/.volta 
set -x PATH $PATH $VOLTA_HOME/bin

# aliases
alias v="nvim"

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

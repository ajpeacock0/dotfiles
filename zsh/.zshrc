# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

#### ZSH Specific ####

# Path to your oh-my-zsh installation.
export ZSH="/home/`whoami`/.oh-my-zsh"
# Go Path
export GOPATH="/home/`whoami`/go"

export PATH=$GOPATH/bin:$PATH

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# Install: git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  history-substring-search
)

source $ZSH/oh-my-zsh.sh

# Note: `man zshzle` to read the zshrc documentation

#### Config #####

export EDITOR='vim'

export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Readline never rings the bell
set bell-style none

#### zsh-vimto ####

# Vim mode
bindkey -v

# Don't take 0.4s to change modes
export KEYTIMEOUT=1

# Save previous RPROMPT to restore when vim status not displayed
RPROMPT_PREVIOUS=$RPROMPT

# Default color settings
#if [ -z "$VIMTO_COLOR_NORMAL_TEXT" ]; then VIMTO_COLOR_NORMAL_TEXT=black; fi
#if [ -z "$VIMTO_COLOR_NORMAL_BACKGROUND" ]; then VIMTO_COLOR_NORMAL_BACKGROUND=white; fi

function zle-keymap-select zle-line-init {
    # If it's not tmux then can use normal sequences
    if [[ -z "${TMUX}" ]]; then
        local vicmd_seq="\e[2 q"
        local viins_seq="\e[0 q"
    else
        # In tmux, escape sequences to pass to terminal need to be
        # surrounded in a DSC sequence and double-escaped:
        # ESC P tmux; {text} ESC \
        # <http://linsam.homelinux.com/tmux/tmuxcodes.pdf>
        local vicmd_seq="\ePtmux;\e\e[2 q\e\\"
        local viins_seq="\ePtmux;\e\e[0 q\e\\"
    fi

    # Command mode
    if [ $KEYMAP = vicmd ]; then
        echo -ne $vicmd_seq
        RPROMPT_PREVIOUS=$RPROMPT
        RPROMPT=$'%K{$VIMTO_COLOR_NORMAL_BACKGROUND} %F{$VIMTO_COLOR_NORMAL_TEXT}NORMAL%f %k'
    # Insert mode
    else
        # Disable changing the cursor
        #echo -ne $viins_seq
        RPROMPT=$RPROMPT_PREVIOUS
    fi
    zle reset-prompt
}

function accept-line-clear-rprompt {
    export RPROMPT=$RPROMPT_PREVIOUS
    zle reset-prompt
    zle accept-line
}

zle -N accept-line-clear-rprompt
## Hook enter being pressed whilst in cmd mode
bindkey -M vicmd "^M" accept-line-clear-rprompt

## Change appearance
#zle -N zle-keymap-select  # When vi mode changes
#zle -N zle-line-init

# When a new line starts
# Fix backspace not working after returning from cmd mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

## Need to initially clear RPROMPT for it to work on first prompt
export RPROMPT=$RPROMPT_PREVIOUS

#### Vi Insert Mode Bindings ####

# Switch to command mode
bindkey -v "\C-X" vi-cmd-mode

set enable-keypad on

# Press up-arrow for previous matching command
bindkey -v "\e[A" history-search-backward # requires the enabled keypad
# Press down-arrow for next matching command
bindkey -v "\e[B" history-search-forward # requires the enabled keypad

# Emacs style non-vi conflicting keys
bindkey -v "\e[1;5C" forward-word   # ctrl + right
bindkey -v "\e[1;5D" backward-word  # ctrl + left
bindkey -v "\e[3;5~" kill-word # ctrl + del

#### Vi Command Mode Bindings ####

# Switch back to insert mode
bindkey -a "\C-X" vi-add-next

# Press up-arrow for previous matching command
bindkey -a '^[[A' history-substring-search-up
# Press down-arrow for next matching command
bindkey -a '^[[B' history-substring-search-down

# Press Vi up (k) for previous matching command
bindkey -M vicmd 'k' history-search-backward
# Press Vi down (j) for next matching command
bindkey -M vicmd 'j' history-search-forward

# Shift+h/l to move cursor to begin or end on line
bindkey -M vicmd "H" vi-beginning-of-line
bindkey -M vicmd "L" vi-end-of-line

#### Private functions ####

_print_array()
{
    local -n name=$1
    printf "Valid options are"
    for i in "${!name[@]}"
    do
        printf "\n- $i"
    done
}

# $1 is the action to perform
# $2 is the associate array
# $3 is the key / selection
_execute()
{
    local -n keys=$2

    if [ $# -eq 3 ] && [ ${keys[$3]+exists} ]
    then
        "$1" "${keys[$3]}" && return 0
    else
        # TODO: only display keys prefixed with given string
        _print_array keys && return 1
    fi
}

_execute_notify()
{
    START_TIME=$(date +"%r")
    local -n keys=$2

    if [ $# -eq 3 ] && [ ${keys[$3]+exists} ]
    then
        "$1" "${keys[$3]}"; echo "Sending Notification"; _send_notification "Execution complete" "${keys[$3]}\nTime: $START_TIME -$(date +"%r")" && return 0
    else
        # TODO: only display keys prefixed with given string
        _print_array keys && return 1
    fi
}

_execute_opt()
{
    local -n keys=$2

    if [ $# -eq 3 ] && [ ${keys[$3]+exists} ]
    then
        "$1" "${keys[$3]}"
    fi
    return 0
}

_execute_func()
{
    local -n funcs=$1

    if [ $# -eq 2 ] && [ ${funcs[$2]+exists} ]
    then
        "${funcs[$2]}"
    fi
    return 0
}

#### Utility ####

# Improved ls
alias ls="ls -FA --color=auto "

# Different ls
alias ll="ls -lhFA --color=auto "

# Improved grep
alias grep="grep --color=auto "

# Search for a file with the name
alias fhere="find . -iname "

# Search for a file containing a string
alias shere="grep -rnw . -e "

# Display the file name containing the string (less detailed shere)
findh () { grep -Rl $1 .; }

# Replaces the contents and filename of str1 to str2
replace () { a=$1; b=$2; grep -Rl "$a" . | xargs sed -i -- s/$a/$b/g; }

# Renames the files in the currently directory by replacing the given string by the second given string
rename () { a=$1; b=$2; for old_file in $(find | rg "$a"); do new_file=$(echo $old_file | sed -En "s/$a/$b/p"); mv $old_file $new_file; done; }

# Git version of replace
greplace () { a=$1; b=$2; git grep --files-with-matches "$a" | xargs sed -i -- s/$a/$b/g; }

# Git version of rename
grename () { a=$1; b=$2; for old_file in $(git ls-files "*$a*"); do new_file=$(echo $old_file | sed -En "s/$a/$b/p"); git mv -f $old_file $new_file; done; }

# Create and enter directory
mkcd () { mkdir -p $1; cd $1; }

# Shortcuts for up directory
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Display the space available on the HD
alias space="df -h"

# Improved rm for larger files TODO: clean up the need to create this enpty_dir/
alias rmsync="mkdir empty_dir; rsync -a --progress --delete empty_dir/ "

# Prints the contents of a function
display () { typeset -f "$1"; }

remove_spaces () { for f in *\ *; do mv "$f" "${f// /_}"; done; }

#### History ####

# Pressing space after !<command> or !! will show the command to be executed
bindkey " " magic-space

# Increase HISTSIZE from 1000 to 10000
HISTSIZE=100000
HISTFILESIZE=110000
# Save timestamp in the history file
HISTTIMEFORMAT="%F %T "
# Don't store duplicates + ignore commands starting with space
HISTCONTROL=ignoreboth

# Allow "sharing" of history between instances
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# If this is running inside WSL, config for X-Server.
if [[ $(uname -r) = *"Microsoft"* ]]; then
    export DISPLAY=localhost:0.0
fi

#### Tools ####

# The default data file location is `~/.z` but since we have
# that as our repo location, change the directory name to ".z_data"
export _Z_DATA="/home/`whoami`/.z_data"

# Start the `z` (jump around) tool
. ~/.z/z.sh

# Alias for thefuck
eval $(thefuck --alias)

alias pe="path-extractor"
alias -g PE='| pe | fzf | read filename; [ ! -z $filename ] && $EDITOR $filename'

# Open all git conflicts using Vim
alias gfix='vim +/HEAD `git diff --name-only | uniq`'

# Include the fzf shortcuts for CTRL-[R/T/C]
# This needs to be at the end of the file for some reason
test -e "${HOME}/.fzf.zsh" && source ~/.fzf.zsh

# Use fd for fzf, if available
if fd_loc="$(type -p fd)" && [[ -n $fd_loc ]]; then
    export FZF_DEFAULT_COMMAND='fd --type file'
fi

# Local variables
[[ ! -f ~/.vars.zsh ]] || source ~/.vars.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

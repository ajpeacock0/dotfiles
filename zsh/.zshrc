# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

#### ZSH Specific ####

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/`whoami`/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="candy"

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
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Include the fzf shortcuts for CTRL-[R/T/C]
# This needs to be at the end of the file for some reason
[ -f ~/.fzf/.fzf.zsh ] && source ~/.fzf/.fzf.zsh

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

# X-Server config
export DISPLAY=:0

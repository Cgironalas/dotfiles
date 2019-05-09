#!/bin/bash

# Based in Samuel Roeca's dotfiles.
#
# Use this file to:
#   Import .profile and ~/.bash/sensitive (using the provided "include")
#   Execute some "basic" commands
#   Define bash aliases and functions
#   Note: do NOT place sensitive information (like passwords) in this file

#######################################################################
# Set up environment and PATH
#######################################################################

## Functions ##################################################################
    path_ladd() {
      # Takes 1 argument and adds it to the beginning of the PATH
      if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
	PATH="$1${PATH:+":$PATH"}"
      fi
    }

    path_radd() {
      # Takes 1 argument and adds it to the end of the PATH
      if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
	PATH="${PATH:+"$PATH:"}$1"
      fi
    }
## ############################################################################


## Exported variable: LS_COLORS ###############################################
    # Colors when using the LS command
    # NOTE:
    # Color codes:
    #   0   Default Colour
    #   1   Bold
    #   4   Underlined
    #   5   Flashing Text
    #   7   Reverse Field
    #   31  Red
    #   32  Green
    #   33  Orange
    #   34  Blue
    #   35  Purple
    #   36  Cyan
    #   37  Grey
    #   40  Black Background
    #   41  Red Background
    #   42  Green Background
    #   43  Orange Background
    #   44  Blue Background
    #   45  Purple Background
    #   46  Cyan Background
    #   47  Grey Background
    #   90  Dark Grey
    #   91  Light Red
    #   92  Light Green
    #   93  Yellow
    #   94  Light Blue
    #   95  Light Purple
    #   96  Turquoise
    #   100 Dark Grey Background
    #   101 Light Red Background
    #   102 Light Green Background
    #   103 Yellow Background
    #   104 Light Blue Background
    #   105 Light Purple Background
    #   106 Turquoise Background
    # Parameters
    #   di 	Directory
    LS_COLORS="di=1;34:"
    #   fi 	File
    LS_COLORS+="fi=0:"
    #   ln 	Symbolic Link
    LS_COLORS+="ln=1;36:"
    #   pi 	Fifo file
    LS_COLORS+="pi=5:"
    #   so 	Socket file
    LS_COLORS+="so=5:"
    #   bd 	Block (buffered) special file
    LS_COLORS+="bd=5:"
    #   cd 	Character (unbuffered) special file
    LS_COLORS+="cd=5:"
    #   or 	Symbolic Link pointing to a non-existent file (orphan)
    LS_COLORS+="or=31:"
    #   mi 	Non-existent file pointed to by a symbolic link (visible with ls -l)
    LS_COLORS+="mi=0:"
    #   ex 	File which is executable (ie. has 'x' set in permissions).
    LS_COLORS+="ex=1;92:"
    # additional file types as-defined by their extension
    LS_COLORS+="*.rpm=90"

    # Finally, export LS_COLORS
    export LS_COLORS
## ############################################################################

# Exported variables: General --- {{{

# React
export REACT_EDITOR='less'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Configure less (de-initialization clears the screen)
# Gives nicely-colored man pages
export PAGER=less
export LESS='--ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --clear-screen'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# tmuxinator
export EDITOR=vim
export SHELL=bash

export MANPAGER="nvim -c 'set ft=man' -"

# environment variable controlling difference between HI-DPI / Non HI_DPI
# turn off because it messes up my pdf tooling
export GDK_SCALE=0

# History: ignore leading space commands, keep lines in memory
export HISTCONTROL=ignorespace
export HISTSIZE=5000

# }}}
# Path appends + Misc env setup --- {{{

PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
  export PYENV_ROOT
  path_radd "$PYENV_ROOT/bin"
  eval "$(pyenv init -)"
fi

NODENV_ROOT="$HOME/.nodenv"
if [ -d "$NODENV_ROOT" ]; then
  export NODENV_ROOT
  path_radd "$NODENV_ROOT/bin"
  eval "$(nodenv init -)"
fi

HOME_BIN="$HOME/bin"
if [ -d "$HOME_BIN" ]; then
  path_ladd "$HOME_BIN"
fi

STACK_LOC="$HOME/.local/bin"
if [ -d "$STACK_LOC" ]; then
  path_ladd "$STACK_LOC"
fi

POETRY_LOC="$HOME/.poetry/bin"
if [ -d "$POETRY_LOC" ]; then
  path_ladd "$POETRY_LOC"
  source $HOME/.poetry/env
fi

# EXPORT THE FINAL, MODIFIED PATH
export PATH

# }}}

#######################################################################
# Interactive Bash session settings
#######################################################################

# Import from other Bash Files --- {{{

include () {
  [[ -f "$1" ]] && source "$1"
}

include ~/.bash/sensitive

# }}}
# Executed Commands --- {{{

# turn off ctrl-s and ctrl-q from freezing / unfreezing terminal
stty -ixon

# }}}


## Aliases --- {{{
  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi


  ## Make "vim" direct to nvim ###
    alias v='nvim .'
    alias vi='nvim'
    alias vim='nvim'
  ################################

  ## List aliases ################
    alias ll='ls -alF'
    alias l='ls -CF'
    alias la='ls -a'
    alias lf='ls -alF | grep '
  ################################

  ## Python Virtual Environments #
    function enva() {
      if [ -d .env ]; then
        source .env/bin/activate
      else
        source $(cat .env)/bin/activate
      fi
      update_prompt
    }

    function envc() {
      if [ -z $1 ]; then
        echo "creating default virtual env '.env'"
        python -m venv .env
      else
        echo "creating virtual env '$1'"
        python -m venv $1
        echo $1 >> .env
      fi
    }

    function envp(){
      if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "${VIRTUAL_ENV##*/}"
      else
        echo ''
      fi
    }

    function envr() {
      if [ -d .env ]; then
        echo "removing default virtual env '.env'"
        rm -rf .env
      else
        echo "removing virtual env '$(cat .env)'"
        rm -rf $(cat .env)
        rm .env
      fi
    }

    alias envd='deactivate && update_prompt'
  ## #############################

  ## Git #########################
    alias g='git'
    alias ga='git add'
    alias gb='git branch'
    alias gcb='git checkout -b'
    alias gci='git commit'
    alias gd='git diff'
    alias gds='git diff --staged'
    alias gh='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
    alias go='git checkout'
    alias gs='git status'
    alias gsu='git status -u'
    alias gbintegration='export GITBRANCH=integration'

    function gitp() {
      if [[ -d .git || $(git rev-parse --git-dir 2> /dev/null) ]]; then
        echo "[$(git branch | grep \* | cut -d ' ' -f2)]"
      else
        echo ''
      fi
    }
  ## #############################

  ## Docker ######################
    alias dklsac='docker container ls -a'
    alias dklsai='docker image ls -a'
    alias dklsc='docker container ls'
    alias dklsi='docker image ls'
    alias dkpr='docker system prune --all'
    alias dkrmac='docker rm $(docker ps -a -q)'
    alias dkrmai='docker rmi $(docker images -q)'
    alias 'dk-cu'='docker-compose up'
    alias 'dk-cd'='docker-compose down'

    function drmi() {
      for img in "$@"
      do
	docker image rm \
	  $(docker images --format "{{.Repository}}:{{.Tag}}" | grep $img)
      done
    }

    ## $ drmi kip python
    ## will remove any docker images that contain kip, amazonaws, and python
  ## #############################


  ## Python ######################
    alias pya='poetry add'
    alias pyad='poetry add --dev'
    alias pyi='poetry init'
    alias pyr='poetry remove'
    alias pipf='pip freeze'
    alias pipfr='pip freeze >> requirements.txt'
    alias pipu='pip install -U'
    alias pipun='pip uninstall'
    alias pipup='pip install -U pip'
    alias pipr='pip install -r requirements.txt'
  ## #############################

  ## #############################
    ## Directory #################
    function c() {
      cd $1
      update_prompt
    }
    function d() {
      cd $1
      update_prompt
    }
    alias .='cd .. && update_prompt'
    alias ..='cd ../../ && update_prompt'
    alias ...='cd ../../../ && update_prompt'
    alias ....='cd ../../../../ && update_prompt'
    alias .....='cd ../../../../../ && update_prompt'

    alias mv='mv -i'
    alias cp='cp -i'
    alias rm='rm -i'
  ## ##########################################################################


  ## ##########################################################################
    ## Other
    alias cl='clear'
    alias fn='find . -name'

    alias trw='tmux rename-window'
    alias saud='sudo apt update'
    alias saup='sudo apt upgrade -y'
    alias ':q'='exit'

    pkg_updates() {
      if [[ $(command -v apt) ]]; then
	echo "Using apt update then upgrade -y"
	sudo apt update && sudo apt upgrade -y
      fi

      if [[ $(command -v pacman) ]]; then
	echo "Using arch pacman and yay"
	sudo pacman -Syyu && yay -Syu
      fi
    }

    # Set copy/paste helper functions
    # the perl step removes the final newline from the output
    alias pbcopy="perl -pe 'chomp if eof' | xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
    ## End Other
  ## ##########################################################################

## ############################################################################


#### Functions ################################################################
  clubhouse() {
    # Clubhouse story template
    echo -e "## Objective\n## Value\n## Acceptance Criteria" | pbcopy
  }

  so() {
    # Reload bashrc
    source ~/.bashrc
  }
#### ##########################################################################

#### ##########################################################################
  ## Command line prompt (PS1) ################################################
  COLOR_BRIGHT_GREEN="\033[38;5;10m"
  COLOR_BRIGHT_BLUE="\033[38;5;115m"
  COLOR_CYAN="\033[0;36m"
  COLOR_LIGHT_CYAN="\033[1;36m"
  COLOR_RED="\033[1;31m"
  COLOR_YELLOW="\033[0;33m"
  COLOR_GREEN="\033[0;32m"
  COLOR_PURPLE="\033[1;35m"
  COLOR_ORANGE="\033[38;5;202m"
  COLOR_BLUE="\033[1;34m"
  COLOR_WHITE="\033[0;37m"
  COLOR_GOLD="\033[38;5;142m"
  COLOR_SILVER="\033[38;5;248m"
  COLOR_RESET="\033[0m"

  BOLD="$(tput bold)"

  # Set Bash PS1
  PS1_GIT="\[$BOLD\]\[$COLOR_GOLD\]$(gitp)"
  PS1_DIR="\[$BOLD\]\[$COLOR_BRIGHT_BLUE\]\w"
  PS1_ENV="\[$BOLD\]\[$COLOR_BRIGHT_GREEN\]$(envp)"
  PS1_USR="\[$BOLD\]\[$COLOR_BLUE\]\u@\h"
  PS1_END="\[$BOLD\]\[$COLOR_LIGHT_CYAN\]$ \[$COLOR_RESET\]"

  PS1="${PS1_GIT} ${PS1_DIR} ${PS1_ENV}\

${PS1_USR} ${PS1_END}"

  function update_prompt() {
    PS1_GIT="\[$BOLD\]\[$COLOR_GOLD\]$(gitp)"
    PS1_DIR="\[$BOLD\]\[$COLOR_BRIGHT_BLUE\]\w"
    PS1_ENV="\[$BOLD\]\[$COLOR_BRIGHT_GREEN\]$(envp)"
    PS1_USR="\[$BOLD\]\[$COLOR_BLUE\]\u@\h"
    PS1_END="\[$BOLD\]\[$COLOR_LIGHT_CYAN\]$ \[$COLOR_RESET\]"

    PS1="${PS1_GIT} ${PS1_DIR} ${PS1_ENV}\

${PS1_USR} ${PS1_END}"
  }
#### ##########################################################################

## Project CDs ################################################################
alias go_dotfiles='cd ~/dotfiles/ && update_prompt && trw dotfiles'
alias go_sandbox='cd ~/sandbox/ && update_prompt && trw sandbox'
alias go_tetris='cd ~/repos/tetris/ && update_prompt && trw tetris'
###############################################################################

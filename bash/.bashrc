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

## PATH Functions #############################################################
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

export MANPAGER="nvim +Man!"

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
  path_radd "/home/carlos/.local/bin"
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

# ASDF {{{
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
# }}}

#######################################################################
# Interactive Bash session settings
#######################################################################

# Import from other Bash Files --- {{{

include () {
  [[ -f "$1" ]] && source "$1"
}

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# }}}
# Executed Commands --- {{{

# turn off ctrl-s and ctrl-q from freezing / unfreezing terminal
# stty -ixon

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
    function open_v() {
      if [ -z $1 ]; then
        nvim .
      else
        nvim $1
      fi
    }
    alias v='open_v'
    alias vi='open_v'
    alias vim='open_v'

    alias vv='nvim ~/dotfiles/vim/.config/nvim/init.vim'
    alias n='nvim ~/dotfiles/vim/.config/nvim/init.vim'
    alias b='nvim ~/dotfiles/bash/.bashrc'
    alias t='nvim ~/dotfiles/tmux/.tmux.conf'
  ################################

  ## List aliases ################
    alias ll='ls -AlF'
    alias l='ls -CF'
    alias la='ls -A'
    alias lf='ls -AlF | grep -i '
  ################################

  ## Python Virtual Environments #
    alias pycache-clean='find . -name "*.pyc" -delete'
  ## #############################

  ## AWS CLI stuff ###############
    alias awsl='aws sso login --no-browser'
    alias awslo='aws sso logout'
  ## #############################

  ## Git #########################
    alias g='git'
    alias ga='git add'
    alias gb='git branch'
    alias gbd='git branch -D'
    alias gco='git commit'
    alias gch='git checkout'
    alias gda='git diff'
    alias gds='git diff --staged'
    alias gdw='git diff --word-diff=color'
    alias gdsw='git diff --staged --word-diff=color'
    alias gg='git grep --color=auto'
    alias ggi='git grep --ignore-case --color=auto'
    alias gh='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
    alias gs='git status .'
    alias gsa='git status'
    alias gsu='git status -u'
    alias push='git push'
    alias pull='git pull'

    # cd to the current git root
    function gr() {
      if [ $(git rev-parse --is-inside-work-tree 2>/dev/null ) ]; then
        cd $(git rev-parse --show-toplevel)
      else
        echo "'$PWD' is not inside a git repository"
        return 1
      fi
    }

    # Simple git diff
    function gd() {
      if [ -z $1 ]; then
        git diff .
      else
        git diff $*
      fi
    }

    # Create git branch
    function gcb() {
      git checkout -b $1
      update_prompt
    }

    # Git checkout
    function gc() {
      git checkout $*
      update_prompt
    }

    # Print current git branch
    function gitp() {
      if [[ -d .git || $(git rev-parse --git-dir 2> /dev/null) ]]; then
        echo "[$(git branch | grep \* | sed -r 's/\* //g')]"
      else
        echo ''
      fi
    }
    function gitb() {
      if [[ -d .git || $(git rev-parse --git-dir 2> /dev/null) ]]; then
        echo "$(git branch | grep \* | sed -r 's/\* //g')" | pbcopy
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
    alias mbt='make build-test'
    alias mbr='make build-release'

    ## $ drmi kip python
    ## will remove any docker images that contain kip, amazonaws, and python
  ## #############################


  ## Python ######################
    alias lintK='poetry run pylint main.py config.py pkg/'
    alias mypyK='poetry run mypy main.py config.py pkg/'
    alias pytestK='poetry run pytest test/unit/ && poetry run pytest test/integration/'
    alias pytestKnw='poetry run pytest --disable-warnings test/unit && poetry run pytest --disable-warnings test/integration'

    alias pipu='pip install -U'
    alias pipun='pip uninstall'
    alias pipup='pip install -U pip'
    alias pipir='pip install -r requirements.txt'

    alias pipf='pip freeze'
    alias pipfr='pip freeze >> requirements.txt'

    alias poi='poetry init'
    alias porun='poetry run'

    alias poa='poetry add'
    alias poad='poetry add --group dev'

    alias por='poetry remove'

    alias pyt='bash test.sh'
    alias pym='python main.py'
    alias pyprep='enva && export GITBRANCH=integration && export ENV=integration'
  ## #############################

  ## #############################
    ## Directory #################
    function c() {
      cd "$@"

      if [[ ! -n "$VIRTUAL_ENV" ]]; then
        if [ -d .env ]; then
          source .env/bin/activate && export GITBRANCH=integration && export ENV=integration
        else
          if [ -f .env ]; then
            source $(cat .env)/bin/activate && export GITBRANCH=integration && export ENV=integration
          fi
        fi
      fi

      update_prompt
    }
    function d() {
      cd "$@"
      update_prompt
    }
    alias kip='cd ~/Documents/repos/'
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
    alias celar='clear'
    alias cl='clear && update_prompt'
    alias cls='clear && update_prompt && git status'
    alias cld='clear && update_prompt && git diff'
    alias clx='clear && pyprep && tox'
    alias clp='clear && pyprep && python main.py'
    # alias fn='find . -name'
    alias dfn='grep -nri'

    alias trw='tmux rename-window'
    alias saud='sudo apt update'
    alias saup='sudo apt upgrade -y'
    alias ':q'='exit'

    # Set copy/paste helper functions
    # the perl step removes the final newline from the output
    alias pbcopy="perl -pe 'chomp if eof' | xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
    ## End Other
  ## ##########################################################################

## ############################################################################


#### Functions ################################################################
  function fn() {
    find . -name *$1*
  }
  ## Python functions ##########################################
    function env_install_dev() {
      ## Install frequently used python pip dependencies
      pip install -U \
        pip \
        mypy \
        pylint \
        pynvim \
        bpython \
        neovim-remote \
      && asdf reshim python
    }

    function env_install_global() {
      pip install -U \
        pip \
        black \
        isort \
        pynvim \
        bpython \
        toml-sort \
        cookiecutter \
        neovim-remote \
        docker-compose \
        pipex \
        && asdf reshim python
    }

    function enva() {
      if [ -z $1 ]; then
        if [ -d .env ]; then
          source .env/bin/activate
        else
          source $(cat .env)/bin/activate
        fi
      else
        source $1/bin/activate
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
      enva
      env_install_dev
    }

    function envp() {
      if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "${VIRTUAL_ENV##*/}_$(print_python_version)"
      else
        echo "$(print_python_version)"
      fi
    }

    function envr() {
      # Deactivate any virtual env being used (just in case)
      if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
      fi

      if [ -z $1 ]; then
        # If no virtual env name received
        if [ -d .env ]; then
          # If '.env' is a directory remove '.env' virtual env
          echo "removing default virtual env '.env'"
          rm -rf .env
        else
          # Revome virtual env written in '.env' file
          echo "removing found virtual env '$(cat .env)'"
          rm -rf $(cat .env)
          rm .env
        fi
      else
        # If virtual env name received
        echo "removing received virtual env '$1'"
        rm -rf $1
      fi
    }

    function envd() {
      if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
        update_prompt
      fi
    }

    function print_python_version() {
      py=$(python --version 2>/dev/null)
      if [[ -z $py ]]; then
        py=$(python --version 2>&1)
      fi
      echo $(echo "$py" | sed -r 's/Python //g')
    }

    function pyenv_update() {
      if [ -d $(pyenv root) ]; then
        echo "Updating pyenv"
        cur_dir=$(pwd)
        cd $(pyenv root)
        git pull
        cd $cur_dir
        source ~/.bashrc
      else
        echo "pyenv is not installed"
      fi
    }
  ######################################

  ## RUST ##############################
    function rustcp() {
      if [ -z $1 ]; then
        if [ -z $2 ]; then
          cargo new --vcs=$2 --verbose --color=always $1
        else
          cargo new --vcs=none --verbose --color=always $1
        fi
      else
        echo "Please specify a name for the project"
      fi
    }

    function rustrp() {
      if [ -z $1 ]; then
        cargo run --verbose --color=always $1
      else
        cargo run --verbose --color=always .
      fi
    }

    function rustrcs() {
      if [ $(command -v runner) ]; then
        runner $1
      else
        echo "ERROR: There is no runner installed, please run 'cargo install runner'"
      fi
    }
  ######################################

  ## DOCKER ##########################{{
    function drmi() {
      for img in "$@"
      do
        docker image rm \
          $(docker images --format "{{.Repository}}:{{.Tag}}" | grep $img)
      done
    }

    function update_compose() {
      # Get only the number part from --version, then remove the extra comma
      current_version=$(\
        docker-compose --version |\
        cut -d ' ' -f3 |\
        sed -r 's/,//g'\
      )
      # Get the latest version from the tag link, then get only the number part
      newest_version=$(\
        curl --silent https://github.com/docker/compose/releases/latest |\
        cut -d '"' -f2 | cut -d '/' -f8\
      )
      if [ "$current_version" == "$newest_version" ]; then
        echo "Current compose version is the lastest."
      else
        echo "Updating compose to $newest_version."
        link="https://github.com/docker/compose/releases/download/$newest_version/docker-compose-$(uname -s)-$(uname -m)"
        dest=/usr/local/bin/docker-compose
        sudo curl -L  ${link} -o $dest
        sudo chmod +x $dest
      fi
    }
  ####################################}}

  ## TDS ###############################
    function clubhouse() {
      # Clubhouse story template
      echo -e "## Objective\n## Value\n## Acceptance Criteria" | pbcopy
    }
    function standup() {
      zoomy 9279165538
    }
    function print_vpn_status() {
      if [[ $(command -v nmcli) ]]; then
        net_status=$(nmcli)
        if [[ $net_status == *"Auto AWS VPN connection"* ]]; then
          echo "ON"
        else
          echo "OFF"
        fi
      else
        echo "OFF"
      fi
    }
  ######################################

  ## MISC ##############################
    # Reload bashrc
    function so() {
      envd
      pushd . >/dev/null
      source ~/.bashrc
      popd >/dev/null
      update_prompt
    }

    # Open current directory in file browser
    function explore() {
      if [[ $(command -v xdg-open) ]]; then
        echo 'using xdg-open'
        xdg-open .
      elif [[ $(command -v nemo) ]]; then
        echo 'using nemo'
        nemo .
      else
        echo "couldn't open current directory"
      fi
    }

    # Clear => list all (if input grep search for it)
    function cll() {
      update_prompt
      if [ -z $1 ]; then
        clear
        ll
      else
        clear
        ll | grep $1
      fi
    }

    function despace() {
      # if [ -z $1 ]; then
      #   echo "Must provide a file as the first and only argument."
      # else
      #   mv "$1" $(printf "$1" | tr -s ' ' '_')
      # fi

      # # Ricardo's implementation
      # local in="$@"
      # if [ -z "$in" ]; then
      #   while read -r in; do
      #     mv "$in" $(printf "$in" | tr -s ' ' '_')
      #   done
      # else
      #   for filename in "$in"; do
      #     mv "$filename" $(printf "$filename" | tr -s ' ' '_')
      #   done
      # fi

      # Sam's implementation
      if [ $# -eq 0 ]; then
        while read -r in; do
          mv "$in" $(printf "$in" | tr -s ' ' '_')
        done
      else
        for filename in "$@"; do
          mv "$filename" $(printf "$filename" | tr -s ' ' '_')
        done
      fi
    }

    function update_zoom() {
      curl -Lsf https://zoom.us/client/latest/zoom_amd64.deb -o /tmp/zoom_amd64.deb
      sudo dpkg -i /tmp/zoom_amd64.deb
    }

    function pkg_updates() {
      if [[ $(command -v apt) ]]; then
        echo "Using apt update then upgrade -y"
        sudo apt update && sudo apt upgrade -y && sudo apt autoremove
      fi

      if [[ $(command -v pacman) ]]; then
        if [[ $(command -v pamac) ]]; then
          echo "Usinch pacmand and pamac"
          sudo pacman -Syyu && \
            sudo pamac checkupdates && \
            sudo pamac update && \
            sudo pamac upgrade
        else
          echo "Using arch pacman and yay"
          sudo pacman -Syyu && yay -Syu
        fi
      fi
    }

    function upgrade() {
      sudo apt update
      sudo apt upgrade -y
      sudo apt autoremove -y
      asdf update
      asdf plugin-update --all
      pushd .
      cd ~/dotfiles
      git pull
      popd
      asdf uninstall neovim nightly
      asdf install neovim nightly
      asdf global neovim nightly
    }

    # Running dfu-util requires sudo permissions
    function flash_ck() {
      if [[ $(command -v dfu-util) ]]; then
        if [ -z $1 ]; then
          echo "No firware path was passed in"
        else
          echo "Flashing firmware located at '$1'"
          sudo dfu-util -d 1eaf:0003 -a 2 -D $1
        fi
      else
        echo 'dfu-util is not installed, please install it before trying again'
      fi
    }

    # Pipe man stuff to neovim
    function m() {
      man --location "$@" &> /dev/null
      if [ $? -eq 0 ]; then
        man --pager=cat "$@" | nvim -c 'set ft=man' -
      else
        man "$@"
      fi
    }

    # Fix apt signatures
    function fix_apt_pubkey() {
      if [ -z $1 ]; then
        echo "No PUBKEY was passed in!!!"
      else
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $1
      fi
    }
  ######################################

  function zoomy() {
    if [ -z $1 ]; then
      echo "Conference room number needed! 'zoomy 1234567890'"
    else
      xdg-open "zoommtg://zoom.us/join?action=join&confno=$1"
    fi
  }

  function nodenv_update() {
    if [ -d $(nodenv root) ]; then
      echo "Updating nodenv and node-build plugin"
      cur_dir=$(pwd)
      cd $(nodenv root)/plugins/node-build
      git pull origin master
      cd $(nodenv root)
      git pull origin master
      cd $cur_dir
      source ~/.bashrc
    else
      echo "nodenv is not installed"
    fi
  }
#### ##########################################################################

#### ##########################################################################
  ## Command line prompt (PS1) ################################################
  COLOR_CYAN="\033[0;36m"
  COLOR_LIGHT_CYAN="\033[1;36m"
  COLOR_RED="\033[1;31m"
  COLOR_YELLOW="\033[0;33m"
  COLOR_GREEN="\033[0;32m"
  COLOR_PURPLE="\033[1;35m"
  COLOR_BLUE="\033[1;34m"
  COLOR_WHITE="\033[0;37m"
  COLOR_RESET="\033[0m"

  # 256 colors: https://jonasjacek.github.io/colors/
  # MAIN COLOURS
  CYAN2_COLOUR="\033[38;5;50m"
  DEEP_PINK1_COLOUR="\033[38;5;198m"

  # COMPLIMENTARY COLOURS
  FRONT_GREY_COLOUR="\033[38;5;250m"
  BACK_GREY_COLOUR="\033[38;5;237m"

  GIT_COLOUR="\033[38;5;226m"
  PY_COLOUR="\033[38;5;118m" #Chartreuse1

  # BOLD="$(tput bold)"

  # Set Bash PS1
  PS1_GIT="\[$GIT_COLOUR\]$(gitp)\[$COLOR_RESET\]"
  PS1_DIR="\[$FRONT_GREY_COLOUR\]\w\[$COLOR_RESET\]"
  PS1_ENV="\[$PY_COLOUR\]$(envp)\[$COLOR_RESET\]"

  if [[ $(print_vpn_status) == 'ON' ]]; then
    LOCATION='AWS_VPN'
  else
    LOCATION="\h"
  fi

  if [ $(whoami) != 'root' ]; then
    PS1_USR="\[$CYAN2_COLOUR\]\u@$LOCATION \[$BOLD\]$ \[$COLOR_RESET\]"
  else
    PS1_USR="\[$DEEP_PINK1_COLOUR\]\u@$LOCATION \[$BOLD\]$ \[$COLOR_RESET\]"
  fi

  PS1="${PS1_GIT} ${PS1_DIR} ${PS1_ENV}\

${PS1_USR}"

  function update_prompt() {
    PS1_GIT="\[$GIT_COLOUR\]$(gitp)\[$COLOR_RESET\]"
    PS1_DIR="\[$FRONT_GREY_COLOUR\]\w\[$COLOR_RESET\]"
    PS1_ENV="\[$PY_COLOUR\]$(envp)\[$COLOR_RESET\]"

    if [[ $(print_vpn_status) == 'ON' ]]; then
      LOCATION='AWS_VPN'
    else
      LOCATION="\h"
    fi

    if [ $(whoami) != 'root' ]; then
      PS1_USR="\[$CYAN2_COLOUR\]\u@$LOCATION \[$BOLD\]$ \[$COLOR_RESET\]"
    else
      PS1_USR="\[$DEEP_PINK1_COLOUR\]\u@$LOCATION \[$BOLD\]$ \[$COLOR_RESET\]"
    fi

    PS1="${PS1_GIT} ${PS1_DIR} ${PS1_ENV}\

${PS1_USR}"
  }
#### ##########################################################################

## Project CDs ################################################################
  function goto() {
    case $1 in
      'dotfiles')
        c ~/dotfiles
        trw dotfiles
        ;;
      'bash')
        c ~/dotfiles/bash
        trw bash_conf
        ;;
      'tmux')
        c ~/dotfiles/tmux
        trw tmux_conf
        ;;
      'vim')
        c ~/dotfiles/vim
        trw vim_conf
        ;;
      'sandbox')
        c ~/sandbox
        trw sandbox
        ;;
      'tetris')
        c ~/repos/tetris
        trw tetris
        ;;
      *)
        echo 'bad got'
      esac
  }
  alias go_dotfiles='cd ~/dotfiles/ && update_prompt && trw dotfiles'
  alias go_sandbox='cd ~/sandbox/ && update_prompt && trw sandbox'
  alias go_tetris='cd ~/repos/tetris/ && update_prompt && trw tetris'
###############################################################################

## Monitor stuff ##############################################################
  function hz() {
    case $1 in
      240)
        echo "240"
        xrandr --output DisplayPort-0 --mode 1920x1080 --rate 239.96
        ;;
      144)
        xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144.00
        ;;
      120)
        xrandr --output DisployPort-0 --mode 1920x1080 --rate 119.98
        ;;
      100)
        xrandr --output DisplayPort-0 --mode 1920x1080 --rate 99.93
        ;;
      *)
        xrandr --output DisplayPort-0 --mode 1920x1080 --rate 60.00
    esac
  }
###############################################################################

## SSH stuff ##################################################################
  get_ppk() {  # $1 input pem file name - $2 output ppk file name
    sudo puttygen $1 -o $2 -O private
  }

  get_pem() {  # $1 input ppk file name - $2 output pem file name
    sudo puttygen $1 -O private-openssh -o $2
  }
###############################################################################

include ~/.bash/sensitive

include ~/.xrandrc

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# add note

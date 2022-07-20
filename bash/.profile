#!/bin/bash

# Default .profile
# Original Author: Samuel Roeca
#
# WARNING: if you insert a bug into this file, you may have trouble logging in
# to your OS
#
# Use this file to:
#   Configure your terminal colors
#   Add environment variables
#   Append directories to your path and configure pyenv, nodeenv, etc
#   Note: do NOT place sensitive information (like passwords) in this file
# if using vim:
#   za: toggle one fold
#   zi: toggle all folds

# Source the bashrc by default
if [ -n "$BASH_VERSION" ] && [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


export PATH="$HOME/.poetry/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

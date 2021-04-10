#!/bin/bash

# Stop if something terrible happens
set -e

cur_dir=$(pwd)

echo "\n\n\n===== Make sure system is up-to-date. ====="
sudo apt update
sudo apt upgrade -y

echo "\n\n\n===== Adding PPAs for some packages. ====="
sudo add-apt-repository --yes ppa:ubuntuhandbook1/audacity
sudo add-apt-repository --yes ppa:inkscape.dev/stable
sudo add-apt-repository --yes ppa:kicad/kicad-5.1-releases


echo "\n\n\n===== Installing Ubuntu system packages. ====="
sudo apt install -y \
  autoconf \
  automake \
  build-essential \
  curl \
  exuberant-ctags \
  fortune \
  git \
  htop \
  jq \
  libbz2-dev \
  libffi-dev \
  liblzma-dev \
  libncurses-dev \
  libncurses5 \
  libncurses5-dev \
  libncursesw5 \
  libncursesw5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  libtool \
  libxslt-dev \
  libyaml-dev \
  llvm \
  make \
  manpages-dev \
  manpages-posix-dev \
  python-openssl \
  python-pygments \
  python3 \
  python3-dev \
  python3-pip \
  python3-virtualenv \
  tk-dev \
  tmux \
  tree \
  unixodbc-dev \
  unzip curl \
  wget \
  xclip \
  xsel \
  xz-utils \
  zlib1g-dev \
  stow \
  gimp \
  vlc \
  filezilla \
  audacity \
  inkscape

echo "\n\n\n===== Install full Kicad. ====="
sudo apt install --install-recommends kicad

echo "\n\n\n===== Installing flatpak packages. ====="
flatpak install -y telegram, spotify, slack, bitwarden, com.obsproject.Studio

echo "\n\n\n===== Make dirs for rc files. ====="
mkdir -p ~/.bash/
mkdir -p ~/.config/nvim
mkdir -p ~/bin

echo "\n\n\n===== Make other common dirs. ====="
mkdir -p ~/sandbox
mkdir -p ~/Documents/repos

echo "\n\n\n===== Clone and make personal dotfiles. ====="
git clone https://github.com/cgironalas/dotfiles.git ~/dotfiles && \
    cd ~/dotfiles && \
    make dotfiles
    cd $cur_dir

echo "\n\n\n===== Cloning / downloading 3rd party stuff. ====="
if [ -d "$HOME/.asdf" ]; the
  echo "\n\n\n===== ~/.asdf already exists, not creating. ====="
else
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  cd $cur_dir
fi

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


echo "\n\n\n===== Doing post install stuff. ====="

nvim -E -s -u "~/.vimrc" +PlugInstall +qall

echo "\n\n\n===== Install commonly used python versions. ====="
source ~/.asdf/asdf.sh && \
    asdf plugin-add python && \
    asdf install python 2.7.15 && \
    asdf install python 3.7.4 && \
    asdf install python 3.8.9 && \
    asdf global python 3.8.9 && \
    pip install -U \
        pip \
        pynvim \
        jedi-language-server \
        black \
        isort \
        neovim-remote \
        pylint \
        toml-sort && \
    asdf reshim python

echo "\n\n\n===== Install nodejs and yarn. ====="
source ~/.asdf/asdf.sh && \
    asdf plugin-add nodejs && \
    asdf plugin-add yarn && \
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring && \
    asdf install nodejs 12.9.1 && \
    asdf install yarn 1.17.3 && \
    asdf global nodejs 12.9.1 && \
    asdf global yarn 1.17.3

echo "\n\n\n===== Recommended to install the following software through their .debs: ====="
echo "Discord: https://discord.com/download"
echo "Steam: https://store.steampowered.com/about/"
echo "VIA: https://github.com/the-via/releases/releases/tag/v1.3.1"
echo "Zoom: https://zoom.us/support/download"

cd $cur_dir

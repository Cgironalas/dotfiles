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
sudo add-apt-repository --yes ppa:kicad/kicad-6.0-releases

echo "\n\n\n===== Add Spotify dependencies. ====="
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list


echo "\n\n\n===== Installing Ubuntu system packages. ====="
sudo apt install -y \
  autoconf \
  automake \
  build-essential \
  curl \
  exuberant-ctags \
  flatpak \
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
  inkscape \
  cmake \
  pkg-config \
  libfreetype6-dev \
  libfontconfig1-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev \
  spotify-client

echo "\n\n\n===== Make dirs for rc files. ====="
mkdir -p ~/.bash/
mkdir -p ~/.config/nvim
mkdir -p ~/bin

echo "\n\n\n===== Make other common dirs. ====="
mkdir -p ~/Documents/sandbox
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


git clone https://github.com/kristijanhusak/vim-packager ~/.config/nvim/pack/packager/opt/vim-packager

echo "\n\n\n===== Doing post install stuff. ====="

nvim -E -s -u "~/.vimrc" +PackInstall +qall

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

echo "\n\n\n===== Install commonly used tools in the latest version. ====="
source ~/.asdf/asdf.sh && \
    asdf plugin-add neovim && \
    asdf install neovim latest && \
    asdf global neovim latest && \
    asdf plugin-add tmux && \
    asdf install tmux latest && \
    asdf global tmux latest && \
    asdf plugin-add rust && \
    asdf install rust latest && \
    asdf global rust latest && \
    asdf plugin-add awscli && \
    asdf install awscli latest && \
    asdf global awscli latest && \
    asdf plugin-add terraform-ls && \
    asdf install terraform-ls latest && \
    asdf global terraform-ls latest

echo "\n\n\n===== Cloning / building alacritty. ====="
git clone https://github.com/alacritty/alacritty.git ~/alacritty
cd ~/alacritty

# Install
cargo build --release

cp ~/alacritty/target/release/alacritty ~/bin/
sudo cp ~/alacritty/extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install ~/alacritty/extra/linux/Alacritty.desktop
sudo update-desktop-database

# terminfo
tic -xe alacritty,alacritty-direct ~/alacritty/extra/alacritty.info

# man page
sudo mkdir -p /usr/local/share/man/man1
gzip -c ~/alacritty/extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

echo "\n\n\n===== Install nodejs and yarn. ====="
source ~/.asdf/asdf.sh && \
    asdf plugin-add nodejs && \
    asdf plugin-add yarn && \
    asdf install nodejs 12.12.0 && \
    asdf install yarn 1.17.3 && \
    asdf global nodejs 12.12.0 && \
    asdf global yarn 1.17.3

echo "\n\n\n===== Install full Kicad. ====="
sudo apt install --install-recommends kicad

echo "\n\n\n===== Installing flatpak packages. ====="
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.telegram.desktop
flatpak install -y flathub com.bitwarden.desktop
flatpak install -y flathub com.obsproject.Studio

echo "\n\n\n===== Recommended to install the following software through their .debs: ====="
echo "VIA: https://github.com/the-via/releases/releases/"
echo "Zoom: https://zoom.us/support/download"
echo "Slack: https://slack.com/downloads/linux"
echo "Discord: https://discord.com/download"
echo "Steam: https://store.steampowered.com/about/"

cd $cur_dir

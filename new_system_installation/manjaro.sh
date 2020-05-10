#/bin/bash

cur_dir=$(pwd)
# Install programs from pacman
echo "\n\n\nInstalling software with pacman"
sudo pacman -Syu \
    ttf-liberation \
    lutris \
    alacritty \
    tmux \
    neovim \
    git \
    stow \
    npm \
    docker \
    docker-compose \
    putty \
    mysql-workbench \
    snapd \
    xsel \
    xclip

echo "\n\n\nInstalling software with pamac"
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"
sudo sed --in-place "s/#CheckAURUpdates/CheckAURUpdates/" "/etc/pamac.conf"
pamac install \
    discord \
    slack-desktop \
    spotify \
    steam \
    telegram-desktop \
    zoom \
    filezilla

echo "\n\n\nFinishing docker installation"
    systemctl start docker
    systemctl enable docker
    sudo usermod -aG docker $USER
echo "Please reboot to be able to use docker"

echo "\n\n\nFinishing snap installation"
    sudo systemctl enable —now snapd.socket && \
    echo "installing bitwarden" && \
    snap install bitwarden 

echo "\n\n\nInstalling vimplug"
cd ~ && \ 
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cur_dir=$(pwd)
#manjaro

echo "\n\n\nMaking common directories"
mkdir ~/.ssh
mkdir ~/.bash
mkdir ~/repos
mkdir ~/sandbox

echo "\n\n\nClone latest ASDF"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf && \
    cd ~/.asdf && /
    git checkout "$(git describe --abbrev=0 --tags)"

echo "\n\n\nClone and make personal dotfiles"
git clone https://github.com/cgironalas/dotfiles.git ~/dotfiles && \
    cd ~/dotfiles && \
    make dotfiles

nvim -E -s -u "~/.vimrc" +PlugInstall +qall

echo "\n\n\nInstall commonly used python versions"
source ~/.asdf/asdf.sh && \
    asdf plugin-add python && \
    asdf install python 2.7.15 && \
    asdf install python 3.7.4 && \
    asdf install python 3.8.2 && \
    asdf global python 3.8.2 && \
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

echo "\n\n\nInstall nodejs and yarn"
source ~/.asdf/asdf.sh && \
    asdf plugin-add nodejs && \
    asdf plugin-add yarn && \
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring && \
    asdf install nodejs 12.9.1 && \
    asdf install yarn 1.17.3 && \
    asdf global nodejs 12.9.1 && \
    asdf global yarn 1.17.3

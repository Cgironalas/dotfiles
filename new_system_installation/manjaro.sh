#/bin/bash

cur_dir=$(pwd)
# Install programs from pacman
echo "Installing software from pacman"
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

if [ -x "$(command -v yay)" ]
  echo "yay not installed, it will be downloaded and installed"
  git clone https://our.archlinux.org/yay.git ~/.yay
  cd ~/.yay
  makepkg -si
  cd $cur_dir
fi

echo "Installing software from yay"
yay -Syu \
  discord \
  slack-desktop-dark \
  spotify \
  steam \
  telegram-desktop \
  zoom

echo "Finishing docker installation"
  systemctl start docker
  systemctl enable docker
  sudo usermod -ag docker $USER
echo "Please reboot to be able to use docker"

echo "Finishing snap installation"
  sudo systemctl enable —now snapd.socket && \
    echo "installing bitwarden" && \
    snap install bitwarden 

echo "Installing vimplug"
cd ~ && \ 
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cur_dir=$(pwd)
#manjaro

#xfce
/usr/bin/setxkbmap -option "ctrl:nocaps"

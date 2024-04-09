#!/bin/bash

# Create User Env
echo USER: $USER
export USER_HOME=/home/${USER}

wget install-node.vercel.app/lts && sudo bash lts --yes && rm lts

# download nvim source code and install pre-requistes
cd /app
wget https://github.com/neovim/neovim/archive/refs/tags/stable.tar.gz
tar xzvf stable.tar.gz
rm stable.tar.gz

cd neovim-stable
sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential
# make CMAKE_BUILD_TYPE=Release
sudo make CMAKE_INSTALL_PREFIX=/usr/local install
sudo rm -rf neovim-stable

echo "Downloading Plug..."
mkdir -p ${USER_HOME}/.config
cp -r ${IMAGE_RESOURCES}/nvim ${USER_HOME}/.config/nvim
bash -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +"PlugInstall --sync" +qa
nvim +"CocInstall -sync coc-cmake" +qall
nvim +"CocInstall -sync coc-clangd" +qall
nvim +"CocCommand -sync clangd.install" +qall test.cpp


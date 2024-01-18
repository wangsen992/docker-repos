#!/bin/bash

# Create User Env
echo USER: $USER
export USER_HOME=/home/${USER}

sudo apt-get install -y tmux
cp ${IMAGE_RESOURCES}/tmux.conf ${USER_HOME}/.tmux.conf
# Will need to update the raw link when build
# Install nvim for development
sudo apt install -y neovim

wget install-node.vercel.app/lts && sudo bash lts --yes && rm lts

echo "Downloading Plug..."
mkdir -p ${USER_HOME}/.config
cp -r ${IMAGE_RESOURCES}/nvim ${USER_HOME}/.config/nvim
bash -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +"PlugInstall --sync" +qa
nvim +"CocInstall -sync coc-cmake" +qall
nvim +"CocInstall -sync coc-clangd" +qall
nvim +"CocCommand -sync clangd.install" +qall test.cpp

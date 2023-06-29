FROM ubuntu:22.04

# Run everything as root as this point
RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y build-essential libfabric-dev libibverbs-dev gfortran wget \
        && apt-get install -y python3 python3-distutils python3-pip gcc

RUN apt-get install -y sudo git curl

# add user "foam"
ARG USER=wangsen992
RUN useradd --user-group --create-home --shell /bin/bash $USER ;\
	echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN usermod -a -G root $USER
RUN usermod -a -G sudo $USER

USER $USER
WORKDIR /home/$USER

## Configure for interactive use
# tmux uses ctr-s for lead key
RUN sudo apt-get install -y tmux
COPY tmux.conf .tmux.conf
# Will need to update the raw link when build
# Install nvim for development
RUN sudo apt install -y neovim
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN mkdir -p .config
COPY nvim-2 .config/nvim
RUN wget install-node.vercel.app/lts && sudo bash lts --yes && rm lts
RUN nvim +"PlugInstall --sync" +qa

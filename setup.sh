#!/bin/bash
DIR="$HOME/.cli-dev"
NODE_VER=15

echo "this script is meant to be used on a debian-type os like Ubuntu"
read -n 1 -p  "Press any key to continue"

echo "updating system before installing dependencies"
sudo apt update
sudo apt upgrade -y

# tools
sudo apt install -y zsh neovim tmux net-tools curl htop g++ make

# omzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# nodejs / nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm ls-remote
nvm install $NODE_VER
nvm alias default $NODE_VER
npm i -g yarn
sudo setcap 'cap_net_bind_service=+ep' `which node`

echo "Changing max notify watcher from $(cat /proc/sys/fs/inotify/max_user_watches) to 524288 (max value)"
echo "fs.inotify.max_user_watches=524288" | sudo tee -a  /etc/sysctl.conf

read -p "Email for git config: " git_email
read -p "Full name for git config: " git_name

git config --global --replace-all user.email $git_email
git config --global --replace-all user.name $git_name

git config --global --replace-all credential.helper cache
git config --global --replace-all color.ui auto
git config --global --replace-all alias.b "branch -a"
git config --global --replace-all alias.aaa "add . --all && commit --amend --no-edit"
git config --global --replace-all alias.rbi "rebase upstream/master -i"
git config --global --replace-all alias.ph "push heroku master"
git config --global --replace-all alias.aa "add -A"
git config --global --replace-all alias.d "diff"
git config --global --replace-all alias.s "status"
git config --global --replace-all alias.co "checkout"
git config --global --replace-all alias.cp "cherry-pick"
git config --global --replace-all alias.ci "commit"
git config --global --replace-all alias.rb "rebase -i"
git config --global --replace-all alias.p "pull"
git config --global --replace-all alias.pp "push origin"
git config --global --replace-all alias.fa "fetch --all"
git config --global --replace-all alias.fu "fetch upstream"
git config --global --replace-all alias.rh "reset --hard"
git config --global --replace-all alias.mt "mergetool"
git config --global --replace-all core.editor "nvim"
git config --global --replace-all push.default "tracking"
git config --global --replace-all alias.l "log --oneline --graph"

echo "Setting up '$DIR/profile.sh'"
chmod +x "$DIR/profile.sh"
echo "source $DIR/profile.sh" >> ~/.zprofile
source "$DIR/profile.sh"

ln -sf ~/.cli-dev/plugins.vim ~/.vim/plugins.vim
ln -sf ~/.cli-dev/nvim.vim ~/.config/nvim/init.vim
sudo chsh -s $(which zsh)
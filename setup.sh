#! /bin/bash

#==============
# Install all the packages
#==============
sudo chown -R $(whoami):admin /usr/local
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew doctor
brew update

#==============
# Remove old dot flies
#==============
sudo rm -rf ~/Brewfile > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
sudo rm -rf ~/.zsh_prompt > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
function create_symlink() {
    if [[ -f "$HOME/Github/.dotfiles/$1" ]]; then
        ln -s $HOME/Github/.dotfiles/$1 ~/$1
    fi
}

create_symlink "Brewfile"
create_symlink ".gitconfig"
create_symlink ".tmux.conf"
create_symlink ".vimrc"
create_symlink ".zsh_prompt"
create_symlink ".zshrc"

#==============
# Install brew packages/tools
#==============
brew bundle install --file ~/Brewfile

#==============
# Set zsh as the default shell
#==============
chsh -s /bin/zsh

#==============
# Done
#==============
echo "\n====== Done ======\n"
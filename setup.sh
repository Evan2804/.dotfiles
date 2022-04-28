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
ln -s $HOME/Github/.dotfiles/Brewfile ~/Brewfile
ln -s $HOME/Github/.dotfiles/.gitconfig ~/.gitconfig
ln -s $HOME/Github/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s $HOME/Github/.dotfiles/.vimrc ~/.vimrc
ln -s $HOME/Github/.dotfiles/.zsh_prompt ~/.zsh_prompt
ln -s $HOME/Github/.dotfiles/.zshrc ~/.zshrc

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
#!/bin/sh

echo "Konfiguriere DNF..."
# edit /etc/dnf/dnf.conf file
sudo bash -c 'echo "fastestmirror=true" >> /etc/dnf/dnf.conf && echo "deltarpm=true" >> /etc/dnf/dnf.conf && echo "max_parallel_downloads=6" >> /etc/dnf/dnf.conf'

echo "Systemupdate..."
sudo dnf upgrade # system upgrade

echo "Hinzufügen von zusätzlichen Paketquellen..."
# RPM Fusion free
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
# RPM Fusion nonfree
sudo dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Setting up files..."
git clone https://github.com/Palexer/dotfiles $HOME

mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/zathura
mkdir -p $HOME/.config/zathura
mkdir -p $HOME/.cache/zsh
touch $HOME/.cache/zsh/history

ln -s $HOME/dotfiles/.config/nvim/init.vim $HOME/.config/nvim/init.vim
ln -s $HOME/dotfiles/.config/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.config/zathura/zathurarc $HOME/.config/zathura/zathurarc

echo "Installiere Software..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install spotify anki geogebra discord simplenote

sudo dnf install tlp tlp-rdw gimp gnome-tweaks nodejs npm go geary neovim zsh zsh-syntax-highlighting-0.7.1-4.fc35.noarch zsh-autosuggestions-0.7.0-2.fc35.noarch util-linux-user starship bat exa

systemctl enable tlp.service
systemctl enable tlp-sleep-service
sudo chsh paul -s /usr/bin/zsh

echo "Installiere Nord Theme für gnome-terminal"
wget https://raw.githubusercontent.com/arcticicestudio/nord-gnome-terminal/develop/src/nord.sh
sh nord.sh
rm nord.sh

echo "Installiere Fonts..."
sudo dnf install dejavu-sans-mono-fonts mozilla-fira-fonts-common adobe-source-code-pro-fonts

echo "Fertig.\n ToDo:\n\t-Autoupdates in Gnome Software deaktivieren"

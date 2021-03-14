BASE=$(PWD)
MKDIR = mkdir -p
LN = ln -vsf
LNDIR = ln -vs

tlp:
	sudo pacman -S tlp powertop
	systemctl enable tlp.service
	systemctl enable tlp-sleep-service

lightdm:
	sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
	systemctl enable lightdm.service

base-config:
	sudo pacman -S xorg-xinit xorg-server i3gaps redshift feh xfce4-settings xfce4-power-manager pulseaudio xautolock i3lock picom dunst neovim alacritty tmux thunderbird zsh zsh-autosuggestions
	yay -S polybar brave zsh-syntax-highlighting
	echo "exec i3" > $HOME/.xinitrc
	chsh

networkmanager:
	sudo systemctl enable NetworkManager.service
	sudo systemctl start NetworkManager.service

bluetooth:
	sudo pacman -S bluez bluez-utils blueman pulseaudio-bluetooth pulseaudio-alsa
	sudo rfkill unblock bluetooth
	sudo rfkill unblock wifi

fonts:
	sudo pacman -S ttf-hack ttf-liberation noto-fonts
	yay -S ttf-font-awesome

yay:
	sudo pacman -S git go
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -sri
	cd ..
	rm -rf yay

dotfiles:
	# create directories
	$MKDIR .config/i3
	$MKDIR .config/polybar
	$MKDIR .config/dunst
	$MKDIR .config/nvim/colors
	$MKDIR .config/nvim/autoload

	# link files
	$LN $BASE/.config/i3/config $HOME/.config/i3/config
	$LN $BASE/.config/polybar/config $HOME/.config/polybar/config
	$LN $BASE/.config/polybar/launch.sh $HOME/.config/polybar/launch.sh
	$LN $BASE/.config/nvim/init.vim $HOME/.config/nvim/init.vim
	$LN $BASE/.config/nvim/autoload/onedark.vim $HOME/.config/nvim/autoload/onedark.vim
	$LN $BASE/.config/nvim/colors/onedark.vim $HOME/.config/nvim/colors/onedark.vim
	$LN $BASE/.tmux.conf $HOME/.tmux.conf
	$LN $BASE/.zshrc $HOME/.zshrc

	# make polybar script executable
	chmod +x $HOME/.config/polybar/launch.sh
	

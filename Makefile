.DEFAULT_GOAL := help
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
	paru -S xorg-xinit xorg-server i3gaps redshift feh xfce4-settings xfce4-power-manager pulseaudio xautolock i3lock picom dunst neovim alacritty tmux thunderbird zsh zsh-autosuggestions man tree lf pcmanfm polybar brave zsh-syntax-highlighting
	echo "exec i3" > $HOME/.xinitrc
	chsh

networkmanager:
	sudo pacman -S networkmanager
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

linkdotfiles:
	# create directories
	$MKDIR $HOME/.config/i3
	$MKDIR $HOME/.config/polybar
	$MKDIR $HOME/.config/alacritty
	$MKDIR $HOME/.config/dunst
	$MKDIR $HOME/.config/zathura
	$MKDIR $HOME/.config/rofi
	$MKDIR $HOME/.config/nvim/colors
	$MKDIR $HOME/.config/nvim/autoload

	# link files
	$LN $BASE/.config/i3/config $HOME/.config/i3/config
	$LN $BASE/.config/polybar/config $HOME/.config/polybar/config
	$LN $BASE/.config/polybar/launch.sh $HOME/.config/polybar/launch.sh
	$LN $BASE/.config/nvim/init.vim $HOME/.config/nvim/init.vim
	$LN $BASE/.config/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
	$LN $BASE/.config/nvim/autoload/onedark.vim $HOME/.config/nvim/autoload/onedark.vim
	$LN $BASE/.config/nvim/colors/onedark.vim $HOME/.config/nvim/colors/onedark.vim
	$LN $BASE/.config/picom.conf $HOME/.config/picom.conf
	$LN $BASE/.config/dunst/dunstrc $HOME/.config/dunst/dunstrc
	$LN $BASE/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
	$LN $BASE/.tmux.conf $HOME/.tmux.conf
	$LN $BASE/.zshrc $HOME/.zshrc
	$LN $BASE/.config/zathura/zathurarc $HOME/.config/zathura/zathurarc
	$LN $BASE/.config/rofi/config.rasi $HOME/.config/rofi/config.rasi
	$LN $BASE/.profile $HOME/.profile

	# make polybar script executable
	chmod +x $HOME/.config/polybar/launch.sh
	
backup:
	$(MKDIR) $(PWD)/archlinux
	pacman -Qnq > $(PWD)/archlinux/pacmanlist
	pacman -Qqem > $(PWD)/archlinux/aurlist

installall:
	sudo pacman --needed --noconfirm -S - < $(PWD)/archlinux/pacmanlist
	yay -S --needed - < $(PWD)/archlinux/pacmanlist

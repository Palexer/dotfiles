# zshrc by Palexer

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# starship prompt
eval "$(starship init zsh)"

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# aliases
alias o="xdg-open"
export QT_QPA_PLATFORMTHEME=qt5ct

# listing with exa
alias ls="exa"
alias l="exa"
alias ll="exa -l"
alias lla="exa -al"
alias la="exa -a"

alias vim="nvim"
alias cl="clear"

# set neovim as editor
EDITOR=nvim
VISUAL=nvim

# quick access to zsh, neovim and i3 config
alias zshrc='$EDITOR ~/.zshrc'
alias nvrc="$EDITOR ~/.config/nvim/init.vim"
alias wmc="$EDITOR ~/.config/i3/config"

alias grep='grep --color'

# pamac and pacman
alias ds="dnf search"
alias di="sudo dnf install"
alias dr="sudo dnf remove"
alias dre="sudo dnf reinstall"
alias update="sudo dnf upgrade && flatpak update"

# git
alias gi="git init"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gps="git push"
alias gpl="git pull"
alias gcl="git clone"
alias gst="git status"
alias gd="git diff"

# export Go bin dir
export PATH="$HOME/go/bin:$PATH"

# CHROME_PATH is used by marp for pdf output
export CHROME_PATH=/usr/bin/brave-browser

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

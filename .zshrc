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

grfmom ()
{
	if [ $# == 0 || $# == 1 ]; then
		echo "too less arguments"
	elif [ $# == 2 ]; then
		eqn $1 -Tpdf | groff -mom -Tpdf -k > $2
	else
		refer -p $2 $1 | eqn -Tpdf | groff -mom -Tpdf -k > $3
	fi
}

# aliases
alias o="xdg-open"

# listing with exa
alias ls="exa"
alias l="exa"
alias ll="exa -l"
alias lla="exa -al"
alias la="exa -a"

alias vim="nvim"
alias cl="clear"

EDITOR=nvim
VISUAL=nvim
alias zshrc='$EDITOR ~/.zshrc' # Quick access to the ~/.zshrc file
alias nvrc="$EDITOR ~/.config/nvim/init.vim"

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

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null


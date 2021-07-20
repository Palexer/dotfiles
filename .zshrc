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

# convert MS Word documents to pdf quicker
doc2pdf ()
{
	lowriter --convert-to pdf $1
}

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
alias o="i3-swallow xdg-open"
export QT_QPA_PLATFORMTHEME=qt5ct

# listing with exa
alias ls="exa"
alias l="exa -alh"
alias ll="exa -l"
alias lla="exa -al"
alias la="exa -a"

alias vim="nvim"
alias v="nvim"
alias cl="clear"

# set neovim as editor
export EDITOR=nvim
export VISUAL=nvim

# quick access to zsh, neovim and i3 config
alias zshrc='$EDITOR ~/.zshrc'
alias zshh='bat ~/.cache/zsh/history'
alias nvrc="$EDITOR ~/.config/nvim/init.vim"
alias wmc="$EDITOR ~/.config/i3/config"

alias grep='grep --color'
alias fzf='fzf --bind "CTRL-O:execute(xdg-open {})"'
alias sc="sc-im"
alias tm="tmux"

# git
alias gini="git init"
alias gadd="git add"
alias gbra="git branch"
alias gcmm="git commit"
alias gpsh="git push"
alias gpll="git pull"
alias gcln="git clone"
alias gstat="git status"
alias gdiff="git diff"

# export Go bin dir
export PATH="$HOME/go/bin:$PATH"

# CHROME_PATH is used by marp for pdf output
export CHROME_PATH=/usr/bin/brave-browser

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null


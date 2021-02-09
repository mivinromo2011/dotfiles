export ZSH="/home/mivin/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias ls="exa -lh"
alias la="exa -lah"
alias push="git push"
alias commit="git commit -m"
alias pull="git pull"
alias addu="git add -u"
alias adda="git add ."
alias status="git status"
alias add="git add"
alias cleanup="yay -R `yay -Qqdt`"
alias upd="yay -Syu"

eval "$(ssh-agent)"
ssh-add -q ~/.ssh/github
clear

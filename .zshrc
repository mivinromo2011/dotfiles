export ZSH="/home/mivin/.oh-my-zsh"
ZSH_THEME="agnoster"
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
alias cleanup="paru -R `paru -Qqdt`"
alias upd="paru -Syu"

eval "$(ssh-agent)"
ssh-add -q ~/.ssh/github
clear

if command -v tmux >/dev/null 2>&1 && [ "${DISPLAY}" ]; then
    # if not inside a tmux session, and if no session is started, start a new session
    [ -z "${TMUX}" ] && (tmux attach || tmux) >/dev/null 2>&1
fi
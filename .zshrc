export ZSH="/home/mivin/.oh-my-zsh"
ZSH_THEME="risto"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias ls="exa -lh"
alias la="exa -lah"
alias hclone="git clone https://github.com/"
alias sclone="git clone git@github.com:"
alias push="git push"
alias commit="git commit -m"
alias pull="git pull"
alias addu="git add -u"
alias adda="git add ."
alias status="git status"
alias add="git add"
alias ghidra="/home/mivin/Tools/ghidra_9.2.3_PUBLIC/ghidraRun"
alias sqlmap="python3 /home/mivin/Tools/sqlmap-dev"
alias dirbuster="java -jar /home/mivin/Tools/DirBuster-0.12/DirBuster-0.12.jar"
alias sherlock="python3 /home/mivin/Tools/sherlock/sherlock/sherlock.py"
alias cleanup="paru -R `paru -Qqdt`"
alias upd="paru -Syu"

eval "$(ssh-agent)"
ssh-add -q ~/.ssh/github
clear

if command -v tmux >/dev/null 2>&1 && [ "${DISPLAY}" ]; then
    # if not inside a tmux session, and if no session is started, start a new session
    [ -z "${TMUX}" ] && (tmux attach || tmux) >/dev/null 2>&1
fi
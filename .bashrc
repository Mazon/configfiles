###############################################################################
# Mazons ~/.bashrc
###############################################################################
PROMPT_COMMAND="echo -ne \"\\033]0;\\007\\033k\${PWD##*/}\\033\\\\\""
PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

shopt -s cdspell
shopt -s extglob
shopt -s cmdhist
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -u promptvars
set -o noclobber
set -o vi 

#kill flow control
if tty -s ; then
    stty -ixon
    stty -ixoff
fi

# exports
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagaced
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/opt/java/jre/bin:/home/mazon/.bin:/Users/hardy/bin/:/usr/local/git/bin/:/Users/hardy/bin/go.tip/bin/:/opt/apache-maven-3.5.0/bin
export PATH=$PATH:/Users/hardy/bin/google-cloud-sdk/bin
export GOPATH=/Users/hardy/Documents
export GOROOT=/usr/local/go
export CVS_RSH="ssh"
export EDITOR=vim
export VISUAL=vim
export HISTCONTROL=ignoredups
export HISTFILESIZE=10000
export HISTSIZE=10000

# aliases
alias rm="rm -v"
alias cp="cp -v"
alias grep="grep --color=auto"
alias c="clear"
alias l='ls -lrt'
alias v="vim"
alias vi="vim"
alias wh="when ci --past=0 --future=3"
alias reboot="sudo reboot"
alias poweroff="sudo poweroff"
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias tmux="TERM=screen-256color-bce tmux"

lsg() {
ls -R $1 | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'
}

ls() {
  GLOBIGNORE="Documents:Library:Public:Music:Movies:Downloads:Dropbox \(Omise\):Sites:Pictures:VirtualBox VMs:Desktop"
  if [ "$#" -eq 1 ]
  then
    command ls $1d [!.]*
  else
    command ls -d [!.]*
  fi
}

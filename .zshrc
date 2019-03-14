#!/bin/zsh


# General
autoload -U colors && colors # Let's have some colors first
autoload -U edit-command-line
zle -N edit-command-line
# Environment variables
path=(~/bin:'/usr/local/Cellar/jx/1.3.942/bin/:/usr/local/opt/coreutils/libexec/gnubin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/Users/hardy/bin/' $path)
export GOPATH=/Users/hardy/src

HISTSIZE=10000  # Keep 1000 lines of history within the shell
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
HISTFILE="$HOME/.zsh_history"

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye

export EDITOR=vim
bindkey -v #VIM MODE
PROMPT='%n@%m %1d$ ${vim_mode}$ '

# vim mode config
setopt PROMPT_SUBST
setopt promptsubst # required for git plugin

vim_ins_mode="[INS]"
vim_cmd_mode="[CMD]"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fuzzy File search
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}


# shell options
setopt autocd # assume "cd" when a command is a directory
#setopt histignorealldups # Substitute commands in the prompt
setopt sharehistory # Share the same history between all shells

export TERM="xterm-256color"  # 256 color mode

# ALIAS
alias less="less -R" # make less accept color codes and re-output them
alias kubectl="kubectl "
alias ls="ls --color=auto" 
alias diff="diff -u" # Make unified diff syntax the default
alias sudo="sudo "  # expand sudo aliases

# Completion system
autoload -Uz compinit
compinit

zstyle ":completion:*" auto-description "specify: %d"
zstyle ":completion:*" completer _expand _complete _correct _approximate
zstyle ":completion:*" format "Completing %d"
zstyle ":completion:*" group-name ""
zstyle ":completion:*" menu select=2
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*" list-colors ""
zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ":completion:*" matcher-list "" "m:{a-z}={A-Z}" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=* l:|=*"
zstyle ":completion:*" menu select=long
zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s
zstyle ":completion:*" verbose true
zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#)*=0=01;31"
zstyle ":completion:*:kill:*" command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"


# Keybindings
# history substring
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# history substring emacs
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -M emacs '^o' autosuggest-accept

# Bind ctrl-backspace to delete word.
# NOTE: This may not work properly in some emulators
# bindkey "^?" backward-delete-word

# Bind shift-tab to backwards-menu
# NOTE this won't work on Konsole if the new tab button is shown
bindkey "\e[Z" reverse-menu-complete

# Make ctrl-e edit the current command line
autoload edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line

# Make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
#if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#	function zle-line-init {
#		printf "%s" ${terminfo[smkx]}
#	}
#	function zle-line-finish {
#		printf "%s" ${terminfo[rmkx]}
#	}
#	zle -N zle-line-init
#	zle -N zle-line-finish
#fi

# typing ... expands to ../.., .... to ../../.., etc.
rationalise-dot() {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
bindkey -M isearch . self-insert # history search fix




##
# Functions
#

# Extras
#

# Git plugin
#zstyle ":vcs_info:*" enable gi 
##autoload -Uz vcs_info
#zstyle ":vcs_info:(git*):*" get-revision true
#zstyle ":vcs_info:(git*):*" check-for-changes true

#local _branch="%c%u%m %{$fg[green]%}%b%{$reset_color%}"
#local _repo="%{$fg[green]%}%r %{$fg[yellow]%}%{$reset_color%}"
#local _revision="%{$fg[yellow]%}%.7i%{$reset_color%}"
#local _action="%{$fg[red]%}%a%{$reset_color%}"
#zstyle ":vcs_info:*" stagedstr "%{$fg[yellow]%}✓%{$reset_color%}"
#zstyle ":vcs_info:*" unstagedstr "%{$fg[red]%}✗%{$reset_color%}"
#zstyle ":vcs_info:git*" formats "$_branch:$_revision - $_repo"
#zstyle ":vcs_info:git*" actionformats "$_branch:$_revision:$_action - $_repo"
#zstyle ':vcs_info:git*+set-message:*' hooks git-stash
# Uncomment to enable vcs_info debug mode
# zstyle ':vcs_info:*+*:*' debug true

#function +vi-git-stash() {
#	if [[ -s "${hook_com[base]}/.git/refs/stash" ]]; then
#		hook_com[misc]="%{$fg_bold[grey]%}~%{$reset_color%}"
#	fi
#}


# Syntax highlighting plugin
if [[ -e /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -e /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# User profile
if [[ -e "$XDG_CONFIG_HOME/zsh/profile" ]]; then
	source "$XDG_CONFIG_HOME/zsh/profile"
fi

# Check if $LANG is badly set as it causes issues
if [[ $LANG == "C"  || $LANG == "" ]]; then
	>&2 echo "$fg[red]The \$LANG variable is not set. This can cause a lot of problems.$reset_color"
fi

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi # add autocomplete permanently to your zsh shell

source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hardy/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hardy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hardy/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hardy/google-cloud-sdk/completion.zsh.inc'; fi


# VI MODE KEYBINDINGS (ins mode)
    bindkey -M viins '^a'    beginning-of-line
    bindkey -M viins '^n'    vi-cmd-mode
    bindkey -M viins '^o'    accept-line
    bindkey -M viins '^e'    end-of-line
    bindkey -M viins -s '^b' "←\n" # C-b move to previous directory (in history)
    bindkey -M viins -s '^f' "→\n" # C-f move to next directory (in history)
    bindkey -M viins '^k'    kill-line
    bindkey -M viins '^r'    history-incremental-pattern-search-backward
    bindkey -M viins '^s'    history-incremental-pattern-search-forward
    bindkey -M viins '^o'    history-beginning-search-backward
    bindkey -M viins '^p'    history-beginning-search-backward
    #bindkey -M viins '^n'    history-beginning-search-forward
    bindkey -M viins '^y'    yank
    bindkey -M viins '^w'    backward-kill-word
    #bindkey -M viins '^u'    backward-kill-line
    bindkey -M viins '^h'    backward-delete-char
    bindkey -M viins '^?'    backward-delete-char
    bindkey -M viins '^_'    undo
    bindkey -M viins '^x^l'  history-beginning-search-backward-then-append
    bindkey -M viins '^x^r'  redisplay
    bindkey -M viins '\eOH'  beginning-of-line # Home
    bindkey -M viins '\eOF'  end-of-line       # End
    bindkey -M viins '\e[2~' overwrite-mode    # Insert
    bindkey -M viins '^u' fh


    # VI MODE KEYBINDINGS (cmd mode)
    bindkey -M vicmd 'ca'    change-around
    bindkey -M vicmd 'ci'    change-in
    bindkey -M vicmd 'da'    delete-around
    bindkey -M vicmd 'di'    delete-in
    bindkey -M vicmd 'ga'    what-cursor-position
    bindkey -M vicmd 'gg'    beginning-of-history
    bindkey -M vicmd 'G '    end-of-history
    bindkey -M vicmd '^a'    beginning-of-line
    bindkey -M vicmd '^e'    end-of-line
    bindkey -M vicmd '^k'    kill-line
    bindkey -M vicmd '^r'    history-incremental-pattern-search-backward
    bindkey -M vicmd '^s'    history-incremental-pattern-search-forward
    bindkey -M vicmd '^o'    history-beginning-search-backward
    bindkey -M vicmd '^p'    history-beginning-search-backward
    bindkey -M vicmd '^n'    history-beginning-search-forward
    bindkey -M vicmd '^y'    yank
    bindkey -M vicmd '^w'    backward-kill-word
    bindkey -M vicmd '^u'    backward-kill-line
    bindkey -M vicmd '/'     vi-history-search-forward
    bindkey -M vicmd '?'     vi-history-search-backward
    bindkey -M vicmd '^_'    undo
    bindkey -M vicmd '\ef'   forward-word                      # Alt-f
    bindkey -M vicmd '\eb'   backward-word                     # Alt-b
    bindkey -M vicmd '\ed'   kill-word                         # Alt-d
    bindkey -M vicmd '\e[5~' history-beginning-search-backward # PageUp
    bindkey -M vicmd '\e[6~' history-beginning-search-forward # PageDown

source /Users/hardy/.zsh/fzf/key-bindings.zsh
source /Users/hardy/.zsh/fzf/completion.zsh



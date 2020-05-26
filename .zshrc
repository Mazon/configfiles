#!/bin/zsh

# General
autoload -U colors && colors # Let's have some colors first
autoload -U edit-command-line
zle -N edit-command-line

# ENV
export EDITOR=vim
export TERM="xterm-256color"  # 256 color mode
export GOPATH=/Users/`whoami`/Projects/golang
export PATH='/usr/local/bin:/Users/'`whoami`'/google-cloud-sdk/bin/:~/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/bin:/usr/sbin:/Users/'`whoami`'/bin/:/bin':'/usr/local/MacGPG2/bin/gpgconf':$GOPATH/bin:$PATH
export LC_ALL=en_US.UTF-8
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye

HISTSIZE=10000  # Keep 1000 lines of history within the shell
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
HISTFILE="$HOME/.zsh_history"

bindkey -v #VIM MODE
PROMPT='%n@%m %1d$ ${vim_mode}$ '

## vim mode config
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
source /Users/`whoami`/.zsh/fzf/key-bindings.zsh
source /Users/`whoami`/.zsh/fzf/completion.zsh


setopt autocd # assume "cd" when a command is a directory # shell options
setopt sharehistory # Share the same history between all shells #setopt histignorealldups # Substitute commands in the prompt


# Alias
alias kubectl="kubectl " # kubectl expand
alias ls="ls --color=auto" 
alias diff="diff -u" # Make unified diff syntax the default
alias sudo="sudo "  # expand sudo aliases
alias encrypt="gpg --encrypt --armor""
alias backup="~/bin/backup.sh"

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

# Make ctrl-e edit the current command line
autoload edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line

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


# Functions
#

# Extras
#

# Syntax highlighting plugin
if [[ -e /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -e /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi # add autocomplete permanently to your zsh shell

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/bin/google-cloud-sdk/path.zsh.inc' ]; then . '~/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '~/bin/google-cloud-sdk/completion.zsh.inc'; fi


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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

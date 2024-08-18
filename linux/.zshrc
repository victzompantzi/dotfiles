# Reference: https://gthub.com/dreamsofautonomy/zensh/blob/main/.zshrc
# Install fzf: https://askubuntu.com/questions/1515760/unknown-option-bash-when-opening-the-terminal
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

fpath+=( ~/.zfuncs "${fpath[@]}" )
export fpath

# ! Functions
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# My added plugins VICTZ
plugins=(fzf-zsh-plugin) # I don't know if this really works 240602


# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::ubuntu
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found
# zinit snippet OMZP::tmux

# Load completions
autoload -Uz compinit -u && compinit -u
autoload -Uz f
autoload -Uz fr

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt extended_glob
setopt dot_glob

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -A -l -F --color==always --date=relative --header --hyperlink=never --size=short --date=relative --group-dirs=last -L $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd -A -l -F --color=always --date=relative --header --hyperlink=never --size=short --date=relative --group-dirs=last -L $realpath'

# Aliases
export EDITOR=nvim
export PAGER=bat
alias v="$EDITOR"
alias fe='yy'
# alias v='nvim'
alias c='clear'
alias ll='lsd -A -l -F --color=always --date=relative --header --hyperlink=never --size=short --date=relative --group-dirs=last -L'
alias l='lsd -A -F --color=always --date=relative --header --hyperlink=never --size=short --date=relative --group-dirs=last -L'
# alias -g bat='batcat'
alias rms='trash-put'
# alias clip='xclip -sel c < '
alias clip="xclip -selection clipboard"
alias paste="xclip -o -selection clipboard"
alias des='trans es:en -d'
alias den='trans en:es -d'
alias top='btop'
alias sup='sudo apt update && sudo apt upgrade'
alias sin='sudo apt install'
alias lv='nvim -c "normal '\''0"'
alias lg='lazygit'
alias ..='cd ..'
alias ...='code .'
alias ds='gdu-go'
cx() { cd "$@" && l; }
alias -g W='| nvim -c "setlocal buftype=nofile bufhidden=wipe" -c "nnoremap <buffer> q :q!<CR>" -'
# alias teln="rg --files | fzf --border-label='[ File search ]' --preview 'batcat --style=numbers --color=always --line-range :100 {}' | xargs nvim "
# alias MANPAGER='nvim +Man!'
# fuzzy find file with preview
# alias pf="
# fzf --bind ctrl-y:preview-up,ctrl-e:preview-down \
# --bind ctrl-b:preview-page-up,ctrl-f:preview-page-down \
# --bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down \
# --bind ctrl-k:up,ctrl-j:down \
# --preview='(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null'  
# "
# # open file with fzf
# alias viz="for file in \`pf\`; do cmd=\"vim \$file\" && print -rs -- \$cmd && eval \$cmd; done"


# Shell integrations
# source <(fzf --zsh)
# eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# To hide the error message of the bug described in this link: "https://github.com/romkatv/powerlevel10k/issues/1554"
unset ZSH_AUTOSUGGEST_USE_ASYNC

# Environment Variables -- 240530
export XDG_SESSION_TYPE=wayland
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/mnt/c/Program\ Files/Java/jdk-22/bin"
export FZF_ALT_C_OPTS="--preview 'lsd -A -l -F --color=always --date=relative --header --hyperlink=never --size=short --date=relative --group-dirs=last -L {}'"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
# export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always {}'"
# export FZF_COMPLETION_TRIGGER='**'
# export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_DEFAULT_OPTS="-i -m --height=100%"
# export FZF_DEFAULT_OPTS="-i --height=100%"
export PATH="$PATH:$HOME/bin"
export MISE_NODE_COREPACK=true
# export FZF_CTRL_R_OPTS="--preview 'echo {}'
                        # --preview-window down:3:hidden:wrap 
                        # --bind '?:toggle-preview' 
                        # --bind 'ctrl-y:execute-silent(echo {+} | clip)+abort' 
                        # --color header:italic 
                        # --header 'Press CTRL-Y to copy command and ? to preview it'"
# export BAT_CONFIG_PATH='/mnt/c/users/vhtc8/.config/.batrc'
export RIPGREP_CONFIG_PATH='/mnt/c/users/vhtc8/.config/.ripgreprc'
export PATH=$PATH:/usr/local/go/bin

# FZF Shell Compeltion
eval "$(fzf --zsh)"

# Mise activate
eval "$(~/.local/bin/mise activate zsh)"

# Atuin
. "$HOME/.atuin/bin/env"
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
eval "$(atuin gen-completions --shell zsh)"
bindkey '^r' atuin-search

# bind to the up key, which depends on terminal mode
bindkey ';5A' atuin-up-search
# bindkey '^[OA' atuin-up-search

# fnm
# FNM_PATH="/home/victz/.local/share/fnm"
# if [ -d "$FNM_PATH" ]; then
#   export PATH="/home/victz/.local/share/fnm:$PATH"
#   eval "`fnm env`"
# fi
eval "$(gh copilot alias -- zsh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

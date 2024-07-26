# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
zinit snippet OMZP::command-not-found
# zinit snippet OMZP::tmux
#zinit snippet OMZP::

# Load completions
autoload -Uz compinit && compinit

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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias fs='yazi'
alias v='nvim'
alias c='clear'
alias ll='eza --color=always --color-scale --long --git --icons=always --time=modified --header --time-style=relative --no-user --classify=auto --group-directories-first --sort=name --links --all --hyperlink'
alias bat='batcat'
# alias fzb="fzf --preview 'batcat -n --color=always --wrap=auto {}'"
alias rm='rm -I'
# alias clip='xclip -sel c < '
alias cs="xclip -selection clipboard"
alias ps="xclip -o -selection clipboard"

# alias fzr=""rg --color=always --line-number --no-heading --smart-case "${*:-}" |
#   fzf --ansi \
#       --color "hl:-1:underline,hl+:-1:underline:reverse" \
#       --delimiter : \
#       --preview 'bat --color=always {1} --highlight-line {2}' \
#       --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
#       --bind 'enter:become(nvim {1} +{2})'""

# Shell integrations
#eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# To hide the error message of the bug described in this link: "https://github.com/romkatv/powerlevel10k/issues/1554"
unset ZSH_AUTOSUGGEST_USE_ASYNC

# Environment Variables -- 240530
export XDG_SESSION_TYPE=wayland
eval "$(~/.local/bin/mise activate zsh)"
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/mnt/c/Program\ Files/Java/jdk-22/bin"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_DEFAULT_COMMAND="fdfind --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always {}'"
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_DEFAULT_OPTS="-m"
export PATH="$PATH:$HOME/bin"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
# export BAT_CONFIG_PATH='/mnt/c/users/vhtc8/.config/.batrc'
export PATH=$PATH:/usr/local/go/bin

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

# eval $(thefuck --alias)

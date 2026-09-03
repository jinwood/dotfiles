# Add deno completions to search path
if [[ -d "$HOME/.zsh/completions" ]] && [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi
ZSH_DISABLE_COMPFIX=true
export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="/usr/local/share/npm/bin:/opt/homebrew/bin:$PATH"
  export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"
  export PATH="/usr/local/opt/python/libexec/bin:/usr/local/opt/ruby/bin:$PATH"
fi

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

alias vim=nvim

# git
alias git-reset="git reset --hard"
alias git-local-branch="!git branch -vv | cut -c 3- | awk '$3 !~/\\[/ { print $1 }'"
alias python="python3"
alias vim=nvim

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

export ZSH="$HOME/.oh-my-zsh"

# User-installed completions (including this repository's `repo` command).
fpath=("$HOME/.local/share/zsh/site-functions" $fpath)

ZSH_THEME="robbyrussell"


# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git fzf)
# Add wisely, as too many plugins slow down shell startup.

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$PATH:$HOME/.spicetify"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "$HOME/.deno/env" ] && . "$HOME/.deno/env"

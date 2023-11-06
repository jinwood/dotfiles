ZSH_DISABLE_COMPFIX=true
export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH=/usr/local/share/npm/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"

# Deno
export DENO_INSTALL="/Users/julianinwood/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"

alias vim=nvim

# git
alias git-reset="git reset --hard"
alias git-local-branch="!git branch -vv | cut -c 3- | awk '$3 !~/\\[/ { print $1 }'"
alias python="python3"
alias vim=nvim

# Add homebrew python to the path
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

# lazyload nvm as its slow
lazy_load_nvm() {
  unset -f node nvm
  export NVM_DIR=~/.nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

node() {
  lazy_load_nvm
  node $@
}

nvm() {
  lazy_load_nvm
  node $@
}

export ZSH="/$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"


# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)
plugins=(fzf)
# Add wisely, as too many plugins slow down shell startup.

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$PATH:/Users/julianinwood/.spicetify

# bun completions
[ -s "/Users/julianinwood/.bun/_bun" ] && source "/Users/julianinwood/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

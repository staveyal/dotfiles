# Zsh theme

# Icon functions
# These functions return an icons code
function ending {
  echo -n ">"
}

function folder {
  echo -n "\ue5ff"
}

function branch {
  echo -n ""
}

autoload -Uz vcs_info
# Unstaged and staged changes props
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{yellow}+'
zstyle ':vcs_info:*' unstagedstr '%F{red}*'

zstyle ':vcs_info:*' actionformats \
  '%F{5}%F{5}[%F{2}%b%F{3}|%F{1}%a%c%u%F{5}]%f '

# Formatting
zstyle ':vcs_info:*' formats       \
  $'%F{134}%b%u%c '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
# Hooks for remote status
# zstyle ':vcs_info:git+post-backend:*' hooks git-remote
# Enabling git and Mercurial
zstyle ':vcs_info:*' enable git

theme_precmd () {
  vcs_info
}

setopt prompt_subst
PROMPT='%F{117}%~ %{$reset_color%}${vcs_info_msg_0_}%F{3}$(ending)%{$reset_color%} '

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

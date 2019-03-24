# Zsh theme

# Icon functions
# These functions return an icons code
function ending {
  echo -n "\uf460"
}

function folder {
  echo -n "\ue5ff"
}

function branch {
  echo -n "\ue725"
}

autoload -Uz vcs_info
# Unstaged and staged changes props
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'
zstyle ':vcs_info:*' stagedstr '%F{yellow}+'

zstyle ':vcs_info:*' actionformats \
  '%F{5}%F{5}[%F{2}%b%F{3}|%F{1}%a%c%u%F{5}]%f '

# Formatting
zstyle ':vcs_info:*' formats       \
  $'%F{134}%{\ue725%} %b %u%c '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '$(branch)%b%F{1}:%F{3}%r'
# Hooks for remote status
# zstyle ':vcs_info:git+post-backend:*' hooks git-remote-staged
# Enabling git and Mercurial
zstyle ':vcs_info:*' enable git hg

# Hooks function for remote checking
function +vi-git-remote-staged () {
  # Show "unstaged" when changes are not staged or not committed
  # Show "staged" when last committed is not pushed
  #
  # See original VCS_INFO_get_data_git for implementation details

  # Set "unstaged" when git reports either staged or unstaged changes
  if (( gitstaged || gitunstaged )) ; then
    gitunstaged=1
  fi

  # Set "staged" when current HEAD is not present in the remote branch
  if (( querystaged )) && \
     [[ "$(${vcs_comm[cmd]} rev-parse --is-inside-work-tree 2> /dev/null)" == 'true' ]] ; then
      # Default: off - these are potentially expensive on big repositories
      if ${vcs_comm[cmd]} rev-parse --quiet --verify HEAD &> /dev/null ; then
          gitstaged=1
          if ${vcs_comm[cmd]} status --branch --short | head -n1 | grep -v ahead > /dev/null ; then
            gitstaged=
          fi
      fi
  fi

  hook_com[staged]=$gitstaged
  hook_com[unstaged]=$gitunstaged
}

theme_precmd () {
  vcs_info
}

setopt prompt_subst
PROMPT='%F{117}$(folder) %~ %{$reset_color%}${vcs_info_msg_0_}%F{3}$(ending)%{$reset_color%} '

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

# shortcut function to run yazi.
function yazi() {
  flatpak run --command=yazi io.github.sxyazi.yazi "$@"
}

function ya() {
  # share=network enables networking since the package manager needs to download themes
  flatpak --share=network run --command=ya io.github.sxyazi.yazi "$@"
}

# create function shortcut for eza to replace ls when listing files and directories.
function ls() {
  eza --color=always --long --git --icons=always --all --header --tree -L=2 --no-user --no-permissions --no-time -o "$@"
}

# create alias for batcat replacing cat in terminal session.
alias cat='bat --paging=never'

# add fzf key bindings and fuzzy completion.
eval "$(fzf --bash)"

# add preview to fzf key bindings.
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# add previews to command path searching with fzf using [command] ** <TAB>.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
  export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
  ssh) fzf --preview 'dig {}' "$@" ;;
  *) fzf --preview 'bat -n --color=always --line-range :500 {}' "$@" ;;
  esac
}

# add shortcut alias for thefuck (command autocorrect)
eval "$(thefuck --alias fk)"

# alias to open .bashrc for editing.
alias nbrc='nvim ~/.bashrc'

# alias to apply .bashrc changes in current terminal session.
alias sbrc='source ~/.bashrc'

# alias to gh cli authentication using pass.
alias ghauth='pass github/gh-cli-token | gh auth login --with-token'

# alias for opening lazygit on cwd.
alias lg='lazygit'

# set nvim as default text editor.
export EDITOR="nvim"

# set dotnet root globally.
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet

# create shortcut alias for clear.
alias c='clear'

eval "$(starship init bash)"

# initialize zoxide and set it to run in place of cd.
eval "$(zoxide init --cmd cd bash)"

eval "$(thefuck --alias)"

# opencode
export PATH=/home/sudocode88/.opencode/bin:$PATH

. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"

function rwb() {
  killall waybar && nohup waybar >/dev/null 2>&1 &
}

function off() {
  systemctl poweroff
}

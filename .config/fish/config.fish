set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias y "yazi"
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias t "tmux"
alias g git
alias cw "cd /home/arrase/workspaces/"
alias mys "sudo systemctl start mysqld"
alias mysk "sudo systemctl stop mysqld"
alias htp "sudo systemctl start httpd"
alias htpk "sudo systemctl stop httpd"
alias pv "python -m venv .env"
alias pva "source .env/bin/activate.fish"
alias pga "source pgadmin4/bin/activate.fish"

command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
  status --is-command-substitution; and return

  if test -f .nvmrc; and test -r .nvmrc;
    nvm use
  else
  end
end


#switch (uname)
#  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
#  case Linux
    # Do nothing
#  case '*'
#    source (dirname (status --current-filename))/config-windows.fish
#end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end

#eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/emacs.zsh
load ~/.zsh/environments/basic.zsh

start-emacs-session
rename-first-tab

# Custom functions, aliases and hooks.
in-first-tab && git pull --rebase --autostash &> /dev/null
in-first-tab && git install-hooks &> /dev/null

report-custom-functions

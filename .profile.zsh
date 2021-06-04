# Let's stick to Vim for this one.
load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/emacs.zsh
load ~/.zsh/environments/basic.zsh
load ~/.zsh/environments/docker.zsh

# Custom functions, aliases and hooks.
docker-login
start-emacs-session
rename-first-tab

push() {
  docker push jakubstastny/dev
}

# TODO: open file in a Vim with a template - and pass that into the -m message.
tag() {
    # git tag ubuntu-21.04 -m "Ubuntu 21.04 with Emacs 27.1, NeoVim 0.4.4 and reworked dotfiles"
    # git push --tags
}

in-first-tab && git pull --rebase --autostash &> /dev/null
in-first-tab && git install-hooks &> /dev/null

report-custom-functions

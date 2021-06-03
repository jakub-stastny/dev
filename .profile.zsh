# Let's stick to Vim for this one.
load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/basic.zsh
load ~/.zsh/environments/docker.zsh

# Custom functions, aliases and hooks.
docker-login

push() {
  docker push jakubstastny/dev
}

in-first-tab && git pull --rebase --autostash &> /dev/null
in-first-tab && git install-hooks &> /dev/null

report-custom-functions

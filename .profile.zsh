# Let's stick to Vim for this one.
load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/basic.zsh

# Custom functions, aliases and hooks.
setup() {
  apt-get install ruby
}

push() {
  docker push jakubstastny/dev
}

in-first-tab && git pull --rebase --autostash &> /dev/null
in-first-tab && git install-hooks &> /dev/null

report-custom-functions

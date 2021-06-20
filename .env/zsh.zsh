load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/emacs.zsh
load ~/.zsh/environments/basic.zsh
load ~/.zsh/environments/git.zsh
load ~/.zsh/environments/docker.zsh

# Custom functions, aliases and hooks.

# We compile on save, but for the first-time compilation,
# we want to be able to do it from the shell, rather than
# having to go and save manually each file from Emacs.
tangle() {
  cd src
  echo "(dolist (file argv) (message file) (find-file file) (org-babel-tangle))" > compile.el
  emacs --script compile.el *.org
  rm compile.el
  cd -
}

push() {
  docker push jakubstastny/dev
}

docker-login
start-emacs-session
rename-first-tab

report-custom-functions

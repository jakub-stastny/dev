load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/basic.zsh
load ~/.zsh/environments/emacs.zsh

try-load ~/blog.meta/inherit/env/zsh.zsh

start-emacs-session
rename-first-tab

# Custom functions & aliases.

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

run() {
  clj -M -m rpm.main
}

t() {
  clj -X:test
}

report-custom-functions

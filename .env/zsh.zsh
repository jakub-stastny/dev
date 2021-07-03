load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/basic.zsh
load ~/.zsh/environments/git.zsh

alias e=nvim

serve() {
  python -m SimpleHTTPServer 8080
}

commit() {
  mv dev/build.html dev/index.html
  mv dev/README.html dev/usage.html
  git add dev
  git commit -m "GitHub pages regenerated"
}

report-custom-functions

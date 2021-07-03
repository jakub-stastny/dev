load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/basic.zsh
load ~/.zsh/environments/git.zsh

alias e=nvim

serve() {
  python -m SimpleHTTPServer 8080
}

commit() {
  mv docs/build.html docs/index.html
  mv docs/README.html docs/usage.html
  git add docs
  git commit -m "GitHub pages regenerated"
}

report-custom-functions

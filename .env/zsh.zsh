load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/emacs.zsh
load ~/.zsh/environments/basic.zsh
load ~/.zsh/environments/git.zsh
load ~/.zsh/environments/docker.zsh

tangle() {
  if [ $# -eq 0 ];
    emacs -Q --batch --eval "(progn (dolist (file command-line-args-left) (with-current-buffer (find-file-noselect file) (org-babel-tangle))))" *.org
  else
    emacs -Q --batch --eval "(progn (dolist (file command-line-args-left) (with-current-buffer (find-file-noselect file) (org-babel-tangle))))" "$@"
  fi
}

rename-first-tab
report-custom-functions

(progn (dolist (file command-line-args-left) (with-current-buffer (find-file-noselect file) (org-babel-tangle))))

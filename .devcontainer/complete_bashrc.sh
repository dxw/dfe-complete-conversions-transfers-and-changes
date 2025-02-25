# Default bashrc providing some Complete conveniences
# Intended to be sourced into /etc/bash.bashrc so it can be overridden by user dotfiles

## Add Rails `bin` and Bundler `bin` directories to PATH
##   Adds `$PWD/bin` to support checking out a repository into a Docker volume through VS Code
##   (which results in the workspace not living in the default `/workspace` directory)
PATH=$PWD/bin:/workspace/bin:/usr/local/bundle/bin:$PATH

## Enable Git bash completion
source /usr/share/bash-completion/completions/git

## Aliases

# Bundler
alias ber="bundle exec rspec --no-profile"
alias berf="bundle exec rspec --no-profile --only-failures"
alias bernf="bundle exec rspec --no-profile --next-failure"
alias berp="bundle exec rspec --profile 10"
alias be="bundle exec"

# Git
alias gst='git status'
alias gsh='git show'
alias gshw='git show'
alias gshow='git show'
alias gi='vim .gitignore'
alias gcm='git ci -m'
alias gcim='git ci -m'
alias gci='git ci'
alias gco='git co'
alias gcp='git cp'
alias ga='git add -A'
alias gap='git add -p'
alias guns='git unstage'
alias gunc='git uncommit'
alias gm='git merge'
alias gms='git merge --squash'
alias gam='git amend --reset-author'
alias grv='git remote -v'
alias grr='git remote rm'
alias grad='git remote add'
alias gr='git rebase'
alias gra='git rebase --abort'
alias ggrc='git rebase --continue'
alias gbi='git rebase --interactive'
alias gl='git l'
alias glg='git l'
alias glog='git l'
alias co='git co'
alias gf='git fetch'
alias gfp='git fetch --prune'
alias gfa='git fetch --all'
alias gfap='git fetch --all --prune'
alias gfch='git fetch'
alias gd='git diff'
alias gb='git b'
# Staged and cached are the same thing
alias gdc='git diff --cached -w'
alias gds='git diff --staged -w'
alias gpub='grb publish'
alias gtr='grb track'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gpsh='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias gnb='git nb' # new branch aka checkout -b
alias grs='git reset'
alias grsh='git reset --hard'
alias gcln='git clean'
alias gclndf='git clean -df'
alias gclndfx='git clean -dfx'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gt='git t'
alias gbg='git bisect good'
alias gbb='git bisect bad'
alias gdmb='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
# Git command for rebasing against Main branch in Github/Origin
alias grbm="git fetch origin && git rebase origin/main"
alias gc="git commit"
alias gbl="git branch --list"
# Git safe Push Force
alias gpf="git push --force-with-lease"
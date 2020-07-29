
#!/bin/bash
_wrap () {
  alias $1="echo \" ~ $2\" && $2"
}

alias gh="cat ~/scripts/gitaliases.sh"
_wrap gba "git branch -a"
_wrap gpaa "git add . --all && git commit --amend --no-edit && git push origin --force-with-lease"
_wrap grbi "git rebase upstream/master -i"
_wrap gph "git push heroku master"
_wrap gaa "git add -A"
_wrap gd "git diff"
_wrap gs "git status"
_wrap gco "git checkout"
_wrap gcp "git cherry-pick"
_wrap gci "git commit"
_wrap gcia "git commit --amend --no-edit"
_wrap grb "git rebase -i"
_wrap gp "git pull"
_wrap gpp "git push origin"
_wrap gfa "git fetch --all"
_wrap gfu "git fetch upstream"
_wrap grh "git reset --hard"
_wrap gmt "git mergetool"
_wrap gl "git log --oneline --graph"
_wrap shipit "npm run deploy"
_wrap gpft "git push --follow-tags"
_wrap npmv "npm version $1 && git push --follow-tags && npm publish"
_wrap gif "~/scripts/gif"
_wrap hosts "sudoedit /etc/hosts && sudo /etc/init.d/dns-clean restart && sudo /etc/init.d/networking restart"
_wrap amisafe "ps auxwww | grep sshd"
_wrap empty-trash "rm -rf ~/.local/share/Trash/*"
_wrap v "nvim"

ipp () {
  dig +short myip.opendns.com @resolver1.opendns.com
}

ipl () {
  ifconfig | grep broadcast | awk '{print $2}'
}

# Kill all processes that match the given name. ie: `killname webpack` will kill all running webpack instances
killname() {
  sudo kill -9 $(ps -e | grep $1 | awk '{print $1}')
}

# Start a parcel / TS project in ~/dev taking the first name as an argument
project() {
  mkdir ~/dev/$1
  cd ~/dev/$1
  git init
  npm init -y
  echo "node_modules" > .gitignore
  mkdir src
  touch ./src/index.ts
  yarn add -D parcel-bundler typescript jest

  git add .
  git commit -m "init"
  code .
}

if [[ -f /opt/dev/dev.sh ]] && [[ $- == *i* ]]; then
  source /opt/dev/dev.sh
fi


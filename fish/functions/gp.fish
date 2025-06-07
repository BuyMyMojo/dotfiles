function gp --wraps='git pull --rebase' --description 'alias gp=git pull --rebase'
  git pull --rebase $argv
        
end

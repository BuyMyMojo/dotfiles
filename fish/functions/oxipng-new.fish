function oxipng-new --wraps='find . -type f -newermt $(date +%m/%d/%Y) -print0 | xargs -0 oxipng -o max -p' --description 'alias oxipng-new find . -type f -newermt $(date +%m/%d/%Y) -print0 | xargs -0 oxipng -o max -p'
  find . -type f -newermt $(date +%m/%d/%Y) -print0 | xargs -0 oxipng -o max -p $argv
        
end

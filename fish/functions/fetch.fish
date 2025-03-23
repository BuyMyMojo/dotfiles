function fetch --wraps='nix-shell -p hyfetch -p fastfetch --run hyfetch' --description 'alias fetch=nix-shell -p hyfetch -p fastfetch --run hyfetch'
  nix-shell -p hyfetch -p fastfetch --run hyfetch $argv
        
end

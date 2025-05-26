function compress-btrfs --wraps='btrfs filesystem defrag -czstd' --description 'alias compress-btrfs=btrfs filesystem defrag -czstd'
  btrfs filesystem defrag -czstd $argv
        
end

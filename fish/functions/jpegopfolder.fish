function jpegopfolder --wraps='find . \\( -iname "*.jpg" -o -iname "*.jpeg" \\) | jpegoptim -p -P --files-stdin -w $(nproc --all)' --description 'alias jpegopfolder find . \\( -iname "*.jpg" -o -iname "*.jpeg" \\) | jpegoptim -p -P --files-stdin -w $(nproc --all)'
  find . \( -iname "*.jpg" -o -iname "*.jpeg" \) | jpegoptim -p -P --files-stdin -w $(nproc --all) $argv
        
end

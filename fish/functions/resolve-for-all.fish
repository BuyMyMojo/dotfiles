function resolve-for-all --wraps="sudo /usr/bin/perl -pi -e 's/\\x74\\x11\\xe8\\x21\\x23\\x00\\x00/\\xeb\\x11\\xe8\\x21\\x23\\x00\\x00/g' /opt/resolve/bin/resolve" --description "alias resolve-for-all=sudo /usr/bin/perl -pi -e 's/\\x74\\x11\\xe8\\x21\\x23\\x00\\x00/\\xeb\\x11\\xe8\\x21\\x23\\x00\\x00/g' /opt/resolve/bin/resolve"
  sudo /usr/bin/perl -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' /opt/resolve/bin/resolve $argv
        
end

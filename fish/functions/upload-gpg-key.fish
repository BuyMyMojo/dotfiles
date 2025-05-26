function upload-gpg-key --wraps='gpg --keyserver https://keys.openpgp.org --send-keys 7EBD3E0C7D3D5C7D5CA8A03F49776EAC872B884B && gpg --send-keys 49776EAC872B884B' --description 'alias upload-gpg-key=gpg --keyserver https://keys.openpgp.org --send-keys 7EBD3E0C7D3D5C7D5CA8A03F49776EAC872B884B && gpg --send-keys 49776EAC872B884B'
  gpg --keyserver https://keys.openpgp.org --send-keys 7EBD3E0C7D3D5C7D5CA8A03F49776EAC872B884B && gpg --send-keys 49776EAC872B884B $argv
        
end

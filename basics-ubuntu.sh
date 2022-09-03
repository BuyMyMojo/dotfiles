sudo apt update -y

sudo apt full-upgrade -y

sudo apt install build-essential curl wget neovim -y

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source "$HOME/.cargo/env"

cargo install just
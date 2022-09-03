# Install the nightly-gnu version of rust
rustup-nightly:
    rustup install nightly-gnu

# Update rust with rustup
rustupdate:
    rustup update

# Install some ctach-all packages for dev stuff
ubuntu-code-stuff:
    sudo apt install gcc make libssl-dev build-essential autoconf automake gdb git -y

# Install the closed-source vscode
ubuntu-vscode:
    sudo apt-get install wget gpg -y && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && rm -f packages.microsoft.gpg && sudo apt install apt-transport-https && sudo apt update -y && sudo apt install code -y
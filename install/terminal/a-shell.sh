# Configure the bash shell using Venus defaults
[ -f "~/.bashrc" ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.local/share/venus/configs/bashrc ~/.bashrc

# Load the PATH for use later in the installers
source ~/.local/share/venus/defaults/bash/shell

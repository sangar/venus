# Needed for all installers
sudo apt update -y
sudo apt upgrade -y

# Run terminal installers
for installer in ~/.local/share/venus/install/terminal/*.sh; do source $installer; done

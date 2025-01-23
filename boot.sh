set -e

ascii_art='____   ____                          
\   \ /   /____   ____  __ __  ______
 \   Y   // __ \ /    \|  |  \/  ___/
  \     /\  ___/|   |  \  |  /\___ \ 
   \___/  \___  >___|  /____//____  >
              \/     \/           \/ 
'

echo -e "$ascii_art"
echo "=> Venus is for Raspberry Pi OS!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning Venus..."
#rm -rf ~/.local/share/venus
git clone https://github.com/sangar/venus.git ~/.local/share/venus >/dev/null

echo "Installation starting..."
source ~/.local/share/venus/install.sh


sudo apt purge --auto-remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupdel docker

sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

sudo rm /etc/apt/sources.list.d/docker.list
sudo rm /etc/apt/keyrings/docker.asc


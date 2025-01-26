cat <<EOF >/etc/systemd/system/minecraft-bot.service
# minecraft-bot.service
# /etc/systemd/system/minecraft-bot.service
#

[Unit]
Description=Discord ec2 bot
After=network.target
After=local-fs.target

[Service]
Type=simple
User=$USER
Group=$USER
WorkingDirectory=/home/$USER/.local/share/venus/bots/minecraft-bot
ExecStart=/home/$USER/.rbenv/shims/ruby app.rb
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl enable minecraft-bot
sudo systemctl start minecraft-bot

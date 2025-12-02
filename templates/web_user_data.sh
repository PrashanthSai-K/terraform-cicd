#!/bin/bash
sudo yum update -y
sudo yum install -y python3-pip
sudo pip3 install flask requests

cat <<EOF > /home/ec2-user/web_app.py
${web_app_content}
EOF

cat <<EOF > /etc/systemd/system/web.service
${web_service_content}
EOF

sudo systemctl daemon-reload
sudo systemctl enable web.service
sudo systemctl start web.service

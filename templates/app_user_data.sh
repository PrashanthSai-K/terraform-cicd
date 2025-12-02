#!/bin/bash
sudo yum update -y
sudo yum install -y python3-pip postgresql
sudo pip3 install flask psycopg2-binary

cat <<EOF > /home/ec2-user/app_app.py
${app_app_content}
EOF

cat <<EOF > /etc/systemd/system/app.service
${app_service_content}
EOF

sudo systemctl daemon-reload
sudo systemctl enable app.service
sudo systemctl start app.service

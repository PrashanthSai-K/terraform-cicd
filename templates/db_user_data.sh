#!/bin/bash
sudo yum update -y
sudo yum install -y postgresql-server
sudo postgresql-setup initdb

# Allow remote connections
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/data/postgresql.conf
echo "host    all             all             10.0.2.0/24             md5" | sudo tee -a /var/lib/pgsql/data/pg_hba.conf

sudo systemctl start postgresql
sudo systemctl enable postgresql

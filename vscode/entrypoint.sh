#!/bin/bash
set -e

echo "Starting Apache..."
service apache2 start

echo "Starting MariaDB..."
service mariadb start

echo "Enable Rewrite module..."
a2enmod rewrite

echo "Starting VS Code server..."
/opt/nvm/nvm.sh

/usr/bin/code serve-web --host 0.0.0.0 --port 8080 --connection-token ${TOKEN}


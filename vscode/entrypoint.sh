#!/bin/bash
set -e

echo "Starting Apache..."
service apache2 start

echo "Starting MariaDB..."
service mysql start

echo "Starting VS Code server..."
. /opt/nvm/nvm.sh
exec /usr/bin/code serve-web --host 0.0.0.0 --port 8080 --connection-token ${TOKEN}

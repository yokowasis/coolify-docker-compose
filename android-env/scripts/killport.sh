#!/bin/bash

# Usage: ./killport.sh <port_number>

if [ -z "$1" ]; then
  echo "Usage: $0 <port_number>"
  exit 1
fi

PORT=$1

PID=$(lsof -t -i tcp:$PORT)

if [ -z "$PID" ]; then
  echo "No process found using port $PORT"
else
  echo "Killing process $PID using port $PORT"
  kill -9 $PID
fi

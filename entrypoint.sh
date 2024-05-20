#!/bin/bash

if [ -f /app/tmp/pids/server.pid ]; then
  echo "Removing already running server..."
  rm /app/tmp/pids/server.pid
fi

echo "Preparing database..."
bundle exec rails db:prepare

echo "Running Server..."
bundle exec rails server
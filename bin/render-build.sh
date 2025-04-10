#!/usr/bin/env bash
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails db:migrate

echo "-----> Ensuring port $PORT is free"
lsof -ti:$PORT | xargs kill -9 || true

echo "-----> Creating restart file"
mkdir -p tmp
touch tmp/restart.txt

# Make sure all scripts are executable
chmod +x bin/rails
chmod +x bin/render-build.sh
chmod +x bin/bundle
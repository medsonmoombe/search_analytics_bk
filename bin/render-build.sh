#!/usr/bin/env bash
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails db:migrate

# Make sure all scripts are executable
chmod +x bin/rails
chmod +x bin/render-build.sh
chmod +x bin/bundle
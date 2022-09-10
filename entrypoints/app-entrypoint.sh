#!/bin/sh
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi


bundle install
bundle exec rails db:create
bundle exec rails db:migrate
# bundle exec rails spec
bundle exec rails s -b 0.0.0.0
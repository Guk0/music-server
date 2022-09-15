#! /bin/sh

./docker/wait-for-services.sh
./docker/prepare-db.sh
# bundle exec puma -C config/puma.rb

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle install
bundle exec rails s -b 0.0.0.0

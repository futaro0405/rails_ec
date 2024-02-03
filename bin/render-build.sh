#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails stg-ecsite:migrate
bundle exec rails stg-ecsite:seed_fu
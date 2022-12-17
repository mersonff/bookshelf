set -a

echo "Starting bookshelf in one tab"
​
export $(grep -v '^#' ./.env | xargs -d '\n')
#load .env file.
source ./.env
# Check for update in yarn and bundler.
bundle install
# Start sidekiq, rails and webpacker in 3 differents process, if you have any issue you can easily restart the container.
nohup rm -f tmp/pids/server.pid  && bundle exec rails s -b 0.0.0.0 -p 3000 & bundle exec sidekiq --environment development
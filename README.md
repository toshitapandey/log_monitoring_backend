### Frontend Repository
https://github.com/toshitapandey/log_monitoring_frontend

# README

Ruby Version - 2.7.0
Rails Version - 6.1.6

##### Install Ruby
rvm install 2.7.0

##### Install bundler
gem install bundler

##### Install Gems
bundle install 

##### Start server
rails s -p 3001

##### Assumption
By default the log monitoring system monitors `log/development.log` file. This can be changed in `app/channels/log_monitor_channel.rb`

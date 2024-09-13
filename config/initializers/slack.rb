# config/initializers/slack.rb

Slack.configure do |config|
  config.token = ENV["SLACK_BOT_TOKEN"]
  raise "Missing ENV['SLACK_BOT_TOKEN']!" unless config.token
end

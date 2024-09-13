# app/services/slack_notifier.rb

class SlackNotifier
  def self.notify(channel:, text:)
    client = Slack::Web::Client.new
    client.chat_postMessage(channel: channel, text: text, as_user: true)
  rescue Slack::Web::Api::Errors::SlackError => e
    Rails.logger.error "Slack notification failed: #{e.message}"
  end
end

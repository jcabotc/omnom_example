require 'thor'

class OmnomExample < Thor; end

require 'omnom_example/declarator'
require 'omnom_example/consumer'

class OmnomExample
  desc "declare PROJECT_ID TOPIC SUBSCRIPTION", "Declare a topic and a subscription on Google Pubsub"

  method_option :host, default: "localhost", desc: "Google Pubsub server host"
  method_option :port, type: :numeric, default: 8085, desc: "Google Pubsub server port"
  method_option :token, default: "fake_auth_token", desc: "Google Pubsub valid oauth token (not needed if you are using the Google Pubsub emulator)"

  def declare(project_id, topic, subscription)
    declarator = Declarator.new(project_id, topic, subscription, options)
    declarator.run
  end

  desc "consume PROJECT_ID SUBSCRIPTION", "Consume messages from a Google Cloud Pubsub subscription"

  method_option :host, default: "localhost", desc: "Google Pubsub server host"
  method_option :port, type: :numeric, default: 8085, desc: "Google Pubsub server port"
  method_option :token, default: "fake_auth_token", desc: "Google Pubsub valid oauth token (not needed if you are using the Google Pubsub emulator)"

  def consume(project_id, subscription)
    consumer = Consumer.new(project_id, subscription, options)
    consumer.start
  end
end

require 'thor'

class OmnomExample < Thor; end

require 'omnom_example/declarator'
require 'omnom_example/consumer'

class OmnomExample
  desc "declare", "Declare a topic and a subscription on Google Pubsub"

  method_option :host, default: "localhost", desc: "Google Pubsub server host"
  method_option :port, type: :numeric, default: 8085, desc: "Google Pubsub server port"
  method_option :project_id, required: true, desc: "Google Pubsub project_id"
  method_option :topic, required: true, desc: "Google Pubsub topic"
  method_option :subscription, required: true, desc: "Google Pubsub subscription name"
  method_option :token, default: "fake_auth_token", desc: "Google Pubsub valid oauth token (not needed if you are using the Google Pubsub emulator)"

  def declare()
    declarator = Declarator.new(options)
    declarator.run
  end

  desc "consume", "Consume messages from a Google Cloud Pubsub subscription"

  method_option :host, default: "localhost", desc: "Google Pubsub server host"
  method_option :port, type: :numeric, default: 8085, desc: "Google Pubsub server port"
  method_option :project_id, required: true, desc: "Google Pubsub project_id"
  method_option :subscription, required: true, desc: "Google Pubsub subscription name"
  method_option :token, default: "fake_auth_token", desc: "Google Pubsub valid oauth token (not needed if you are using the Google Pubsub emulator)"

  def consume()
    consumer = Consumer.new(options)
    consumer.start
  end
end

require 'thor'

class OmnomExample < Thor; end

require 'omnom_example/declarator'
require 'omnom_example/publisher'
require 'omnom_example/consumer'

class OmnomExample
  class_option :host, default: "localhost", desc: "Pubsub server host"
  class_option :port, type: :numeric, default: 8085, desc: "Pubsub server port"
  class_option :token, default: "fake_auth_token", desc: "Valid oauth token (not needed if you are using the Google Pubsub emulator)"

  desc "declare PROJECT_ID TOPIC SUBSCRIPTION", "Declare a topic and a subscription"
  def declare(project_id, topic, subscription)
    declarator = Declarator.new(project_id, topic, subscription, options)
    declarator.run
  end

  desc "publish PROJECT_ID TOPIC AMOUNT", "Publish the specified amount of messages to a topic"
  def publish(project_id, topic, str_amount)
    amount = str_amount.to_i

    publisher = Publisher.new(project_id, topic, amount, options)
    publisher.run
  end

  desc "consume PROJECT_ID SUBSCRIPTION", "Consume messages from a subscription"
  def consume(project_id, subscription)
    consumer = Consumer.new(project_id, subscription, options)
    consumer.start
  end
end

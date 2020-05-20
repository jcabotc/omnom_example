require "net/http"
require "base64"
require "json"

class OmnomExample
  class Publisher
    BATCH_SIZE = 200

    def initialize(project_id, topic, amount, opts)
      @full_topic = "projects/#{project_id}/topics/#{topic}"
      @amount = amount

      @http = Net::HTTP.new(opts[:host], opts[:port])
      @headers = {"authorization" => "Bearer #{opts[:token]}", "content-type" => "application/json"}
    end

    def run
      puts("Publishing #{amount} in batches of #{BATCH_SIZE} messages to #{full_topic} ...")

      batch_count = (Float(amount) / BATCH_SIZE).ceil

      amount.times.each_slice(BATCH_SIZE).each_with_index do |message_indexes, batch_index|
        publish_batch(message_indexes)
        puts("Batch published #{batch_index + 1}/#{batch_count}")
      end

      puts("Done!")
    end

    private

    def publish_batch(batch_indexes)
      messages = batch_indexes.map do |index|
        encoded = Base64.encode64("message_#{index + 1}").delete_suffix("\n")

        {"data" => encoded}
      end

      path = "/v1/#{full_topic}:publish"
      body = {"messages" => messages}.to_json

      post(path, body)
    end

    def post(path, body)
      response = http.send_request("POST", path, body, headers)

      if response.code != "200"
        raise "Unexpected status: #{response.code} (#{response.body})"
      end
    end

    attr_reader :full_topic, :amount, :http, :headers
  end
end

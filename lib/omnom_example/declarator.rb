require "net/http"
require "json"

class OmnomExample
  class Declarator
    def initialize(project_id, topic, subscription, opts)
      @full_topic = "projects/#{project_id}/topics/#{topic}"
      @full_subscription = "projects/#{project_id}/subscriptions/#{subscription}"

      @http = Net::HTTP.new(opts[:host], opts[:port])
      @headers = {"authorization" => "Bearer #{opts[:token]}", "content-type" => "application/json"}
    end

    def run
      print("Declaring topic #{full_topic} ...")
      put("/v1/#{full_topic}", "")
      puts(" Done!")

      print("Declaring subscription #{full_subscription} ...")
      put("/v1/#{full_subscription}", {"topic" => full_topic}.to_json)
      puts(" Done!")
    end

    private

    def put(path, body)
      response = http.send_request("PUT", path, body, headers)

      if response.code != "200"
        raise "Unexpected status: #{response.code} (#{response.body})"
      end
    end

    attr_reader :full_topic, :full_subscription, :http, :headers
  end
end

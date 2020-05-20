require 'thor'

class OmnomExample < Thor
  desc "consume", "consume messages from the default subscription"
  def consume()
    puts "Consuming"
  end
end

require 'omnom'

require 'omnom_example/consumer/handler'

class OmnomExample
  class Consumer
    def initialize(options)
      @config = build_config(options)
    end

    def start
      puts "PID: #{Process.pid}"
      puts "Starting consumer..."
      setup_system_signals_and_consume
      puts "Consumer started!"
      sleep
    end

    private

    def build_config(options)
      Omnom::Config.new(
        adapter: Omnom::Adapter::GooglePubsub.new(options),
        handler: Handler.new,
        buffer_size: 100,
        poll_interval_ms: 250,
        concurrency: 8
      )
    end

    def setup_system_signals_and_consume
      Signal.trap("TERM") { stop; exit }
      Signal.trap("USR1") { stop; exit }

      @consumer = Omnom.new(config)
    end

    def stop
      Thread.new do
        puts "Stopping consumer..."
        consumer.stop
        puts "Consumer stopped. Bye!"
      end.join
    end
    
    attr_reader :config, :consumer
  end
end

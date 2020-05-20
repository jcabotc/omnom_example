require 'omnom'

require 'omnom_example/consumer/handler'

class OmnomExample
  class Consumer
    def initialize(project_id, subscription, opts)
      adapter_config = opts.merge(project_id: project_id, subscription: subscription)

      @config = Omnom::Config.new(
        adapter: Omnom::Adapter::GooglePubsub.new(adapter_config),
        handler: Handler.new,
        buffer_size: 20,
        poll_interval_ms: 250,
        concurrency: 8
      )
    end

    def start
      puts "PID: #{Process.pid}"
      puts "Starting consumer..."
      setup_system_signals_and_consume
      puts "Consumer started!"
      sleep
    end

    private

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

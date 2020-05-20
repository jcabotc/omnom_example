class OmnomExample
  class Consumer
    class Handler
      def handle(message)
        sleep(rand * 4) # Simulate a long running task

        puts "Handler consumed: #{message}"
        true
      end
    end
  end
end

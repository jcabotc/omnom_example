class OmnomExample
  class Consumer
    class Handler
      def handle(message)
        sleep(rand * 4) # Simulate a long running task

        puts "[Handler] Consumed: #{message}"
        true
      end
    end
  end
end

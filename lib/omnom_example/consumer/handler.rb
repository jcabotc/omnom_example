class OmnomExample
  class Consumer
    class Handler
      def handle(message)
        puts "[#{message}] Processing..."
        sleep(rand * 4)
        puts "[#{message}] Done!"

        true
      end
    end
  end
end

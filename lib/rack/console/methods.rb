module Rack
  class Console
    module Methods
      def reload!
        puts 'Reloading...'
        exec $0
      end

      def app
        @app
      end
    end
  end
end

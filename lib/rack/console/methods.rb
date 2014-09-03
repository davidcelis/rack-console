module Rack
  class Console
    module Methods
      def reload!
        ENV['IGNORE_RACK_CONSOLE_INTRO'] = true
        puts 'Reloading...'
        exec $0
      end

      def app
        @app
      end
    end
  end
end

module Rack
  class Console
    module Methods
      def reload!
        ENV['RACK_CONSOLE_PREAMBLE'] = ''
        puts 'Reloading...'
        exec $0
      end

      def app
        @app
      end
    end
  end
end

module Rack
  class Console
    module Methods
      def reload!
        ENV['IGNORE_RACK_CONSOLE_INTRO'] = 'true'
        puts 'Reloading...'
        Kernel.exec $0, *ARGV
      end

      def app
        @app
      end
    end
  end
end

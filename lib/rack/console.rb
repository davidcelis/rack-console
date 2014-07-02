require 'rack'
require 'rack/console/version'
require 'optparse'

module Rack
  class Console
    def initialize(options = {})
      @options = { config: 'config.ru' }.merge(options)
    end

    def start
      ENV['RACK_ENV'] = @options[:environment] || 'development'

      if includes = @options[:include]
        $LOAD_PATH.unshift(*includes)
      end

      if library = @options[:require]
        require library
      end

      Rack::Builder.parse_file(@options[:config])

      Object.class_eval do
        def reload!
          puts 'Reloading...'
          exec $0
        end
      end

      begin
        require 'pry'
        Pry.start
      rescue LoadError
        require 'irb'
        IRB.start
      end
    end
  end
end

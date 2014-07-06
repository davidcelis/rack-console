require 'rack'
require 'rack/console/methods'
require 'rack/console/session'
require 'rack/console/version'

module Rack
  class Console
    def self.start(options = {})
      self.new(options).start
    end

    def initialize(options = {})
      @options = { config: 'config.ru' }.merge(options)

      ENV['RACK_ENV'] = @options[:environment] || 'development'
      ENV['RACK_CONSOLE_PREAMBLE'] ||= "Loading #{ENV['RACK_ENV']} environment (Rack::Console #{Rack::Console::VERSION})"

      if includes = @options[:include]
        $LOAD_PATH.unshift(*includes)
      end

      if library = @options[:require]
        require library
      end
    end

    def start
      if ENV['RACK_CONSOLE_PREAMBLE'] && !ENV['RACK_CONSOLE_PREAMBLE'].empty?
        puts ENV['RACK_CONSOLE_PREAMBLE']
      end

      app = Rack::Builder.parse_file(@options[:config]).first

      # Add convenience methods to the top-level binding (main)
      main.extend(Rack::Console::Methods)
      main.instance_variable_set(:@app, Rack::Console::Session.new(app))

      begin
        require 'pry'
        Pry.start
      rescue LoadError
        require 'irb'
        IRB.start
      end
    end

    private

    def main
      TOPLEVEL_BINDING.eval('self')
    end
  end
end

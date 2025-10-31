require "rack"
require "rack/console/methods"
require "rack/console/session"
require "rack/console/version"

module Rack
  class Console
    def self.start(options = {})
      new(options).start
    end

    def initialize(options = {})
      @options = default_options.merge(options)

      ENV["RACK_ENV"] = @options[:environment]
      set_preamble

      $LOAD_PATH.unshift(*@options[:include]) if @options[:include]

      require @options[:require] if @options[:require]
    end

    def start
      puts ENV["RACK_CONSOLE_INTRO"] unless ENV["IGNORE_RACK_CONSOLE_INTRO"]

      app = Rack::Builder.parse_file(@options[:config])

      # Add convenience methods to the top-level binding (main)
      main.extend(Rack::Console::Methods)
      main.instance_variable_set(:@app, Rack::Console::Session.new(app))

      if Gem::Specification.find_all_by_name("pry").any?
        require "pry"
        Pry.start
      else
        require "irb"
        IRB.start
      end
    end

    private

    def main
      TOPLEVEL_BINDING.eval("self")
    end

    def set_preamble
      return if ENV["RACK_CONSOLE_INTRO"]

      loading = "Loading #{ENV["RACK_ENV"]} environment"
      version = "(Rack::Console #{Rack::Console::VERSION})"

      ENV["RACK_CONSOLE_INTRO"] = "#{loading} #{version}"
    end

    def default_options
      {
        config: "config.ru",
        environment: ENV["RACK_ENV"] || "development"
      }
    end
  end
end

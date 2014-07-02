require 'rack'
require 'rack/console/version'
require 'optparse'

module Rack
  class Console
    def self.start(args = ARGV)
      options = { config: 'config.ru' }

      OptionParser.new do |opts|
        opts.banner = 'USAGE: rack-console [OPTIONS] [ENVIRONMENT]'

        opts.on('-c', '--config [RACKUP_FILE]', 'Specify a rackup config file') do |config|
          options[:config] = config
        end

        opts.on('-r', '--require [LIBRARY]', 'Require a file or library before the Rack console loads') do |library|
          require library
        end

        opts.on('-I', '--include [PATHS]', 'Add paths (colon-separated) to the $LOAD_PATH') do |paths|
          $LOAD_PATH.unshift(*paths.split(':'))
        end

        opts.on('-v', '--version', 'Print version and exit') do |v|
          puts Rack::Console::VERSION
          exit 0
        end
      end.parse!(args)

      if environment = args.shift
        ENV['RACK_ENV'] = environment
      end

      Rack::Builder.parse_file(options[:config])

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

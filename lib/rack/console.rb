require 'rack/builder'

require 'rack/console/version'

module Rack
  class Console
    def self.start
      Rack::Builder.parse_file('config.ru')

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

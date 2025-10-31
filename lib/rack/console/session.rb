require "rack/test"

module Rack
  class Console
    class Session
      include Rack::Test::Methods

      attr_reader :app

      def initialize(app)
        @app = app
      end
    end
  end
end

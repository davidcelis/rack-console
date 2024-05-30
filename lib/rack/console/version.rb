module Rack
  class Console
    class Version
      MAJOR = 1
      MINOR = 3
      PATCH = 2

      def self.to_s
        [MAJOR, MINOR, PATCH].join('.')
      end
    end

    VERSION = Version.to_s
  end
end

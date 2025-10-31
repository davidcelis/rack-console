module Rack
  class Console
    class Version
      MAJOR = 2
      MINOR = 0
      PATCH = 0

      def self.to_s
        [MAJOR, MINOR, PATCH].join(".")
      end
    end

    VERSION = Version.to_s
  end
end

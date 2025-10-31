$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "rack/console/version"

Gem::Specification.new do |s|
  s.name = "rack-console"
  s.version = Rack::Console::VERSION
  s.authors = ["David Celis"]
  s.email = ["me@davidcel.is"]

  s.summary = "`rails console` for your Rack applications"
  s.description = <<-DESCRIPTION.gsub(/^\s{4}/, "")
    Find yourself missing a `rails console` analogue in your other Ruby web
    applications? This lightweight gem provides a Rack::Console that will load
    your Rack application's code and environment into an IRB or Pry session.
    Either use `Rack::Console.start` directly, or run the provided `rack-console`
    executable.
  DESCRIPTION

  s.homepage = "https://github.com/davidcelis/rack-console"
  s.license = "MIT"

  s.executables = ["rack-console"]
  s.files = Dir["lib/**/*.rb"]
  s.require_paths = ["lib"]

  s.add_dependency "rack", "~> 3.0"
  s.add_dependency "rack-test"
end

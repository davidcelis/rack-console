require 'rack/builder'

app = Rack::Builder.new
  map('/') { [200, { 'Content-Type' => 'text/plain' }, 'Hello world.'] }
end

run app

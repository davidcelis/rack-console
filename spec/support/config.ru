require "rack"

app = Rack::Builder.new do
  map("/") { [200, {"Content-Type" => "text/plain"}, ["Hello world."]] }
end

run app

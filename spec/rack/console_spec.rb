require 'rack/console'
require 'irb'

describe Rack::Console do
  before { Dir.chdir 'spec/support' }

  it 'parses config.ru in the current working directory' do
    expect(Rack::Builder).to receive(:parse_file).with('config.ru')
    expect(IRB).to receive(:start)

    Rack::Console.start
  end
end

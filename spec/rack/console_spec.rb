require 'rack/console'
require 'irb'

describe Rack::Console do
  before do
    @old_cwd = Dir.pwd
    Dir.chdir File.expand_path('../../support', __FILE__)
  end

  it 'parses config.ru in the current working directory' do
    expect(Rack::Builder).to receive(:parse_file).with('config.ru')
    expect(IRB).to receive(:start)

    Rack::Console.start
  end

  it 'accepts an option to set the config.ru' do
    Dir.chdir @old_cwd

    expect(Rack::Builder).to receive(:parse_file).with('spec/support/config.ru').twice
    expect(IRB).to receive(:start).twice

    Rack::Console.start(['-c',       'spec/support/config.ru'])
    Rack::Console.start(['--config', 'spec/support/config.ru'])
  end

  it 'accepts an argument to set the environment' do
    expect(IRB).to receive(:start)

    Rack::Console.start(['production'])
    expect(ENV['RACK_ENV']).to eq('production')
  end
end

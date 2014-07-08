require 'rack/console'
require 'irb'

describe Rack::Console do
  before do
    @old_pwd = Dir.pwd
    Dir.chdir File.expand_path('../../support', __FILE__)

    expect(IRB).to receive(:start)
  end

  it 'defaults to a config.ru file in the current working directory' do
    expect(Rack::Builder).to receive(:parse_file).
                             with('config.ru').
                             and_call_original

    Rack::Console.new.start
  end

  it 'accepts the --config option to override the location of config.ru' do
    Dir.chdir @old_pwd
    expect(Rack::Builder).to receive(:parse_file).
                             with('spec/support/config.ru').
                             and_call_original

    Rack::Console.new(config: 'spec/support/config.ru').start
  end

  it 'accepts the --require option to require a file or library' do
    Rack::Console.new(require: 'json').start
    expect { JSON }.not_to raise_error
  end

  it 'accepts the --require option to add paths to $LOAD_PATH' do
    Rack::Console.new(include: ['lib', 'spec']).start
    expect($LOAD_PATH).to include('lib')
    expect($LOAD_PATH).to include('spec')
  end

  it 'accepts an argument to set the environment' do
    Rack::Console.new(environment: 'production').start
    expect(ENV['RACK_ENV']).to eq('production')
  end

  describe 'preamble message' do
    it 'defaults to a loading message' do
      preamble = "Loading #{ENV['RACK_ENV']} environment (Rack::Console #{Rack::Console::VERSION})"

      Rack::Console.new.start
      expect(ENV['RACK_CONSOLE_PREAMBLE']).to eq(preamble)
    end

    it 'does not override a preamble if one has already been set' do
      ENV['RACK_CONSOLE_PREAMBLE'] = 'Hello, Rack::Console!'

      expect { Rack::Console.new.start }.not_to change { ENV['RACK_CONSOLE_PREAMBLE'] }

      ENV['RACK_CONSOLE_PREAMBLE'] = nil
    end
  end

  after do
    Dir.chdir @old_pwd

    ENV['RACK_ENV'] = 'test'
    ENV['RACK_CONSOLE_PREAMBLE'] = nil
  end
end

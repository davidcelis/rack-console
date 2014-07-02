require 'rack/console'
require 'irb'

describe Rack::Console do
  before do
    @old_cwd = Dir.pwd
    Dir.chdir File.expand_path('../../support', __FILE__)

    expect(IRB).to receive(:start)
  end

  context 'parsing config.ru' do
    it 'defaults to a config.ru file in the current working directory' do
      expect(Rack::Builder).to receive(:parse_file).with('config.ru')

      Rack::Console.start
    end
  end

  context 'overriding the location of config.ru' do
    before { Dir.chdir @old_cwd }

    it 'accepts the -c option to override the location of config.ru' do
      expect(Rack::Builder).to receive(:parse_file).with('spec/support/config.ru')

      Rack::Console.start(['-c', 'spec/support/config.ru'])
    end

    it 'accepts the --config option to override the location of config.ru' do
      expect(Rack::Builder).to receive(:parse_file).with('spec/support/config.ru')

      Rack::Console.start(['--config', 'spec/support/config.ru'])
    end
  end

  context 'requiring libraries' do
    it 'accepts the -r option' do
      Rack::Console.start(['-r', 'json'])
      expect { JSON }.not_to raise_error
    end

    it 'accepts the --require option' do
      Rack::Console.start(['--require', 'json'])
      expect { JSON }.not_to raise_error
    end
  end

  context 'adding paths to $LOAD_PATH' do
    it 'accepts the -I option' do
      Rack::Console.start(['-I', 'lib:spec'])
      expect($LOAD_PATH).to include('lib')
      expect($LOAD_PATH).to include('spec')
    end

    it 'accepts the --require option' do
      Rack::Console.start(['--include', 'lib:spec'])
      expect($LOAD_PATH).to include('lib')
      expect($LOAD_PATH).to include('spec')
    end
  end

  it 'accepts an argument to set the environment' do
    Rack::Console.start(['production'])
    expect(ENV['RACK_ENV']).to eq('production')
  end
end

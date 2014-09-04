require 'rack/console/methods'

describe Rack::Console::Methods do
  let(:session) { Object.new }

  before { session.send :extend, Rack::Console::Methods }

  describe 'reload!' do
    it 're-executes the running process' do
      expect(Kernel).to receive(:exec).with(/bin\/rspec$/)

      session.reload!
    end
  end

  describe 'app' do
    before { session.instance_variable_set(:@app, 'app') }
    subject { session.app }

    it { is_expected.to eq('app') }
  end
end

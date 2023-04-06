# frozen_string_literal: true

RSpec.describe Injector::Inject do
  describe '.register' do
    it 'has to create a Injectable instance' do
      described_class.register('Service', :service, -> { Class.new })

      expect(described_class.injectables['Service'].first.class).to be Injector::Injectable
    end

    it 'has to insert Injectable instance into array' do
      expect do
        described_class.register('Service', :service, -> { Class.new })
      end.to change { described_class.injectables.length }.by(1)
    end
  end

  describe '.find' do
    context 'when a injectable with informed name was not registered' do
      it 'has to raise a InjectableNotFoundError' do
        expect do
          described_class.find('Service', :service)
        end.to raise_error Injector::InjectableNotFound
      end
    end

    context 'when a injectable with informed name was registered' do
      before do
        described_class.register('Service', :service, -> { Class.new })
      end

      it 'has to return Injectable instance' do
        expect(described_class.find('Service', :service).class).to be Injector::Injectable
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe Injector::Contract do
  describe '.register' do
    it 'has to use class name as contract name' do
      class DummyContract < described_class # rubocop:disable Lint/ConstantDefinitionInBlock, Rspec/LeakyConstantDeclaration
        register :service, -> { Class.new }
      end

      expect(Injector::Inject.injectables.key?('DummyContract')).to be true
    end
  end
end

# frozen_string_literal: true

RSpec.describe SimpleInjector do
  describe '.included' do
    context 'when Injector is included into class' do
      let(:dummy_class) { Class.new { include SimpleInjector } }

      it { expect(dummy_class.methods.include?(:attr_injector)).to be true }

      it { expect(dummy_class.methods.include?(:contract)).to be true }
    end
  end

  describe '.attr_injector' do
    context 'when exist a instance for given injector name' do
      let(:service_class) { Class.new }

      let(:service_contract) do
        Class.new(SimpleInjector::Contract) do
          register :service, -> { ServiceClass.new }
        end
      end

      let(:dummy_class) do
        Class.new do
          include SimpleInjector

          contract ServiceDependencies

          attr_injector :service
        end
      end

      before do
        allow(SimpleInjector::Contract).to receive(:to_s).and_return('ServiceContract')

        stub_const 'ServiceClass', service_class
        stub_const 'ServiceDependencies', service_contract
      end

      it 'when exist an instance for given name has to retrieve lazyly' do
        expect(dummy_class.new.service).to be_instance_of service_class
      end
    end

    context 'when a instance for given injector name was not registered' do
      it 'has to raise exception' do
        expect do
          Class.new do
            include SimpleInjector

            attr_injector :service
          end
        end.to raise_error SimpleInjector::InjectableNotFound
      end
    end
  end

  describe '.contract' do
    # rubocop:disable Lint/ConstantDefinitionInBlock, Rspec/LeakyConstantDeclaration
    it 'has to define instance variabel on class level with informed class name as value' do
      ServiceClass = Class.new

      class ServiceContract < SimpleInjector::Contract
        register :service, -> { ServiceClass.new }
      end

      class DummyClass
        include SimpleInjector

        contract ServiceContract

        attr_injector :service
      end

      expect(DummyClass.instance_variable_get(:@contractor_class)).to eq 'ServiceContract'
    end
    # rubocop:enable Lint/ConstantDefinitionInBlock, Rspec/LeakyConstantDeclaration
  end
end

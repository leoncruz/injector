# frozen_string_literal: true

RSpec.describe Injector do
  describe '.included' do
    context 'when Injector is included into class' do
      let(:dummy_class) { Class.new { include Injector } }

      it 'has to insert on class the ClassMethods as an ancestor' do
        expect(dummy_class.methods.include?(:attr_injector)).to be true
      end
    end
  end

  describe '.attr_injector' do
    context 'when exist a instance for given injector name' do
      let(:service_class) { Class.new }

      let(:service_dependencies) do
        Class.new do
          extend Injector::Dependencies

          register :service, -> { ServiceClass.new }
        end
      end

      let(:dummy_class) do
        Class.new do
          include Injector

          attr_injector :service
        end
      end

      before do
        stub_const 'ServiceClass', service_class
        stub_const 'ServiceDependencies', service_dependencies
      end

      it 'when exist an instance for given name has to retrieve lazyly' do
        expect(dummy_class.new.service).to be_instance_of service_class
      end
    end

    context 'when a instance for given injector name was not registered' do
      it 'has to raise exception' do
        expect do
          Class.new do
            include Injector

            attr_injector :service
          end
        end.to raise_error Injector::InjectableNotFound
      end
    end
  end
end

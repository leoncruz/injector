# frozen_string_literal: true

module SimpleInjector
  class InjectableNotFound < StandardError; end

  # Singleton class to save instances and retrieve
  class Inject
    @injectables = {}

    class << self
      attr_accessor :injectables

      def register(contract_name, name, callback)
        (@injectables[contract_name] ||= []) << Injectable.new(name, callback)
      end

      def find(contract_name, name)
        injectable = (@injectables[contract_name] ||= []).find { |i| i.name == name }

        raise InjectableNotFound, "An instance with name '#{name}' was not registered" unless injectable

        injectable
      end
    end
  end
end

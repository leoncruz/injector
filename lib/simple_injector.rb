# frozen_string_literal: true

require_relative 'simple_injector/version'
require_relative 'simple_injector/contract'
require_relative 'simple_injector/injectable'
require_relative 'simple_injector/inject'

# Entrypoint module
module SimpleInjector
  def self.included(target)
    target.extend(ClassMethods)
  end

  # methods to add on included class
  module ClassMethods
    @contractor_class = nil

    def attr_injector(name)
      injectable = Inject.find(@contractor_class, name)

      define_method name do
        instance_variable_set(:"@#{name}", injectable.callback.call) unless instance_variable_defined?(:"@#{name}")

        instance_variable_get(:"@#{name}")
      end
    end

    def contract(klass)
      @contractor_class = klass.to_s
    end
  end
end

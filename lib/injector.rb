# frozen_string_literal: true

require_relative 'injector/version'
require_relative 'injector/contract'
require_relative 'injector/injectable'
require_relative 'injector/inject'

# Entrypoint module
module Injector
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

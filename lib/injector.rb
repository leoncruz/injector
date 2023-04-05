# frozen_string_literal: true

require_relative 'injector/version'
require_relative 'injector/dependencies'
require_relative 'injector/injectable'
require_relative 'injector/inject'

# Entrypoint module
module Injector
  def self.included(target)
    target.extend(ClassMethods)
  end

  # methods to add on included class
  module ClassMethods
    def attr_injector(name)
      injectable = Inject.find(name)

      define_method name do
        instance_variable_set(:"@#{name}", injectable.callback.call) unless instance_variable_defined?(:"@#{name}")

        instance_variable_get(:"@#{name}")
      end
    end
  end
end

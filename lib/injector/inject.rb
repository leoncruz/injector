# frozen_string_literal: true

module Injector
  class InjectableNotFound < StandardError; end

  # Singleton class to save instances and retrieve
  class Inject
    @injectables = []

    class << self
      attr_accessor :injectables
    end

    def self.register(name, callback)
      @injectables << Injectable.new(name, callback)
    end

    def self.find(name)
      injectable = @injectables.find { |i| i.name == name }

      raise InjectableNotFound, "An instance with name '#{name}' was not registered" unless injectable

      injectable
    end
  end
end

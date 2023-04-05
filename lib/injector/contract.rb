# frozen_string_literal: true

module Injector
  # Module to handle instance registrations
  class Contract
    class << self
      def register(name, callback)
        Inject.register(name, callback)
      end

      def find(name)
        Inject.find(name)
      end
    end
  end
end

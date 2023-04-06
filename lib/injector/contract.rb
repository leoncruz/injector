# frozen_string_literal: true

module Injector
  # Module to handle instance registrations
  class Contract
    class << self
      def register(name, callback)
        class_name = to_s

        Inject.register(class_name, name, callback)
      end

      def find(name)
        class_name = to_s

        Inject.find(class_name, name)
      end
    end
  end
end

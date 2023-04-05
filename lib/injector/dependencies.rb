# frozen_string_literal: true

module Injector
  # Module to handle instance registrations
  module Dependencies
    def register(name, callback)
      Inject.register(name, callback)
    end

    def find(name)
      Inject.find(name)
    end
  end
end

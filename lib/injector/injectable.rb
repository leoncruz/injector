# frozen_string_literal: true

module Injector
  # Class to handle instances to are injectable
  class Injectable
    attr_accessor :name, :callback

    def initialize(name, callback)
      @name = name
      @callback = callback
    end
  end
end

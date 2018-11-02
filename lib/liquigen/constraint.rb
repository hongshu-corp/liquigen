module Liquigen
  class Constraint
    attr_accessor :nullable
    attr_accessor :primary_key

    def initialize(attributes = {})
      self.nullable = attributes[:nullable]
      self.primary_key = attributes[:primary_key]
    end
  end
end

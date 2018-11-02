module Liquigen
  class Column
    attr_accessor :name
    attr_accessor :type

    attr_accessor :auto_increment
    attr_accessor :constraints

    def initialize(attributes = {})
      self.name = attributes[:name]
      self.type = attributes[:type]
      self.constraints = []
    end
  end
end

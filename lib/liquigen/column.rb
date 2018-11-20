require 'liquigen/type_map'

module Liquigen
  class Column
    attr_accessor :name
    attr_accessor :type

    attr_accessor :auto_increment
    attr_accessor :constraints

    def initialize(attributes = {})
      self.name = attributes[:name]
      self.type = TypeMap.new(attributes[:type]).db_type

      self.constraints = Constraint.new
    end
  end
end

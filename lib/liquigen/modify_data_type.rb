require 'liquigen/change'

module Liquigen
  class ModifyDataType < Change
    attr_accessor :table_name
    attr_accessor :column_name
    attr_accessor :new_date_type

    def initialize(table, from, to)
      self.table_name = table&.underscore&.pluralize
      self.column_name = from
      self.new_date_type = TypeMap.new(to).db_type || to
    end
  end
end

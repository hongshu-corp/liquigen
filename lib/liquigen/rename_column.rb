require 'liquigen/change'

module Liquigen
  class RenameColumn < Change
    attr_accessor :table_name
    attr_accessor :old_column_name
    attr_accessor :new_column_name
    attr_accessor :column_data_type

    def initialize(table, old_name, new_name, type)
      self.table_name = table&.underscore&.pluralize
      self.old_column_name = old_name
      self.new_column_name = new_name
      self.column_data_type = TypeMap.new(type).db_type || type
    end
  end
end

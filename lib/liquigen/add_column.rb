require 'liquigen/change'

module Liquigen
  class AddColumn < Change
    attr_accessor :table_name

    attr_accessor :columns

    def initialize(table_name)
      self.table_name = table_name&.underscore&.pluralize
      self.columns = []
    end
  end
end

require 'liquigen/change'

module Liquigen
  class DropTable < Change
    attr_accessor :table_name

    def initialize(table)
      self.table_name = table.underscore.pluralize
    end
  end
end

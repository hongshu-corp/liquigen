require 'liquigen/change'

module Liquigen
  class CreateIndex < Change
    attr_accessor :table_name
    attr_accessor :index_name
    attr_accessor :columns

    def initialize(table_name)
      self.table_name = table_name&.underscore&.pluralize
      self.index_name = ''
      self.columns = []
    end
  end
end

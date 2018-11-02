require 'liquigen/change'

module Liquigen
  class CreateTable < Change
    attr_accessor :table_name

    attr_accessor :columns

    def initialize(table_name)
      self.table_name = table_name
      self.columns = []
    end

  end
end

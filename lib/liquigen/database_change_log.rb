require 'liquigen/create_table'

module Liquigen
  class DatabaseChangeLog
    attr_accessor :change_sets

    def initialize
      self.change_sets = []
    end

    def init_with_create_table(name)
      create_table_change = CreateTable.new(name)

      change_set = ChangeSet.new
      change_set.changes << change
      change_sets << change_set

      create_table_change
    end
  end
end

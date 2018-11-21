require 'liquigen/change'

module Liquigen
  class Sql < Change
    attr_accessor :sql

    def initialize(sql)
      self.sql = sql
    end
  end
end

require 'liquigen/handlers/base'

module Liquigen::Handlers
  class CreateTable < Base
    def action_name
      'CreateTable'
    end

    def build_change_sets
      set = Liquigen::ChangeSet.new
      change = Liquigen::CreateTable.new(table)
      set.changes << change
      props.each { |k, t| change.columns << build_column(k, t) }
      sets << set
    end

    def build_column(name, type)
      column = Liquigen::Column.new(name: name, type: type)

      constraint = Liquigen::Constraint.new
      if name == 'id'
        column.auto_increment = true
        constraint.primary_key = true
      else
        constraint.nullable = false
      end

      column.constraints << constraint
      column
    end
  end
end

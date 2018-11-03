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
      props.each { |kv| change.columns << build_column(kv) }
      sets << set
    end

    def build_column(name_and_type)
      kv = name_and_type.split(':')
      column = Liquigen::Column.new(name: kv[0], type: kv[1])

      constraint = Liquigen::Constraint.new
      if column.name == 'id'
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

require 'liquigen/handlers/base'

module Liquigen::Handlers
  class CreateTable < Base
    def action_name
      'CreateTable'
    end

    def build_one_changeset(set)
      change = Liquigen::CreateTable.new(table)
      set.changes << change
      props.each { |kv| change.columns << build_column(kv) }
    end

    def build_column(name_and_type)
      kv = name_and_type.split(':')
      column = Liquigen::Column.new(name: kv[0], type: kv[1])

      if column.name == 'id'
        column.auto_increment = true
        column.constraints.primary_key = true
      else
        column.constraints.nullable = false
      end

      column
    end
  end
end

require 'liquigen/handlers/base'

module Liquigen::Handlers
  class AddColumn < CreateTable
    def action_name
      'AddColumn'
    end

    # Add Column
    def file_suffix
      table.capitalize

      columns = props.map do |item|
        item.split(':')[0].camelize
      end.uniq.join('And')

      "#{table.capitalize}_#{columns}"
    end

    def build_one_changeset(set)
      change = Liquigen::AddColumn.new(table)
      set.changes << change
      props.each { |kv| change.columns << build_column(kv) }
    end
  end
end

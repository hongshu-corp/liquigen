require 'liquigen/handlers/base'

module Liquigen::Handlers
  class AddIndex < CreateTable
    def action_name
      'AddIndex'
    end

    # Add Column
    def file_suffix
      table.capitalize

      columns = props.map do |item|
        item.split(':')[0].camelize
      end.uniq.join('And')

      "On#{table.capitalize}_#{columns}"
    end

    def build_one_changeset(set)
      change = Liquigen::CreateIndex.new(table)
      set.changes << change
      props.each { |kv| change.columns << build_column(kv) }

      column_names = props.map { |x| x.split(':')[0] }.uniq.join('_')

      change.index_name = "idx_#{table.underscore.pluralize}_#{column_names}"
    end

    def constraints?
      false
    end
  end
end

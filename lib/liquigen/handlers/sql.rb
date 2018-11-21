require 'liquigen/handlers/base'

module Liquigen::Handlers
  class Sql < Base
    def initialize(props)
      self.props = props
      self.sets = []
      self.id = build_id
    end

    def action_name
      'Sql'
    end

    def file_suffix
      "With#{props.size}Clauses"
    end

    def build_one_changeset(set)
      props.each do |sql|
        change = Liquigen::Sql.new sql
        set.changes << change
      end
    end
  end
end

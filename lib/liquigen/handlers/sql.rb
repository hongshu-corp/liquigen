require 'liquigen/handlers/base'

module Liquigen::Handlers
  class Sql < Base
    def initialize(props)
      self.props = props
      self.sets = []
      self.id = build_id
    end

    def action_name
      'sql'
    end

    def file_suffix
      props.map(&:underscore).join('_')
    end

    def build_one_changeset(set)
      change = Liquigen::Sql.new '# write your sql here, and you can remove the quote outside.'
      set.changes << change
    end
  end
end

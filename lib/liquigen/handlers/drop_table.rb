require 'liquigen/handlers/base'

module Liquigen::Handlers
  class DropTable < Base
    def initialize(props)
      self.props = props
      self.sets = []
      self.id = build_id
    end

    def action_name
      'DropTable'
    end

    def file_suffix
      props.map(&:camelize).join('And')
    end

    def build_one_changeset(set)
      props.each do |tbl|
        change = Liquigen::DropTable.new tbl
        set.changes << change
      end
    end
  end
end

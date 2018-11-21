require 'liquigen/handlers/base'

module Liquigen::Handlers
  class RenameTable < Base
    def initialize(props)
      self.props = props
      self.sets = []
      self.id = build_id
    end

    def action_name
      'RenameTable'
    end

    def file_suffix
      props.map do |item|
        item.split(':')[0].camelize
      end.join('And')
    end

    def build_one_changeset(set)
      props.each do |kv|
        kv = kv.split(':')
        change = Liquigen::RenameTable.new(kv[0], kv[1])
        set.changes << change
      end
    end
  end
end

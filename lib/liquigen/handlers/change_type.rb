require 'liquigen/handlers/base'

module Liquigen::Handlers
  class ChangeType < Base
    def initialize(props)
      self.props = props
      self.sets = []
      self.id = build_id
    end

    def action_name
      'ChangeType'
    end

    def file_suffix
      props.map do |item|
        item.split(':')[0].camelize
      end.uniq.join('And')
    end

    def build_one_changeset(set)
      props.each do |kv|
        kv = kv.split(':')
        change = Liquigen::ChangeType.new(kv[0], kv[1], kv[2])
        set.changes << change
      end
    end
  end
end

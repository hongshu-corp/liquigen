require 'liquigen/handlers/base'

module Liquigen::Handlers
  class RenameColumn < Base
    def initialize(props)
      self.props = props
      self.sets = []
      self.id = build_id
    end

    def action_name
      'RenameColumn'
    end

    def file_suffix
      props.map do |item|
        arr = item.split(':')
        column_description = Array[arr[1].camelize, arr[2].camelize].join('To')
        "#{arr[0].camelize}#{column_description}"
      end.join('And')
    end

    def build_one_changeset(set)
      props.each do |kv|
        kv = kv.split(':')
        change = Liquigen::RenameColumn.new(kv[0], kv[1], kv[2], kv[3])
        set.changes << change
      end
    end
  end
end

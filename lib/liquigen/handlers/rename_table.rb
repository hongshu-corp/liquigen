require 'liquigen/handlers/base'

module Liquigen::Handlers
  class RenameTable < Base
    def initialize(props)
      self.props = props
      self.sets = []
    end

    def action_name
      'RenameTable'
    end

    def file_suffix
      props.map do |item|
        item.split(':')[0]
      end.join('_and_')
    end

    def build_change_sets
      set = Liquigen::ChangeSet.new

      props.each do |kv|
        kv = kv.split(':')
        change = Liquigen::RenameTable.new(kv[0], kv[1])
        set.changes << change
      end

      sets << set
    end
  end
end

module Liquigen
  class ChangeSet
    attr_accessor :id
    attr_accessor :name
    attr_accessor :changes

    def initialize
      self.id = Time.new.strftime('%Y%m%d%H%M')
      # todo Get the current git config name
      self.name = 'Jeremy'
      self.changes = []
    end
  end
end

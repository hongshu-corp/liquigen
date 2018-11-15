module Liquigen
  class ChangeSet
    attr_accessor :id
    attr_accessor :author
    attr_accessor :changes

    def initialize
      self.id = Time.new.strftime('%Y%m%d%H%M%S')
      # todo Get the current git config name
      self.author = 'Jeremy'
      self.changes = []
    end
  end
end

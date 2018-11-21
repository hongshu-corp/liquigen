module Liquigen
  class ChangeSet
    attr_accessor :id
    attr_accessor :author
    attr_accessor :changes

    def initialize(file_name)
      self.id = file_name
      self.author = current_git_user
      self.changes = []
    end

    def current_git_user
      author = ''
      IO.popen('git config -l | grep user.name') { |x| author = x.gets }
      author = author.gsub(/user.name=(\w*)/, '\1').strip || 'yourname'
    end
  end
end

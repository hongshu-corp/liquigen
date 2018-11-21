module Liquigen
  class ChangeSet
    attr_accessor :id
    attr_accessor :author
    attr_accessor :changes

    def initialize(file_name)
      self.id = file_name
      self.author = "#{git_user} <#{git_email}>"
      self.changes = []
    end

    def git_user
      author = ''
      IO.popen('git config -l | grep user.name') { |x| author = x.gets }
      author = author.gsub(/user.name=(\w*)/, '\1').strip || 'yourname'
    end

    def git_email
      email = []
      IO.popen('git config -l | grep user.email') { |x| email = x.gets }
      email = email.gsub(/user.email=(\w*)/, '\1').strip
    end
  end
end

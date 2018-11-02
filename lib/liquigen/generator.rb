require 'liquigen/version'
require 'liquigen/database_change_log'
require 'liquigen/create_table'
require 'liquigen/change_set'
require 'liquigen/change'
require 'liquigen/column'
require 'liquigen/constraint'
require 'liquigen/handler'

module Liquigen
  class Handler
    def add_table(name, props = {})
      log = DatabaseChangeLog.new
      change = log.init_with_create_table name
      props.each { |k, t| change.columns << build_column(k, t) }

      File.open(build_file_name(name), 'w+') do |file|
        file.write(log.to_yaml(indentation: 4))
      end
    end

    private

    def build_file_name(name)
      "#{Time.new.strftime('%Y%m%d%H%M')}CreateTable#{name.capitalize}.yaml"
    end

    def build_column(name, type)
      column = Column.new(name: name, type: type)

      constraint = Constraint.new
      if name == 'id'
        column.auto_increment = true
        constraint.primary_key = true
      else
        constraint.nullable = false
      end

      column.constraints << constraint
      column
    end
  end
end

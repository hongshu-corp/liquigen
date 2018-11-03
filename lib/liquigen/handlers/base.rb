require 'liquigen/database_change_log'
require 'liquigen/create_table'
require 'liquigen/change_set'
require 'liquigen/change'
require 'liquigen/column'
require 'liquigen/constraint'

module Liquigen::Handlers
  class Base
    attr_accessor :table
    attr_accessor :props
    attr_accessor :sets

    def initialize(table, props)
      self.table = table
      self.props = props
      self.sets = []
    end

    def process
      build_change_sets

      file_path = build_file_name
      File.open(file_path, 'w+') { |f| f.write(sets.to_yaml(indentation: 4)) }

      process_lines file_path
    end

    protected

    def action_name
      'liquigen'
    end

    def build_file_name
      "#{Time.new.strftime('%Y%m%d%H%M%S')}_#{action_name}#{table.capitalize}.yaml"
    end

    def process_lines(file_path)
      lines = read_lines_without_ruby_redundant_type file_path
      lines = remove_lines_with_empty_value lines
      lines = camelize_words lines

      File.open(file_path, 'w+') { |f| f.write(lines.join("\n")) }
    end

    def read_lines_without_ruby_redundant_type(file_path)
      lines = []
      File.readlines(file_path).each do |line|
        if line.include?('!ruby/object:Liquigen::')
          line = line.gsub '!ruby/object:Liquigen::', ''
          line = line.rstrip + ":\n"
        end
        lines << line.rstrip
      end
      lines[0] = 'databaseChangeLog:'
      lines << '' # make sure the last line is empty
      lines
    end

    def remove_lines_with_empty_value(lines)
      empty_marks = []
      lines.each_with_index do |line, index|
        parts = line.split(':')
        next if parts.size > 1
        next if line.include?('-')
        next if line.strip.size.zero?
        next if lines[index + 1].nil?

        empty_marks << index unless lines[index + 1].include?('-')
      end

      lines.select.with_index { |_, i| !empty_marks.include?(i) }
    end

    def camelize_words(lines)
      lines.map do |line|
        line.gsub(/[\w^:]+/) { |x| x.camelize(:lower) }
      end
    end
  end
end

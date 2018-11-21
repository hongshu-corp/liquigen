require 'liquigen/create_table'
require 'liquigen/change_set'
require 'liquigen/change'
require 'liquigen/column'
require 'liquigen/constraint'

require 'fileutils'

module Liquigen::Handlers
  class Base
    attr_accessor :table
    attr_accessor :props
    attr_accessor :sets

    attr_accessor :id

    def initialize(table, props)
      self.table = table
      self.props = props
      self.sets = []

      self.id = build_id
    end

    def process
      set = Liquigen::ChangeSet.new(id)
      build_one_changeset(set)
      sets << set

      file_path = build_file_name
      File.open(file_path, 'w+') { |f| f.write(sets.to_yaml(indentation: 4)) }

      process_lines file_path
    end

    protected

    def action_name
      'liquigen'
    end

    def file_suffix
      table.capitalize
    end

    def build_id
      "#{Time.new.strftime('%Y%m%d%H%M%S')}_#{action_name}_#{file_suffix}"
    end

    def build_file_name
      dir = 'src/main/resources/db/migrations'

      FileUtils.mkdir_p(dir)

      "#{dir}/#{id}.yaml"
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
          if line.include?('-')
            line = line.gsub '!ruby/object:Liquigen::', ''
          else
            line = line.split(':')[0]
          end
          line = line.rstrip + ':'
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

        current_blank = line.gsub(/^(\s+).*$/, '\1')
        next_blank = lines[index + 1].gsub(/^(\s+).*$/, '\1')

        valid = false
        valid = true if lines[index + 1].include?('-')
        valid = true if current_blank.size < next_blank.size

        empty_marks << index unless valid
      end

      lines.select.with_index { |_, i| !empty_marks.include?(i) }
    end

    def camelize_words(lines)
      lines.map do |line|
        left = line.gsub(/^(.*?):.*$/, '\1')
        right = line.gsub(/^.*?(:.*)$/, '\1')
        left.gsub(/[\w^:]+/) { |x| x.camelize(:lower) } + right
      end
    end
  end
end

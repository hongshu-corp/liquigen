module Liquigen::Scaffold
  class Base
    attr_accessor :name
    attr_accessor :props

    def initialize(name, props)
      self.name = name
      self.props = props
    end

    def process
      file = "#{directory}/#{file_name}"
      return if File.exist? file

      lines = []
      lines += import_lines
      lines += []
      lines += class_lines
      lines += []
      lines += methods_lines
      lines += ['}']

      File.open(file, 'w') do |f|
        f.write lines.join("\n")
      end
    end

    def current_package
      Liquigen.package_name
    end

    def directory
      "#{Liquigen.java_codes_root}/#{current_package.split('.').join('/')}"
    end

    def file_name
      "#{name.singularize.camelize}#{file_append}.java"
    end

    def file_append
      ''
    end

    def write_lines(file, lines = [])
      file.write lines.join("\n")
      file.write("\n")
    end

    def import_lines
      []
    end

    def class_lines
      []
    end

    def methods_lines
      []
    end
  end
end

require 'liquigen/type_map'

module Liquigen::Scaffold
  class Entity < Base
    def current_package
      Liquigen.entity_package_name
    end

    def import_lines
      [
        "package #{current_package};",
        'import lombok.Data;',
        'import lombok.experimental.Accessors;',
        '',
        'import javax.persistence.Entity;',
        ''
      ]
    end

    def class_lines
      [
        "@Entity(name = \"#{name.underscore.pluralize}\")",
        '@Data',
        '@Accessors(chain = true)',
        "public class #{name.singularize.camelize} extends FakeDeleteBaseEntity {"
      ]
    end

    def methods_lines
      lines = []
      skip_ones = %w[id created_time updated_time]
      props.map do |property|
        key, value = property.split(':')
        next if skip_ones.include?(key.underscore)

        lines += ["private #{Liquigen::TypeMap.new(value).java_type} #{key.camelize(:lower)};",
                  '']
      end
    end
  end
end

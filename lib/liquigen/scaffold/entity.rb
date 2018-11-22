require 'liquigen/type_map'

module Liquigen::Scaffold
  class Entity < Base
    def current_package
      Liquigen.entity_package_name
    end

    def import_lines
      [
        "package #{current_package};",
        'import com.fasterxml.jackson.annotation.*;',
        'import com.fasterxml.jackson.databind.annotation.JsonDeserialize;',
        'import lombok.Getter;',
        'import lombok.Setter;',
        'import lombok.experimental.Accessors;',
        'import javax.persistence.*;',
        'import java.util.List;',
        ''
      ]
    end

    def class_lines
      [
        '@Entity',
        '@Getter',
        '@Setter',
        '@Accessors(chain = true)',
        "@Table(name = \"#{name.underscore.pluralize}\")",
        "public class #{name.singularize.camelize} extends ModelBase {"
      ]
    end

    def methods_lines
      lines = []
      skip_ones = %w[id created_time updated_time]
      props.map do |property|
        key, value = property.split(':')
        next if skip_ones.include?(key.underscore)

        lines += [
                    '@Column(nullable = false)',
                    '@JsonProperty',
                    "private #{Liquigen::TypeMap.new(value).java_type} #{key.camelize};",
                    ''
                  ]
      end
    end
  end
end

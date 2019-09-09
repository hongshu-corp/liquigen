require 'liquigen/type_map'

module Liquigen::Scaffold
  class Entity < Base
    def current_package
      Liquigen.entity_package_name
    end

    def import_lines
      [
        "package #{current_package};",
        'import com.dyg.entity.FakeDeleteBaseEntity;',
        'import lombok.Getter;',
        'import lombok.Setter;',
        'import lombok.experimental.Accessors;',
        '',
        'import javax.persistence.Entity;',
        'import javax.persistence.OneToOne;',
        'import javax.persistence.OneToMany;',
        'import javax.persistence.ManyToMany;',
        ''
      ]
    end

    def class_lines
      [
        '@Entity',
        "@Table(name = \"#{name.underscore.pluralize}\")",
        '@Getter',
        '@Setter',
        '@Accessors(chain = true)',
        "public class #{name.singularize.camelize} extends FakeDeleteBaseEntity {"
      ]
    end

    def methods_lines
      lines = []
      skip_ones = %w[id created_at updated_at available]
      props.each do |property|
        key, value = property.to_s.split(':')
        next if skip_ones.include?(key.underscore)

        lines += [
          '//@OneToOne',
          "private #{Liquigen::TypeMap.new(value).java_type} #{key.camelize(:lower)};",
          ''
        ]
      end
      lines
    end
  end
end

require 'liquigen/type_map'

module Liquigen::Scaffold
  class Permit < Base
    def current_package
      Liquigen.permit_package_name
    end

    def directory
      "#{Liquigen.libs_root}/#{current_package.split('.').join('/')}"
    end

    def import_lines
      [
        "package #{current_package};",
        '',
        'import com.github.leeonky.map.Action;',
        'import com.github.leeonky.map.Permit;',
        '',
        'import java.math.BigDecimal;',
        ''
      ]
    end

    def class_lines
      [
        "public class #{name.singularize.camelize} {",
      ]
    end

    def methods_lines
      lines = [
        "@Permit(target = com.dyg.entity.#{name.singularize.camelize}.class, action = Action.Update.class)",
        'public class Update {'
      ]
      skip_ones = %w[id created_at updated_at available]
      props.each do |property|
        key, value = property.to_s.split(':')
        next if skip_ones.include?(key.underscore)

        lines += [
          "public #{Liquigen::TypeMap.new(value).java_type} #{key.camelize(:lower)};",
          ''
        ]
      end

      lines += [
        '}',
        "@Permit(target = com.dyg.entity.#{name.singularize.camelize}.class, action = Action.Create.class)",
        'public class Create extends Update {',
        '}'
      ]
      lines
    end
  end
end

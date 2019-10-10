module Liquigen::Scaffold
  class Schema < Base
    def directory
      Liquigen.cucumber_schema_path
    end

    def current_package
      Liquigen.cucumber_schema_package_name
    end

    def import_lines
      [
        "package #{current_package};",
        '',
        'import com.dyg.entity;',
        'import com.github.leeonky.dal.format.Formatters;',
        ''
      ]
    end

    def class_lines
      [
        "public class #{name.singularize.camelize}#{file_append} {"
      ]
    end

    def methods_lines
      lines = [
        'public static class Simple extends Schemas.IdAndTime {',
        ''
      ]
      skip_ones = %w[id created_at updated_at available]
      props.each do |property|
        key, value = property.to_s.split(':')
        next if skip_ones.include?(key.underscore)

        lines += [
          "#{Liquigen::TypeMap.new(value).java_type} #{key.camelize(:lower)};",
          "//Formatters.Number #{key.camelize(:lower)};",
          "//Schemas.IdAndName #{key.camelize(:lower)};",
          ''
        ]
      end
      lines += [
        '}',
        '',
        'public static class Detail extends Simple {',
        '}'
      ]
      lines
    end
  end
end

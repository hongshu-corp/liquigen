require 'liquigen/type_map'

module Liquigen::Scaffold
  class Vo < Base
    def current_package
      Liquigen.vo_package_name
    end

    def directory
      "#{Liquigen.libs_root}/#{current_package.split('.').join('/')}"
    end

    def import_lines
      [
        "package #{current_package};",
        '',
        'import com.dyg.base.rest.QiniuResources;',
        'import com.fasterxml.jackson.databind.annotation.JsonSerialize;',
        'import com.github.leeonky.map.MappingFrom;',
        'import com.github.leeonky.map.MappingView;',
        'import com.github.leeonky.map.View;',
        '',
        'import java.math.BigDecimal;',
        ''
      ]
    end

    def class_lines
      [
        "@MappingFrom(com.dyg.entity.#{name.singularize.camelize}.class)",
        "public class #{name.singularize.camelize} {"
      ]
    end

    def methods_lines
      lines = [
        '@MappingView(View.Simple.class)',
        'public static class Simple extends ViewObjects.BaseEntity {'
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
        '@MappingView(View.Detail.class)',
        'public static class Detail extends Simple {',
        '}'
      ]
      lines
    end
  end
end

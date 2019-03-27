require 'liquigen/type_map'

module Liquigen::Scaffold
  class Schema < Base
    def current_package
      Liquigen.schema_package_name
    end

    def import_lines
      [
        "package #{current_package};",
        '',
        'import com.dyg.backend.config.Constants;',
        'import com.dyg.schemas.*;',
        'import lombok.Getter;',
        'import lombok.Setter;',
        '',
        'import java.util.Date;'
      ]
    end

    def class_lines
      [
        "@Getter",
        '@Setter',
        "@PresentationSchema(name = \"#{name.singularize}\")",
        "public class #{name.singularize.camelize} {"
      ]
    end

    def methods_lines
      lines = []
      skip_ones = %w[id created_at updated_at]
      lines += [
        '@PresentationField(primary = true, i18nKey = Constants.I18nCommon.Property.ID, type = FieldType.Number)',
        '@PresentationColumn(type = ColumnType.LinkShow, width = "50px")',
        '@PresentationDetailField',
        'private Long id;',
        ''
      ]
      props.each do |property|
        key, value = property.to_s.split(':')
        next if skip_ones.include?(key.underscore)
        next if key.casecmp('available').zero?

        type = Liquigen::TypeMap.new(value).java_type
        stype = Liquigen::TypeMap.new(value).statement_type

        if (stype && !stype.size.zero?)
          lines += ["@PresentationField(type = FieldType.#{stype})"]
        else
          lines += ["@PresentationField//(i18nKey = Constants.I18nCommon.Property.#{key.upcase})"]
        end

        lines += [
          '@PresentationColumn',
          '@PresentationFormField(rules = { @PresentationRule(required = true) })',
          '@PresentationDetailField',
          '//@PresentationSearchField',
          "private #{type} #{key.camelize(:lower)};",
          ''
        ]
      end

      lines += [
        '@PresentationField(type = FieldType.Datetime, i18nKey = Constants.I18nCommon.Property.CREATED_AT)',
        '@PresentationColumn(width = "140px")',
        '@PresentationDetailField',
        'private Date createdAt;',
        '',
        '@PresentationField(type = FieldType.Datetime, i18nKey = Constants.I18nCommon.Property.UPDATED_AT)',
        '@PresentationColumn(width = "140px")',
        '@PresentationDetailField',
        'private Date updatedAt;'
      ]
      lines
    end
  end
end

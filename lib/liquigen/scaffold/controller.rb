module Liquigen::Scaffold
  class Controller < Base
    def current_package
      Liquigen.controller_package_name
    end

    def file_append
      'Controller'
    end

    def file_name
      "#{name.pluralize.camelize}#{file_append}.java"
    end

    def import_lines
      [
        "package #{current_package};",
        '',
        'import com.dyg.backend.controller.auth.HasPermissionOrRoot;',
        'import com.dyg.base.rest.controller.RestCRUD;',
        'import lombok.Getter;',
        'import org.springframework.web.bind.annotation.RequestMapping;',
        'import org.springframework.web.bind.annotation.RestController;',
        ''
      ]
    end

    def class_lines
      [
        '@RestController',
        "@RequestMapping(\"/#{name.underscore.pluralize}\")",
        '@HasPermissionOrRoot',
        "public class #{name.pluralize.camelize}#{file_append} implements RestCRUD<#{name.singularize.camelize}> {"
      ]
    end

    def permit_params
      lines = []
      skip_ones = %w[id created_at updated_at available]
      props.each do |property|
        key, value = property.to_s.split(':')
        next if skip_ones.include?(key.underscore)

        lines += ["\"#{key.camelize(:lower)}\""]
      end
      lines
    end
  end
end

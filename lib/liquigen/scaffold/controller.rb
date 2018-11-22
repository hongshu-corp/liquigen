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
        "import #{Liquigen.entity_package_name}.#{name.singularize.camelize};",
        "import #{Liquigen.repository_package_name}.#{name.camelize}Repository;",
        'import org.springframework.beans.factory.annotation.Autowired;',
        'import org.springframework.web.bind.annotation.RequestMapping;',
        'import org.springframework.web.bind.annotation.RestController;',
        ''
      ]
    end

    def class_lines
      [
        '@RestController',
        "@RequestMapping(\"/#{name.underscore.pluralize}\")",
        "public class #{name.pluralize.camelize}#{file_append} extends ControllerBase<#{name.singularize.camelize}, #{name.singularize.camelize}Repository> {"
      ]
    end

    def methods_lines
      [
        '@Autowired',
        "public #{name.pluralize.camelize}#{file_append}(#{name.singularize.camelize}Repository repository) {",
        'this.repository = repository;',
        '}'
      ]
    end
  end
end

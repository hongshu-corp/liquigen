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
        'import com.dyg.lib.rest.controller.RestCRUD;',
        'import com.dyg.main.controller.auth.HasPermissionOrRoot;',
        "import #{Liquigen.repository_package_name}.#{name.singularize.camelize}Repo;",
        'import lombok.Getter;',
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
        '@HasPermissionOrRoot',
        "public class #{name.pluralize.camelize}#{file_append} implements RestCRUD {"
      ]
    end

    def methods_lines
      [
        '',
        '@Autowired',
        '@Getter',
        "private #{name.singularize.camelize}Repo entityRepository;",
        ''
      ]
    end
  end
end

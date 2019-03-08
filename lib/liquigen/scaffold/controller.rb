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
        'import com.dyg.lib.rest.controller.Create;',
        'import com.dyg.lib.rest.controller.Delete;',
        'import com.dyg.lib.rest.controller.Read;',
        'import com.dyg.lib.rest.controller.Update;',
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
        "public class #{name.pluralize.camelize}#{file_append} implements Create, Read.Index, Read.Show, Update, Delete {"
      ]
    end

    def methods_lines
      [
        'private final static Object[] PERMIT_PARAMS = {"name"};',
        '',
        '@Autowired',
        '@Getter',
        "private #{name.singularize.camelize}Repo entityRepository;",
        '',
        '@Override',
        'public Object[] createPermit() { return PERMIT_PARAMS; }',
        '',
        '@Override',
        'public Object[] updatePermit() { return PERMIT_PARAMS; }'
      ]
    end
  end
end

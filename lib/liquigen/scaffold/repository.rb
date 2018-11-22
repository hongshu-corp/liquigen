module Liquigen::Scaffold
  class Repository < Base
    def current_package
      Liquigen.repository_package_name
    end

    def file_append
      'Repository'
    end

    def import_lines
      [
        "package #{current_package};",
        "import #{Liquigen.entity_package_name}.#{name.singularize.camelize};",
        'import org.springframework.stereotype.Repository;',
        ''
      ]
    end

    def class_lines
      [
        '@Repository',
        "public interface #{name.singularize.camelize}#{file_append} extends IRepository<#{name.singularize.camelize}, Long> {"
      ]
    end

    def methods_lines
      []
    end
  end
end

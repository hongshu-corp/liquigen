module Liquigen::Scaffold
  class Repository < Base
    def current_package
      Liquigen.repository_package_name
    end

    def file_append
      Liquigen.repository_suffix
    end

    def import_lines
      [
        "package #{current_package};",
        'import com.dyg.lib.rest.repository.EntityRepository;',
        "import com.dyg.main.entity.#{name.singularize.camelize};",
        ''
      ]
    end

    def class_lines
      [
        "public interface #{name.singularize.camelize}#{file_append} extends EntityRepository<#{name.singularize.camelize}, Long> {"
      ]
    end

    def methods_lines
      []
    end
  end
end

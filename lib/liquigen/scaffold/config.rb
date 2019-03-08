module Liquigen::Scaffold
  CONFIG_FILE = '.liquigen'.freeze
  class Config
    # write config file
    def process
      # if not exist the .liquigen file create it
      File.write(CONFIG_FILE, prepare_default_content.join("\n")) unless File.exist?(CONFIG_FILE)

      # then open the vim editor
      system('vi ' + CONFIG_FILE)
    end

    def prepare_default_content
      contents = []
      contents << '# You can remove the # to set your custom value'
      contents << '# package_name=your-package-name, required'
      contents << '# java_codes_root=src/main/java'
      contents << '# migration_path=src/main/resources/db/migrations'
      contents << '# controller_package_name='
      contents << '# entity_package_name='
      contents << '# repository_package_name='
      contents << '# repository_suffix=Repository'
      contents << ''
    end
  end
end

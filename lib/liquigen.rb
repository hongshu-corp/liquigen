require 'liquigen/version.rb'

require 'active_support'
require 'active_support/inflector'

require 'liquigen/create_table'
require 'liquigen/add_column'
require 'liquigen/rename_table'
require 'liquigen/modify_data_type'
require 'liquigen/rename_column'
require 'liquigen/sql'
require 'liquigen/create_index'
require 'liquigen/drop_table'

require 'liquigen/change_set'
require 'liquigen/change'
require 'liquigen/column'
require 'liquigen/constraint'

require 'liquigen/handlers/base'
require 'liquigen/handlers/create_table'
require 'liquigen/handlers/add_column'
require 'liquigen/handlers/rename_table'
require 'liquigen/handlers/change_type'
require 'liquigen/handlers/rename_column'
require 'liquigen/handlers/sql'
require 'liquigen/handlers/add_index'
require 'liquigen/handlers/drop_table'

require 'liquigen/scaffold/config'
require 'liquigen/scaffold/base'
require 'liquigen/scaffold/controller'
require 'liquigen/scaffold/entity'
require 'liquigen/scaffold/schema'
require 'liquigen/scaffold/feature'
require 'liquigen/scaffold/permit'
require 'liquigen/scaffold/vo'

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file

module Liquigen
  class << self
    attr_accessor :package_name
    # default value: #{package_name}.controller
    attr_accessor :controller_package_name
    # default value: #{package_name}.model
    attr_accessor :entity_package_name
    # default value: #{package_name}.permit
    attr_accessor :permit_package_name
    # default value: #{package_name}.statements
    attr_accessor :schema_package_name
    # default value: #{package_name}.vo
    attr_accessor :vo_package_name
    # default value:
    attr_accessor :libs_root
    # default value: src/main/java
    attr_accessor :java_codes_root
    # default value: src/main/resources/db/migrations
    attr_accessor :migration_path
    # default value: src/test/resources/features/domain
    attr_accessor :feature_path
    # default value: src/main/java/com/service/cucumber/schema
    attr_accessor :cucumber_schema_path
    # default value: #{package_name}.cucumber.schema
    attr_accessor :cucumber_schema_package_name

    def load_default
      self.package_name ||= 'com.package'
      self.controller_package_name ||= "#{package_name}.controller"
      self.libs_root ||= 'libs/service/src/main/java'
      self.entity_package_name ||= "#{package_name}.model"
      self.permit_package_name ||= "#{package_name}.permit"
      self.vo_package_name ||= "#{package_name}.vo"
      self.cucumber_schema_package_name ||= "#{package_name}.cucumber.schema"
      self.java_codes_root ||= 'src/main/java'
      self.migration_path ||= 'src/main/resources/db/migrations'
      self.feature_path ||= 'src/test/resources/features/domain'
      self.cucumber_schema_path ||= 'src/main/java/com/service/cucumber/schema'
    end

    def load
      load_lines File.readlines(Liquigen::Scaffold::CONFIG_FILE) if File.exist?(Liquigen::Scaffold::CONFIG_FILE)

      load_default
    end

    def load_lines(lines)
      lines.each do |line|
        next if line.strip.start_with? '#'
        next if line.strip.size.zero?

        assignment = line.split('=')
        name = "#{assignment[0]&.strip}="

        Liquigen.send(name, assignment[1]&.strip) if Liquigen.singleton_methods.include?(name.to_sym)
      end
    end
  end
end

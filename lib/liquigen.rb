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

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file

module Liquigen
  class << self
    attr_accessor :package_name
    # default value: #{package_name}.controller
    attr_accessor :controller_package_name
    # default value: #{package_name}.model
    attr_accessor :entity_package_name
    # default value: #{package_name}.repository
    attr_accessor :repository_package_name
    # default value: src/main/java
    attr_accessor :java_codes_root
    # default value: src/main/resources/db/migrations
    attr_accessor :migration_path
  end
end
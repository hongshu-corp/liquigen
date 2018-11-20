require 'liquigen/version.rb'

require 'active_support'
require 'active_support/inflector'

require 'liquigen/create_table'
require 'liquigen/rename_table'
require 'liquigen/change_set'
require 'liquigen/change'
require 'liquigen/column'
require 'liquigen/constraint'
require 'liquigen/handlers/base'
require 'liquigen/handlers/create_table'
require 'liquigen/handlers/rename_table'

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file
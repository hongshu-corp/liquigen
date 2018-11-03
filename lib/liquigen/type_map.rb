module Liquigen
  class TypeMap
    attr_accessor :rails_type
    attr_accessor :map

    def set_map
      # Only for mysql
      # http://blog.ifyouseewendy.com/blog/2015/08/10/data-types-in-rails/
      self.map = {
        integer: 'bigint',
        string: 'varchar(255)',
        text: 'text',
        float: 'float',
        decimal: 'decimal',
        datetime: 'datetime',
        binary: 'blob',
        boolean: 'tinyint(1)'
      }
    end

    def initialize(type)
      self.rails_type = type
      set_map
    end

    def db_type
      map[rails_type.to_sym]
    end
  end
end

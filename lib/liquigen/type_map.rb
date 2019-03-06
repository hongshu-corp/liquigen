module Liquigen
  class TypeMap
    attr_accessor :rails_type
    attr_accessor :map
    attr_accessor :java_map

    def set_map
      # Only for mysql
      # http://blog.ifyouseewendy.com/blog/2015/08/10/data-types-in-rails/
      self.map = {
        integer: 'bigint',
        long: 'bigint',
        string: 'varchar(255)',
        text: 'text',
        float: 'float',
        decimal: 'decimal',
        datetime: 'datetime',
        binary: 'blob',
        boolean: 'boolean'
      }

      self.java_map = {
        integer: 'Long',
        long: 'Long',
        string: 'String',
        text: 'String',
        float: 'Float',
        decimal: 'BigDecimal',
        datetime: 'Date',
        binary: 'Object',
        boolean: 'boolean'
      }
    end

    def initialize(type)
      self.rails_type = type
      set_map
    end

    def db_type
      map[rails_type.to_sym]
    end

    def java_type
      java_map[rails_type.to_sym]
    end
  end
end

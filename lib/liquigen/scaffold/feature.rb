module Liquigen::Scaffold
  class Feature < Base
    def directory
      Liquigen.feature_path
    end

    def file_name
      "#{name.pluralize.camelize}.feature"
    end

    def import_lines
      [
        '# language: zh-CN',
        '功能: CRUD',
        '',
        '  背景:',
        '    假如这里有一座金山',
        '',
        '',
        '  场景: 假如还有一辆挖掘机',
        '    当挖金子的时候',
        '',
        '',
        ''
      ]
    end
  end
end

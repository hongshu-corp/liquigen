require 'spec_helper'

RSpec.describe Liquigen::Handler, type: :model do
  let(:handler) { Liquigen::Handler.new 'User', 'id: integer' }

  let(:source) {
    'databaseChangeLog:
- ChangeSet:
    id: 201811031330
    name: Jeremy
    changes:
    - CreateTable:
        table_name: user
        columns:
        - Column:
            name: id
            type:
            constraints:
            - Constraint:
                nullable: false
                primary_key:

      '
    }
  describe '#remove_empty' do
    let(:lines) { source.split("\n") }
    subject { handler.send(:remove_empty, lines) }

    it 'should remove the lines which contains empty value' do
      ret = subject

      expect(ret.size).to eq 15
    end
  end

  describe '#camelize' do
    let(:source) {
      '- ChangeSet:
    id: 201811031330
    name: Jeremy
    changes:
    - CreateTable
      table_name: user

'
    }
    let(:lines) { source.split("\n") }

    it 'should camelize the lines' do
      ret = handler.send(:camelize_lines, lines)
      expect(ret[ret.size - 1]).to eq '      tableName: user'
    end
  end
end

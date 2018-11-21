require 'spec_helper'

RSpec.describe Liquigen::Handlers::CreateTable, type: :model do
  let(:handler) { described_class.new 'User', 'id: integer' }

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
                primary_key:
                nullable: false

      '
    }
  describe '#remove_empty' do
    let(:lines) { source.split("\n") }
    subject { handler.send(:remove_lines_with_empty_value, lines) }

    it 'should remove the lines which contains empty value' do
      ret = subject

      expect(ret.size).to eq 14
    end
  end

  describe '#camelize' do
    let(:source) {
      '- ChangeSet:
    id: 201811031330
    name: Jeremy
    changes:
    - RenameTable:
      old_table_name: users
      new_table_name: s_users
    - CreateTable:
      table_name: user

'
    }
    let(:lines) { source.split("\n") }

    it 'should camelize the lines' do
      ret = handler.send(:camelize_words, lines)
      expect(ret[ret.size - 1]).to eq '      tableName: user'
    end

    describe 'Should only process the key part' do
      let(:source) { ' new_table_name: s_users'}

      it 'should only process the key part' do
        ret = handler.send(:camelize_words, lines)
        expect(ret[ret.size - 1]).to eq ' newTableName: s_users'
      end
    end
  end

  describe '#id' do
    specify { expect(handler.id).not_to eq '' }
  end
end

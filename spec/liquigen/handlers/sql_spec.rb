require 'spec_helper'

RSpec.describe Liquigen::Handlers::Sql, type: :model do
  let(:props) { ['update users set x = 1', 'update customers set x = 2'] }
  let(:handler) { described_class.new props }

  describe '#action_name' do
    specify { expect(handler.action_name).to eq 'Sql' }
  end

  describe '#file_suffix' do
    specify { expect(handler.file_suffix).to eq 'With2Clauses' }
  end

  describe '#id' do
    specify { expect(handler.id).not_to eq '' }
  end
end

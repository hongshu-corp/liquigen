require 'spec_helper'

RSpec.describe Liquigen::Handlers::RenameTable, type: :model do
  let(:props) { ['user:s_users', 'customer:s_customers'] }
  let(:handler) { described_class.new props }

  describe '#action_name' do
    specify { expect(handler.action_name).to eq 'RenameTable' }
  end

  describe '#file_suffix' do
    specify { expect(handler.file_suffix).to eq 'UserAndCustomer' }
  end

  describe '#id' do
    specify { expect(handler.id).not_to eq '' }
  end
end

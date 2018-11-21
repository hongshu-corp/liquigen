require 'spec_helper'

RSpec.describe Liquigen::Handlers::RenameColumn, type: :model do
  let(:props) { ['user:status:status_ok:string', 'customer:status:status_ok:string'] }
  let(:handler) { described_class.new props }

  describe '#action_name' do
    specify { expect(handler.action_name).to eq 'RenameColumn' }
  end

  describe '#file_suffix' do
    specify { expect(handler.file_suffix).to eq 'UserStatusToStatusOkAndCustomerStatusToStatusOk' }
  end

  describe '#id' do
    specify { expect(handler.id).not_to eq '' }
  end
end

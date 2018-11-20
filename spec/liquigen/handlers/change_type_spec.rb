require 'spec_helper'

RSpec.describe Liquigen::Handlers::ChangeType, type: :model do
  let(:props) { ['user:id:string', 'customer:name:text'] }
  let(:handler) { described_class.new props }

  describe '#action_name' do
    specify { expect(handler.action_name).to eq 'ChangeType' }
  end

  describe '#file_suffix' do
    specify { expect(handler.file_suffix).to eq 'UserAndCustomer' }

  end
end

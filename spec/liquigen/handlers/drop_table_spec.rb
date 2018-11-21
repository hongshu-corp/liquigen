require 'spec_helper'

RSpec.describe Liquigen::Handlers::DropTable, type: :model do
  let(:props) { %w[user customer] }
  let(:handler) { described_class.new props }

  describe '#action_name' do
    specify { expect(handler.action_name).to eq 'DropTable' }
  end

  describe '#file_suffix' do
    specify { expect(handler.file_suffix).to eq 'UserAndCustomer' }
  end

  describe '#id' do
    specify { expect(handler.id).not_to eq '' }
  end
end

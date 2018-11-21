require 'spec_helper'

RSpec.describe Liquigen::Handlers::AddIndex, type: :model do
  let(:props) { ['name:string', 'email:string'] }
  let(:handler) { described_class.new 'user', props }

  describe '#action_name' do
    specify { expect(handler.action_name).to eq 'AddIndex' }
  end

  describe '#file_suffix' do
    specify { expect(handler.file_suffix).to eq 'OnUser_NameAndEmail' }
  end

  describe '#id' do
    specify { expect(handler.id).not_to eq '' }
  end
end

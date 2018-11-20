require 'spec_helper'

RSpec.describe Liquigen::ChangeSet, type: :model do
  let(:change_set) { described_class.new }

  describe '#current git user' do
    let(:author) { 'Jeremy Cui' }
    specify { expect(change_set.author).to eq author }
  end
end
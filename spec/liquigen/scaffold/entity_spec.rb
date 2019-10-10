require 'spec_helper'

RSpec.describe Liquigen::Scaffold::Entity, type: :model do
  let(:name) { 'user' }
  let(:props) { ['id:integer', 'name:string'] }
  let(:package) { 'com.hongshu.io.entity' }

  before do
    Liquigen.libs_root = 'src/main/java'
    allow_any_instance_of(Liquigen::Scaffold::Entity).to receive(:current_package).and_return(package)
  end

  let(:entity) { described_class.new name, props }

  describe '#location' do
    specify { expect(entity.directory).to eq 'src/main/java/com/hongshu/io/entity' }
  end

  describe '#filename' do
    specify { expect(entity.file_name).to eq 'User.java' }
  end

  describe '#method_lines' do
    let(:props) { ['name:string', 'nickname:string'] }
    let(:result) { entity.methods_lines.reject { |x| x.length.zero? } }
    specify { expect(result.size).to eq props.size * 2 }
  end
end

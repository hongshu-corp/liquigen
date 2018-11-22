require 'spec_helper'

RSpec.describe Liquigen do
  describe 'module variable' do
    let(:package_name) { 'com.liquigen.example' }
    before { Liquigen.package_name = package_name }
    specify { expect(Liquigen.package_name).to eq package_name }
  end

  describe '#load_lines' do
    let(:lines) do
      [
        'package_name=com.hongshu.io',
        'java_codes_root=src/main/java',
        ''
      ]
    end

    before { Liquigen.load_lines lines }
    before { Liquigen.load_default }
    specify { expect(Liquigen.package_name).to eq('com.hongshu.io') }
    specify { expect(Liquigen.controller_package_name).to eq('com.hongshu.io.controller') }
    specify { expect(Liquigen.java_codes_root).to eq('src/main/java') }
  end
end

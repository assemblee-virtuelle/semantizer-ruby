# frozen_string_literal: true

describe VirtualAssembly::Semantizer::SemanticProperty do
  it 'has a name' do
    property = described_class.new('http://example.net/property5')
    expect(property.name).to eq 'http://example.net/property5'
  end

  it 'stores a getter' do
    property = described_class.new('@id') { 'person/42' }
    expect(property.value).to eq 'person/42'
  end
end

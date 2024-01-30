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

  it 'can store a setter' do
    weather = "rain"

    property = described_class.new("weather") { weather }
    property.valueSetter = -> (value) { weather = value }

    expect { property.value = "sunshine" }
      .to change { property.value }
      .from("rain").to("sunshine")
  end

  it 'can be compared' do
    green = described_class.new("colour") { "green" }
    green_colour = described_class.new("colour") { "green" }
    green_grass = described_class.new("ground_type") { "green" }
    purple = described_class.new("colour") { "purple" }

    expect(green).to eq green_colour
    expect(green).to_not eq green_grass
    expect(green).to_not eq purple
    expect(green).to_not eq nil
  end
end

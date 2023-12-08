# frozen_string_literal: true

describe VirtualAssembly::Semantizer::SemanticObject do
  subject(:object) do
    Class.new(Object) do
      include VirtualAssembly::Semantizer::SemanticObject
    end.new
  end
  let(:other_clazz) do
    Class.new(Object) do
      include VirtualAssembly::Semantizer::SemanticObject
    end
  end

  it 'has a semantic id' do
    expect { object.semanticId = 'five' }
      .to change { object.semanticId }.from(nil).to('five')
  end

  it 'has semantic properties' do
    expect(object.hasSemanticProperty?('@id')).to eq true
  end

  it 'allow to register properties' do
    property = subject.registerSemanticProperty('smokes')
    expect(property.name).to eq 'smokes'
  end

  it 'allows to access properties' do
    object.semanticId = 'five'

    expect { object.semanticProperty('@id').value = 'six' }
      .to change { object.semanticPropertyValue('@id') }.from('five').to('six')
  end

  it 'can be compared' do
    expect(object).to eq object.clone
    expect(object).to eq other_clazz.new

    expect(object).to_not eq other_clazz.new("id5")
    expect(object).to_not eq other_clazz.new(nil, "typeA")

    object.semanticId = "id5"
    object.semanticType = "typeA"

    expect(object).to eq other_clazz.new("id5", "typeA")

    expect(object).to_not eq other_clazz.new("id5")
    expect(object).to_not eq other_clazz.new(nil, "typeA")
  end
end

# frozen_string_literal: true

describe VirtualAssembly::Semantizer::SemanticObject do
  subject(:object) do
    Class.new(Object) do
      include VirtualAssembly::Semantizer::SemanticObject
    end.new
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
end

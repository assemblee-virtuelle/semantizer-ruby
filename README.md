# Virtual Assembly Semantizer

Semantizer lets you enhance your object model with semantic data without breaking existing code. Just include the `SemanticObject` module to get the ability to mark some properties of your object as "semantic". You can add to your object as any semantic properties as you want. These semantic properties can then be serialized to any output format, like JSON-LD.

This library was writen for the [Data Food Consortium](https://datafoodconsortium.org) project (DFC) which aims to provide interoperability between food supply chain platforms. We use the semantizer library inside our connector library to help developers to exchange JSON-LD data expressed with the DFC ontology.

## Get started
Lets take an example, with a simple Person class:

```RB
class Person

    attr_accessor :name

    def initialize(name)
        @name = name
    end

end
```

Include the `SemanticObject` module and add this two following lines at the end of the `initialize` method:
```RB
semanticType = "http://xmlns.com/foaf/0.1/Person"
registerSemanticProperty("http://xmlns.com/foaf/0.1/name") {self.name}
```

The Person class should now looks like:
```RB
require 'virtual_assembly/semantizer'

class Person

    include Semantizer::SemanticObject

    attr_accessor :name

    def initialize(name)
        @name = name
        semanticType = "http://xmlns.com/foaf/0.1/Person"
        registerSemanticProperty("http://xmlns.com/foaf/0.1/name") {self.name}
    end

end
```

Then you can serialize this object to a simple `Hash` object:
```RB
person = Person.new("John")
person.semanticId = "http://platform.example/John"
output = person.serialize(Semantizer::HashSerializer.new)
```

`puts(output)` will output:
```RB
{
  "@id" => "http://platform.example/John",
  "@type" => "http://xmlns.com/foaf/0.1/Person",
  "http://xmlns.com/foaf/0.1/name" => "John"
}
```

You can then use a library like [json-ld](https://github.com/ruby-rdf/json-ld) to add a semantic context like:
```RB
require 'json/ld'

context = JSON.parse(%({
    "@context": {
        "foaf": "http://xmlns.com/foaf/0.1/"
    }
}))['@context']

input = JSON.parse %([output])

puts JSON::LD::API.compact(input, context)
```

This will output a contextualized JSON-LD text:
```JSON
{
  "@context": {
    "foaf": "http://xmlns.com/foaf/0.1/"
  },
  "@id": "http://platform.example/John",
  "@type": "foaf:Person",
  "foaf:name": "John"
}
```
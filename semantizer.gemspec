Gem::Specification.new do |s|
  s.name        = "virtual_assembly-semantizer"
  s.version     = "1.0.3"
  s.summary     = "Semantizer"
  s.description = "A library to add linked data to your models"
  s.authors     = ["Maxime Lecoq"]
  s.email       = "maxime@lecoqlibre.fr"
  s.files       = ["lib/virtual_assembly/semantizer.rb", "lib/virtual_assembly/semantizer/semantic_property.rb", "lib/virtual_assembly/semantizer/semantic_object.rb", "lib/virtual_assembly/semantizer/hash_serializer.rb"]
  s.homepage    =
    "https://github.com/assemblee-virtuelle/semantizer-ruby/"
  s.license       = "MIT"

  s.add_runtime_dependency "json-ld", "~> 3.2", ">= 3.2.3"
end
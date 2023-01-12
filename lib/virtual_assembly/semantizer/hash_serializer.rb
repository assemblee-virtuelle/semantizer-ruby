# Copyright © 2023 Maxime Lecoq, <maxime@lecoqlibre.fr>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the “Software”), to deal in the Software without
# restriction, including without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.

# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# The HashSerializer turns all the semantic properties of a SemanticObject into a Hash.
#
# Lets consider the following SemanticObject with a single semantic property like:
# - name: "http://xmlns.com/foaf/0.1/name"
# - value: "John"
#
# The HashSerializer will return the following Hash:
# {"http://xmlns.com/foaf/0.1/name" => "John"}.
class VirtualAssembly::Semantizer::HashSerializer

    # This is the main method to begin the serialization.
    #
    # The subject should be a SemanticObject.
    def process(subject)
        result = {}

        # We iterate over all the semantic properties of the subject.
        subject.semanticProperties.each do |property|
            name = property.name
            value = property.value

            if (value == nil)
                next
            end

            # In case the property is a primitive, we simply get its value.
            if ([ String, Integer, Float, TrueClass, FalseClass ].include?(value.class))
                result[name] = value

            # In case the property is a SemanticObject, we get its semanticId 
            # or we process it if it is a blank node.
            elsif (value.class < VirtualAssembly::Semantizer::SemanticObject)
                if (value.isBlankNode?)
                    result[name] = process(value)
                else
                    result[name] = value.semanticId
                end

            # In case the property is an Array, we export each item.
            elsif (value.class == Array)
                result[name] = exportCollection(value)

            else 
                raise "The type of the property '" + name + "' is '" + value.class.to_s + "' but a primitive, a SemanticObject or an Array is required."
            end
        end
     
        return result;
    end

    private 
    
        # Serialize a collection of values.
        def exportCollection(values)
            collection = []

            if (!values.empty?)
                type = values.at(0).class

                # If the collection contains only primitives, we simply return it.
                if ([ String, Integer, Float, TrueClass, FalseClass ].include?(type))
                    collection = values

                # In case the collection contains SemanticObject we have to process 
                # the blank nodes or return the semantic id.
                elsif type < VirtualAssembly::Semantizer::SemanticObject
                    values.each do |item|
                        if (item.isBlankNode?)
                            collection.push(process(item))
                        else
                            collection.push(item.semanticId)
                        end
                    end
                else
                    raise "Elements of the collection are not primitive nor SemanticObject."
                end
            end

            return collection;
        end

end
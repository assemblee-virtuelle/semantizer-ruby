# frozen_string_literal: true

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

require 'virtual_assembly/semantizer/semantic_property'

# The SemanticObject module is designed to add linked data
# to classical objects.
#
# A semanticObject holds semantic properties (SemanticProperty)
# that refers to linked data concepts.
#
# For example, a Person object including this module could register
# in its initializer method a semantic property for its name like:
# Person.registerSemanticProperty("http://xmlns.com/foaf/0.1/name") {self.name}
module VirtualAssembly
  module Semantizer
    module SemanticObject
      # The semantic ID implements the concept of linked data ID.
      #
      # This ID is an uri pointing to the location of the object
      # on the web like "https://mywebsite/myobject" for instance.
      #
      # If a SemanticObject doesn't define its ID, it
      # will be considered as a blank node.
      #
      # This should be a String or nil.
      attr_accessor :semanticId

      # The semantic type implements the concept of linked data type
      # (also called class).
      #
      # This type is an uri pointing to the location of the linked
      # data concept on the web like "http://xmlns.com/foaf/0.1/Person"
      # for instance.
      #
      # This should be a String or nil.
      attr_accessor :semanticType

      # If the semanticId is nil, the object will be treated as a blank node.
      def initialize(semanticId = nil, semanticType = nil)
        @semanticPropertiesMap = {}

        # Ensure to call the setter methods
        self.semanticId = semanticId
        self.semanticType = semanticType
      end

      # This Array stores the semantic properties of the object.
      # To append a SemanticProperty, use the dedicated
      # registerSemanticProperty method. You should pass the value
      # of the property as a block (callback) like so:
      # registerSemanticProperty("http://xmlns.com/foaf/0.1/name") {self.name}.
      def semanticProperties
        @semanticPropertiesMap.values
      end

      def hasSemanticProperty?(name)
        @semanticPropertiesMap.key?(name)
      end

      def isBlankNode?
        @semanticId.nil? || @semanticId == ''
      end

      # Given the name of the property, it returns the value
      # associated to a property of this object.
      def semanticPropertyValue(name)
        semanticProperty(name)&.value
      end

      # Given its name, returns the corresponding SemanticProperty
      # stored by this object or nil if the property does not exist.
      def semanticProperty(name)
        @semanticPropertiesMap[name]
      end

      # Use this method to append a semantic property to this object.
      # The value of the property should be passed as a block so its
      # value would be up to date when we will access it.
      def registerSemanticProperty(name, &valueGetter)
        createOrUpdateSemanticProperty(name, valueGetter)
      end

      # Sets the semantic id of the object and registers the
      # corresponding semantic property.
      #
      # The semantic ID implements the concept of linked data ID.
      #
      # This ID is an uri pointing to the location of the object
      # on the web like "https://mywebsite/myobject" for instance.
      #
      # If a SemanticObject doesn't define its ID, it
      # will be considered as a blank node.
      #
      # This should be a String or nil.
      def semanticId=(uri)
        @semanticId = uri
        property = registerSemanticProperty('@id') { semanticId }
        property.valueSetter = ->(value) { @semanticId = value }
      end

      # Sets the semantic type of the object and registers the
      # corresponding semantic property.
      #
      # The semantic type implements the concept of linked data type
      # (also called class).
      #
      # This type is an uri pointing to the location of the linked
      # data concept on the web like "http://xmlns.com/foaf/0.1/Person"
      # for instance.
      #
      # This should be a String or nil.
      def semanticType=(type)
        @semanticType = type
        property = registerSemanticProperty('@type') { semanticType }
        property.valueSetter = ->(value) { @semanticType = value }
      end

      # Serialize all the semantic properties of this object
      # to an output format.
      #
      # You could use the HashSerializer to export as a Hash.
      # This Hash should be then exported to JSON for instance.
      def serialize(serializer)
        serializer.process(self)
      end

      def ==(other)
        semanticProperties == other.semanticProperties
      end

      protected

      # If the semantic property already exist in this object, this
      # method will simply update the valueGetter of the property.
      #
      # If this object does not holds the property, the new property
      # will be added into the semanticProperties Array of this object.
      def createOrUpdateSemanticProperty(name, valueGetter)
        # Update
        if hasSemanticProperty?(name)
          property = semanticProperty(name)
          property&.valueGetter = valueGetter

        # Create
        else
          property = VirtualAssembly::Semantizer::SemanticProperty.new(name, &valueGetter)
          @semanticPropertiesMap[name] = property
        end
        property
      end
    end
  end
end

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

# The SemanticPropety class is designed to turn properties of 
# objects into linked data.
#
# A SemanticProperty has a name and a corresponding value that
# can be fetched later (so its value would be up to date).
#
# This class is intented to be used through the SemanticObject 
# class.
# 
# For instance, we can tell that the name of a Person object refers
# to the linked data concept "name" from the FOAF project. The name
# of the property would be the uri of the FOAF:name property while the
# value would be the attribute reader of the name of the Person object.
#
# You should use a block to pass the value like so:
# SemanticProperty.new("http://xmlns.com/foaf/0.1/name") {self.name}
class Semantizer::SemanticProperty

    # The name of the property. It generally points to an uri
    # like "http://xmlns.com/foaf/0.1/name" or it is used to 
    # define a reserved linked data property like "@id".
    #
    # This should be a String.
    attr_accessor :name

    # The function to call when the value is requested.
    #
    # This should be a Proc passed as a Block.
    attr_accessor :valueGetter

    # @param name The name of the property, like 
    # "http://xmlns.com/foaf/0.1/name" or "@id" for instance.
    #
    # @param valueGetter A Proc used to retrieve the value of the 
    # property when requested. 
    def initialize(name, &valueGetter)
        @name = name
        @valueGetter = valueGetter
    end

    # Fetch and returns the value associated to this property.
    def value
        return @valueGetter.call
    end

end
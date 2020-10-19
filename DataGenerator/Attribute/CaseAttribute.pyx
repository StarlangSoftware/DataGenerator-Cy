from Classification.Attribute.DiscreteAttribute cimport DiscreteAttribute
from MorphologicalAnalysis.MorphologicalParse cimport MorphologicalParse


cdef class CaseAttribute(DiscreteAttribute):

    def __init__(self, parse: MorphologicalParse):
        """
        Discrete attribute for a given word. If the last inflectional group of the word contains case information, the
        attribute will have that case value. Otherwise the attribute will have the value null.

        PARAMETERS
        ----------
        parse : MorphologicalParse
            Morphological parse of the word.
        """
        super().__init__(parse.lastIGContainsCase())

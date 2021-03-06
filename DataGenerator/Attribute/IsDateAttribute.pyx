from Classification.Attribute.BinaryAttribute cimport BinaryAttribute
from MorphologicalAnalysis.MorphologicalParse cimport MorphologicalParse


cdef class IsDateAttribute(BinaryAttribute):

    def __init__(self, parse: MorphologicalParse):
        """
        Binary attribute for a given word. If the word represents a date ( if the morphological parse contains
        tag DATE), the attribute will have the value "true", otherwise "false".

        PARAMETERS
        ----------
        parse: MorphologicalParse
            Morphological parse of the word.
        """
        super().__init__(parse.isDate())

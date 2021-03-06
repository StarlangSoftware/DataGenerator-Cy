from Classification.Attribute.BinaryAttribute cimport BinaryAttribute
from NamedEntityRecognition.Gazetteer cimport Gazetteer


cdef class IsOrganizationGazetteer(BinaryAttribute):

    gazetteer = Gazetteer("ORGANIZATION", "gazetteer-organization.txt")

    def __init__(self, surfaceForm: str):
        """
        Binary attribute for a given word. If the word is listed in the Organization Gazetteer file, the attribute will
        have the value "true", otherwise "false".

        PARAMETERS
        ----------
        surfaceForm : str
            Surface form of the word.
        """
        super().__init__(self.gazetteer.contains(surfaceForm))

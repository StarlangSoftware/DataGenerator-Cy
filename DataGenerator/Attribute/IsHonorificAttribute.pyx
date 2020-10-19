from Classification.Attribute.BinaryAttribute cimport BinaryAttribute
from Dictionary.Word cimport Word


class IsHonorificAttribute(BinaryAttribute):

    def __init__(self, surfaceForm: str):
        """
        Binary attribute for a given word. If the word is "bay" or "bayan", the attribute will have the value "true",
        otherwise "false".

        PARAMETERS
        ----------
        surfaceForm : str
            Surface form of the word.
        """
        super().__init__(Word.isHonorific(surfaceForm))

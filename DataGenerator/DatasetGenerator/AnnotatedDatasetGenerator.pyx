from AnnotatedSentence.AnnotatedCorpus cimport AnnotatedCorpus
from AnnotatedSentence.AnnotatedSentence cimport AnnotatedSentence
from Classification.DataSet.DataSet cimport DataSet
from DataGenerator.InstanceGenerator.InstanceGenerator cimport InstanceGenerator


cdef class AnnotatedDatasetGenerator:

    cdef AnnotatedCorpus __corpus
    cdef InstanceGenerator __instance_generator

    def __init__(self,
                 folder: str,
                 pattern: str,
                 instanceGenerator: InstanceGenerator):
        """
        Constructor for the AnnotatedDataSetGenerator which takes input the data directory, the pattern for the
        training files included, and an instanceGenerator. The constructor loads the sentence corpus from the given
        directory including the given files having the given pattern.

        PARAMETERS
        ----------
        folder : str
            Directory where the corpus files reside.
        pattern : str
            Pattern of the tree files to be included in the treebank. Use "." for all files.
        instanceGenerator : InstanceGenerator
            The instance generator used to generate the dataset.
        """
        self.__corpus = AnnotatedCorpus(folder, pattern)
        self.__instance_generator = instanceGenerator

    cpdef setInstanceGenerator(self, InstanceGenerator instanceGenerator):
        """
        Mutator for the instanceGenerator attribute.

        PARAMETERS
        ----------
        instanceGenerator : InstanceGenerator
            Input instanceGenerator
        """
        self.__instance_generator = instanceGenerator

    cpdef DataSet generate(self):
        """
        Creates a dataset from the corpus. Calls generateInstanceFromSentence for each parse sentence in the corpus.

        RETURNS
        -------
        DataSet
            Created dataset.
        """
        cdef DataSet data_set
        cdef AnnotatedSentence sentence, generated_instance
        cdef int j
        data_set = DataSet()
        for sentence in self.__corpus.sentences:
            for j in range(sentence.wordCount()):
                generated_instance = self.__instance_generator.generateInstanceFromSentence(sentence, j)
                if generated_instance is not None:
                    data_set.addInstance(generated_instance)
        return data_set

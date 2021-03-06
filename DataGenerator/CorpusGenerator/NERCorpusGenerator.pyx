from AnnotatedSentence.ViewLayerType import ViewLayerType
from AnnotatedTree.TreeBankDrawable cimport TreeBankDrawable
from AnnotatedTree.ParseTreeDrawable cimport ParseTreeDrawable
from NamedEntityRecognition.NERCorpus cimport NERCorpus
from AnnotatedSentence.AnnotatedSentence cimport AnnotatedSentence


cdef class NERCorpusGenerator:

    cdef TreeBankDrawable __treeBank

    def __init__(self, folder: str, pattern: str):
        """
        Constructor for the NERCorpusGenerator which takes input the data directory and the pattern for the
        training files included. The constructor loads the treebank from the given directory including the given files
        the given pattern.

        PARAMETERS
        ----------
        folder : str
            Directory where the treebank files reside.
        pattern : str
            Pattern of the tree files to be included in the treebank. Use "." for all files.
        """
        self.__treeBank = TreeBankDrawable(folder, pattern)

    cpdef NERCorpus generate(self):
        """
        Creates a morphological disambiguation corpus from the treeBank. Calls generateAnnotatedSentence for each parse
        tree in the treebank.

        RETURNS
        -------
        DisambiguationCorpus
            Created disambiguation corpus.
        """
        cdef NERCorpus corpus
        cdef int i
        cdef ParseTreeDrawable parseTree
        cdef AnnotatedSentence sentence
        corpus = NERCorpus()
        for i in range(self.__treeBank.size()):
            parseTree = self.__treeBank.get(i)
            if parseTree.layerAll(ViewLayerType.NER):
                sentence = parseTree.generateAnnotatedSentence()
                corpus.addSentence(sentence)
        return corpus

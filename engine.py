"""
Functionality for the Aeolia engine.
"""



import sys
import getopt
import nltk
import spacy
import corpus.model



class Cmdline:
    """
    Parses the command line for input.
    """

    def __init__(self, argv):
        self.__file = ''

        try:
            opts = getopt.getopt(argv, "hi:", ["input=",])
        except:
            self.__show_help()

        for opt, arg in opts:
            if opt == "-h":
                self.__show_help()
            elif opt in ("-i", "--input",):
                self.__file = arg
            else:
                self.__show_help()


    @staticmethod
    def __show_help():
        """
        Shows the default help message.
        """

        print("./engine.py -i <input-file>")
        sys.exit(2)


    def input_file(self):
        """
        Gets the parsed input file.
        """

        return self.__file


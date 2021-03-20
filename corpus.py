"""
Provides functionality for the corpus schema.
"""



from database import Database



class Schema:
    """
    Manages the corpus schema.
    """

    def __init__(self):
        self.__dbase = Database()


    def create(self):
        """
        Creates the corpus schema.
        """

        self.__dbase.script('corpus/domain')
        self.__dbase.script('corpus/iface')


    def nuke(self):
        """
        Destroys the corpus schema.
        """

        self.__dbase.script('corpus/nuke')



class TitleEntity:
    """
    Corpus title entity.
    """

    def __init__(self):
        self.__dbase = Database()


    def single(self, rec_id):
        """
        Gets a single corpus title entity.
        """

        return self.__dbase.func('corpus.title_single', (rec_id,))


    def all(self):
        """
        Gets all corpus title entities.
        """

        return self.__dbase.func('corpus.title_all')


    def find(self, title):
        """
        Finds a corpus title entity.
        """

        return self.__dbase.func('corpus.title_find', (title,))


    def search(self, title):
        """
        Searches for matching title entities.
        """

        return self.__dbase.func('corpus.title_search', (title,))


    def add(self, title, author):
        """
        Add a title entity.
        """

        self.__dbase.proc('corpus.title_add', '%s, %s', (title, author,))

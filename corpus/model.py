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

        self.__dbase.script("corpus/domain")
        self.__dbase.script("corpus/iface")


    def nuke(self):
        """
        Destroys the corpus schema.
        """

        self.__dbase.script("corpus/nuke")



class Title:
    """
    Corpus title model.
    """

    def __init__(self):
        self.__dbase = Database()


    def single(self, rec_id):
        """
        Gets a single corpus title record.
        """

        return self.__dbase.func("corpus.title_single", (rec_id,))


    def all(self):
        """
        Gets all corpus title records.
        """

        return self.__dbase.func("corpus.title_all")


    def find(self, title):
        """
        Finds a corpus title record.
        """

        return self.__dbase.func("corpus.title_find", (title,))


    def search(self, title):
        """
        Searches for matching title records.
        """

        return self.__dbase.func("corpus.title_search", (title,))


    def add(self, title, author):
        """
        Add a title record.
        """

        self.__dbase.proc("corpus.title_add", "%s, %s", (title, author,))


    def breakup(self, title):
        """
        Gets all tokens for a given title
        """

        return self.__dbase.func("corpus.breakup_title", (title,))



class Token:
    """
    Corpus token model.
    """

    def __init__(self):
        self.__dbase = Database()


    def single(self, rec_id):
        """
        Gets a single token record.
        """

        return self.__dbase.func("corpus.token_single", (rec_id,))


    def all(self):
        """
        Gets all corpus title records.
        """

        return self.__dbase.func("corpus.token_all")



    def find(self, lexeme, pos):
        """
        Finds a token record with a given lexeme and PoS.
        """

        return self.__dbase.func("corpus.token_find", (lexeme, pos))


    def search(self, lexeme):
        """
        Searches for token records matching a given lexeme.
        """

        return self.__dbase.func("corpus.token_search", (lexeme,))


    def add(self, lexeme, pos):
        """
        Adds a new token record.
        """

        self.__dbase.proc("corpus.token_add", "%s, %s", (lexeme, pos,))



class Breakup:
    """
    Corpus breakup model.
    """

    def __init__(self):
        self.__dbase = Database()


    def single(self, rec_id):
        """
        Gets a single breakup record.
        """

        return self.__dbase.func("corpus.breakup_single", (rec_id,))


    def all(self):
        """
        Gets all breakup records.
        """

        return self.__dbase.func("corpus.breakup_all")


    def find(self, title, para, sent, index, lexeme, pos):
        """
        Finds a breakup record with a given set of attributes.
        """

        return self.__dbase.func("corpus.breakup_find", 
                                 (title, para, sent, index, lexeme, pos,))


    def search(self, lexeme):
        """
        Searches all breakup records matching a given token.
        """

        return self.__dbase.func("corpus.breakup_search", (lexeme,))


    def add(self, title, para, sent, index, lexeme, pos):
        """
        Adds a new breakup record.
        """

        self.__dbase.proc("corpus.breakup_add", "%s, %s, %s, %s, %s, %s",
                          (title, para, sent, index, lexeme, pos,))


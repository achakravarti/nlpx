import nltk
import spacy
import corpus.model


class Token:
    """
    Represents a token in a sentence.
    """

    def __init__(self, title, para_index, sent_index, index, text, pos, dep):
        self.__title = title
        self.__para_index = para_index
        self.__sent_index = sent_index
        self.__index = index
        self.__text = text
        self.__pos = pos
        self.__dep = dep


    def __str__(self):
        return "{}.{}.{} {} ({} {})".format(self.para_index(),
                                            self.sent_index(), self.index(),
                                            self.text(), self.pos(),
                                            self.dependency())


    def title(self):
        """
        Gets the title to which the token belongs.
        """

        return self.__title


    def index(self):
        """
        Gets the index of the token in the sentence.
        """

        return self.__index


    def sent_index(self):
        """
        Gets the sentence index of the token.
        """

        return self.__sent_index


    def para_index(self):
        """
        Gets the paragraph index of the token.
        """

        return self.__para_index


    def text(self):
        """
        Gets the lexeme of a token.
        """

        return self.__text


    def pos(self):
        """
        Gets the PoS of a token.
        """

        return self.__pos


    def dependency(self):
        """
        Gets the dependency label of a token.
        """

        return self.__dep


    def save(self):
        """
        Saves the token to database.
        """

        print("Saving token", str(self), "...")

        model = corpus.model.Token()
        model.add(self.__text, self.__pos)

        model = corpus.model.Breakup()
        model.add(self.title(), self.para_index(), self.sent_index(),
                  self.index(), self.text(), self.pos())



class Sentence:
    """
    Represents a sentence in a paragraph.
    """

    def __init__(self, title, para_index, index, text):
        self.__title = title
        self.__para_index = para_index
        self.__index = index
        self.__text = text


    def __str__(self):
        return "[{}.{}]: {}".format(self.__para_index, self.__index,
                                    self.__text)


    def para_index(self):
        """
        Gets the index of the paragraph to which the sentence belongs.
        """

        return self.__para_index


    def index(self):
        """
        Gets the index of the sentence.
        """

        return self.__index


    def text(self):
        """
        Gets the text of the sentence.
        """

        return self.__text


    def tokens(self):
        """
        Gets the tokens that make up the sentence.
        """

        nlp = spacy.load("en_core_web_sm")
        doc = nlp(self.__text)

        tok_list = []
        for tok in doc:
            tok_list.append(Token(self.__title, self.__para_index, self.__index,
                            tok.i, tok.text, tok.pos_, tok.dep_))

        return tok_list


    def save(self):
        """
        Saves the tokens of a database.
        """

        for token in self.tokens():
            token.save()




class Paragraph:
    """
    Represents a paragraph of a corpus.
    """


    def __init__(self, title, index, text):
        text = text.replace("\n", " ").replace("\r", "").strip()
        nlp = nltk.sent_tokenize(text)

        self.__sent = []
        for  sent_index, sent in enumerate(nlp):
            self.__sent.append(Sentence(title, index, sent_index, sent))


    def __str__(self):
        return "[{}]: {}".format(self.index(), self.text())


    def index(self):
        """
        Gets the index of the paragraph.
        """

        return self.__sent[0].para_index()


    def text(self):
        """
        Gets the full text of the paragraph.
        """

        text = ""
        for sent in self.__sent:
            text = text + sent.text()

        return text



    def sentences(self):
        """
        Gets the list of individual sentences.
        """

        return self.__sent


    def save(self):
        """
        Saves the sentences of a paragraph to the database.
        """

        for sent in self.__sent:
            sent.save()



class Document:
    """
    Represents a corpus document.
    """


    def __init__(self, title, author, path):
        self.__path = path 
        self.__title = title
        self.__author = author

        with open(self.__path) as text:
            paras = list(filter(lambda x: x != "",
                                text.read().split("\n\n")))

            self.__paras = []

            for index, para in enumerate(paras):
                para = Paragraph(title, index, para)
                self.__paras.append(para)


    def title(self):
        """
        Gets the title of the document.
        """

        return self.__title


    def author(self):
        """
        Gets the author of the document.
        """

        return self.__author


    def paragraphs(self):
        """
        Gets a dictionary of the paragraphs in the loaded corpus document.
        """

        return self.__paras


    def save(self):
        title = corpus.model.Title()
        title.add(title=self.__title, author=self.__author)

        print("Saving document", self.__title, "...")

        for para in self.__paras:
            para.save()

        print("Done.")

#!/usr/bin/env python3
"""
Tests out functionality as it is developed.
"""



import corpus, engine



def corpus_schema_create():
    """
    Tests the creation of the corpus schema.
    """

    schema = corpus.Schema()
    schema.nuke()
    schema.create()


def corpus_title_add():
    """
    Tests the addition of a corpus title record.
    """

    ent = corpus.TitleEntity()
    ent.add(title="Thurnley Abbey", author="Perceval Landon")
    ent.add(title="The Monkey's Paw", author="W. W. Jacobs")



def corpus_title_all():
    """
    Tests the listing of all corpus title records.
    """

    print(corpus.TitleEntity().all())



def corpus_title_single():
    """
    Tests the retrieval of a single corpus title record.
    """

    print(corpus.TitleEntity().single(rec_id=2))



def corpus_title_find():
    """
    Tests finding a single corpus title record.
    """

    print(corpus.TitleEntity().find(title="The Monkey's Paw"))


def corpus_title_search():
    """
    Tests the searching of corpus title records for a pattern"
    """

    print(corpus.TitleEntity().search(title="urnley"))


def engine_analyzer():
    """
    Tests the analyzer engine.
    """

    doc = engine.Document(title="The Monkey's Paw", author="W. W. Jacobs",
                          path="corpus/the-monkeys-paw.txt")

    for para in doc.paragraphs():
        for sent in para.sentences():
            print(str(sent))

        print("\n")


    para = doc.paragraphs()[145]
    sent = para.sentences()[2]

    print(sent.text())
    for token in sent.tokens():
        print(str(token))
        #print(token.index(), token.text(), token.pos(), token.dependency())

    doc.save()


if __name__ == '__main__':
    corpus_schema_create()
    corpus_title_add()
    corpus_title_all()
    corpus_title_single()
    corpus_title_find()
    corpus_title_search()

    engine_analyzer()

#!/usr/bin/env python3
"""
Tests out functionality as it is developed.
"""



import engine





def engine_analyzer():
    """
    Tests the analyzer engine.
    """

    doc = engine.Document(title="The Monkey's Paw", author="W. W. Jacobs",
                          path="sources/the-monkeys-paw.txt")

    for para in doc.paragraphs():
        for sent in para.sentences():
            print(str(sent))

        print("\n")


    para = doc.paragraphs()[145]
    sent = para.sentences()[2]

    print(sent.text())
    for token in sent.tokens():
        print(str(token))

    doc.save()


if __name__ == '__main__':

    engine_analyzer()

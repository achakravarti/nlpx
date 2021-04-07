#!/usr/bin/env python3
"""
Tests out functionality as it is developed.
"""



import engine
import corpus.model
import corpus.entity
import tag.model


def setup():
    tag.model.Schema().create()
    corpus.model.Schema().create()


def teardown():
    corpus.model.Schema().nuke()
    tag.model.Schema().nuke()


def run(test, show=False):
    if show is False:
        eval(test)
    else:
        eval("print(" + str(test) + ")")
        print()


def tag_pos_model(show=False):
    model = tag.model.Pos()

    run(model.single(1), show)
    run(model.all(), show)
    run(model.find("ADJ"), show)
    run(model.search("CCON"), show)


def tag_dependency_model(show=False):
    model = tag.model.Dependency()

    run(model.single(1), show)
    run(model.all(), show)
    run(model.find("root"), show)
    run(model.search("num"), show)


def tag_entity_model(show=False):
    model = tag.model.Entity()

    run(model.single(1), show)
    run(model.all(), show)
    run(model.find("DRV"), show)
    run(model.search("GPE"), show)


def corpus_title_model(show=False):
    model = corpus.model.Title()

    model.add("The Monkey's Paw", "W. W. Jacobs")
    model.add("Thurnley Abbey", "Perceval Landon")

    run(model.single(1), show)
    run(model.all(), show)
    run(model.find("Thurnley Abbey"), show)
    run(model.search("Abbey"), show)


def corpus_token_model(show=False):
    model = corpus.model.Token()

    model.add("Joe", "PROPN")
    model.add("the", "DET")

    run(model.single(1), show)
    run(model.all(), show)
    run(model.find("the", "DET"), show)
    run(model.search("Joe"), show)


def corpus_breakup_model(show=False):
    model = corpus.model.Breakup()

    model.add("Thurnley Abbey", 0, 0, 0, "Joe", "PROPN")
    model.add("The Monkey's Paw", 1, 1, 1, "the", "DET")

    run(model.single(1), show)
    run(model.all(), show)
    run(model.find("The Monkey's Paw", 1, 1, 1, "the", "DET"), show)
    run(model.search("the"), show)



def entity_analyzer():
    """
    Tests the analyzer engine.
    """

    doc = corpus.entity.Document(title="The Monkey's Paw", 
                                 author="W. W. Jacobs")

    doc.parse("sources/the-monkeys-paw.txt")
    doc.save()
    print(doc.load())


if __name__ == '__main__':
    teardown()
    setup()

    """
    tag_pos_model()
    tag_dependency_model()
    tag_entity_model()

    corpus_title_model()
    corpus_token_model()
    corpus_breakup_model()
    """

    entity_analyzer()

    #teardown()


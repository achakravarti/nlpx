#!/usr/bin/env python3


import json
import psycopg2
from psycopg2.extras import RealDictCursor


class Database:
    def __init__(self):
        self.__conn = psycopg2.connect(database='nlpx', user='nlpx')
        self.__conn.set_session(autocommit=True)


    def __del__(self):
        self.__conn.close()


    def script(self, script):
        """
        Executes an SQL script file.
        """

        with self.__conn.cursor() as cur:
            cur.execute(open('sql/' + script + '.sql', 'r').read())


    def proc(self, proc, params=None, args=None):
        """
        Executes a PostgreSQL stored procedure.
        """

        with self.__conn.cursor() as cur:
            if params is None:
                cur.execute("CALL " + proc + "();")
            else:
                cur.execute("CALL " + proc + "(" + params + ");", args)


    def func(self, func, args=None):
        """
        Executes a PostgreSQL function.
        """

        with self.__conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.callproc(func, args)
            return json.dumps(cur.fetchall(), indent=2)


class TagSchema:
    def __init__(self):
        self.__dbase = Database()

    # https://github.com/explosion/spaCy/blob/master/spacy/glossary.py
    def __pop_universal(self):
        tags = {
            "ADJ": "adjective",
            "ADP": "adposition",
            "ADV": "adverb",
            "AUX": "auxiliary",
            "CONJ": "conjunction",
            "CCONJ": "coordinating conjunction",
            "DET": "determiner",
            "INTJ": "interjection",
            "NOUN": "noun",
            "NUM": "numeral",
            "PART": "particle",
            "PRON": "pronoun",
            "PROPN": "proper noun",
            "PUNCT": "punctuation",
            "SCONJ": "subordinating conjunction",
            "SYM": "symbol",
            "VERB": "verb",
            "X": "other",
            "EOL": "end of line",
            "SPACE": "space",
        }

        for key in tags:
            self.__dbase.proc("tags.pos_add_universal", "%s, %s",
                              (key, tags[key]))


    def __pop_penn_treebank(self):
        tags = {
            ".": "punctuation mark, sentence closer",
            ",": "punctuation mark, comma",
            "-LRB-": "left round bracket",
            "-RRB-": "right round bracket",
            "``": "opening quotation mark",
            '""': "closing quotation mark",
            "''": "closing quotation mark",
            ":": "punctuation mark, colon or ellipsis",
            "$": "symbol, currency",
            "#": "symbol, number sign",
            "AFX": "affix",
            "CC": "conjunction, coordinating",
            "CD": "cardinal number",
            "DT": "determiner",
            "EX": "existential there",
            "FW": "foreign word",
            "HYPH": "punctuation mark, hyphen",
            "IN": "conjunction, subordinating or preposition",
            "JJ": "adjective",
            "JJR": "adjective, comparative",
            "JJS": "adjective, superlative",
            "LS": "list item marker",
            "MD": "verb, modal auxiliary",
            "NIL": "missing tag",
            "NN": "noun, singular or mass",
            "NNP": "noun, proper singular",
            "NNPS": "noun, proper plural",
            "NNS": "noun, plural",
            "PDT": "predeterminer",
            "POS": "possessive ending",
            "PRP": "pronoun, personal",
            "PRP$": "pronoun, possessive",
            "RB": "adverb",
            "RBR": "adverb, comparative",
            "RBS": "adverb, superlative",
            "RP": "adverb, particle",
            "TO": 'infinitival "to"',
            "UH": "interjection",
            "VB": "verb, base form",
            "VBD": "verb, past tense",
            "VBG": "verb, gerund or present participle",
            "VBN": "verb, past participle",
            "VBP": "verb, non-3rd person singular present",
            "VBZ": "verb, 3rd person singular present",
            "WDT": "wh-determiner",
            "WP": "wh-pronoun, personal",
            "WP$": "wh-pronoun, possessive",
            "WRB": "wh-adverb",
            "SP": "space",
            "ADD": "email",
            "NFP": "superfluous punctuation",
            "GW": "additional word in multi-word expression",
            "XX": "unknown",
            "BES": 'auxiliary "be"',
            "HVS": 'forms of "have"',
        }

        for key in tags:
            self.__dbase.proc("tags.pos_add_penn_treebank", "%s, %s",
                              (key, tags[key]))

    def __pop_dependency(self):
        tags = {
            "acl": "clausal modifier of noun (adjectival clause)",
            "acomp": "adjectival complement",
            "advcl": "adverbial clause modifier",
            "advmod": "adverbial modifier",
            "agent": "agent",
            "amod": "adjectival modifier",
            "appos": "appositional modifier",
            "attr": "attribute",
            "aux": "auxiliary",
            "auxpass": "auxiliary (passive)",
            "case": "case marking",
            "cc": "coordinating conjunction",
            "ccomp": "clausal complement",
            "clf": "classifier",
            "complm": "complementizer",
            "compound": "compound",
            "conj": "conjunct",
            "cop": "copula",
            "csubj": "clausal subject",
            "csubjpass": "clausal subject (passive)",
            "dative": "dative",
            "dep": "unclassified dependent",
            "det": "determiner",
            "discourse": "discourse element",
            "dislocated": "dislocated elements",
            "dobj": "direct object",
            "expl": "expletive",
            "fixed": "fixed multiword expression",
            "flat": "flat multiword expression",
            "goeswith": "goes with",
            "hmod": "modifier in hyphenation",
            "hyph": "hyphen",
            "infmod": "infinitival modifier",
            "intj": "interjection",
            "iobj": "indirect object",
            "list": "list",
            "mark": "marker",
            "meta": "meta modifier",
            "neg": "negation modifier",
            "nmod": "modifier of nominal",
            "nn": "noun compound modifier",
            "npadvmod": "noun phrase as adverbial modifier",
            "nsubj": "nominal subject",
            "nsubjpass": "nominal subject (passive)",
            "nounmod": "modifier of nominal",
            "npmod": "noun phrase as adverbial modifier",
            "num": "number modifier",
            "number": "number compound modifier",
            "nummod": "numeric modifier",
            "oprd": "object predicate",
            "obj": "object",
            "obl": "oblique nominal",
            "orphan": "orphan",
            "parataxis": "parataxis",
            "partmod": "participal modifier",
            "pcomp": "complement of preposition",
            "pobj": "object of preposition",
            "poss": "possession modifier",
            "possessive": "possessive modifier",
            "preconj": "pre-correlative conjunction",
            "prep": "prepositional modifier",
            "prt": "particle",
            "punct": "punctuation",
            "quantmod": "modifier of quantifier",
            "rcmod": "relative clause modifier",
            "relcl": "relative clause modifier",
            "reparandum": "overridden disfluency",
            "root": "root",
            "vocative": "vocative",
            "xcomp": "open clausal complement",
        }

        for key in tags:
            self.__dbase.proc("tags.dependency_add", "%s, %s", (key, tags[key]))


    def __pop_entity(self):
        """
        Populate named entity table.
        """

        tags = {
            "PERSON": "People, including fictional",
            "NORP": "Nationalities or religious or political groups",
            "FACILITY": "Buildings, airports, highways, bridges, etc.",
            "FAC": "Buildings, airports, highways, bridges, etc.",
            "ORG": "Companies, agencies, institutions, etc.",
            "GPE": "Countries, cities, states",
            "LOC": "Non-GPE locations, mountain ranges, bodies of water",
            "PRODUCT": "Objects, vehicles, foods, etc. (not services)",
            "EVENT": "Named hurricanes, battles, wars, sports events, etc.",
            "WORK_OF_ART": "Titles of books, songs, etc.",
            "LAW": "Named documents made into laws.",
            "LANGUAGE": "Any named language",
            "DATE": "Absolute or relative dates or periods",
            "TIME": "Times smaller than a day",
            "PERCENT": 'Percentage, including "%"',
            "MONEY": "Monetary values, including unit",
            "QUANTITY": "Measurements, as of weight or distance",
            "ORDINAL": '"first", "second", etc.',
            "CARDINAL": "Numerals that do not fall under another type",
            "PER": "Named person or family.",
            "MISC": "Miscellaneous entities, e.g. events, nationalities, products or works of art",
            "EVT": "Festivals, cultural events, sports events, weather phenomena, wars, etc.",
            "PROD": "Product, i.e. artificially produced entities including speeches, radio shows, programming languages, contracts, laws and ideas",
            "DRV": "Words (and phrases?) that are dervied from a name, but not a name in themselves, e.g. 'Oslo-mannen' ('the man from Oslo')",
            "GPE_LOC": "Geo-political entity, with a locative sense, e.g. 'John lives in Spain'",
            "GPE_ORG": "Geo-political entity, with an organisation sense, e.g. 'Spain declined to meet with Belgium'",
        }

        for key in tags:
            self.__dbase.proc("tags.entity_add", "%s, %s", (key, tags[key]))


    def create(self):
        """
        Create database
        """

        self.__dbase.script('tag/domain')
        self.__dbase.script('tag/iface')

        self.__pop_universal()
        self.__pop_penn_treebank()
        self.__pop_dependency()
        self.__pop_entity()


    def nuke(self):
        '''
        Nuke database
        '''

        self.__dbase.script('tag/nuke')


    def pos_single(self, rec_id):
        """
        Returns a single PoS record.
        """

        return self.__dbase.func('tags.pos_single', (rec_id,))


    def pos_list(self):
        """
        Returns the list of all PoS tags.
        """

        return self.__dbase.func('tags.pos_list')


    def pos_find(self, pos):
        """
        Gets the ID of a PoS tag.
        """

        return self.__dbase.func('tags.pos_find', (pos,))


    def pos_search(self, pos):
        """
        Searches for matching PoS tags.
        """

        return self.__dbase.func('tags.pos_search', (pos,))


    def dependency_single(self, rec_id):
        """
        Gets a single dependency record.
        """

        return self.__dbase.func('tags.dependency_single', (rec_id,))


    def dependency_list(self):
        """
        Returns the list of all dependency labels in the database.
        """

        return self.__dbase.func('tags.dependency_list')


    def dependency_find(self, label):
        """
        Gets the ID of a dependency label tag.
        """

        return self.__dbase.func('tags.dependency_find', (label,))


    def entity_single(self, rec_id):
        """
        Gets a single entity record.
        """

        return self.__dbase.func('tags.entity_single', (rec_id,))


    def entity_list(self):
        """
        Returns the list of all named entity relations in the database.
        """

        return self.__dbase.func('tags.entity_list')


    def entity_find(self, name):
        """
        Gets the ID of a named entity tag.
        """

        return self.__dbase.func('tags.entity_find', (name,))


if __name__ == '__main__':
    tag = TagSchema()
    tag.nuke()
    tag.create()

    #print(tag.entity_single("10"))
    print(tag.pos_search("conj"))


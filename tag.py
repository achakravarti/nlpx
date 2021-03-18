#!/usr/bin/env python3


import json
import psycopg2
from psycopg2.extras import RealDictCursor
from psycopg2.extras import NamedTupleCursor


class Database:
    def __init__(self):
        self.__conn = psycopg2.connect(database='nlpx', user='nlpx')
        self.__conn.set_session(autocommit=True)


    def __del__(self):
        self.__conn.close()


    def script(self, script):
        with self.__conn.cursor() as cur:
            cur.execute(open('sql/' + script + '.sql', 'r').read())


    def proc(self, proc, params=None, args=None):
        with self.__conn.cursor() as cur:
            if params is None:
                cur.execute("CALL " + proc + "();")
            else:
                cur.execute("CALL " + proc + "(" + params + ");", args)


    def func(self, func, args=None):
        with self.__conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.callproc(func, args)
            return json.dumps(cur.fetchall(), indent=2)


class TagSchema:
    '''
    TODO
    '''

    # https://github.com/explosion/spaCy/blob/master/spacy/glossary.py
    __POS_UNIVERSAL = {
        'ADJ': 'adjective',
        'ADP': 'adposition',
        'ADV': 'adverb',
        'AUX': 'auxiliary',
        'CONJ': 'conjunction',
        'CCONJ': 'coordinating conjunction',
        'DET': 'determiner',
        'INTJ': 'interjection',
        'NOUN': 'noun',
        'NUM': 'numeral',
        'PART': 'particle',
        'PRON': 'pronoun',
        'PROPN': 'proper noun',
        'PUNCT': 'punctuation',
        'SCONJ': 'subordinating conjunction',
        'SYM': 'symbol',
        'VERB': 'verb',
        'X': 'other',
        'EOL': 'end of line',
        'SPACE': 'space',
    }


    __POS_PENN_TREEBANK = {
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

    __DEPENDENCY = {
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


    __ENTITY = {
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
    

    def create(self):
        '''
        Create database
        '''

        db = Database()
        db.script('tag/domain')
        db.script('tag/iface')


    def populate(self):
        '''
        Populate database
        '''

        db = Database()

        for key in self.__POS_UNIVERSAL:
            db.proc("tag.pos_add_universal", "%s, %s",
                (key, self.__POS_UNIVERSAL[key]))

        for key in self.__POS_PENN_TREEBANK:
            db.proc("tag.pos_add_penn_treebank", "%s, %s", 
                (key, self.__POS_PENN_TREEBANK[key]))
        
        for key in self.__DEPENDENCY:
            db.proc("tag.dependency_add", "%s, %s",
                (key, self.__DEPENDENCY[key]))

        for key in self.__ENTITY:
            db.proc("tag.entity_add", "%s, %s", (key, self.__ENTITY[key]))


    def nuke(self):
        '''
        Nuke database
        '''

        Database().script('tag/nuke')


    def pos_list(self):
        db = Database()
        print(db.func('tag.pos_list'));


if __name__ == '__main__':
    tag = TagSchema()
    tag.nuke()
    tag.create()
    tag.populate()
    tag.pos_list()

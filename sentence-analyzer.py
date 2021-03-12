#!/usr/bin/env python3


import sys, getopt, nltk, tabulate
from nltk.corpus import wordnet as wn

pos = {
    "CC": 	"coordinating conjunction",
    "CD": 	"cardinal digit",
    "DT": 	"determiner",
    "EX": 	"existential there",
    "FW": 	"foreign word",
    "IN": 	"preposition/subordinating conjunction",
    "JJ": 	"adjective (large)",
    "JJR": 	"adjective, comparative (larger)",
    "JJS": 	"adjective, superlative (largest)",
    "LS": 	"list market",
    "MD": 	"modal (could, will)",
    "NN": 	"noun, singular (cat, tree)",
    "NNS": 	"noun plural (desks)",
    "NNP": 	"proper noun, singular (Sarah)",
    "NNPS": "proper noun, plural (Indians or Americans)",
    "PDT": 	"predeterminer (all, both, half)",
    "POS": 	"possessive ending (parent\ 's)",
    "PRP": 	"personal pronoun (hers, herself, him,himself)",
    "PRP$": "possessive pronoun (her, his, mine, my, our )",
    "RB": 	"adverb (occasionally, swiftly)",
    "RBR": 	"adverb, comparative (greater)",
    "RBS": 	"adverb, superlative (biggest)",
    "RP": 	"particle (about)",
    "TO": 	"infinite marker (to)",
    "UH": 	"interjection (goodbye)",
    "VB": 	"verb (ask)",
    "VBG": 	"verb gerund (judging)",
    "VBD": 	"verb past tense (pleaded)",
    "VBN": 	"verb past participle (reunified)",
    "VBP": 	"verb, present tense not 3rd person singular(wrap)",
    "VBZ": 	"verb, present tense with 3rd person singular (bases)",
    "WDT": 	"wh-determiner (that, what)",
    "WP": 	"wh- pronoun (who)",
    "WRB": 	"wh- adverb (how) ",
}

# https://stackoverflow.com/questions/5364493
# https://www.nltk.org/howto/wordnet.html
tag_map = {
    'CC':None, # coordin. conjunction (and, but, or)
    'CD':wn.NOUN, # cardinal number (one, two)
    'DT':None, # determiner (a, the)
    'EX':wn.ADV, # existential ‘there’ (there)
    'FW':None, # foreign word (mea culpa)
    'IN':wn.ADV, # preposition/sub-conj (of, in, by)
    'JJ':[wn.ADJ, wn.ADJ_SAT], # adjective (yellow)
    'JJR':[wn.ADJ, wn.ADJ_SAT], # adj., comparative (bigger)
    'JJS':[wn.ADJ, wn.ADJ_SAT], # adj., superlative (wildest)
    'LS':None, # list item marker (1, 2, One)
    'MD':None, # modal (can, should)
    'NN':wn.NOUN, # noun, sing. or mass (llama)
    'NNS':wn.NOUN, # noun, plural (llamas)
    'NNP':wn.NOUN, # proper noun, sing. (IBM)
    'NNPS':wn.NOUN, # proper noun, plural (Carolinas)
    'PDT':[wn.ADJ, wn.ADJ_SAT], # predeterminer (all, both)
    'POS':None, # possessive ending (’s )
    'PRP':None, # personal pronoun (I, you, he)
    'PRP$':None, # possessive pronoun (your, one’s)
    'RB':wn.ADV, # adverb (quickly, never)
    'RBR':wn.ADV, # adverb, comparative (faster)
    'RBS':wn.ADV, # adverb, superlative (fastest)
    'RP':[wn.ADJ, wn.ADJ_SAT], # particle (up, off)
    'SYM':None, # symbol (+,%, &)
    'TO':None, # “to” (to)
    'UH':None, # interjection (ah, oops)
    'VB':wn.VERB, # verb base form (eat)
    'VBD':wn.VERB, # verb past tense (ate)
    'VBG':wn.VERB, # verb gerund (eating)
    'VBN':wn.VERB, # verb past participle (eaten)
    'VBP':wn.VERB, # verb non-3sg pres (eat)
    'VBZ':wn.VERB, # verb 3sg pres (eats)
    'WDT':None, # wh-determiner (which, that)
    'WP':None, # wh-pronoun (what, who)
    'WP$':None, # possessive (wh- whose)
    'WRB':None, # wh-adverb (how, where)
    '$':None, #  dollar sign ($)
    '#':None, # pound sign (#)
    '“':None, # left quote (‘ or “)
    '”':None, # right quote (’ or ”)
    '(':None, # left parenthesis ([, (, {, <)
    ')':None, # right parenthesis (], ), }, >)
    ',':None, # comma (,)
    '.':None, # sentence-final punc (. ! ?)
    ':':None # mid-sentence punc (: ; ... – -)
}


def parse_argv(argv):
    in_file = ''
    out_file = ''

    try:
        opts, args = getopt.getopt(argv, 'hi:o:', ['input=', 'output='])
    except:
        print('./sentence-analyzer.py -i <input-file> -o <output-file>')
        sys.exit(2)

    for opt, arg in opts:
        if opt == '-h':
            print('./sentence-analyzer.py -i <input-file> -o <output-file>')
            sys.exit()
        elif opt in ('-i', '--input'):
            in_file = arg
        elif opt in ('-o', '--output'):
            out_file = arg
    
    return in_file, out_file


def paras(in_file):
    reader = nltk.corpus.reader.plaintext.PlaintextCorpusReader('.', in_file,
        para_block_reader=read_line_block)

    paras = reader.paras()
    print('Paragraphs' + str(len(paras)))

    for p in paras:
        print(str(p))
        print('\n\n')


def sentences(in_file):
    input_file = open(in_file, 'r')
    sentences = nltk.sent_tokenize(input_file.read())
    input_file.close()

    for i, s in enumerate(sentences):
        print('Sentence #' + str(i + 1) + ':')
        print(s)
        print()

        token = nltk.word_tokenize(s)
        tag = nltk.pos_tag(token)
        rows = []

        for t in tag:
            word = t[0]
            part = pos.get(t[1])

            if part is not None:
                #synonyms = []
                synonyms = ''
                antonyms = []
                meanings = ''

                for i, j in enumerate(nltk.corpus.wordnet.synsets(word)):
                        meaning = '{}. {}\n'.format(i + 1, j.definition())
                        meanings = meanings + meaning

                        #print(j.lemma_names())
                        synonym = '{}. {}\n'.format(i + 1, j.lemma_names())
                        synonyms = synonyms + synonym

                        #synonym = '{}\n'.format(', '.join(j.lemma_names()))
                        #synonyms.append(synonym)


                """
                for syn in nltk.corpus.wordnet.synsets(word):
                    for name in syn.lemma_names():
                        synonyms.append(name)
                """

                """
                for syn in nltk.corpus.wordnet.synsets(word):
                    for l in syn.lemmas():
                        synonyms.append(l.name())
                        if l.antonyms():
                            antonyms.append(l.antonyms()[0].name())
                """
                
                row = [word, part, meanings, synonyms]
                rows.append(row)


        head = ['Word', 'Part of Speech', 'Meanings', 'Synonyms']
        table = tabulate.tabulate(rows, headers=head, tablefmt='grid')
        print(table)

        print('\n\n')


if __name__ == '__main__':
    nltk.download('averaged_perceptron_tagger')
    nltk.download('wordnet')

    in_file, out_file = parse_argv(sys.argv[1:])
    sentences(in_file)

    print('\n\ndone')


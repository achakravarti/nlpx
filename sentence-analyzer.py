#!/usr/bin/env python3


import sys, getopt, nltk, tabulate

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


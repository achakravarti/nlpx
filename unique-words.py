#!/usr/bin/env python3


import sys, getopt, nltk


def parse_argv(argv):
    in_file = ''
    out_file = ''

    try:
        opts, args = getopt.getopt(argv, 'hi:o:', ['input=', 'output='])
    except:
        print('./unique-words.py -i <input-file> -o <output-file>')
        sys.exit(2)

    for opt, arg in opts:
        if opt == '-h':
            print('./unique-words.py -i <input-file> -o <output-file>')
            sys.exit()
        elif opt in ('-i', '--input'):
            in_file = arg
        elif opt in ('-o', '--output'):
            out_file = arg
    
    return in_file, out_file


def parse_sentences(src):
    input_file = open(src, 'r')
    sentences = nltk.sent_tokenize(input_file.read())
    input_file.close()

    return sentences


def parse_tokens(sentences):
    token_list = []

    for s in sentences:
        tokens = nltk.word_tokenize(s)
        tagged_tokens = nltk.pos_tag(tokens)

        for t in tagged_tokens:
            token_list.append(t)

    return sorted(set(token_list))


def main():
    in_file, out_file = parse_argv(sys.argv[1:])
    sentences = parse_sentences(in_file)
    tokens = parse_tokens(sentences)

    print(tokens)
    print('Parsed', len(tokens), 'tokens from', len(sentences), 'sentences...')


if __name__ == '__main__':
    main()


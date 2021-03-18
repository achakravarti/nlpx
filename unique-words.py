#!/usr/bin/env python3


import sys, getopt, nltk, psycopg2, rake_nltk

from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.tokenize import sent_tokenize
from heapq import nlargest


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


def parse_keywords(sentences):
    r = rake_nltk.Rake()
    r.extract_keywords_from_sentences(sentences)

    return r.get_ranked_phrases()[:10]


# https://github.com/DivakarPM/NLP/blob/master/Text_Summarization/Text_Summarization.ipynb 
def parse_summary(in_file):
    stop_words = stopwords.words('english')
    punctuation ='!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~\n' 
    word_frequencies = {}
    sentence_scores = {}
    summary = ''

    with open(in_file, 'r') as input_file:
        text = input_file.read()
        tokens = word_tokenize(text)

        for word in tokens:
            if word.lower() not in stop_words:
                if word.lower() not in punctuation:
                    if word not in word_frequencies.keys():
                        word_frequencies[word] = 1
                    else:
                        word_frequencies[word] += 1

        max_frequency = max(word_frequencies.values())

        for word in word_frequencies.keys():
            word_frequencies[word] = word_frequencies[word] / max_frequency

        sent_token = sent_tokenize(text)
        
        for sent in sent_token:
            sentence = sent.split(' ')
            
            for word in sentence:
                if word.lower() in word_frequencies.keys():
                    if sent not in sentence_scores.keys():
                        sentence_scores[sent] = word_frequencies[word.lower()]
                    else:
                        sentence_scores[sent] += word_frequencies[word.lower()]

        select_length = int(len(sent_token) * 0.3)
        summary = nlargest(select_length, sentence_scores,
            key=sentence_scores.get)

        final_summary = [word for word in summary]
        summary = ' '.join(final_summary)

    return summary






def main():
    in_file, out_file = parse_argv(sys.argv[1:])
    sentences = parse_sentences(in_file)
    keywords = parse_keywords(sentences)
    tokens = parse_tokens(sentences)

    print(tokens)
    print('Parsed', len(tokens), 'tokens from', len(sentences), 'sentences...')

    conn = psycopg2.connect('dbname=nlpx user=nlpx password=nlpx')
    cur = conn.cursor()
    cur.execute('SELECT * FROM pos.upenn_treebank;')
    print(str(cur.fetchone()))
    cur.close()
    conn.close()

    print(keywords)
    print(parse_summary(in_file))


def download():
    nltk.download('averaged_perceptron_tagger')
    nltk.download('wordnet')
    nltk.download('stopwords')


if __name__ == '__main__':
    download()
    main()


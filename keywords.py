#!/usr/bin/env python3


from gensim.summarization import keywords
from gensim.summarization.keywords import get_graph
import networkx as nx
import matplotlib.pyplot as plt

import spacy
from spacy import displacy

def get_text():
    return open('corpus/the-monkeys-paw.txt', 'r').read()


def displayGraph(textGraph):
    graph = nx.Graph()
    for edge in textGraph.edges():
        graph.add_node(edge[0])
        graph.add_node(edge[1])
        graph.add_weighted_edges_from([(edge[0], edge[1], textGraph.edge_weight(edge))])

        textGraph.edge_weight(edge)
    pos = nx.spring_layout(graph)
    plt.figure()
    nx.draw(graph, pos, edge_color='black', width=1, linewidths=1,
            node_size=500, node_color='seagreen', alpha=0.9,
            labels={node: node for node in graph.nodes()})
    plt.axis('off')
    plt.show()


def test_gensim():
    text = get_text()
    kw = keywords(text).split('\n')
    print(kw)
    #displayGraph(get_graph(text))


# https://towardsdatascience.com/keyword-extraction-process-in-python-with-natural-language-processing-nlp-d769a9069d5c
#https://spacy.io/usage/visualizers
def test_spacy():
    nlp = spacy.load('en_core_web_trf')
    text = get_text()
    doc = nlp(text)
    #print(doc.ents)
    displacy.serve(doc, style='ent')


def main():
    #test_gensim()
    test_spacy()


if __name__ == '__main__':
    main()

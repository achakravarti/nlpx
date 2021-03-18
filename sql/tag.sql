-- https://github.com/explosion/spaCy/blob/master/spacy/glossary.py

SET search_path TO PUBLIC;

DROP SCHEMA IF EXISTS tag CASCADE;
CREATE SCHEMA IF NOT EXISTS tag;

CREATE TYPE tag.pos_class AS ENUM(
	'penn_treebank',
	'universal'
);


CREATE TABLE IF NOT EXISTS tag.pos(
	id	BIGSERIAL PRIMARY KEY,
	class	tag.pos_class NOT NULL,
	pos	VARCHAR(5) NOT NULL UNIQUE,
	def	VARCHAR(128) NOT NULL
);


CREATE TABLE IF NOT EXISTS tag.dependency(
	id	BIGSERIAL PRIMARY KEY,
	label	VARCHAR(16) NOT NULL UNIQUE,
	def	VARCHAR(128) NOT NULL
);


CREATE TABLE IF NOT EXISTS tag.entity(
	id	BIGSERIAL PRIMARY KEY,
	name	VARCHAR(16) NOT NULL UNIQUE,
	def	VARCHAR(128) NOT NULL
);


INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'ADJ', 'adjective')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'ADP', 'adposition')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'ADV', 'adverb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'AUX', 'auxiliary')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'CONJ', 'conjunction')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'CCONJ', 'coordinating conjunction')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'DET', 'determiner')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'INTJ', 'interjection')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'NOUN', 'noun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'NUM', 'numeral')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'PART', 'particle')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'PRON', 'pronoun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'PROPN', 'proper noun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'PUNCT', 'punctuation')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'SCONJ', 'subordinating conjunction')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'SYM', 'symbol')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'VERB', 'verb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'X', 'other')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'EOL', 'end of line')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('universal', 'SPACE', 'space')
	ON CONFLICT DO NOTHING;


INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', '.', 'punctuation mark')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', ',', 'punctuation mark')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', '-LRB-', 'left round bracket')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', '-RRB-', 'right round bracket')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', '``', 'opening quotation mark')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', '""', 'closing quotation mark')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', '''''', 'closing quotation mark')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', ':', 'punctuation mark')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', '$', 'symbol')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', '#', 'symbol')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'AFX', 'affix')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'CC', 'conjunction')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'CD', 'cardinal number')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'DT', 'determiner')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'EX', 'existential there')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'FW', 'foreign word')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'HYPH', 'punctuation mark')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'IN', 'conjunction')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'JJ', 'adjective')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'JJR', 'adjective')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'JJS', 'adjective')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'LS', 'list item marker')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'MD', 'verb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'NIL', 'missing tag')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'NN', 'noun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'NNP', 'noun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'NNPS', 'noun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'NNS', 'noun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'PDT', 'predeterminer')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'POS', 'possessive ending')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'PRP', 'pronoun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'PRP$', 'pronoun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'RB', 'adverb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'RBR', 'adverb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'RBS', 'adverb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'RP', 'adverb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'TO', 'infinitival to')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'UH', 'interjection')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'VB', 'verb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'VBD', 'verb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'VBG', 'verb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'VBN', 'verb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'VBP', 'verb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'VBZ', 'verb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'WDT', 'wh-determiner')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'WP', 'wh-pronoun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'WP$', 'wh-pronoun')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'WRB', 'wh-adverb')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'SP', 'space')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'ADD', 'email')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'NFP', 'superfluous punctuation')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'GW', 'additional word in multi-word expression')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'XX', 'unknown')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'BES', 'auxiliary be')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.pos(class, pos, def)
	VALUES('penn_treebank', 'HVS', 'forms of have')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('acl', 'clausal modifier of noun (adjectival clause)')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('acomp', 'adjectival complement')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('advcl', 'adverbial clause modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('advmod', 'adverbial modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('agent', 'agent')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('amod', 'adjectival modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('appos', 'appositional modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('attr', 'attribute')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('aux', 'auxiliary')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('auxpass', 'auxiliary (passive)')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('case', 'case marking')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('cc', 'coordinating conjunction')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('ccomp', 'clausal complement')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('clf', 'classifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('complm', 'complementizer')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('compound', 'compound')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('conj', 'conjunct')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('cop', 'copula')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('csubj', 'clausal subject')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('csubjpass', 'clausal subject (passive)')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('dative', 'dative')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('dep', 'unclassified dependent')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('det', 'determiner')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('discourse', 'discourse element')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('dislocated', 'dislocated elements')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('dobj', 'direct object')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('expl', 'expletive')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('fixed', 'fixed multiword expression')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('flat', 'flat multiword expression')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('goeswith', 'goes with')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('hmod', 'modifier in hyphenation')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('hyph', 'hyphen')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('infmod', 'infinitival modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('intj', 'interjection')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('iobj', 'indirect object')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('list', 'list')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('mark', 'marker')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('meta', 'meta modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('neg', 'negation modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('nmod', 'modifier of nominal')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('nn', 'noun compound modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('npadvmod', 'noun phrase as adverbial modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('nsubj', 'nominal subject')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('nsubjpass', 'nominal subject (passive)')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('nounmod', 'modifier of nominal')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('npmod', 'noun phrase as adverbial modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('num', 'number modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('number', 'number compound modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('nummod', 'numeric modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('oprd', 'object predicate')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('obj', 'object')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('obl', 'oblique nominal')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('orphan', 'orphan')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('parataxis', 'parataxis')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('partmod', 'participal modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('pcomp', 'complement of preposition')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('pobj', 'object of preposition')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('poss', 'possession modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('possessive', 'possessive modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('preconj', 'pre-correlative conjunction')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('prep', 'prepositional modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('prt', 'particle')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('punct', 'punctuation')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('quantmod', 'modifier of quantifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('rcmod', 'relative clause modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('relcl', 'relative clause modifier')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('reparandum', 'overridden disfluency')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('root', 'root')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('vocative', 'vocative')
	ON CONFLICT DO NOTHING;

INSERT INTO tag.dependency(label, def)
	VALUES('xcomp', 'open clausal complement')
	ON CONFLICT DO NOTHING;



GRANT USAGE ON SCHEMA tag TO nlpx;
GRANT SELECT ON ALL TABLES IN SCHEMA tag TO nlpx;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA tag TO nlpx;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA tag TO nlpx;


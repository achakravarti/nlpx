SET SEARCH_PATH TO PUBLIC;


DROP TABLE IF EXISTS _pos CASCADE;


CREATE TABLE IF NOT EXISTS _pos(
	id		BIGSERIAL PRIMARY KEY,
	name		VARCHAR(5) NOT NULL UNIQUE,
	description	VARCHAR(64) NOT NULL,
	example		VARCHAR(64)
);


BEGIN;
	INSERT INTO _pos(name, description, example) VALUES('CC',
	    'coordinating conjunction', NULL) ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('CD',
	    'cardinal digit', NULL) ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('DT',
	    'determiner', NULL) ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('EX',
	    'existential there', NULL) ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('FW',
	    'foreign word', NULL) ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('IN',
	    'preposition/subordinating conjunction', NULL)
	    ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('JJ',
	    'adjective', 'large') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('JJR',
	    'adjective, comparative',  'larger') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('JJS',
	    'adjective, superlative', 'largest') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('LS',
	    'list marker', NULL) ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('MD',
	    'modal',  'could, will') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('NN',
	    'noun, singular', 'cat, tree') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('NNS',
	    'noun, plural', 'desks') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('NNP',
	    'proper noun, singular', 'Sarah') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('NNPS',
	    'proper noun, plural', 'Indians or Americans')
            ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('PDT',
	    'predeterminer', 'all, both, half') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('POS',
	    'possessive ending', 'parent''s') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('PRP',
	    'personal pronoun', 'hers, herself, him,himself')
	    ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('PRP$',
	    'possessive pronoun', 'her, his, mine, my, our')
            ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('RB',
	    'adverb',  'occasionally, swiftly') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('RBR',
	    'adverb, comparative', 'greater') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('RBS',
	    'adverb, superlative', 'biggest') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('RP',
	    'particle', 'about') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('TO',
	    'infinite marker', 'to') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('UH',
	    'interjection', 'goodbye') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('VB',
	    'verb', 'ask') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('VBG',
	    'verb gerund', 'judging') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('VBD',
	    'verb past tense', 'pleaded') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('VBN',
	    'verb past participle', 'reunified') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('VBP',
	    'verb, present tense not 3rd person singular', 'wrap')
            ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('VBZ',
	    'verb, present tense with 3rd person singular', 'bases')
            ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('WDT',
	    'wh-determiner', 'that, what') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('WP',
	    'wh- pronoun', 'who') ON CONFLICT DO NOTHING;
	INSERT INTO _pos(name, description, example) VALUES('WRB',
	    'wh-adverb', 'how') ON CONFLICT DO NOTHING;
END;


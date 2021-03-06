SET search_path TO PUBLIC;


DROP SCHEMA IF EXISTS pos CASCADE;
CREATE SCHEMA IF NOT EXISTS pos;




-- https://stackoverflow.com/questions/15388831
-- https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html
CREATE TABLE IF NOT EXISTS pos.upenn_treebank(
	id		BIGSERIAL PRIMARY KEY,
	tag		VARCHAR(5) NOT NULL UNIQUE,
	description	VARCHAR(64) NOT NULL,
	example		VARCHAR(64)
);


CREATE OR REPLACE FUNCTION pos.upenn_treebank_find(
	_tag	TEXT
) RETURNS BIGINT
AS $func$
DECLARE
	__id	BIGINT;
BEGIN
	__id := (SELECT id FROM pos.upenn_treebank WHERE tag = _tag);

	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag % not available', _tag;
	END IF;

	RETURN __id;
END;
$func$ LANGUAGE plpgsql;

BEGIN;
	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'CC', 'Coordinating conjunction', NULL
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'CD', 'Cardinal number', NULL
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'DT', 'Determiner', NULL
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'EX', 'Existential ''there''', NULL
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'FW', 'Foreign word', NULL
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'IN', 'Preposition or subordinating conjunction', NULL
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'JJ', 'Adjective', 'large'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'JJR', 'Adjective, comparative',  'larger'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'JJS', 'Adjective, superlative', 'largest'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'LS', 'List item marker', NULL
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'MD', 'Modal',  'could, will'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'NN', 'Noun, singular or mass', 'cat, tree'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'NNS', 'Noun, plural', 'desks'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'NNP', 'Proper noun, singular', 'Sarah'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'NNPS', 'Proper noun, plural', 'Indians or Americans'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'PDT', 'Predeterminer', 'all, both, half'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'POS', 'Possessive ending', 'parent''s'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'PRP', 'Personal pronoun', 'hers, herself, him,himself'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
		'PRP$', 'Possessive pronoun', 'her, his, mine, my, our'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'RB', 'Adverb',  'occasionally, swiftly'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'RBR', 'Adverb, comparative', 'greater'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'RBS', 'Adverb, superlative', 'biggest'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'RP', 'Particle', 'about'
	) ON CONFLICT DO NOTHING;
	
	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'SYM', 'Symbol', NULL
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'TO', 'Infinitive marker', 'to'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'UH', 'Interjection', 'goodbye'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'VB', 'Verb, base form', 'ask'
	) ON CONFLICT DO NOTHING;
	
	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'VBD', 'Verb, past tense', 'pleaded'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'VBG', 'Verb, gerund', 'judging'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'VBN', 'Verb, past participle', 'reunified'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'VBP', 'Verb, non-3rd person singular present', 'wrap'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'VBZ', 'Verb, 3rd person singular present', 'bases'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'WDT', 'Wh-determiner', 'that, what'
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'WP', 'Wh- pronoun', 'who'
	) ON CONFLICT DO NOTHING;
	
	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'WP$', 'Possessive wh- pronoun', NULL
	) ON CONFLICT DO NOTHING;

	INSERT INTO pos.upenn_treebank(tag, description, example) VALUES(
	    'WRB', 'Wh-adverb', 'how'
	) ON CONFLICT DO NOTHING;
END;


GRANT USAGE ON SCHEMA pos TO nlpx;
GRANT SELECT ON ALL TABLES IN SCHEMA pos TO nlpx;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA pos TO nlpx;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA pos TO nlpx;


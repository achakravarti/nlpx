SET search_path TO PUBLIC;


CREATE TABLE IF NOT EXISTS _lexicon(
	id	BIGSERIAL PRIMARY KEY,
	word	VARCHAR(64) NOT NULL,
	tag	BIGINT REFERENCES _upenn_treebank_tagset(id) ON DELETE CASCADE,
	corpus	BIGINT REFERENCES _corpus(id) ON DELETE SET NULL,
	flag	SMALLINT,
	UNIQUE(word, tag)
);



CREATE OR REPLACE PROCEDURE lexicon_add(
	p_word	TEXT,
	p_tag	TEXT,	
	p_title	TEXT
) AS $$
DECLARE
	v_tag		BIGINT;
	v_corpus	BIGINT;
BEGIN
	v_tag := (SELECT id FROM _upenn_treebank_tagset WHERE tag = p_tag);
	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag % not available', p_tag;
	END IF;
	
	v_corpus := (SELECT id FROM _corpus WHERE title = p_title);
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Title ''%'' not avaiable in corpus', p_title;
	END IF;

	INSERT INTO _lexicon(word, tag, corpus, flag) 
	    VALUES(p_word, v_tag, v_corpus, -1)
	    ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE PLPGSQL;


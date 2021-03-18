SET search_path TO PUBLIC;


CREATE SCHEMA IF NOT EXISTS lexicon;


CREATE TABLE IF NOT EXISTS lexicon.data(
	id	BIGSERIAL PRIMARY KEY,
	word	VARCHAR(64) NOT NULL,
	tag	BIGINT REFERENCES pos.upenn_treebank(id) ON DELETE CASCADE,
	src	BIGINT REFERENCES corpus.__data__(id) ON DELETE SET NULL,
	flag	SMALLINT,
	UNIQUE(word, tag)
);


CREATE OR REPLACE PROCEDURE lexicon.new(
	p_word	TEXT,
	p_tag	TEXT,	
	p_title	TEXT
) AS $$
DECLARE
	v_tag		BIGINT;
	v_corpus	BIGINT;

	v_tag := (SELECT id FROM pos.upenn_treebank WHERE tag = p_tag);
	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag % not available', p_tag;
	END IF;
	
	v_corpus := (SELECT id FROM corpus.data WHERE title = p_title);
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Title ''%'' not avaiable in corpus', p_title;
	END IF;

	INSERT INTO lexicon.data(word, tag, src, flag) 
	    VALUES(p_word, v_tag, v_corpus, -1)
	    ON CONFLICT DO NOTHING;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE lexicon.flag(
	p_id	BIGINT,
	p_flag	INT
) AS $$
	UPDATE _lexicon.data SET flag = p_flag WHERE id = p_id;
$$ LANGUAGE sql;



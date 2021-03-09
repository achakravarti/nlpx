SET search_path TO PUBLIC;


CREATE TABLE IF NOT EXISTS _lexicon(
	id	BIGSERIAL PRIMARY KEY,
	word	VARCHAR(64) NOT NULL,
	tag	BIGINT REFERENCES _upenn_treebank_tagset(id) ON DELETE CASCADE,
	flag	INT,
	UNIQUE(word, tag)
);



CREATE OR REPLACE PROCEDURE lexicon_add(
	p_word	VARCHAR(64),
	p_tag	VARCHAR(6),
	p_flag	INT
) AS $$
DECLARE
	v_tag	BIGINT;
BEGIN
	v_tag := (SELECT id FROM _upenn_treebank_tagset WHERE tag = p_tag);

	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag % not available', p_tag;
	END IF;

	INSERT INTO _lexicon(tag, word, flag) VALUES(v_tag, p_word, p_flag)
	    ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE PLPGSQL;


SET search_path TO PUBLIC;

CREATE TABLE IF NOT EXISTS _lexicon(
	id	BIGSERIAL PRIMARY KEY,
	pos	BIGINT REFERENCES _pos(id) ON DELETE CASCADE,
	word	VARCHAR(64) NOT NULL,
	flag	INT,
	UNIQUE(pos, word)
);


CREATE OR REPLACE PROCEDURE lexicon_add(
	p_word	VARCHAR(64),
	p_pos	VARCHAR(6),
	p_flag	INT
) AS $$
DECLARE
	v_pos	BIGINT;
BEGIN
	v_pos := (SELECT id FROM _pos WHERE name = p_pos);

	IF NOT FOUND THEN
		RAISE EXCEPTION 'POS % not available', p_pos;
	END IF;

	INSERT INTO _lexicon(pos, word, flag) VALUES(v_pos, p_word, p_flag)
	    ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE PLPGSQL;


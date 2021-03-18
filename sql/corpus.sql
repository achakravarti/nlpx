SET search_path TO PUBLIC;


DROP SCHEMA IF EXISTS corpus CASCADE;
CREATE SCHEMA IF NOT EXISTS corpus;


CREATE TABLE IF NOT EXISTS corpus.title(
	id	BIGSERIAL PRIMARY KEY,
	title	VARCHAR(256) NOT NULL UNIQUE,
	author	VARCHAR(512) NOT NULL
);


CREATE TABLE IF NOT EXISTS corpus.lexeme(
	id	BIGSERIAL PRIMARY KEY,
	token	VARCHAR(64) NOT NULL,
	tag	BIGINT REFERENCES pos.upenn_treebank(id) ON DELETE CASCADE,
	UNIQUE(token, tag)
);



CREATE TABLE IF NOT EXISTS corpus.token(
	id	BIGSERIAL PRIMARY KEY,
	title	BIGINT REFERENCES corpus.title(id) ON DELETE CASCADE,
	lexeme	BIGINT REFERENCES corpus.lexeme(id) ON DELETE CASCADE,
	num	INT NOT NULL,
	sent	INT NOT NULL,
	para	INT NOT NULL
);


CREATE OR REPLACE PROCEDURE corpus.title_add(
	_title	TEXT,
	_author	TEXT
) AS $$
	INSERT INTO corpus.title(title, author) VALUES(_title, _author)
	    ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;


CREATE OR REPLACE FUNCTION corpus.title_get(
	_id	BIGINT
) RETURNS TABLE (
	id	BIGINT,
	title	VARCHAR(256),
	author	VARCHAR(512)
) AS $body$
	SELECT id, title, author FROM corpus.title WHERE id = _id;
$body$ LANGUAGE sql;


CREATE OR REPLACE FUNCTION corpus.title_list(
) RETURNS TABLE (
	id	BIGINT,
	title	VARCHAR(256),
	author	VARCHAR(512)
) AS $body$
	SELECT id, title, author FROM corpus.title;
$body$ LANGUAGE sql;


CREATE OR REPLACE FUNCTION corpus.title_find(
	_title	TEXT
) RETURNS BIGINT
AS $func$
DECLARE
	__id	BIGINT;
BEGIN
	__id := (SELECT id FROM corpus.title WHERE title = _title);

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Corpus title % not available', _title;
	END IF;

	RETURN __id;
END;
$func$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION corpus.lexeme_find(
	_token	TEXT,
	_tag	TEXT
) RETURNS BIGINT
AS $func$
DECLARE
	__id	BIGINT;
	__tag	BIGINT;
BEGIN
	__tag := pos.upenn_treebank_find(_tag);
	
	__id := (SELECT id FROM corpus.lexeme WHERE token = _token AND tag = __tag);

	IF NOT FOUND THEN
		RAISE EXCEPTION 'lexeme % (%) not available', _token, _tag;
	END IF;

	RETURN __id;
END;
$func$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE corpus.lexeme_add(
	_token	TEXT,
	_tag	TEXT
) AS $$
DECLARE
	__tag	BIGINT;
BEGIN
	__tag := pos.upenn_treebank_find(_tag);

	INSERT INTO corpus.lexeme(token, tag) VALUES(_token, __tag)
		ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE corpus.token_add(
	_title	TEXT,
	_token	TEXT,
	_tag	TEXT,
	_num	INT,
	_sent	INT,
	_para	INT
) AS $$
DECLARE
	__title		BIGINT;
	__lexeme	BIGINT;
BEGIN
	__title := corpus.title_find(_title);
	__lexeme := corpus.lexeme_find(_token, _tag);

	INSERT INTO corpus.token(title, lexeme, num, sent, para) VALUES(
		__title, __lexeme, _num, _sent, _para);
END;
$$ LANGUAGE plpgsql;


SET search_path TO PUBLIC;


CREATE OR REPLACE FUNCTION tag.pos_single(
	_id	BIGINT
) RETURNS TABLE(
	id	BIGINT,
	class	VARCHAR(16),
	pos	VARCHAR(5),
	def	VARCHAR(128)
) AS $func$
BEGIN
	SELECT id, class, pos, def FROM tag.pos WHERE id = _id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag with ID % not available', _id;
	END IF;
END;
$func$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION tag.pos_list()
RETURNS TABLE(
	id	BIGINT,
	class	VARCHAR(16),
	pos	VARCHAR(5),
	def	VARCHAR(128)
) AS $func$
	SELECT id, class, pos, def FROM tag.pos ORDER BY class, pos;
$func$ LANGUAGE sql;


CREATE OR REPLACE PROCEDURE tag.pos_add_universal(
	_pos	TEXT,
	_def	TEXT
) AS $$
	INSERT INTO tag.pos(class, pos, def) VALUES('universal', _pos, _def)
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;


CREATE OR REPLACE PROCEDURE tag.pos_add_penn_treebank(
	_pos	TEXT,
	_def	TEXT
) AS $$
	INSERT INTO tag.pos(class, pos, def) VALUES('penn_treebank', _pos, _def)
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;




CREATE OR REPLACE FUNCTION tag.dependency_single(
	_id	BIGINT
) RETURNS TABLE(
	id	BIGINT,
	label	VARCHAR(16),
	def	VARCHAR(128)
) AS $func$
BEGIN
	SELECT id, label, def FROM tag.dependency WHERE id = _id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag with ID % not available', _id;
	END IF;
END;
$func$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION tag.dependency_list()
RETURNS TABLE(
	id	BIGINT,
	label	VARCHAR(16),
	def	VARCHAR(128)
) AS $func$
	SELECT id, label, def FROM tag.dependency ORDER BY label;
$func$ LANGUAGE sql;


CREATE OR REPLACE PROCEDURE tag.dependency_add(
	_lab	TEXT,
	_def	TEXT
) AS $$
	INSERT INTO tag.dependency(label, def) VALUES(_lab, _def) 
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;




CREATE OR REPLACE FUNCTION tag.entity_single(
	_id	BIGINT
) RETURNS TABLE(
	id	BIGINT,
	name	VARCHAR(16),
	def	VARCHAR(128)
) AS $func$
BEGIN
	SELECT id, name, def FROM tag.entity WHERE id = _id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag with ID % not available', _id;
	END IF;
END;
$func$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION tag.entity_list()
RETURNS TABLE(
	id	BIGINT,
	name	VARCHAR(16),
	def	VARCHAR(128)
) AS $func$
	SELECT id, name, def FROM tag.entity ORDER BY name;
$func$ LANGUAGE sql;


CREATE OR REPLACE PROCEDURE tag.entity_add(
	_name	TEXT,
	_def	TEXT
) AS $$
	INSERT INTO tag.entity(name, def) VALUES(_name, _def) 
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;


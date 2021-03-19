SET search_path TO PUBLIC;


CREATE OR REPLACE FUNCTION tag.pos_single(
	id_	BIGINT
) RETURNS TABLE(
	id	BIGINT,
	class	VARCHAR(16),
	pos	VARCHAR(5),
	def	VARCHAR(128)
) AS $$
BEGIN
	RETURN QUERY SELECT _id, _class::VARCHAR(16), _pos, _def FROM tag.pos
		WHERE _id = id_;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag with ID % not available', id_;
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION tag.pos_list()
RETURNS TABLE(
	id	BIGINT,
	class	VARCHAR(16),
	pos	VARCHAR(5),
	def	VARCHAR(128)
) AS $$
BEGIN
	RETURN QUERY SELECT _id, _class::VARCHAR(16), _pos, _def FROM tag.pos
		ORDER BY _class, _pos;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE tag.pos_add_universal(
	pos_	TEXT,
	def_	TEXT
) AS $$
	INSERT INTO tag.pos(_class, _pos, _def) VALUES('universal', pos_, def_)
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;


CREATE OR REPLACE PROCEDURE tag.pos_add_penn_treebank(
	pos_	TEXT,
	def_	TEXT
) AS $$
	INSERT INTO tag.pos(_class, _pos, _def) 
		VALUES('penn_treebank', pos_, def_)
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;




CREATE OR REPLACE FUNCTION tag.dependency_single(
	id_	BIGINT
) RETURNS TABLE(
	id	BIGINT,
	label	VARCHAR(16),
	def	VARCHAR(128)
) AS $$
BEGIN
	RETURN QUERY SELECT _id, _label, _def FROM tag.dependency
		WHERE _id = id_;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag with ID % not available', id_;
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION tag.dependency_list()
RETURNS TABLE(
	id	BIGINT,
	label	VARCHAR(16),
	def	VARCHAR(128)
) AS $$
BEGIN
	RETURN QUERY SELECT _id, _label, _def FROM tag.dependency
		ORDER BY _label;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE tag.dependency_add(
	lab_	TEXT,
	def_	TEXT
) AS $$
	INSERT INTO tag.dependency(_label, _def) VALUES(lab_, def_)
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;




CREATE OR REPLACE FUNCTION tag.entity_single(
	id_	BIGINT
) RETURNS TABLE(
	id	BIGINT,
	name	VARCHAR(16),
	def	VARCHAR(128)
) AS $$
BEGIN
	RETURN QUERY SELECT _id, _name, _def FROM tag.entity WHERE _id = id_;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'PoS tag with ID % not available', _id;
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION tag.entity_list()
RETURNS TABLE(
	id	BIGINT,
	name	VARCHAR(16),
	def	VARCHAR(128)
) AS $$
BEGIN
	RETURN QUERY SELECT _id, _name, _def FROM tag.entity ORDER BY _name;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE tag.entity_add(
	name_	TEXT,
	def_	TEXT
) AS $$
	INSERT INTO tag.entity(_name, _def) VALUES(name_, def_)
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;


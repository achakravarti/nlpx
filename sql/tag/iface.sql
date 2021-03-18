SET search_path TO PUBLIC;


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


CREATE OR REPLACE PROCEDURE tag.dependency_add(
	_lab	TEXT,
	_def	TEXT
) AS $$
	INSERT INTO tag.dependency(label, def) VALUES(_lab, _def) 
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;


CREATE OR REPLACE PROCEDURE tag.entity_add(
	_name	TEXT,
	_def	TEXT
) AS $$
	INSERT INTO tag.entity(name, def) VALUES(_name, _def) 
		ON CONFLICT DO NOTHING;
$$ LANGUAGE sql;


CREATE OR REPLACE FUNCTION tag.pos_list()
RETURNS TABLE(
	id	BIGINT,
	class	VARCHAR(16),
	pos	VARCHAR(5),
	def	VARCHAR(128)
) AS $func$
	SELECT id, class, pos, def FROM tag.pos;
$func$ LANGUAGE sql;

SET search_path TO PUBLIC;


CREATE SCHEMA IF NOT EXISTS tag;


CREATE TYPE tag.pos_class AS ENUM(
	'penn_treebank',
	'universal'
);


CREATE TABLE IF NOT EXISTS tag.pos(
	id	BIGSERIAL PRIMARY KEY,
	class	tag.pos_class NOT NULL,
	pos	VARCHAR(5) NOT NULL UNIQUE,
	def	VARCHAR(128) NOT NULL
);


CREATE TABLE IF NOT EXISTS tag.dependency(
	id	BIGSERIAL PRIMARY KEY,
	label	VARCHAR(16) NOT NULL UNIQUE,
	def	VARCHAR(128) NOT NULL
);


CREATE TABLE IF NOT EXISTS tag.entity(
	id	BIGSERIAL PRIMARY KEY,
	name	VARCHAR(16) NOT NULL UNIQUE,
	def	VARCHAR(128) NOT NULL
);


GRANT USAGE ON SCHEMA tag TO nlpx;
GRANT SELECT ON ALL TABLES IN SCHEMA tag TO nlpx;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA tag TO nlpx;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA tag TO nlpx;


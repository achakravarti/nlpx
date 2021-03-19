set search_path to public;


create extension if not exists pg_trgm;
create schema if not exists tag;


create type tag.pos_class as enum(
	'penn_treebank',
	'universal'
);


create table if not exists tag.pos(
	_id	bigserial primary key,
	_class	tag.pos_class not null,
	_pos	varchar(5) not null unique,
	_def	varchar(128) not null
);


create table if not exists tag.dependency(
	_id	bigserial primary key,
	_label	varchar(16) not null unique,
	_def	varchar(128) not null
);


create table if not exists tag.entity(
	_id	bigserial primary key,
	_name	varchar(16) not null unique,
	_def	varchar(128) not null
);


grant usage on schema tag to nlpx;
grant select on all tables in schema tag to nlpx;
grant select on all sequences in schema tag to nlpx;
grant execute on all functions in schema tag to nlpx;


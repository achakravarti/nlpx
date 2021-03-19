set search_path to public;


create extension if not exists pg_trgm;
create schema if not exists tags;


create type tags.pos_cat as enum (
	'PENN_TREEBANK',
	'UNIVERSAL'
);


create table if not exists tags.pos (
	_id	bigserial primary key,
	_cat	tags.pos_cat not null,
	_tag	varchar (5) not null unique,
	_def	varchar (128) not null
);


create table if not exists tags.dependency (
	_id	bigserial primary key,
	_tag	varchar (16) not null unique,
	_def	varchar (128) not null
);


create table if not exists tags.entity (
	_id	bigserial primary key,
	_tag	varchar (16) not null unique,
	_def	varchar (128) not null
);


grant usage on schema tags to nlpx;
grant select on all tables in schema tags to nlpx;
grant select on all sequences in schema tags to nlpx;
grant execute on all functions in schema tags to nlpx;


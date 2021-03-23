set search_path to public;


create extension if not exists pg_trgm;
create schema if not exists tags;


grant usage on schema tags to nlpx;
grant select on all tables in schema tags to nlpx;
grant select on all sequences in schema tags to nlpx;
grant execute on all functions in schema tags to nlpx;


do $$ 
begin
	create type tags.pos_cat as enum (
		'PENN_TREEBANK',
		'UNIVERSAL'
	);
exception
	when duplicate_object then null;
end 
$$;


create table if not exists tags.pos (
	id	int primary key generated always as identity,
	cat	tags.pos_cat not null,
	tag	varchar (5) not null unique,
	def	varchar (128) not null
);


create table if not exists tags.dependency (
	id	int primary key generated always as identity,
	tag	varchar (16) not null unique,
	def	varchar (128) not null
);


create table if not exists tags.entity (
	id	int primary key generated always as identity,
	tag	varchar (16) not null unique,
	def	varchar (128) not null
);


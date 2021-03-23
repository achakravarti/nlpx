set search_path to public;


create extension if not exists pg_trgm;
create schema if not exists corpus;


create table if not exists corpus.title (
	id	int primary key generated always as identity,
	title	varchar (256) not null unique,
	author	varchar	(512) not null
);


create table if not exists corpus.token (
	id	int primary key generated always as identity,
	lexeme	varchar (64) not null,
	pos	int references tags.pos (id) on delete cascade,
	unique (lexeme, pos)
);


create table if not exists corpus.breakup (
	id	int primary key generated always as identity,
	title	int references corpus.title (id) on delete cascade,
	token	int references corpus.token (id) on delete cascade,
	idx	int not null,
	sent	int not null,
	para	int not null,
	unique (title, token, idx, sent, para)
);


grant usage on schema corpus to nlpx;
grant select on all tables in schema corpus to nlpx;
grant select on all sequences in schema corpus to nlpx;
grant execute on all functions in schema corpus to nlpx;


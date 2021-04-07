set search_path to corpus, public;


create or replace function title_single(
	p_id	int
) returns setof title
as $$
begin
	return query
	select	T.id,
		T.title,
		T.author
	from corpus.title as T
	where T.id = p_id;

	if not found then
		raise exception 'title with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function title_all()
returns setof title
as $$
	select	T.id,
		T.title,
		T.author
	from corpus.title as T
	order by T.title;
$$ language sql;


create or replace function title_find(
	p_title	text
) returns table (
	id	int
) as $$
	select T.id
	from corpus.title as T
	where T.title = p_title;
$$ language sql;


create or replace function title_search(
	p_title	text
) returns setof corpus.title
as $$
	select	T.id,
		T.title,
		T.author
	from corpus.title as T
	where T.title % p_title
	order by T.title;
$$ language sql;


create or replace procedure title_add(
	p_title		text,
	p_author	text
) as $$
	insert into corpus.title (title, author)
	values (p_title, p_author)
	on conflict do nothing;
$$ language sql;


create or replace function token_single(
	p_id	int
) returns table (
	id	int,
	lexeme	text,
	pos	text
) as $$
begin
	return query
	select	T.id,
		T.lexeme::text,
		P.tag::text as pos
	from corpus.token as T
	inner join tags.pos as P on T.pos = P.id
	where T.id = p_id;

	if not found then
		raise exception 'token with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function token_all()
returns table (
	id	int,
	lexeme	text,
	pos	text
) as $$
	select	T.id,
		T.lexeme::text,
		P.tag::text as pos
	from corpus.token as T
	inner join tags.pos as P on T.pos = P.id;
$$ language sql;


create or replace function token_find(
	p_lexeme	text,
	p_pos		text
) returns table (
	id	int
) as $$
	select T.id
	from corpus.token as T
	where T.lexeme = p_lexeme
	and T.pos = (select id from tags.pos_find(p_pos));
$$ language sql;


create or replace function token_search(
	p_lexeme	text
) returns table (
	id	int,
	lexeme	text,
	pos	text
) as $$
	select	T.id,
		T.lexeme::text,
		P.tag::text as pos
	from corpus.token as T
	inner join tags.pos as P on T.pos = P.id
	where T.lexeme % p_lexeme
	order by T.lexeme;
$$ language sql;


create or replace procedure token_add(
	p_lexeme	text,
	p_pos		text
) as $$
	insert into corpus.token (lexeme, pos)
	values (p_lexeme, tags.pos_find(p_pos))
	on conflict do nothing;
$$ language sql;


create or replace function breakup_single(
	p_id	int
) returns table (
	id	int,
	title	text,
	para	int,
	sent	int,
	idx	int,
	lexeme	text,
	pos	text
) as $$
begin
	return query
	select	B.id,
		T.title::text,
		B.para,
		B.sent,
		B.idx,
		K.lexeme::text,
		P.tag::text
	from corpus.breakup as B
	inner join corpus.title as T on B.title = T.id
	inner join corpus.token as K on B.token = K.id
	inner join tags.pos as P on K.pos = P.id
	where B.id = p_id;
end;
$$
language plpgsql;


create or replace function breakup_all()
returns table (
	id	int,
	title	text,
	para	int,
	sent	int,
	idx	int,
	lexeme	text,
	pos	text
) as $$
	select	B.id,
		T.title::text,
		B.para,
		B.sent,
		B.idx,
		K.lexeme::text,
		P.tag::text
	from corpus.breakup as B
	inner join corpus.title as T on B.title = T.id
	inner join corpus.token as K on B.token = K.id
	inner join tags.pos as P on K.pos = P.id
	order by T.title, B.para, B.sent, B.idx;
$$ language sql;


create or replace function breakup_title(
	p_text	text
) returns table (
	id	int,
	lexeme	text,
	pos	text,
	idx	int,
	sent	int,
	para	int
) as $$
	select 	B.id,
		T.lexeme::text,
		P.tag::text,
		B.idx,
		B.sent,
		B.para
	from corpus.breakup as B
	inner join corpus.token as T on B.token = T.id
	inner join tags.pos as P on T.pos = P.id
	where B.title = (select id from corpus.title_find(p_text))
	order by B.para, B.sent, B.idx;
$$ language sql;

create or replace function breakup_find(
	p_title		text,
	p_para		int,
	p_sent		int,
	p_idx		int,
	p_lexeme	text,
	p_pos		text
) returns table (
	id	int
) as $$
	select B.id
	from corpus.breakup as B
	where B.title = (select id 
			 from corpus.title_find(p_title))
	and B.token = (select id 
		       from corpus.token_find(p_lexeme, p_pos))
	and B.para = p_para
	and B.sent = p_sent
	and B.idx = p_idx;
$$ language sql;


create or replace function breakup_search(
	p_lexeme	text
) returns table (
	id	int,
	title	text,
	para	int,
	sent	int,
	idx	int,
	lexeme	text,
	pos	text
) as $$
	select	B.id,
		T.title::text,
		B.para,
		B.sent,
		B.idx,
		K.lexeme::text,
		P.tag::text
	from corpus.breakup as B
	inner join corpus.title as T on B.title = T.id
	inner join corpus.token as K on B.token = K.id
	inner join tags.pos as P on K.pos = P.id
	where K.lexeme % p_lexeme
	order by T.title, B.para, B.sent, B.idx;
$$ language sql;


create or replace procedure breakup_add(
	p_title		text,
	p_para		int,
	p_sent		int,
	p_idx		int,
	p_lexeme	text,
	p_pos		text
) as $$
	insert into corpus.breakup	(title, 
					 token, 
					 idx, 
					 sent, 
					 para)
	values	(corpus.title_find(p_title), 
		 corpus.token_find(p_lexeme, p_pos), 
		 p_idx, 
		 p_sent, 
		p_para)
	on conflict do nothing;
$$ language sql;


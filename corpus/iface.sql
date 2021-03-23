set search_path to corpus, public;


create or replace function title_single(
	p_id	int
) returns setof title
as $$
begin
	return query select id, title, author from corpus.title where id = p_id;

	if not found then
		raise exception 'title with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function title_all()
returns setof title
as $$
begin
	return query select id, title, author from corpus.title order by title;
end;
$$ language plpgsql;


create or replace function title_find(
	p_title	text
) returns table (
	id	int
) as $$
begin
	return query select corpus.title.id from corpus.title 
		where title = p_title;
end;
$$ language plpgsql;


create or replace function title_search(
	p_title	text
) returns setof title
as $$
begin
	return query select id, title, author from corpus.title
		where title.title % p_title order by title;
end;
$$ language plpgsql;


create or replace procedure title_add(
	p_title		text,
	p_author	text
) as $$
insert into corpus.title (title, author) values (p_title, p_author)
	on conflict do nothing;
$$ language sql;


create or replace function token_single(
	p_id	int
) returns setof token
as $$
begin
	return query select id, lexeme, pos from token where id = p_id;

	if not found then
		raise exception 'token with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function token_all()
returns setof token
as $$
begin
	return query select id, lexeme, pos from token order by lexeme, pos;
end;
$$ language plpgsql;


create or replace function token_find(
	p_lexeme	text
) returns table (
	id	int
) as $$
begin
	return query select corpus.token.id from token where lexeme = p_lexeme;
end;
$$ language plpgsql;


create or replace function token_search(
	p_lexeme	text
) returns setof token
as $$
begin
	return query select id, lexeme, pos from token where lexeme % p_lexeme
		order by lexeme;
end;
$$ language plpgsql;


create or replace procedure token_add(
	p_lexeme	text,
	p_pos		text
) as $$
declare
	v_pos	int;
begin
	v_pos := tags.pos_find(p_pos);

	insert into token (lexeme, pos) values (p_lexeme, v_pos)
		on conflict do nothing;
end;
$$ language plpgsql;


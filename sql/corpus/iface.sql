set search_path to corpus, public;


create or replace function title_single(
	p_id
) returns setof title
as $$
begin
	return query select id, title.title, author from title where id = p_id;

	if not found then
		raise exception 'title with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function title_list()
returns setof title
as $$
begin
	return query select id, title.title, author from title
		order by title.title;
end;
$$ language plpgsql;


create or replace function title_find(
	p_title	text
) returns table (
	id	int
) as $$
begin
	return query select id from title where title.title = p_title;
end;
$$ language plpgsql;


create or replace function title_search(
	p_title	text
) returns setof title
as $$
begin
	return query select id, title.title, author from title
		where title.title % p_title;
end;
$$ language plpgsql;


create or replace procedure title_add(
	p_title		text
	p_author	text
) as $$
insert into title (title, author) values (p_title, p_author)
	on conflict do nothing;
$$ language sql;


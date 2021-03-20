set search_path to tags, public;


create or replace function pos_single(
	p_id	int
) returns setof pos
as $$
begin
	return query select id, cat, tag, def from pos where id = p_id;
	if not found then
		raise exception 'PoS tags.with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function pos_list()
returns setof pos
as $$
begin
	return query select id, cat, tag, def from pos order by cat, tag;
end;
$$ language plpgsql;


create or replace function pos_find(
	p_tag	text
) returns table(
	id	int
) as $$
begin
	return query select pos.id from pos where tag = p_tag;
end;
$$ language plpgsql;



create or replace function pos_search(
	p_tag	text
) returns setof pos
as $$
begin
	return query select id, cat, tag, def from pos where tag % p_tag
		order by cat, tag;
end;
$$ language plpgsql;


create or replace procedure pos_add_universal(
	p_tag	text,
	p_def	text
) as $$
	insert into pos(cat, tag, def)
		values ('UNIVERSAL', p_tag, p_def)
		on conflict do nothing;
$$ language sql;


create or replace procedure pos_add_penn_treebank(
	p_tag	text,
	p_def	text
) as $$
	insert into pos(cat, tag, def)
		values ('PENN_TREEBANK', p_tag, p_def)
		on conflict do nothing;
$$ language sql;




create or replace function dependency_single(
	p_id	int
) returns setof dependency
as $$
begin
	return query select id, tag, def from dependency where id = p_id;

	if not found then
		raise exception 'PoS tags.with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function dependency_list()
returns setof dependency
as $$
begin
	return query select id, tag, def from dependency order by tag;
end;
$$ language plpgsql;


create or replace function dependency_find(
	p_tag	text
) returns table (
	id	int
) as $$
begin
	return query select dependency.id from dependency where tag = p_tag;
end;
$$ language plpgsql;


create or replace function dependency_search(
	p_tag	text
) returns setof dependency
as $$
begin
	return query select id, tag, def from dependency where tag % p_tag
		order by tag;
end;
$$ language plpgsql;


create or replace procedure dependency_add(
	p_tag	text,
	p_def	text
) as $$
	insert into dependency (tag, def) values (p_tag, p_def)
		on conflict do nothing;
$$ language sql;




create or replace function entity_single(
	p_id	int
) returns setof entity
as $$
begin
	return query select id, tag, def from entity where id = p_id;

	if not found then
		raise exception 'PoS tags.with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function entity_list()
returns setof entity
as $$
begin
	return query select id, tag, def from entity order by tag;
end;
$$ language plpgsql;


create or replace function entity_find(
	p_tag	text
) returns table (
	id	int
) as $$
begin
	return query select entity.id from entity where tag = p_tag;
end;
$$ language plpgsql;


create or replace function entity_search(
	p_tag	text
) returns setof tags.entity
as $$
begin
	return query select id, tag, def from entity where tag % p_tag
		order by tag;
end;
$$ language plpgsql;


create or replace procedure entity_add(
	p_tag	text,
	p_def	text
) as $$
	insert into entity (tag, def) values (p_tag, p_def)
		on conflict do nothing;
$$ language sql;


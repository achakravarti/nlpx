set search_path to tags, public;


create or replace function pos_single(
	p_id	int
) returns setof tags.pos
as $$
begin
	return query
	select	P.id,
		P.cat,
		P.tag,
		P.def
	from tags.pos as P
	where P.id = p_id;

	if not found then
		raise exception 'PoS tags.with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function pos_all()
returns setof tags.pos
as $$
	select	P.id,
		P.cat,
		P.tag,
		P.def
	from tags.pos as P
	order by P.cat, P.tag;
$$ language sql;


create or replace function pos_find(
	p_tag	text
) returns table (
	id	int
) as $$
	select P.id
	from tags.pos as P
	where P.tag = p_tag;
$$ language sql;



create or replace function pos_search(
	p_tag	text
) returns setof tags.pos
as $$
	select	P.id,
		P.cat,
		P.tag,
		P.def
	from tags.pos as P
	where P.tag % p_tag
	order by P.cat, P.tag;
$$ language sql;


create or replace procedure pos_add_universal(
	p_tag	text,
	p_def	text
) as $$
	insert into tags.pos (cat, tag, def)
	values ('UNIVERSAL', p_tag, p_def)
	on conflict do nothing;
$$ language sql;


create or replace procedure pos_add_penn_treebank(
	p_tag	text,
	p_def	text
) as $$
	insert into tags.pos (cat, tag, def)
	values ('PENN_TREEBANK', p_tag, p_def)
	on conflict do nothing;
$$ language sql;




create or replace function dependency_single(
	p_id	int
) returns setof tags.dependency
as $$
begin
	return query
	select	D.id,
		D.tag,
		D.def
	from tags.dependency as D
	where D.id = p_id;

	if not found then
		raise exception 'PoS tags.with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function dependency_all()
returns setof tags.dependency
as $$
	select	D.id,
		D.tag,
		D.def
	from tags.dependency as D
	order by D.tag;
$$ language sql;


create or replace function dependency_find(
	p_tag	text
) returns table (
	id	int
) as $$
	select D.id
	from tags.dependency as D
	where D.tag = p_tag;
$$ language sql;


create or replace function dependency_search(
	p_tag	text
) returns setof tags.dependency
as $$
	select	D.id,
		D.tag,
		D.def
	from tags.dependency as D
	where D.tag % p_tag
	order by D.tag;
$$ language sql;


create or replace procedure dependency_add(
	p_tag	text,
	p_def	text
) as $$
	insert into tags.dependency (tag, def)
	values (p_tag, p_def)
	on conflict do nothing;
$$ language sql;




create or replace function entity_single(
	p_id	int
) returns setof tags.entity
as $$
begin
	return query
	select	E.id,
		E.tag,
		E.def
	from tags.entity as E
	where E.id = p_id;

	if not found then
		raise exception 'PoS tag with ID % not available', p_id;
	end if;
end;
$$ language plpgsql;


create or replace function entity_all()
returns setof tags.entity
as $$
	select	E.id,
		E.tag,
		E.def
	from tags.entity as E
	order by E.tag;
$$ language sql;


create or replace function entity_find(
	p_tag	text
) returns table (
	id	int
) as $$
	select E.id
	from tags.entity as E
	where E.tag = p_tag;
$$ language sql;


create or replace function entity_search(
	p_tag	text
) returns setof tags.entity
as $$
	select	id,
		tag,
		def
	from tags.entity as E
	where E.tag % p_tag
	order by tag;
$$ language sql;


create or replace procedure entity_add(
	p_tag	text,
	p_def	text
) as $$
	insert into tags.entity (tag, def)
	values (p_tag, p_def)
	on conflict do nothing;
$$ language sql;


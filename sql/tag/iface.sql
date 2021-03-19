set search_path to public;


create or replace function tags.pos_single(
	id_	bigint
) returns setof tags.pos
as $$
begin
	return query select id, cat, tag, def from tags.pos where id = id_;

	if not found then
		raise exception 'PoS tags.with ID % not available', id_;
	end if;
end;
$$ language plpgsql;


create or replace function tags.pos_list()
returns setof tags.pos
as $$
begin
	return query select id, cat, tag, def from tags.pos order by cat, tag;
end;
$$ language plpgsql;


create or replace function tags.pos_find(
	tag_	text
) returns table(
	id	bigint
) as $$
begin
	return query select tags.pos.id from tags.pos where tag = tag_;
end;
$$ language plpgsql;



create or replace function tags.pos_search(
	tag_	text
) returns setof tags.pos
as $$
begin
	return query select id, cat, tag, def from tags.pos where tag % tag_ 
		order by cat, tag;
end;
$$ language plpgsql;


create or replace procedure tags.pos_add_universal(
	tag_	text,
	def_	text
) as $$
	insert into tags.pos(cat, tag, def) 
		values ('UNIVERSAL', tag_, def_)
		on conflict do nothing;
$$ language sql;


create or replace procedure tags.pos_add_penn_treebank(
	tag_	text,
	def_	text
) as $$
	insert into tags.pos(cat, tag, def) 
		values ('PENN_TREEBANK', tag_, def_)
		on conflict do nothing;
$$ language sql;




create or replace function tags.dependency_single(
	id_	bigint
) returns setof tags.dependency
as $$
begin
	return query select id, tag, def from tags.dependency
		where id = id_;

	if not found then
		RAISE EXCEPTIon 'PoS tags.with ID % not available', id_;
	end if;
end;
$$ language plpgsql;


create or replace function tags.dependency_list()
returns setof tags.dependency
as $$
begin
	return query select id, tag, def from tags.dependency
		order by tag;
end;
$$ language plpgsql;


create or replace function tags.dependency_find(
	tag_	text
) returns table (
	id	bigint
) as $$
begin
	return query select tags.dependency.id from tags.dependency
		where tag = tag_;
end;
$$ language plpgsql;


create or replace function tags.dependency_search(
	tag_	text
) returns setof tags.dependency
as $$
begin
	return query select id, tag, def from tags.dependency
		where tag % tag_ order by tag;
end;
$$ language plpgsql;


create or replace procedure tags.dependency_add(
	tag_	text,
	def_	text
) as $$
	insert into tags.dependency (tag, def) values (tag_, def_)
		on conflict do nothing;
$$ language sql;




create or replace function tags.entity_single(
	id_	bigint
) returns setof tags.entity
as $$
begin
	return query select id, tag, def from tags.entity where id = id_;

	if not found then
		raise exception 'PoS tags.with ID % not available', id;
	end if;
end;
$$ language plpgsql;


create or replace function tags.entity_list()
returns setof tags.entity
as $$
begin
	return query select id, tag, def from tags.entity order by tag;
end;
$$ language plpgsql;


create or replace function tags.entity_find(
	tag_	text
) returns table (
	id	bigint
) as $$
begin
	return query select tags.entity.id from tags.entity where tag = tag_;
end;
$$ language plpgsql;


create or replace procedure tags.entity_add(
	tag_	text,
	def_	text
) as $$
	insert into tags.entity (tag, def) values (tag_, def_)
		on conflict do nothing;
$$ language sql;


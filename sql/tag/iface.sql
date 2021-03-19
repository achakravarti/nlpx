set search_path to public;


create or replace function tags.pos_single(
	id_	bigint
) returns table(
	id	bigint,
	cat	varchar (16),
	tag	varchar (5),
	def	varchar (128)
) as $$
begin
	return query select _id, _cat::varchar (16), _tag, _def from tags.pos
		where _id = id_;

	if not found then
		raise exception 'PoS tags.with ID % not available', id_;
	end if;
end;
$$ language plpgsql;


create or replace function tags.pos_list()
returns table(
	id	bigint,
	cat	varchar (16),
	tag	varchar (5),
	def	varchar (128)
) as $$
begin
	return query select _id, _cat::varchar (16), _tag, _def from tags.pos
		order by _cat, _tag;
end;
$$ language plpgsql;


create or replace function tags.pos_find(
	tag_	text
) returns table(
	id	bigint
) as $$
begin
	return query select _id from tags.pos where _tag = tag_;
end;
$$ language plpgsql;



create or replace function tags.pos_search(
	tag_	text
) returns table(
	id	bigint,
	cat	varchar (16),
	tag	varchar (5),
	def	varchar (128)
) as $$
begin
	return query select _id, _cat::varchar (16), _tag, _def from tags.pos 
		where _tag % tag_ order by _cat, _tag;
end;
$$ language plpgsql;


create or replace procedure tags.pos_add_universal(
	tag_	text,
	def_	text
) as $$
	insert into tags.pos(_cat, _tag, _def) 
		values ('UNIVERSAL', tag_, def_)
		on conflict do nothing;
$$ language sql;


create or replace procedure tags.pos_add_penn_treebank(
	tag_	text,
	def_	text
) as $$
	insert into tags.pos(_cat, _tag, _def) 
		values ('PENN_TREEBANK', tag_, def_)
		on conflict do nothing;
$$ language sql;




create or replace function tags.dependency_single(
	id_	bigint
) returns table (
	id	bigint,
	tag	varchar (16),
	def	varchar (128)
) as $$
begin
	return query select _id, _tag, _def from tags.dependency
		where _id = id_;

	if not found then
		RAISE EXCEPTIon 'PoS tags.with ID % not available', id_;
	end if;
end;
$$ language plpgsql;


create or replace function tags.dependency_list()
returns table (
	id	bigint,
	tag	varchar (16),
	def	varchar (128)
) as $$
begin
	return query select _id, _tag, _def from tags.dependency
		order by _tag;
end;
$$ language plpgsql;


create or replace function tags.dependency_find(
	tag_	text
) returns table (
	id	bigint
) as $$
begin
	return query select _id from tags.dependency where _tag = tag_;
end;
$$ language plpgsql;


create or replace function tags.dependency_search(
	tag_	text
) returns table (
	id	bigint,
	tag	varchar (16),
	def	varchar (128)
) as $$
begin
	return query select _id, _tag, _def from tags.dependency
		where _tag % tag_ order by _tag;
end;
$$ language plpgsql;


create or replace procedure tags.dependency_add(
	tag_	text,
	def_	text
) as $$
	insert into tags.dependency (_tag, _def) values (tag_, def_)
		on conflict do nothing;
$$ language sql;




create or replace function tags.entity_single(
	id_	bigint
) returns table (
	id	bigint,
	tag	varchar (16),
	def	varchar (128)
) as $$
begin
	return query select _id, _tag, _def from tags.entity where _id = id_;

	if not found then
		raise exception 'PoS tags.with ID % not available', _id;
	end if;
end;
$$ language plpgsql;


create or replace function tags.entity_list()
returns table(
	id	bigint,
	tag	varchar (16),
	def	varchar (128)
) as $$
begin
	return query select _id, _tag, _def from tags.entity order by _tag;
end;
$$ language plpgsql;


create or replace function tags.entity_find(
	tag_	text
) returns table (
	id	bigint
) as $$
begin
	return query select _id from tags.entity where _tag = tag_;
end;
$$ language plpgsql;


create or replace procedure tags.entity_add(
	tag_	text,
	def_	text
) as $$
	insert into tags.entity (_tag, _def) values (tag_, def_)
		on conflict do nothing;
$$ language sql;


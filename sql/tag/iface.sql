set search_path to public;


create or replace function tag.pos_single(
	id_	bigint
) returns table(
	id	bigint,
	class	varchar(16),
	pos	varchar(5),
	def	varchar(128)
) as $$
begin
	return query select _id, _class::varchar(16), _pos, _def from tag.pos
		where _id = id_;

	if not found then
		raise exception 'PoS tag with ID % not available', id_;
	end if;
end;
$$ language plpgsql;


create or replace function tag.pos_list()
returns table(
	id	bigint,
	class	varchar(16),
	pos	varchar(5),
	def	varchar(128)
) as $$
begin
	return query select _id, _class::varchar(16), _pos, _def from tag.pos
		order by _class, _pos;
end;
$$ language plpgsql;


create or replace function tag.pos_find(
	pos_	text
) returns table(
	id	bigint
) as $$
begin
	return query select _id from tag.pos where _pos = pos_;
end;
$$ language plpgsql;



create or replace function tag.pos_search(
	pos_	text
) returns table(
	id	bigint,
	class	varchar(16),
	pos	varchar(5),
	def	varchar(128)
) as $$
begin
	return query select _id, _class::varchar(16), _pos, _def from tag.pos 
		where _pos % pos_ order by _class, _pos;
end;
$$ language plpgsql;


create or replace procedure tag.pos_add_universal(
	pos_	text,
	def_	text
) as $$
	insert into tag.pos(_class, _pos, _def) values ('universal', pos_, def_)
		on conflict do nothing;
$$ language sql;


create or replace procedure tag.pos_add_penn_treebank(
	pos_	text,
	def_	text
) as $$
	insert into tag.pos(_class, _pos, _def) 
		values ('penn_treebank', pos_, def_)
		on conflict do nothing;
$$ language sql;




create or replace function tag.dependency_single(
	id_	bigint
) returns table (
	id	bigint,
	label	varchar(16),
	def	varchar(128)
) as $$
begin
	return query select _id, _label, _def from tag.dependency
		where _id = id_;

	IF NOT FOUND THEN
		RAISE EXCEPTIon 'PoS tag with ID % not available', id_;
	end IF;
end;
$$ language plpgsql;


create or replace function tag.dependency_list()
returns table (
	id	bigint,
	label	varchar (16),
	def	varchar (128)
) as $$
begin
	return query select _id, _label, _def from tag.dependency
		order by _label;
end;
$$ language plpgsql;


create or replace function tag.dependency_find(
	lab_	text
) returns table (
	id	bigint
) as $$
begin
	return query select _id from tag.dependency where _label = lab_;
end;
$$ language plpgsql;


create or replace function tag.dependency_search(
	lab_	text
) return table (
	id	bigint,
	label	varchar(16),
	def	varchar(128)
) as $$
begin
	return query select _id, _label, _def from tag.dependency
		where _label % lab_ order by _label;
end;
$$ language plpgsql;


create or replace procedure tag.dependency_add(
	lab_	text,
	def_	text
) as $$
	insert into tag.dependency (_label, _def) values (lab_, def_)
		on conflict do nothing;
$$ language sql;




create or replace function tag.entity_single(
	id_	bigint
) returns table (
	id	bigint,
	name	varchar(16),
	def	varchar(128)
) as $$
begin
	return query select _id, _name, _def from tag.entity where _id = id_;

	IF NOT FOUND THEN
		RAISE EXCEPTIon 'PoS tag with ID % not available', _id;
	end IF;
end;
$$ language plpgsql;


create or replace function tag.entity_list()
returns table(
	id	bigint,
	name	varchar(16),
	def	varchar(128)
) as $$
begin
	return query select _id, _name, _def from tag.entity order by _name;
end;
$$ language plpgsql;


create or replace function tag.entity_find(
	name_	text
) returns table (
	id	bigint
) as $$
begin
	return query select _id from tag.entity where _name = name_;
end;
$$ language plpgsql;


create or replace procedure tag.entity_add(
	name_	text,
	def_	text
) as $$
	insert into tag.entity (_name, _def) values (name_, def_)
		on conflict do nothing;
$$ language sql;


drop table videos;

create table videos (
  id serial8 primary key,
  title varchar(50),
  description varchar(200),
  link varchar(500)
);

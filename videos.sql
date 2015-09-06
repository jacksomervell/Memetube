drop table videos;

create table videos.erb (
  id serial8 primary key,
  title varchar(50),
  description varchar(200),
  link text
);

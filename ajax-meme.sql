drop table memetube_ajax;
create table memetube_ajax (
  id serial8 primary key,
  link varchar(100),
  title varchar(150),
  description text  
);

INSERT INTO memetube_ajax (link, title, description) VALUES ('https://www.youtube.com/embed/qzp8I-naJOg', 'Nick Cave', 'I will love you till the end of time');
CREATE TABLE "File"(
   id varchar PRIMARY KEY,
   name varchar NOT NULL ,
   mime_type varchar NOT NULL ,
   session varchar NOT NULL ,
   password varchar,
   date_deleted date,
   count_download int
);

CREATE UNIQUE INDEX unique_session_name ON "File"(session, name);
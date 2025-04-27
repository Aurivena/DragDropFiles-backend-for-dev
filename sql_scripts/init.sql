CREATE TABLE "File"(
   id varchar PRIMARY KEY,
   name varchar NOT NULL ,
   data_base64 varchar NOT NULL ,
   session varchar NOT NULL ,
   password varchar,
   date_deleted date,
   count_download int
);


CREATE USER dragdrop_api WITH PASSWORD '1234';
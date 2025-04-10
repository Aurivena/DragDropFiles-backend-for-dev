CREATE TABLE "File"(
   id varchar(32) PRIMARY KEY,
   date_created date NOT NULL ,
   date_deleted date,
   count_download int,
   count_discoveries int,
   count_day int
);

CREATE USER dragdrop_api WITH PASSWORD '1234';
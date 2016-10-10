CREATE DATABASE database1;
\connect database1
CREATE SCHEMA flask;
CREATE USER admin PASSWORD 'postgres';
GRANT ALL ON DATABASE database1 TO admin;
GRANT ALL ON SCHEMA flask TO admin;
CREATE TABLE flask.example(id SERIAL PRIMARY KEY,name VARCHAR(30),age INTEGER);
GRANT ALL ON ALL TABLES IN SCHEMA flask TO admin;
INSERT INTO flask.example (name,age) VALUES ('flanders',25);
-- Create user "feast" with LOGIN and REPLICATION privileges
CREATE USER feast WITH PASSWORD 'feast';
ALTER USER feast WITH LOGIN REPLICATION;

-- Create database "feast" and set "feast" as the owner
CREATE DATABASE feast WITH OWNER feast;

-- Create user "feast_online" with LOGIN privileges
CREATE USER feast_online WITH PASSWORD 'feast_online';
ALTER USER feast_online WITH LOGIN;

-- Create database "feast_online" and set "feast_online" as the owner
CREATE DATABASE feast_online WITH OWNER feast_online;


CREATE TABLE feast.public.titanic_survive_svc_v1 (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INTEGER,
    email TEXT UNIQUE
);

CREATE TABLE feast_online.public.titanic_survive_svc_v1 (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INTEGER,
    email TEXT UNIQUE
);

commit;
---CREATE ROLE repl_user REPLICATION LOGIN;
---CREATE ROLE REPLICATION_GROUP;
---GRANT REPLICATION_GROUP TO feast;
---GRANT REPLICATION_GROUP TO repl_user;
---ALTER TABLE titanic_survive_svc_v1 OWNER TO REPLICATION_GROUP;


-- Create user "feast" with LOGIN and REPLICATION privileges
CREATE USER feast WITH PASSWORD 'feast';
ALTER USER feast WITH LOGIN REPLICATION;

-- Create database "feast" and set "feast" as the owner
CREATE DATABASE feast WITH OWNER feast;

CREATE TABLE titanic_survive_svc_v1 (
    name TEXT,
    age INTEGER,
    email TEXT UNIQUE NOT NULL PRIMARY KEY
);

INSERT INTO titanic_survive_svc_v1 (name, age, email) VALUES ('John Doe', 30, 'john.doe@example.com');
INSERT INTO titanic_survive_svc_v1 (name, age, email) VALUES ('John Go', 31, 'john.go@example.com');


-- Create user "feast_online" with LOGIN privileges
CREATE USER feast_online WITH PASSWORD 'feast_online';
ALTER USER feast_online WITH LOGIN;

-- Create database "feast_online" and set "feast_online" as the owner
CREATE DATABASE feast_online WITH OWNER feast_online;

CREATE TABLE titanic_survive_svc_v1 (
    name TEXT,
    age INTEGER,
    email TEXT UNIQUE NOT NULL PRIMARY KEY
);


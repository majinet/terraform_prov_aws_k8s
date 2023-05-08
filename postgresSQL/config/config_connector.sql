CREATE ROLE repl_user REPLICATION LOGIN;
CREATE ROLE REPLICATION_GROUP;
GRANT REPLICATION_GROUP TO feast;
GRANT REPLICATION_GROUP TO repl_user;
ALTER TABLE titanic_survive_svc_v1 OWNER TO REPLICATION_GROUP;

ALTER ROLE feast `q` CREATEDB REPLICATION LOGIN;

CREATE TABLE titanic_survive_svc_v1 (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INTEGER,
    email TEXT UNIQUE
);

INSERT INTO titanic_survive_svc_v1 (name, age, email) VALUES ('John Doe', 30, 'john.doe@example.com');
INSERT INTO titanic_survive_svc_v1 (name, age, email) VALUES ('John Go', 31, 'john.go@example.com');
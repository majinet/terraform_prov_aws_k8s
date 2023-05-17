CREATE TABLE public.titanic_survive_svc_v1 (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INTEGER,
    email TEXT UNIQUE
);

commit;
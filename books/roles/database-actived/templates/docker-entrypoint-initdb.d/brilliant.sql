-- user: {{ brilliant_user }}
-- DROP ROLE {{ brilliant_user }};

DO $$
DECLARE count int;
BEGIN
    SELECT count(*) INTO count FROM pg_roles WHERE rolname = '{{ brilliant_user }}';
    IF count = 0 THEN
        CREATE ROLE {{ brilliant_user }} WITH
            LOGIN
            NOSUPERUSER
            INHERIT
            CREATEDB
            CREATEROLE
            NOREPLICATION;
    END IF;
END
$$;
ALTER ROLE {{ brilliant_user }} WITH PASSWORD '{{ brilliant_pass }}';


-- database: main
-- DROP DATABASE main;

CREATE DATABASE main
    WITH
    TEMPLATE template0
    OWNER = {{ brilliant_user }}
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE main TO {{ brilliant_user }};

-- create schema
\c main

CREATE SCHEMA IF NOT EXISTS foundation
    AUTHORIZATION {{ brilliant_user }};
-- GRANT ALL PRIVILEGES ON SCHEMA foundation TO {{ brilliant_user }};
-- ALTER SCHEMA foundation OWNER TO {{ brilliant_user }};

CREATE SCHEMA IF NOT EXISTS passport
    AUTHORIZATION {{ brilliant_user }};
-- GRANT ALL PRIVILEGES ON SCHEMA passport TO {{ brilliant_user }};
-- ALTER SCHEMA passport OWNER TO {{ brilliant_user }};

-- user: {{ kdb_user }}
-- DROP ROLE {{ kdb_user }};

DO $$
DECLARE count int;
BEGIN
    SELECT count(*) INTO count FROM pg_roles WHERE rolname = '{{ kdb_user }}';
    IF count = 0 THEN
        CREATE ROLE {{ kdb_user }} WITH
            LOGIN
            NOSUPERUSER
            INHERIT
            CREATEDB
            CREATEROLE
            NOREPLICATION;
    END IF;
END
$$;
ALTER ROLE {{ kdb_user }} WITH PASSWORD '{{ kdb_pass }}';


-- database: k3s
-- DROP DATABASE k3s;

CREATE DATABASE k3s
    WITH
    TEMPLATE template0
    OWNER = {{ kdb_user }}
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE k3s TO {{ kdb_user }};

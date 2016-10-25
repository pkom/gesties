--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE gesties;
ALTER ROLE gesties WITH NOSUPERUSER INHERIT NOCREATEROLE CREATEDB LOGIN NOREPLICATION PASSWORD 'md551a9ffa27a1cee9544726b9884405e68';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION PASSWORD 'md53175bce1d3201d16594cebf9d7eb3f9d';






--
-- Database creation
--

CREATE DATABASE gesties_dev WITH TEMPLATE = template0 OWNER = gesties;
REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect gesties_dev

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO gesties;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailaddress_id_seq OWNER TO gesties;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE account_emailaddress_id_seq OWNED BY account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO gesties;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailconfirmation_id_seq OWNER TO gesties;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE account_emailconfirmation_id_seq OWNED BY account_emailconfirmation.id;


--
-- Name: alumnos_alumno; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE alumnos_alumno (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    nie character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    fecha_nacimiento date,
    usuario_rayuela character varying(20) NOT NULL,
    foto character varying(200) NOT NULL,
    email character varying(50) NOT NULL,
    telefono character varying(50) NOT NULL,
    codigo_postal character varying(10) NOT NULL,
    direccion character varying(200) NOT NULL,
    dni character varying(20) NOT NULL,
    localidad character varying(100) NOT NULL,
    provincia character varying(100) NOT NULL,
    expediente character varying(10) NOT NULL
);


ALTER TABLE public.alumnos_alumno OWNER TO gesties;

--
-- Name: alumnos_alumno_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE alumnos_alumno_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alumnos_alumno_id_seq OWNER TO gesties;

--
-- Name: alumnos_alumno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE alumnos_alumno_id_seq OWNED BY alumnos_alumno.id;


--
-- Name: alumnos_tutor; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE alumnos_tutor (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    dni character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    domicilio character varying(100) NOT NULL,
    codigo_postal character varying(10) NOT NULL,
    municipio character varying(50) NOT NULL,
    provincia character varying(50) NOT NULL,
    foto character varying(100) NOT NULL,
    telefono1 character varying(50) NOT NULL,
    telefono2 character varying(50) NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE public.alumnos_tutor OWNER TO gesties;

--
-- Name: alumnos_tutor_alumnos; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE alumnos_tutor_alumnos (
    id integer NOT NULL,
    tutor_id integer NOT NULL,
    alumno_id integer NOT NULL
);


ALTER TABLE public.alumnos_tutor_alumnos OWNER TO gesties;

--
-- Name: alumnos_tutor_alumnos_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE alumnos_tutor_alumnos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alumnos_tutor_alumnos_id_seq OWNER TO gesties;

--
-- Name: alumnos_tutor_alumnos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE alumnos_tutor_alumnos_id_seq OWNED BY alumnos_tutor_alumnos.id;


--
-- Name: alumnos_tutor_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE alumnos_tutor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alumnos_tutor_id_seq OWNER TO gesties;

--
-- Name: alumnos_tutor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE alumnos_tutor_id_seq OWNED BY alumnos_tutor.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO gesties;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO gesties;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO gesties;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO gesties;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO gesties;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO gesties;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: configies_configies; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE configies_configies (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    codigo_centro character varying(15) NOT NULL,
    nombre_centro character varying(50) NOT NULL,
    url_centro character varying(200) NOT NULL,
    email_centro character varying(254) NOT NULL,
    direccion_centro character varying(200) NOT NULL,
    telefono_centro character varying(200) NOT NULL,
    fax_centro character varying(200) NOT NULL,
    nombre_director character varying(50) NOT NULL,
    firma_director character varying(100) NOT NULL,
    logo_centro character varying(100) NOT NULL,
    sello_centro character varying(100) NOT NULL,
    curso_defecto_id integer
);


ALTER TABLE public.configies_configies OWNER TO gesties;

--
-- Name: configies_configies_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE configies_configies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configies_configies_id_seq OWNER TO gesties;

--
-- Name: configies_configies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE configies_configies_id_seq OWNED BY configies_configies.id;


--
-- Name: cursos_curso; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE cursos_curso (
    id integer NOT NULL,
    curso character varying(9) NOT NULL,
    retrasos_amonestacion smallint NOT NULL,
    retrasos_trimestre boolean NOT NULL,
    inicio_primer_trimestre date NOT NULL,
    fin_primer_trimestre date NOT NULL,
    inicio_segundo_trimestre date NOT NULL,
    fin_segundo_trimestre date NOT NULL,
    inicio_tercer_trimestre date NOT NULL,
    fin_tercer_primer_trimestre date NOT NULL,
    slug character varying(9) NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    CONSTRAINT cursos_curso_retrasos_amonestacion_check CHECK ((retrasos_amonestacion >= 0))
);


ALTER TABLE public.cursos_curso OWNER TO gesties;

--
-- Name: cursos_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE cursos_curso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cursos_curso_id_seq OWNER TO gesties;

--
-- Name: cursos_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE cursos_curso_id_seq OWNED BY cursos_curso.id;


--
-- Name: departamentos_cursodepartamento; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE departamentos_cursodepartamento (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    curso_id integer NOT NULL,
    departamento_id integer NOT NULL,
    jefe_id integer
);


ALTER TABLE public.departamentos_cursodepartamento OWNER TO gesties;

--
-- Name: departamentos_cursodepartamento_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE departamentos_cursodepartamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departamentos_cursodepartamento_id_seq OWNER TO gesties;

--
-- Name: departamentos_cursodepartamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE departamentos_cursodepartamento_id_seq OWNED BY departamentos_cursodepartamento.id;


--
-- Name: departamentos_cursodepartamentoprofesor; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE departamentos_cursodepartamentoprofesor (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    curso_departamento_id integer NOT NULL,
    profesor_id integer NOT NULL
);


ALTER TABLE public.departamentos_cursodepartamentoprofesor OWNER TO gesties;

--
-- Name: departamentos_cursodepartamentoprofesor_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE departamentos_cursodepartamentoprofesor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departamentos_cursodepartamentoprofesor_id_seq OWNER TO gesties;

--
-- Name: departamentos_cursodepartamentoprofesor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE departamentos_cursodepartamentoprofesor_id_seq OWNED BY departamentos_cursodepartamentoprofesor.id;


--
-- Name: departamentos_departamento; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE departamentos_departamento (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    departamento character varying(100) NOT NULL,
    descripcion character varying(100) NOT NULL,
    slug character varying(100) NOT NULL
);


ALTER TABLE public.departamentos_departamento OWNER TO gesties;

--
-- Name: departamentos_departamento_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE departamentos_departamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departamentos_departamento_id_seq OWNER TO gesties;

--
-- Name: departamentos_departamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE departamentos_departamento_id_seq OWNED BY departamentos_departamento.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO gesties;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO gesties;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO gesties;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO gesties;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO gesties;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO gesties;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO gesties;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO gesties;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO gesties;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: grupos_cursogrupo; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE grupos_cursogrupo (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    curso_id integer NOT NULL,
    grupo_id integer NOT NULL,
    tutor_id integer
);


ALTER TABLE public.grupos_cursogrupo OWNER TO gesties;

--
-- Name: grupos_cursogrupo_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE grupos_cursogrupo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grupos_cursogrupo_id_seq OWNER TO gesties;

--
-- Name: grupos_cursogrupo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE grupos_cursogrupo_id_seq OWNED BY grupos_cursogrupo.id;


--
-- Name: grupos_cursogrupoalumno; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE grupos_cursogrupoalumno (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    alumno_id integer NOT NULL,
    curso_grupo_id integer NOT NULL
);


ALTER TABLE public.grupos_cursogrupoalumno OWNER TO gesties;

--
-- Name: grupos_cursogrupoalumno_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE grupos_cursogrupoalumno_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grupos_cursogrupoalumno_id_seq OWNER TO gesties;

--
-- Name: grupos_cursogrupoalumno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE grupos_cursogrupoalumno_id_seq OWNED BY grupos_cursogrupoalumno.id;


--
-- Name: grupos_cursogrupoprofesor; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE grupos_cursogrupoprofesor (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    curso_grupo_id integer NOT NULL,
    profesor_id integer NOT NULL
);


ALTER TABLE public.grupos_cursogrupoprofesor OWNER TO gesties;

--
-- Name: grupos_cursogrupoprofesor_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE grupos_cursogrupoprofesor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grupos_cursogrupoprofesor_id_seq OWNER TO gesties;

--
-- Name: grupos_cursogrupoprofesor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE grupos_cursogrupoprofesor_id_seq OWNED BY grupos_cursogrupoprofesor.id;


--
-- Name: grupos_grupo; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE grupos_grupo (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    grupo character varying(50) NOT NULL,
    descripcion character varying(50) NOT NULL,
    slug character varying(50) NOT NULL
);


ALTER TABLE public.grupos_grupo OWNER TO gesties;

--
-- Name: grupos_grupo_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE grupos_grupo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grupos_grupo_id_seq OWNER TO gesties;

--
-- Name: grupos_grupo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE grupos_grupo_id_seq OWNED BY grupos_grupo.id;


--
-- Name: rayuela_rayuela; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE rayuela_rayuela (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    tipo character varying(2) NOT NULL,
    archivo character varying(100) NOT NULL,
    procesado boolean NOT NULL,
    resultado text,
    curso_id integer NOT NULL
);


ALTER TABLE public.rayuela_rayuela OWNER TO gesties;

--
-- Name: rayuela_rayuela_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE rayuela_rayuela_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rayuela_rayuela_id_seq OWNER TO gesties;

--
-- Name: rayuela_rayuela_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE rayuela_rayuela_id_seq OWNED BY rayuela_rayuela.id;


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    uid character varying(191) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO gesties;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE socialaccount_socialaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialaccount_id_seq OWNER TO gesties;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE socialaccount_socialaccount_id_seq OWNED BY socialaccount_socialaccount.id;


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(191) NOT NULL,
    secret character varying(191) NOT NULL,
    key character varying(191) NOT NULL
);


ALTER TABLE public.socialaccount_socialapp OWNER TO gesties;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE socialaccount_socialapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_id_seq OWNER TO gesties;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE socialaccount_socialapp_id_seq OWNED BY socialaccount_socialapp.id;


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE socialaccount_socialapp_sites (
    id integer NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO gesties;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_sites_id_seq OWNER TO gesties;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE socialaccount_socialapp_sites_id_seq OWNED BY socialaccount_socialapp_sites.id;


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO gesties;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE socialaccount_socialtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialtoken_id_seq OWNER TO gesties;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE socialaccount_socialtoken_id_seq OWNED BY socialaccount_socialtoken.id;


--
-- Name: users_user; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE users_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    name character varying(255) NOT NULL,
    dni character varying(20) NOT NULL,
    es_usuario boolean NOT NULL,
    foto character varying(100) NOT NULL,
    id_usuario character varying(20) NOT NULL,
    usuario_rayuela character varying(50) NOT NULL
);


ALTER TABLE public.users_user OWNER TO gesties;

--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE users_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_user_groups OWNER TO gesties;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE users_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_groups_id_seq OWNER TO gesties;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE users_user_groups_id_seq OWNED BY users_user_groups.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO gesties;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE users_user_id_seq OWNED BY users_user.id;


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: gesties; Tablespace: 
--

CREATE TABLE users_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_user_user_permissions OWNER TO gesties;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: gesties
--

CREATE SEQUENCE users_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_user_permissions_id_seq OWNER TO gesties;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gesties
--

ALTER SEQUENCE users_user_user_permissions_id_seq OWNED BY users_user_user_permissions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY account_emailaddress ALTER COLUMN id SET DEFAULT nextval('account_emailaddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('account_emailconfirmation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY alumnos_alumno ALTER COLUMN id SET DEFAULT nextval('alumnos_alumno_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY alumnos_tutor ALTER COLUMN id SET DEFAULT nextval('alumnos_tutor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY alumnos_tutor_alumnos ALTER COLUMN id SET DEFAULT nextval('alumnos_tutor_alumnos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY configies_configies ALTER COLUMN id SET DEFAULT nextval('configies_configies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY cursos_curso ALTER COLUMN id SET DEFAULT nextval('cursos_curso_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY departamentos_cursodepartamento ALTER COLUMN id SET DEFAULT nextval('departamentos_cursodepartamento_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY departamentos_cursodepartamentoprofesor ALTER COLUMN id SET DEFAULT nextval('departamentos_cursodepartamentoprofesor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY departamentos_departamento ALTER COLUMN id SET DEFAULT nextval('departamentos_departamento_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupo ALTER COLUMN id SET DEFAULT nextval('grupos_cursogrupo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupoalumno ALTER COLUMN id SET DEFAULT nextval('grupos_cursogrupoalumno_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupoprofesor ALTER COLUMN id SET DEFAULT nextval('grupos_cursogrupoprofesor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_grupo ALTER COLUMN id SET DEFAULT nextval('grupos_grupo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY rayuela_rayuela ALTER COLUMN id SET DEFAULT nextval('rayuela_rayuela_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY socialaccount_socialaccount ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialaccount_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY socialaccount_socialapp ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialapp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY socialaccount_socialapp_sites ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialapp_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY socialaccount_socialtoken ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialtoken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY users_user ALTER COLUMN id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY users_user_groups ALTER COLUMN id SET DEFAULT nextval('users_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY users_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('users_user_user_permissions_id_seq'::regclass);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('account_emailaddress_id_seq', 1, false);


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('account_emailconfirmation_id_seq', 1, false);


--
-- Data for Name: alumnos_alumno; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY alumnos_alumno (id, created, modified, nie, nombre, apellidos, fecha_nacimiento, usuario_rayuela, foto, email, telefono, codigo_postal, direccion, dni, localidad, provincia, expediente) FROM stdin;
120	2016-10-20 08:46:44.830022+02	2016-10-24 10:24:32.422217+02	3360809	Mercedes	Hermoso Morato	2000-12-22	mhermosom02	alumnos/3360809.jpg		 	06260	C/ Elías Torres, 26	20537820Q	Monesterio	Badajoz	2683
320	2016-10-20 08:46:54.420772+02	2016-10-24 10:24:27.240543+02	3386788	Mario	Abril Santana	2004-11-08	marioabril4	alumnos/3386788.jpg	mabrilsantana@gmail.com	653463029 690764414	06906	C/ Barriada las Reliquias, 18	29515521N	Puebla del Maestre	Badajoz	2988
134	2016-10-20 08:46:45.520115+02	2016-10-24 10:24:27.3+02	3264410	Míriam	Abril Santana	2000-12-05	mabrils02	alumnos/3264410.jpg	mabrilsantana@gmail.com	653463030 690764414	06906	C/ Barriada las Reliquias, 18	29504941N	Puebla del Maestre	Badajoz	2656
303	2016-10-20 08:46:53.573+02	2016-10-24 10:24:27.326357+02	3360574	Alejandro	Alcantarilla Romero	2002-04-17	aalcantarillar01	alumnos/3360574.jpg		616470362 	06260	C/ Rafael Alberti, 15	20540651H	Monesterio	Badajoz	2801
331	2016-10-20 08:46:54.925879+02	2016-10-24 10:24:27.354351+02	3264377	Blanca María	Almagro Lara	1997-06-19	bmalmagrol01	alumnos/3264377.jpg		924512324 	06906	Bda/ Las Reliquias, 8	8897560X	Puebla del Maestre	Badajoz	2312
50	2016-10-20 08:46:41.51193+02	2016-10-24 10:24:27.38252+02	3360810	Rubén	Almeida Méndez	1997-10-20	ralmeidam01	alumnos/3360810.jpg		649892883 	06260	C/ Las Espeñas, 12 13	45969504W	Monesterio	Badajoz	3066
200	2016-10-20 08:46:48.672283+02	2016-10-24 10:24:27.410058+02	3360610	Candela	Alonso Sánchez	2003-08-15	calonsos02	alumnos/3360610.jpg		647933915 	06260	C/ Rosa de Luxemburgo, 9	7269214H	Monesterio	Badajoz	2893
272	2016-10-20 08:46:52.088791+02	2016-10-24 10:24:27.438073+02	3264411	Gema	Álvarez González	2000-01-03	galvarezg07	alumnos/3264411.jpg		659331151 	06908	C/ Carretera, 41	45969874G	Santa María de la Nava	Badajoz	2657
105	2016-10-20 08:46:44.119353+02	2016-10-24 10:24:27.466086+02	3360814	Elena	Ambrona López	2001-06-18	eambronal01	alumnos/3360814.jpg		610652042 	06260	C/ Espronceda, 8	20537896T	Monesterio	Badajoz	2716
144	2016-10-20 08:46:45.995582+02	2016-10-24 10:24:27.493979+02	3360749	Javier	Ambrona Rebollo	2000-06-05	jambronar04	alumnos/3360749.png		606581869 	06260	C/ Cañuelo, 4 1º B	80230895H	Monesterio	Badajoz	2661
116	2016-10-20 08:46:44.646124+02	2016-10-24 10:24:27.521865+02	3383870	Ángela	Ambrona Vila	2004-12-22	aambronav01	alumnos/3383870.jpg		665828948 627956138	06260	C/ Extremadura, 255	80108472R	Monesterio	Badajoz	2989
140	2016-10-20 08:46:45.804039+02	2016-10-24 10:24:27.549991+02	3359688	Javier	Arroyo Botón	2000-11-29	jarroyob01	alumnos/3359688.jpg		650678147 	06292	C/ Cristóbal Colón, 8	7268116R	Calera de León	Badajoz	2607
212	2016-10-20 08:46:49.22343+02	2016-10-24 10:24:27.578064+02	3386422	Javier	Artero Fernández	2004-02-20	jarterof01	alumnos/3386422.jpg		646478646 924584117	06290	Avda/ Del Parque, 12	20538134P	Calera de León	Badajoz	2990
10	2016-10-20 08:46:39.574785+02	2016-10-24 10:24:27.605909+02	3754276	Aarón	Ávila Moral	2004-07-11	aavilam06	alumnos/3754276.jpg		619294316 671037662	06260	C/ Las Linas, 8		Monesterio	Badajoz	3050
297	2016-10-20 08:46:53.285064+02	2016-10-24 10:24:27.63319+02	3359665	Alba	Balsera Durán	1999-10-27	abalserad03	alumnos/3359665.jpg		 	06292	C/ Río Ardila, 3	29501026F	Calera de León	Badajoz	2505
117	2016-10-20 08:46:44.691154+02	2016-10-24 10:24:27.659289+02	3386499	Daniel	Balsera Durán	2004-07-06	dbalserad01	alumnos/3386499.jpg		 	06292	C/ Río Ardila, 3	29501024M	Calera de León	Badajoz	2991
127	2016-10-20 08:46:45.157245+02	2016-10-24 10:24:27.717411+02	3360583	Nerea	Barragán Delgado	2002-08-13	nbarragand01	alumnos/3360583.jpg		667435375 667435383	06260	C/ Labrador, 44	8368088K	Monesterio	Badajoz	2802
201	2016-10-20 08:46:48.719149+02	2016-10-24 10:24:27.752743+02	3360786	Valeria	Barragán Delgado	2002-10-10	vbarragand01	alumnos/3360786.jpg		646574496 680562156	06260	C/ Francisco Pizarro, 6	8898354E	Monesterio	Badajoz	2894
151	2016-10-20 08:46:46.357836+02	2016-10-24 10:24:27.77863+02	3386955	José Antonio	Barragán Guillén	2002-10-20	jabarragang02	alumnos/3386955.jpg		652346844 	06906	C/ Queipo de Llano, 100	47391785D	Puebla del Maestre	Badajoz	2803
21	2016-10-20 08:46:40.12583+02	2016-10-24 10:24:27.81196+02	3360611	Sandra	Barragán Martínez	2003-11-14	sbarraganm01	alumnos/3360611.jpg		670310554 670310554	06260	C/ Rosa de Luxemburgo, 16	7269194K	Monesterio	Badajoz	2895
141	2016-10-20 08:46:45.852315+02	2016-10-24 10:24:27.847011+02	3360836	Lucía	Barragán Miranda	2001-03-24	lbarraganm04	alumnos/3360836.jpg		651778794 924516425	06260	C/ Pozo, 25	20537802K	Monesterio	Badajoz	2717
252	2016-10-20 08:46:51.138608+02	2016-10-24 10:24:27.879922+02	3264435	María	Barroso Maldonado	2002-04-03	mbarrosom01	alumnos/3264435.jpg		630227234 	06906	C/ Ramón y Cajal, 37	20538102E	Puebla del Maestre	Badajoz	2804
49	2016-10-20 08:46:41.466383+02	2016-10-24 10:24:27.909215+02	3264425	Belén	Barroso Roguera	2001-03-27	bbarrosor01	alumnos/3264425.jpg		636002975 	06906	C/ Calvo Sotelo, 50	20538077C	Puebla del Maestre	Badajoz	2805
219	2016-10-20 08:46:49.560645+02	2016-10-24 10:24:27.936561+02	3360765	Diego	Bautista Delgado	2000-08-21	dbautistad01	alumnos/3360765.jpg		695922677 924516836	06260	C/ De la Radio,36,	7268081N	Monesterio	Badajoz	2608
164	2016-10-20 08:46:46.955799+02	2016-10-24 10:24:27.962364+02	3360755	Elena	Bautista Peraza	2000-08-15	ebautistap01	alumnos/3360755.jpg		691257872 699126655	06260	C/ Barrio de la Cruz, 36 A	45557766X	Monesterio	Badajoz	2609
142	2016-10-20 08:46:45.900547+02	2016-10-24 10:24:27.980932+02	3360824	Belén María	Bautista Ramos	2001-04-05	bmbautistar01	alumnos/3360824.jpg		690799682 677746506	06260	C/ C / Sierra del Castillo, 17	7269184B	Monesterio	Badajoz	2718
310	2016-10-20 08:46:53.909193+02	2016-10-24 10:24:28.008188+02	3360615	Fátima	Bautista Ramos	2003-10-21	fbautistar01	alumnos/3360615.jpg		637367223 677746506	06260	C/ C / Sierra del Castillo, 17	7269185N	Monesterio	Badajoz	2896
213	2016-10-20 08:46:49.269982+02	2016-10-24 10:24:28.035358+02	3383838	Celia	Bayón Caballero	2004-06-01	cbayonc04	alumnos/3383838.jpg		633283136 	06260	C/ De la Radio, 28	20537789P	Monesterio	Badajoz	2992
29	2016-10-20 08:46:40.498669+02	2016-10-24 10:24:28.075631+02	3383975	Victoria	Bayón Macías	2004-04-02	vbayonm01	alumnos/3383975.jpg		696459342 	06260	C/ Ramón y Cajal, 22	7269191H	Monesterio	Badajoz	2993
172	2016-10-20 08:46:47.328963+02	2016-10-24 10:24:28.104443+02	3360815	Francisco	Bayón Rodríguez	2001-04-17	fbayonr01	alumnos/3360815.jpg		984576760 	06260	C/ Robledillo, 2	20540650V	Monesterio	Badajoz	2767
228	2016-10-20 08:46:49.998778+02	2016-10-24 10:24:28.1324+02	3360779	Víctor	Bayón Rodríguez	2002-02-14	vbayonr01	alumnos/3360779.jpg		637940722 637940722	06260	C/ Robledillo, 2	20540652L	Monesterio	Badajoz	2806
58	2016-10-20 08:46:41.881389+02	2016-10-24 10:24:28.16037+02	3360854	Laura	Benítez Rubio	2001-03-26	lbenitezr01	alumnos/3360854.jpg		622644622 	06260	C/ Rosa de Luxemburgo, 12	20537798V	Monesterio	Badajoz	2769
214	2016-10-20 08:46:49.315895+02	2016-10-24 10:24:28.188079+02	3384031	Lucía	Benítez Rubio	2004-01-02	lbenitezr03	alumnos/3384031.jpg		 	06260	C/ Rosa de Luxemburgo, 12	20537799H	Monesterio	Badajoz	2994
326	2016-10-20 08:46:54.69726+02	2016-10-24 10:24:28.215617+02	3685568	Ana Isabel	Bonilla Colorado	1990-06-12	inaranjom01	alumnos/3685568.jpg	anabel_olalla@hotmail.com	610074318 	21260	C/ España, 21	53354411T	Santa Olalla del Cala	Huelva	2983
71	2016-10-20 08:46:42.511751+02	2016-10-24 10:24:28.223576+02	3386601	Antonio Luis	Botón Maldonado	2004-03-14	albotonm01	alumnos/3386601.jpg		659695430 	06292	C/ Espronceda, 17 A	45975146D	Calera de León	Badajoz	2995
287	2016-10-20 08:46:52.766447+02	2016-10-24 10:24:28.251329+02	3264395	Tamara	Caballero Gordito	1999-09-11	tcaballerog01	alumnos/3264395.jpg		 	06906	Bda/ Las Reliquias, 19	8897563J	Puebla del Maestre	Badajoz	2506
64	2016-10-20 08:46:42.186831+02	2016-10-24 10:24:28.300635+02	3360588	Elena	Calderón Aceiton	2002-02-13	ecalderona02	alumnos/3360588.jpg		924516800 	06260	C/ Plaza del Pueblo, 14	7268210A	Monesterio	Badajoz	2809
191	2016-10-20 08:46:48.228246+02	2016-10-24 10:24:28.325496+02	3360816	Gema	Calderón Barragán	2001-04-04	gcalderonb01	alumnos/3360816.jpg		677806254 924517235	06260	C/ Pozo, 34	20538067X	Monesterio	Badajoz	2721
305	2016-10-20 08:46:53.668367+02	2016-10-24 10:24:28.352999+02	3360825	Ángeles	Calderón Bayón	2001-12-27	acalderonb01	alumnos/3360825.jpg		610637827 610637877	06260	C/ Sierra del Castillo, 3	7269202Y	Monesterio	Badajoz	2719
357	2016-10-20 08:46:56.176893+02	2016-10-24 10:24:28.380458+02	3360737	Alberto	Calderón Carballar	1999-06-03	acalderonc06	alumnos/3360737.jpg		674910974 	06260	C/ Juan Pablo II, 28	7268097M	Monesterio	Badajoz	2507
289	2016-10-20 08:46:52.867443+02	2016-10-24 10:24:28.40801+02	3360652	Valeria	Calderón Carballar	2003-04-22	vcalderonc02	alumnos/3360652.jpg		674910974 	06260	C/ Juan Pablo II, 28	7268098Y	Monesterio	Badajoz	2897
223	2016-10-20 08:46:49.769832+02	2016-10-24 10:24:28.435768+02	3360993	Carlos	Calderón Delgado	1998-10-16	ccalderond02	alumnos/3360993.jpg		676418585 	06260	C/ C / Labrador, 10	80229986Y	Monesterio	Badajoz	2386
358	2016-10-20 08:46:56.245269+02	2016-10-24 10:24:28.463599+02	3360613	Ana	Calderón Gallego	2003-03-14	acalderong10	alumnos/3360613.jpg		625387027 924517217	06260	C/ El Cerezo, 27	7268189M	Monesterio	Badajoz	2898
15	2016-10-20 08:46:39.839089+02	2016-10-24 10:24:28.491758+02	3360802	Francisco Javier	Calderón Gallego	2000-04-28	fjcalderong02	alumnos/3360802.png		625387027 924517217	06260	C/ El Cerezo, 27	7268188G	Monesterio	Badajoz	2610
154	2016-10-20 08:46:46.498118+02	2016-10-24 10:24:28.519694+02	3360635	Javier	Calderón Garrote	2003-05-28	jcalderong06	alumnos/3360635.jpg		924516834 665278804	06260	C/ Cabarco, 7 A	20537908N	Monesterio	Badajoz	2899
152	2016-10-20 08:46:46.405441+02	2016-10-24 10:24:28.547729+02	3360567	Alfonso	Calderón Guareño	2002-05-28	acalderong17	alumnos/3360567.jpg		653923732 	06260	C/ Zurbarán, 25 A	7268090K	Monesterio	Badajoz	2810
65	2016-10-20 08:46:42.232973+02	2016-10-24 10:24:28.577029+02	3360621	María	Calderón Márquez	2003-02-27	mcalderonm09	alumnos/3360621.jpg	anacalderonmarquez@gmail.com	679017898 679017898	06260	C/ Saine, 13	8898376K	Monesterio	Badajoz	2900
148	2016-10-20 08:46:46.197605+02	2016-10-24 10:24:28.605514+02	3360732	Juan	Calderón Palacios	1999-11-21	jcalderonp01	alumnos/3360732.jpg		 	06260	C/ Ramón y Cajal, 5	8893880X	Monesterio	Badajoz	2508
288	2016-10-20 08:46:52.816875+02	2016-10-24 10:24:28.634788+02	3360612	Carmen	Calderón Sánchez	2003-07-03	ccalderons01	alumnos/3360612.jpg	 andres.monesterio.10@gmail.com	626053923 	06260	C/ Cañuelo, 41	8898358A	Monesterio	Badajoz	2901
216	2016-10-20 08:46:49.406692+02	2016-10-24 10:24:28.662403+02	3360801	María	Calderón Sánchez	2000-03-08	mcalderons03	alumnos/3360801.jpg		 	06260	C/ La Noria, 30	7268202H	Monesterio	Badajoz	2662
369	2016-10-20 08:46:56.777555+02	2016-10-24 10:24:28.690493+02	3384034	Álvaro	Calderón Vasco	2004-01-06	acalderonv04	alumnos/3384034.jpg		665783689 	06260	C/ Sierra de la Cruz, 3	20965893J	Monesterio	Badajoz	2996
183	2016-10-20 08:46:47.86801+02	2016-10-24 10:24:28.718171+02	3360837	David	Calderón Vasco	2001-05-03	dcalderonv01	alumnos/3360837.jpg		665783689 665783689	06260	C/ Sierra de la Cruz, 3,	20537808G	Monesterio	Badajoz	2722
162	2016-10-20 08:46:46.863516+02	2016-10-24 10:24:28.746442+02	3359677	Jorge	Calvo Miranda	2000-11-24	jcalvom09	alumnos/3359677.jpg		 	06292	C/ Ntra. Sra. De los Dolores, 35	20538120V	Calera de León	Badajoz	2663
72	2016-10-20 08:46:42.557774+02	2016-10-24 10:24:28.774213+02	3386794	Noelia	Campanario Ferrero	2004-03-30	noeliacampanario4	alumnos/3386794.jpg		681005404 	06907	C/ Puebla, 6	8898390N	Pallarés	Badajoz	2997
118	2016-10-20 08:46:44.737015+02	2016-10-24 10:24:28.802145+02	3430301	Desiré	Campanario Rueda	2004-05-21	dcampanarior01	alumnos/3430301.jpg		677338549 603549461	06291	C/ Calvario, 40	8370551T	Montemolín	Badajoz	2998
380	2016-10-20 08:46:57.342606+02	2016-10-24 10:24:28.830019+02	3430355	Juan Carlos	Campanario Rueda	2002-03-26	jccampanor01	alumnos/3430355.jpg		677338549 603549461	06291	C/ Calvario, 40	8370550E	Montemolín	Badajoz	2902
231	2016-10-20 08:46:50.134732+02	2016-10-24 10:24:28.85813+02	3360811	Myriam	Campos Barrero	2000-06-16	mcamposb01	alumnos/3360811.jpg		924517470 662278442	06260	C/ Pablo Iglesias, 21	77846955M	Monesterio	Badajoz	2723
34	2016-10-20 08:46:40.730641+02	2016-10-24 10:24:28.886196+02	3360758	Gemma	Cardoso Sayago	2000-06-16	gcardosos01	alumnos/3360758.jpg		 	06260	C/ Huerta Murcia, 52	20537886J	Monesterio	Badajoz	2665
370	2016-10-20 08:46:56.829691+02	2016-10-24 10:24:28.919367+02	3383536	Adrián	Carrasco Álvarez	2004-11-06	acarrascoa04	alumnos/3383536.jpg		609714128 635630486	06260	C/ Cañuelo, 30	45879002M	Monesterio	Badajoz	2999
126	2016-10-20 08:46:45.110745+02	2016-10-24 10:24:28.951978+02	3359666	Rafael	Carrasco Blanco	1999-09-02	agarrotef01	alumnos/3359666.png		 	06292	C/ Bravo Murillo, 29	8370439A	Calera de León	Badajoz	2980
11	2016-10-20 08:46:39.619822+02	2016-10-24 10:24:28.985121+02	3360571	Eduardo	Carrasco Granadero	2002-07-08	ecarrascog02	alumnos/3360571.jpg		627745618 627745618	06260	C/ Sierra del Castillo, 11	20537803E	Monesterio	Badajoz	2812
42	2016-10-20 08:46:41.140284+02	2016-10-24 10:24:29.01708+02	3360856	Antonio Jesús	Carrasco Lancharro	2002-08-04	ajcarrascol01	alumnos/3360856.jpg		924517054 	06260	C/ Elías Torres, 13	8370379N	Monesterio	Badajoz	2813
353	2016-10-20 08:46:55.984496+02	2016-10-24 10:24:29.04083+02	3264427	Luna	Carrasco Márquez	2001-07-05	lcarrascom04	alumnos/3264427.jpg		924113326 630383196	06907	C/ La Puebla, 74	8370558F	Pallarés	Badajoz	2720
12	2016-10-20 08:46:39.66469+02	2016-10-24 10:24:29.065337+02	3359702	Daniel	Carrasco Morales	2001-06-14	dcarrascom07	alumnos/3359702.jpg		692583277 	06292	C/ Juan Carlos I, 2 A	20538135D	Calera de León	Badajoz	2724
74	2016-10-20 08:46:42.647139+02	2016-10-24 10:24:29.091461+02	3360791	Miguel	Carrasco Sánchez	2000-01-09	mcarrascos01	alumnos/3360791.jpg		 	06260	C/ Rafael Alberti, 16	7269122H	Monesterio	Badajoz	2612
222	2016-10-20 08:46:49.724399+02	2016-10-24 10:24:29.118897+02	3745798	Desirée	Castillo Campano	1999-11-15	dcastilloc02	alumnos/3745798.jpg	estefareal@hotmail.com	676156998 	41250	C/ Doctor Fleming, 1 C	47391544K	El Real de la Jara	Sevilla	2968
293	2016-10-20 08:46:53.095805+02	2016-10-24 10:24:29.126755+02	3360772	Antonia	Castro Jaramillo	2002-09-02	acastroj01	alumnos/3360772.jpg		603434871 	06260	C/ Los Almendros, 8		Monesterio	Badajoz	2814
273	2016-10-20 08:46:52.133026+02	2016-10-24 10:24:29.154362+02	3360769	Andrea	Chavero López	2000-03-07	achaverol01	alumnos/3360769.jpg		 	06260	C/ Sierra del Castillo, 13	7268171X	Monesterio	Badajoz	2613
22	2016-10-20 08:46:40.177088+02	2016-10-24 10:24:29.182986+02	3360628	José Carlos	Chavero Sánchez	2003-07-04	jcchaveros01	alumnos/3360628.jpg		638650514 	06260	C/ Paseo de Extremadura, 104	20540630C	Monesterio	Badajoz	2904
73	2016-10-20 08:46:42.603739+02	2016-10-24 10:24:29.211891+02	3384042	Carla	Chavero Velázquez	2004-05-04	cchaverov01	alumnos/3384042.jpg		666841054 	06260	C/ Río Viar, 23 2 B	20537970M	Monesterio	Badajoz	3000
225	2016-10-20 08:46:49.860755+02	2016-10-24 10:24:29.240507+02	3360715	Jesús	Chaves Romero	1999-10-31	jchavesr02	alumnos/3360715.jpg		 	06260	C/ Bovedo, 10 2º A	20537890V	Monesterio	Badajoz	2515
286	2016-10-20 08:46:52.722423+02	2016-10-24 10:24:29.269832+02	3359693	Luis Miguel	Chávez Gata	2000-06-18	lmchavezg03	alumnos/3359693.jpg		648133788 	06292	C/ García de Paredes, 5	8370431H	Calera de León	Badajoz	2614
198	2016-10-20 08:46:48.579485+02	2016-10-24 10:24:29.297548+02	3360775	Claudia	Chávez González	2002-05-07	cchavezg02	alumnos/3360775.jpg	igonzalezc14@gmail.com	626861804 649658760	06260	C/ Barrio de la Cruz, 45	8898352C	Monesterio	Badajoz	2815
139	2016-10-20 08:46:45.757648+02	2016-10-24 10:24:29.325918+02	3360729	Elena	Chávez González	1999-12-17	echavezg01	alumnos/3360729.jpg	igonzalezc14@gmail.com	650618713 924516688	06260	C/ Barrio de la Cruz, 45	8893896A	Monesterio	Badajoz	2517
149	2016-10-20 08:46:46.249025+02	2016-10-24 10:24:29.354168+02	3359668	Elena	Chávez Hoyos	1999-03-29	echavezh01	alumnos/3359668.jpg		696658155 	06292	C/ Plaza de Cervantes, 2 A	20538125E	Calera de León	Badajoz	2518
163	2016-10-20 08:46:46.910364+02	2016-10-24 10:24:29.382267+02	3359684	Laura	Chávez Hoyos	2000-09-23	lchavezh01	alumnos/3359684.jpg		 	06292	C/ Plaza de Cervantes, 2 A	20538126T	Calera de León	Badajoz	2615
202	2016-10-20 08:46:48.766775+02	2016-10-24 10:24:29.410349+02	3360618	Nerea	Cobos Martínez	2003-08-16	ncobosm01	alumnos/3360618.jpg		652559637 924516531	06260	C/ Tierno Galván, 7	20537790D	Monesterio	Badajoz	2905
290	2016-10-20 08:46:52.937168+02	2016-10-24 10:24:29.438457+02	3360640	Cristian	Colorado Ferreira	2003-02-19	ccoloradof03	alumnos/3360640.jpg		685148428 	06260	C/ Cañuelo, 4 2º B	7269121V	Monesterio	Badajoz	2906
66	2016-10-20 08:46:42.279119+02	2016-10-24 10:24:29.464915+02	3360629	David	Colorado Megías	2003-09-02	dcoloradom01	alumnos/3360629.jpg		618742036 667361769	06260	C/ Pablo Iglesias, 10	20537776H	Monesterio	Badajoz	2907
114	2016-10-20 08:46:44.555877+02	2016-10-24 10:24:29.492764+02	3360607	Carla	Conde Moruno	1998-04-17	ccondem02	alumnos/3360607.jpg		677095257 	06260	Rda/ Bodonal de la Sierra, 120	20538034T	Monesterio	Badajoz	2398
33	2016-10-20 08:46:40.687391+02	2016-10-24 10:24:29.52163+02	3562301	Miguel	Contreras Chaves	1999-09-27	mcontrerasc05	alumnos/3562301.jpg		924584040 608140025	06292	C/ Hernando de Soto, 3 B	48210846V	Calera de León	Badajoz	2519
269	2016-10-20 08:46:51.950776+02	2016-10-24 10:24:29.55004+02	3562508	Raúl	Contreras Chaves	2004-07-02	rcontrerasc04	alumnos/3562508.jpg		602360416 	06292	C/ Hernando de Soto, 3 B	48210848L	Calera de León	Badajoz	3001
384	2016-10-20 08:46:57.548412+02	2016-10-24 10:24:29.577991+02	3562473	Sergio	Contreras Chaves	2001-09-08	scontrerasc04	alumnos/3562473.jpg		619783113 608140025	06292	C/ Hernando de Soto, 3 B	48210847H	Calera de León	Badajoz	2816
129	2016-10-20 08:46:45.26185+02	2016-10-24 10:24:29.605806+02	3359676	Inés	Contreras Durán	2000-09-18	icontrerasd01	alumnos/3359676.jpg		629766393 	06292	C/ Reyes Católicos, 35	8370442Y	Calera de León	Badajoz	2725
20	2016-10-20 08:46:40.073076+02	2016-10-24 10:24:29.6337+02	3360789	Laura	Contreras Ferreira	2002-06-09	lcontrerasf02	alumnos/3360789.jpg		663989821 	06260	C/ Los Cotos, 9	7268193D	Monesterio	Badajoz	2817
131	2016-10-20 08:46:45.377878+02	2016-10-24 10:24:29.661848+02	3360587	Alejandro	Contreras Iglesias	2002-07-27	acontrerasi01	alumnos/3360587.jpg		687392274 620391046	06260	C/ Cañuelo, 51	20537948Y	Monesterio	Badajoz	3059
373	2016-10-20 08:46:56.977288+02	2016-10-24 10:24:29.689167+02	3360886	Juan Antonio	Córdoba Barranco	1996-09-12	jacordobab01	alumnos/3360886.jpg		 	06260	C/ Ronda de Cabeza la Vaca, 15	20538071Z	Monesterio	Badajoz	2225
359	2016-10-20 08:46:56.300288+02	2016-10-24 10:24:29.716624+02	3747663	Desireé	Covilla D'Acosta	2003-09-30	dcovillad01	alumnos/3747663.jpg		660195489 660195489	06260	C/ La Trocha, S / N,	54186266Z	Monesterio	Badajoz	2974
143	2016-10-20 08:46:45.947271+02	2016-10-24 10:24:29.73621+02	3264426	Marta	Crisóstomo Lozano	2001-09-20	mcrisostomol01	alumnos/3264426.jpg		660588252 924512209	06906	Pl/ Manuel Durán, 13	8368690W	Puebla del Maestre	Badajoz	2726
354	2016-10-20 08:46:56.029964+02	2016-10-24 10:24:29.763925+02	3359711	Candela	Cubero Carrasco	2001-05-10	ccuberoc01	alumnos/3359711.jpg		680392605 	06292	C/ Río Ardila, 7	45970976W	Calera de León	Badajoz	2727
347	2016-10-20 08:46:55.705008+02	2016-10-24 10:24:29.783543+02	3359712	Mario	Cubero Carrasco	1999-06-16	mcuberoc01	alumnos/3359712.jpg		924584082 	06292	C/ Río Ardila, 7	45970977A	Calera de León	Badajoz	2520
296	2016-10-20 08:46:53.237607+02	2016-10-24 10:24:29.803344+02	3386505	Fabián	Cubero González	2004-09-26	fcuberog01	alumnos/3386505.jpg		609862577 	06290	Avda/ Ntra. Sra. De los Dolores, 29	9212837A	Calera de León	Badajoz	3053
184	2016-10-20 08:46:47.912756+02	2016-10-24 10:24:29.830766+02	3359685	Antonio	Cubero Zapata	2000-02-06	acuberoz01	alumnos/3359685.jpg		9245884262 	06292	C/ Pedro de Valdivia, 16	20538130G	Calera de León	Badajoz	2617
335	2016-10-20 08:46:55.126416+02	2016-10-24 10:24:29.858147+02	3360787	Juan José	Cubo González	2002-03-05	jjcubog01	alumnos/3360787.jpg		652504029 	06260	C/ Pablo Iglesias, 8	7269123L	Monesterio	Badajoz	2908
379	2016-10-20 08:46:57.277076+02	2016-10-24 10:24:29.885472+02	3360687	Raúl	Dacosta Bayón	1998-05-01	rdacostab01	alumnos/3360687.jpg		 	06260	C/ Espronceda, 12 1º A,	8890861G	Monesterio	Badajoz	2522
240	2016-10-20 08:46:50.55438+02	2016-10-24 10:24:29.910795+02	3360600	María	Dahiri 	2002-07-24	mdahirim01	alumnos/3360600.jpg		632267584 	06260	C/ Cañuelo, 35	X4686645G	Monesterio	Badajoz	2909
300	2016-10-20 08:46:53.425715+02	2016-10-24 10:24:29.938394+02	3264413	Raúl	Danta Romero	2000-02-19	rdantar01	alumnos/3264413.jpg		924512070 	06906	C/ Queipo de Llano, 70	8897553A	Puebla del Maestre	Badajoz	2618
352	2016-10-20 08:46:55.938174+02	2016-10-24 10:24:29.965807+02	3573187	Soraya	Danta San Juan	2000-04-01	elopezd09	alumnos/3573187.jpg		649571819 	06906	C/ Queipo de Llano,		Puebla del Maestre	Badajoz	2728
119	2016-10-20 08:46:44.783557+02	2016-10-24 10:24:29.993308+02	3573193	Yumara	Danta San Juan	2003-12-05	yumaradanta4	alumnos/3573193.jpg		673246970 	06906	C/ Queipo de Llano,	45974711B	Puebla del Maestre	Badajoz	3002
292	2016-10-20 08:46:53.044305+02	2016-10-24 10:24:30.018466+02	3657596	Ángel	De la Coba Córdoba	2001-04-09	adelacobac01	alumnos/3657596.jpg		666805626 	06291	C/ Medio Grande, 44	74394572Z	Montemolín	Badajoz	2819
232	2016-10-20 08:46:50.18143+02	2016-10-24 10:24:30.043151+02	3360653	Mario	De Ocampo Delgado	2003-04-11	mdeocampod01	alumnos/3360653.jpg		653118717 653118717	06260	C/ Reyes Lancharro, 16 B 7	77929940Y	Monesterio	Badajoz	3058
295	2016-10-20 08:46:53.190956+02	2016-10-24 10:24:30.067771+02	3359669	Almudena	Delgado Aguilar	1999-03-11	adelgadoa09	alumnos/3359669.jpg		689551961 	06292	Avda/ Del Parque, 16 1 A	7268125X	Calera de León	Badajoz	2523
153	2016-10-20 08:46:46.451689+02	2016-10-24 10:24:30.101487+02	3360780	Juan	Delgado Calderón	2002-03-25	jdelgadoc11	alumnos/3360780.jpg	manumonesterio@hotmail.com	924516840 	06260	C/ Constitución, 21	7269130A	Monesterio	Badajoz	2820
266	2016-10-20 08:46:51.795725+02	2016-10-24 10:24:30.134294+02	3360817	Sergio	Delgado González	2001-09-13	sdelgadog05	alumnos/3360817.jpg		657471655 	06260	C/ Zurbarán, 44	20537811F	Monesterio	Badajoz	2729
111	2016-10-20 08:46:44.417701+02	2016-10-24 10:24:30.159678+02	3360569	David	Delgado Romero	2002-12-17	ddelgador09	alumnos/3360569.jpg	radema65@jotmail.com	675734662 675734662	06260	C/ Endrinales, 7 2 B	20537874R	Monesterio	Badajoz	2821
316	2016-10-20 08:46:54.233788+02	2016-10-24 10:24:30.18715+02	3360818	Jesús	Delgado Zambrano	2001-12-19	jdelgadoz01	alumnos/3360818.jpg		646954524 	06260	C/ La Noria, 37	20538005V	Monesterio	Badajoz	2730
348	2016-10-20 08:46:55.752761+02	2016-10-24 10:24:30.214852+02	3360713	María Teresa	Delgado Zambrano	1999-12-08	teeresaaaaa01	alumnos/3360713.jpg		696457502 	06260	C/ La Noria, 37	20538006H	Monesterio	Badajoz	2525
317	2016-10-20 08:46:54.280577+02	2016-10-24 10:24:30.242825+02	3359703	Judith	Díaz Domínguez	2001-03-10	jdelgadoz01	alumnos/3359703.jpg		 	06292	C/ Avda de San Marcos, 11 1º A	45879525E	Calera de León	Badajoz	2733
387	2016-10-20 08:46:57.695533+02	2016-10-24 10:24:30.271652+02	3359709	Jonathan	Domínguez Blanco	2002-08-08	jdominguezb08	alumnos/3359709.jpg		657418184 	06292	C/ Maestre Gonzalo Mexías, 6	20538146C	Calera de León	Badajoz	2822
180	2016-10-20 08:46:47.732992+02	2016-10-24 10:24:30.299549+02	3360794	Isabel María	Domínguez Campano	2000-06-11	imdominguezc02	alumnos/3360794.jpg		648731929 	06260	C/ Paseo de Extremadura, 23	20537879Y	Monesterio	Badajoz	2731
75	2016-10-20 08:46:42.690277+02	2016-10-24 10:24:30.32701+02	3360793	Francisco Javier	Domínguez Sabido	2000-06-05	fjdominguezs01	alumnos/3360793.jpg		924517212 	06260	C/ Sierra del Castillo 6, 1 A	20537875W	Monesterio	Badajoz	2666
346	2016-10-20 08:46:55.65726+02	2016-10-24 10:24:30.354597+02	3264428	Antonio Jesús	Domínguez Uguina	2000-10-12	ajdominguezu01	alumnos/3264428.png		664495374 	06906	C/ Reliquias, 44	8898764H	Puebla del Maestre	Badajoz	2667
30	2016-10-20 08:46:40.54754+02	2016-10-24 10:24:30.38222+02	3386921	Alicia	Domínguez Vaz	2004-08-12	aliciadominguez4	alumnos/3386921.jpg		 	06908	C/ Fuente, 3	20540617F	Santa María de la Nava	Badajoz	3003
52	2016-10-20 08:46:41.603449+02	2016-10-24 10:24:30.410113+02	3360576	Manuel José	Donoso Calderón	2002-07-27	mjdonosoc01	alumnos/3360576.jpg		658549202 	06260	C/ La Noria, 19	8897547C	Monesterio	Badajoz	2911
333	2016-10-20 08:46:55.017307+02	2016-10-24 10:24:30.437819+02	3360826	Clara	Duqueso Villalba	2001-06-24	cduquesov01	alumnos/3360826.jpg	joandufer@hotmail.com	685790393 658107432	06260	C/ Rafael Alberti, 10	7268093R	Monesterio	Badajoz	2732
199	2016-10-20 08:46:48.625876+02	2016-10-24 10:24:30.463475+02	3360573	María del Mar	Durán Mejías	2002-03-07	mdmduranm01	alumnos/3360573.jpg		674734344 646924571	06260	C/ Paseo de Extremadura, 27	7269124C	Monesterio	Badajoz	2823
378	2016-10-20 08:46:57.227373+02	2016-10-24 10:24:30.486861+02	3613170	Gerard	Escudero Muñoz	2001-07-10	gescuderom04	alumnos/3613170.jpg		924512331 	06906	C/ Hernán Cortes, 1	53830383X	Puebla del Maestre	Badajoz	2734
360	2016-10-20 08:46:56.346254+02	2016-10-24 10:24:30.510422+02	3360616	Ara	Espacio Santos	2003-11-06	aespacios03	alumnos/3360616.jpg		679075290 699501681	06260	C/ Las Espeñas, 1	7269199A	Monesterio	Badajoz	2912
349	2016-10-20 08:46:55.79934+02	2016-10-24 10:24:30.5344+02	3360716	María	Esteban Delgado	1999-04-29	mesteband04	alumnos/3360716.jpg		619166632 	06260	C/ Ronda de Bodonal de la Sierra, 118	7268173N	Monesterio	Badajoz	2526
28	2016-10-20 08:46:40.454029+02	2016-10-24 10:24:30.560132+02	3360827	Paula	Esteban González	2001-12-14	pestebang01	alumnos/3360827.jpg		625643009 924517155	06260	C/ Luis Chamizo, 25	8898367N	Monesterio	Badajoz	2735
196	2016-10-20 08:46:48.473077+02	2016-10-24 10:24:30.586012+02	3264397	Alicia	Esteban Ortiz	1999-05-27	aestebano01	alumnos/3264397.jpg		 	06907	C/ Cervantes, 1	20538224Y	Pallarés	Badajoz	2527
372	2016-10-20 08:46:56.929341+02	2016-10-24 10:24:30.611873+02	3360606	Mónica	Estévez Baños	1999-02-18	mestevezb01	alumnos/3360606.jpg		649482307 	06260	C/ Juan Pablo II, 26	20537946G	Monesterio	Badajoz	2528
329	2016-10-20 08:46:54.834759+02	2016-10-24 10:24:30.63771+02	3360608	Xavier	Estévez Baños	2002-02-23	xestevezb01	alumnos/3360608.jpg		645878082 	06260	C/ Juan Pablo II, 26	20537947M	Monesterio	Badajoz	2824
189	2016-10-20 08:46:48.137795+02	2016-10-24 10:24:30.662452+02	3360570	Marcos	Expósito Granadero	2002-10-17	mexpositog01	alumnos/3360570.jpg		687244494 	06260	C/ San Ildefonso, 41	20537805R	Monesterio	Badajoz	2825
63	2016-10-20 08:46:42.140762+02	2016-10-24 10:24:30.687188+02	3360632	Francisco José	Fernández Cañizares	2003-02-21	fjfernandezc11	alumnos/3360632.jpg		626666459 	06260	C/ Rosa de Luxenburgo, 13	20537973P	Monesterio	Badajoz	2913
330	2016-10-20 08:46:54.880106+02	2016-10-24 10:24:30.712899+02	3359695	Victoria	Fernández Cubero	2001-03-07	vfernandezc11	alumnos/3359695.jpg		625959714 648069906	06292	C/ Río Ardila, 5	20538139J	Calera de León	Badajoz	2826
8	2016-10-20 08:46:39.486331+02	2016-10-24 10:24:30.737242+02	3359714	Saúl	Fernández Fernández	2003-12-08	sfernandezf24	alumnos/3359714.jpg		678864319 	06292	C/ San Marcos, 9 B D	20538138N	Calera de León	Badajoz	2914
256	2016-10-20 08:46:51.323048+02	2016-10-24 10:24:30.761348+02	3360731	Macarena	Fernández Garrote	1999-04-17	mfernandezg31	alumnos/3360731.jpg		924516303 	06260	C/ Río Culebrín, 2	7269196T	Monesterio	Badajoz	2529
161	2016-10-20 08:46:46.817705+02	2016-10-24 10:24:30.785447+02	3384047	Marcos	Fernández González	2004-04-07	mfernandezg28	alumnos/3384047.jpg		924516609 605014946	06260	C/ Barrio de la Cruz, 115	7269120Q	Monesterio	Badajoz	3004
267	2016-10-20 08:46:51.859157+02	2016-10-24 10:24:30.81073+02	3359699	Paola	Fernández Megías	2001-07-16	pfernandezm42	alumnos/3359699.jpg		606853151 	06290	C/ Reyes Católicos, 11	20538137B	Calera de León	Badajoz	2736
279	2016-10-20 08:46:52.402865+02	2016-10-24 10:24:30.836887+02	3452574	Carmen María	Fernández Ramos	1997-04-12	cmfernandezr01	alumnos/3452574.jpg		689342646 	06291	C/ Llerena, 17	8370544Q	Montemolín	Badajoz	2409
227	2016-10-20 08:46:49.952424+02	2016-10-24 10:24:30.85639+02	3452575	María de los Ángeles	Fernández Ramos	1997-04-12	mdlafernandezr02	alumnos/3452575.jpg		681176979 	06291	C/ Llerena, 17	8370543S	Montemolín	Badajoz	2410
258	2016-10-20 08:46:51.416744+02	2016-10-24 10:24:30.87301+02	3264436	Isabel	Fernández Sánchez	2002-08-16	ifernandezs02	alumnos/3264436.jpg		924512163 	06906	Bda/ Las Reliquias, 9	8897551R	Puebla del Maestre	Badajoz	2827
32	2016-10-20 08:46:40.643506+02	2016-10-24 10:24:30.897247+02	3360759	María de los Ángeles	Fernández Vasco	2000-07-12	mdlafernandezv01	alumnos/3360759.jpg		 	06260	C/ Mesones, 21	20538014A	Monesterio	Badajoz	2620
160	2016-10-20 08:46:46.771836+02	2016-10-24 10:24:30.923657+02	3359697	Andrés	Fernández Zapata	2001-02-27	afernandezz03	alumnos/3359697.jpg		689914499 615191484	06292	C/ García de Paredes, 9	8370435E	Calera de León	Badajoz	2771
260	2016-10-20 08:46:51.50991+02	2016-10-24 10:24:30.947291+02	3359721	Diego	Fernández Zapata	2003-05-06	dfernandezz03	alumnos/3359721.jpg		924584100 615191484	06292	C/ García de Paredes, 9	8370436T	Calera de León	Badajoz	2915
88	2016-10-20 08:46:43.31102+02	2016-10-24 10:24:30.972543+02	3360768	Francisco Javier	Ferreira Lancharro	2002-07-26	fjferreiral01	alumnos/3360768.jpg		636448056 	06260	C/ Ramón y Cajal, 44	20537822H	Monesterio	Badajoz	2916
56	2016-10-20 08:46:41.788506+02	2016-10-24 10:24:30.997799+02	3360797	Carlos	Ferreira Pizarro	2000-03-16	cferreirap01	alumnos/3360797.jpg		 	06260	C/ Sevilla,9,	20540615M	Monesterio	Badajoz	2621
234	2016-10-20 08:46:50.272961+02	2016-10-24 10:24:31.02525+02	3264398	Daniel	Filigrana Guillén	1999-06-29	dfiligranag01	alumnos/3264398.png		 	06906	Bda/ Las Reliquias, 25	8898769T	Puebla del Maestre	Badajoz	2622
270	2016-10-20 08:46:51.99816+02	2016-10-24 10:24:31.053083+02	3359689	Ismael	Flores Baños	2000-11-19	isfloba1	alumnos/3359689.jpg		 	06292	C/ Travesía de los Galanes, 2	7268113K	Calera de León	Badajoz	2623
166	2016-10-20 08:46:47.045865+02	2016-10-24 10:24:31.080915+02	3386949	María Luisa	Flores Moro	2004-02-29	luisaflores4	alumnos/3386949.jpg		697905658 	06907	C/ Montemolin, 17	26559578Y	Pallarés	Badajoz	3005
304	2016-10-20 08:46:53.620608+02	2016-10-24 10:24:31.10864+02	3359706	Alejandro	Galán Cano	2002-02-10	agalanc11	alumnos/3359706.jpg		669068117 639231291	06292	C/ Pizarro, 12	20538106A	Calera de León	Badajoz	2828
55	2016-10-20 08:46:41.741424+02	2016-10-24 10:24:31.136675+02	3264440	David	Galván Ferrero	1999-06-12	dgalvanf01	alumnos/3264440.jpg		 	06907	C/ Llerena, 6	30245979J	Pallarés	Badajoz	2979
76	2016-10-20 08:46:42.734926+02	2016-10-24 10:24:31.170282+02	3386898	Raúl	Galván Ferrero	2004-11-16	raulgalvan4	alumnos/3386898.jpg		 	06907	C/ Llerena, 6	30245980Z	Pallarés	Badajoz	3006
16	2016-10-20 08:46:39.883527+02	2016-10-24 10:24:31.205969+02	3264390	Ainhoa	García Campanario	1998-10-30	agarciac156	alumnos/3264390.jpg		924511113 689936628	06907	C/ Puebla, 47	8898389B	Pallarés	Badajoz	2978
169	2016-10-20 08:46:47.186422+02	2016-10-24 10:24:31.240008+02	3360771	Adrián	García Chavero	2002-02-18	agarciac89	alumnos/3360771.jpg		616896755 	06260	C/ El Cerezo, 23	45968205Z	Monesterio	Badajoz	2829
259	2016-10-20 08:46:51.46314+02	2016-10-24 10:24:31.26743+02	3430356	Ana Isabel	García Galván	2002-05-20	aigarciag06	alumnos/3430356.jpg		644872301 615274541	06291	C/ Bastiana, 6	7268151J	Montemolín	Badajoz	2830
299	2016-10-20 08:46:53.378758+02	2016-10-24 10:24:31.293618+02	3360800	Laura	García Garrote	2000-05-06	lgarciag10	alumnos/3360800.jpg		 	06260	C/ Libertad, 26	8893876Y	Monesterio	Badajoz	2624
285	2016-10-20 08:46:52.677323+02	2016-10-24 10:24:31.319546+02	3360693	Juan Carlos	García Muñiz	1998-04-07	jcgarciam05	alumnos/3360693.jpg		608621975 	06260	C/ Paseo de Extremadura, 192	7268196N	Monesterio	Badajoz	2415
137	2016-10-20 08:46:45.66282+02	2016-10-24 10:24:31.34533+02	3264399	Celia	Garrote Abril	1999-03-19	cgarrotea01	alumnos/3264399.jpg		924512368 	06906	Bda/ Las Reliquias, 28	8897550T	Puebla del Maestre	Badajoz	2533
125	2016-10-20 08:46:45.064641+02	2016-10-24 10:24:31.371319+02	3360723	Álvaro	Garrote Fuentes	1999-11-09	agarrotef01	alumnos/3360723.jpg		924517123 615123505	06260	C/ Bóvedo, 1	8893883J	Monesterio	Badajoz	2534
323	2016-10-20 08:46:54.559018+02	2016-10-24 10:24:31.398942+02	3383558	Carmen	Garrote Fuentes	2004-05-19	cgarrotef01	alumnos/3383558.jpg		924517123 615123505	06260	C/ Bovedo, 1	8368093A	Monesterio	Badajoz	3007
165	2016-10-20 08:46:47.000844+02	2016-10-24 10:24:31.426978+02	3360808	Ana	Garrote García	2000-09-03	agarroteg04	alumnos/3360808.jpg		 	06260	C/ Cervantes, 14	20537961L	Monesterio	Badajoz	2625
155	2016-10-20 08:46:46.544226+02	2016-10-24 10:24:31.455393+02	3360639	Javier	Garrote Garrón	2003-08-07	jgarroteg01	alumnos/3360639.jpg	garrotegarronangela@gmail.com	657460510 655049617	06260	C/ Endrinales, 11	20537958Q	Monesterio	Badajoz	2918
1	2016-10-20 08:46:39.1265+02	2016-10-24 10:24:31.483267+02	3360580	María	Garrote Garrón	2002-09-19	mgarroteg05	alumnos/3360580.jpg	garrotegarronangela@gmail.com	924517291 646029474	06260	C/ Los Almendros, 5	20537965T	Monesterio	Badajoz	2831
171	2016-10-20 08:46:47.281727+02	2016-10-24 10:24:31.511305+02	3360578	Alberto	Garrote Ledesma	2002-02-22	agarrotel02	alumnos/3360578.jpg		678242908 687444929	06260	C/ Barrio de la Cruz, 126	20537796S	Monesterio	Badajoz	2832
217	2016-10-20 08:46:49.451736+02	2016-10-24 10:24:31.539225+02	3360805	Cristina	Garrote Mateos	2000-09-20	cgarrotem04	alumnos/3360805.jpg		633469972 	06260	C/ Pozos, 8	7269116N	Monesterio	Badajoz	2626
31	2016-10-20 08:46:40.597584+02	2016-10-24 10:24:31.567214+02	3360767	Ángela	Garrote Megías	2000-04-25	agarrotem01	alumnos/3360767.jpg		 	06260	C/ Zurbarán, 64,	20537861B	Monesterio	Badajoz	2627
366	2016-10-20 08:46:56.631117+02	2016-10-24 10:24:31.596265+02	3360829	Leire	Gata Rodríguez	2001-01-06	lgatar01	alumnos/3360829.jpg		629613570 615309223	06260	C/ Templarios, 36	7269186J	Monesterio	Badajoz	2737
203	2016-10-20 08:46:48.813521+02	2016-10-24 10:24:31.62436+02	3359718	Laura	Gavira Rodríguez	2003-01-14	lgavirar01	alumnos/3359718.jpg	jgaylau@hotmail.com	638392537 924584073	06292	C/ Río Ardila, 4	20538133F	Calera de León	Badajoz	2919
311	2016-10-20 08:46:53.956514+02	2016-10-24 10:24:31.653987+02	3533565	Danielius	Gedvilas Kerevicius	2003-01-04	dgedvilask01	alumnos/3533565.jpg		924584069 	06290	C/ Maestre González Mexias, 28	Y1897868Z	Calera de León	Badajoz	2920
243	2016-10-20 08:46:50.716848+02	2016-10-24 10:24:31.676243+02	3264441	Pedro	Giles Grau	2002-07-19	pgilesg01	alumnos/3264441.jpg		639681103 	06906	C/ Churruca, 7	45974608T	Puebla del Maestre	Badajoz	2833
389	2016-10-20 08:46:57.79147+02	2016-10-24 10:24:31.704686+02	3360778	Alberto	Godino Gómez	2002-12-13	agodinog01	alumnos/3360778.jpg		609253454 627412908	06260	Pso/ Extremadura, 1 2º D	9216937D	Monesterio	Badajoz	2835
133	2016-10-20 08:46:45.471212+02	2016-10-24 10:24:31.732762+02	3360848	María de los Ángeles	Gómez Monjo	2001-12-23	mdlagomezm01	alumnos/3360848.jpg		924516316 689297214	06260	C/ Cabarco, 8	8898374L	Monesterio	Badajoz	2741
388	2016-10-20 08:46:57.742133+02	2016-10-24 10:24:31.752561+02	3360766	Sira	González Bernáldez	2000-05-09	sgonzalezb09	alumnos/3360766.jpg		675401836 642458024	06260	C/ Luis Chamizo 25,	7269176A	Monesterio	Badajoz	2682
185	2016-10-20 08:46:47.957591+02	2016-10-24 10:24:31.780212+02	3360584	Fabián	González Cardoso	2002-12-06	fgonzalezc29	alumnos/3360584.jpg		605674295 	06260	C/ Almendro, 2	8898348Q	Monesterio	Badajoz	2836
318	2016-10-20 08:46:54.327291+02	2016-10-24 10:24:31.807987+02	3359701	Daniel	González Cubero	2001-11-12	jdelgadoz01	alumnos/3359701.jpg		924584078 659313417	06292	C/ Cristóbal Colón, 3	7268117W	Calera de León	Badajoz	2738
109	2016-10-20 08:46:44.327324+02	2016-10-24 10:24:31.836081+02	3360721	Elena Isabel	González Delgado	1999-11-20	egonzalezd09	alumnos/3360721.jpg		924517224 	06260	C/ Barrio de la Cruz, 123	80089303Z	Monesterio	Badajoz	2536
244	2016-10-20 08:46:50.770343+02	2016-10-24 10:24:31.863768+02	3360773	Rafael	González Delgado	2002-06-07	rgonzalezd06	alumnos/3360773.jpg		 	06260	C/ Barrio de la Cruz, 123	20537887Z	Monesterio	Badajoz	2837
233	2016-10-20 08:46:50.22694+02	2016-10-24 10:24:31.889478+02	3360623	Cristian	González Fernández	2003-02-25	cgonzalezf09	alumnos/3360623.jpg		656428781 680235654	06260	C/ Avda. De Portugal, 15	7268183E	Monesterio	Badajoz	3062
220	2016-10-20 08:46:49.627296+02	2016-10-24 10:24:31.917104+02	3381561	Javier	González Fernández	2004-08-21	jgonzalezf35	alumnos/3381561.jpg		635063809 	06260	C/ Camping Tentudia Carretera 630 Km 727,	45139190B	Monesterio	Badajoz	3008
35	2016-10-20 08:46:40.778927+02	2016-10-24 10:24:31.946308+02	3384060	Sonia	González Nogués	2004-07-15	sgonzalezn05	alumnos/3384060.jpg		615309315 	06260	C/ San Pedro, 40 1º	20537880F	Monesterio	Badajoz	3009
275	2016-10-20 08:46:52.223235+02	2016-10-24 10:24:31.97292+02	3383862	Pablo	González Pecellín	2004-07-02	pgonzalezp14	alumnos/3383862.jpg		625323305 	06260	C/ Cerro de la Fuente, 9	29499768Z	Monesterio	Badajoz	3010
108	2016-10-20 08:46:44.282426+02	2016-10-24 10:24:31.998581+02	3360838	Antonio	González Vasco	2001-08-07	agonzalezv17	alumnos/3360838.jpg		622730929 924517158	06260	C/ Juan Ramón Jiménez, 15	7268201V	Monesterio	Badajoz	2739
281	2016-10-20 08:46:52.489294+02	2016-10-24 10:24:32.026224+02	3414544	José Daniel	González Vázquez	1999-08-31	jdgonzalezv01	alumnos/3414544.png		 	06260	Avda/ Portugal, 15	7268181C	Monesterio	Badajoz	2628
241	2016-10-20 08:46:50.60007+02	2016-10-24 10:24:32.053557+02	3414543	Paola	González Vázquez	1999-08-30	pgonzalezv07	alumnos/3414543.jpg		654488781 	06260	Avda/ Portugal, 15	7268182K	Monesterio	Badajoz	2629
278	2016-10-20 08:46:52.359463+02	2016-10-24 10:24:32.080265+02	3360572	José Fernando	González Villacis	2002-07-23	jfgonzalezv02	alumnos/3360572.jpg		924517296 659602152	06260	C/ Libertad, 19	45875165D	Monesterio	Badajoz	2838
128	2016-10-20 08:46:45.202882+02	2016-10-24 10:24:32.107782+02	3360830	Francisco Alejandro	Gordito Rivera	2001-09-22	fagorditor01	alumnos/3360830.jpg		661539600 665885693	06260	C/ Dolores Ibarruri, 33	7269209J	Monesterio	Badajoz	2740
249	2016-10-20 08:46:51.000421+02	2016-10-24 10:24:32.13568+02	3361003	Desiree	Gordito Velázquez	1998-03-09	dgorditov01	alumnos/3361003.jpg		645544784 	06260	C/ San Isidro, 16	8890878K	Monesterio	Badajoz	2538
377	2016-10-20 08:46:57.176939+02	2016-10-24 10:24:32.163803+02	3448578	Alba	Granadero Larrayad	2000-02-23	agranaderol01	alumnos/3448578.jpg		622431057 924510153	06291	C/ Ranchuelo, 24	8368982H	Montemolín	Badajoz	2772
2	2016-10-20 08:46:39.215915+02	2016-10-24 10:24:32.191514+02	3360785	Belén	Granadero Villalba	2002-08-13	bgranaderov01	alumnos/3360785.jpg		676654825 	06260	C/ Barrio de la Cruz, 68 D	8370374F	Monesterio	Badajoz	2839
382	2016-10-20 08:46:57.443972+02	2016-10-24 10:24:32.219751+02	3360774	Francisco	Granados Calderón	2002-05-02	fgranadosc01	alumnos/3360774.jpg		924517086 924517590	06260	C/ Santa Ana,	8898371Q	Monesterio	Badajoz	2840
23	2016-10-20 08:46:40.229302+02	2016-10-24 10:24:32.248611+02	3453822	Laura	Guareño Muñoz	2003-10-22	lguareñom01	alumnos/3453822.jpg	pilarmunozreal@hotmail.es	636933226 636933226	06260	C/ P. Extremadura, 240 x	20537967W	Monesterio	Badajoz	2922
77	2016-10-20 08:46:42.779004+02	2016-10-24 10:24:32.285156+02	3384751	Alba	Guareño Valencia	2004-05-15	aguareñov01	alumnos/3384751.jpg		924516701 642136606	06260	C/ Cañuelo, 23	8368098P	Monesterio	Badajoz	3011
97	2016-10-20 08:46:43.714433+02	2016-10-24 10:24:32.314269+02	3449793	Ignacio	Guerrero Noguera	2002-06-17	iguerreron01	alumnos/3449793.jpg		675577726 686041696	06291	C/ San Blas, 7	20538178Y	Montemolín	Badajoz	2841
226	2016-10-20 08:46:49.906468+02	2016-10-24 10:24:32.340146+02	3360597	Amal	Harkaoui Elabbassi	2002-06-27	aharkaouie01	alumnos/3360597.jpg		632969416 	06260	C/ Juan Ramón Jiménez, 4	45971290V	Monesterio	Badajoz	2842
45	2016-10-20 08:46:41.280944+02	2016-10-24 10:24:32.366774+02	3360596	Nabil	Herba Herba	2002-08-30	nherbah01	alumnos/3360596.jpg		631263641 	06260	C/ Paseo de Extremadura, 180 1	X4761465M	Monesterio	Badajoz	2924
176	2016-10-20 08:46:47.544612+02	2016-10-24 10:24:32.393995+02	3360595	Najib	Herba Herba	2002-08-30	nherbah02	alumnos/3360595.jpg		631263641 	06260	C/ Paseo de Extremadura, 180 1	X4761444F	Monesterio	Badajoz	2923
218	2016-10-20 08:46:49.497243+02	2016-10-24 10:24:32.450061+02	3360763	Laura	Hernández Bayón	2000-02-04	lhernandezb05	alumnos/3360763.jpg		 	06260	C/ Hernán Cortes, 1	20537891H	Monesterio	Badajoz	2630
245	2016-10-20 08:46:50.817092+02	2016-10-24 10:24:32.477894+02	3360783	Sara	Hernández Bayón	2002-09-19	shernandezb06	alumnos/3360783.jpg		 	06260	C/ Hernán Cortes, 1	20537892L	Monesterio	Badajoz	2843
44	2016-10-20 08:46:41.234605+02	2016-10-24 10:24:32.505754+02	3360656	Gabriel	Hernández Cardoso	2003-11-03	ghernandezc04	alumnos/3360656.jpg		646152295 	06260	C/ Chorrito, 10	20969306E	Monesterio	Badajoz	2925
319	2016-10-20 08:46:54.374023+02	2016-10-24 10:24:32.533335+02	3360839	Carlos	Hernández Fernández	2001-11-01	chernandezf05	alumnos/3360839.jpg		 	06260	C/ Sevilla, 18 IZ	8370386L	Monesterio	Badajoz	2742
367	2016-10-20 08:46:56.678963+02	2016-10-24 10:24:32.561214+02	3360840	María	Hernández Fernández	2001-11-01	mhernandezf03	alumnos/3360840.jpg		 	06260	C/ Sevilla, 18 IZ	8370387C	Monesterio	Badajoz	2743
177	2016-10-20 08:46:47.591971+02	2016-10-24 10:24:32.586378+02	3360831	Adrián	Hernández Lucio	2001-11-22	ahernandezl09	alumnos/3360831.jpg		600310515 924516355	06260	C/ Los Almendros, 7	80108385Y	Monesterio	Badajoz	2773
173	2016-10-20 08:46:47.396065+02	2016-10-24 10:24:32.614246+02	3361001	Carlos Andrés	Hernández Lucio	1998-07-08	cahernandezl01	alumnos/3361001.jpg		696696169 608924548	06260	C/ Almendros, 7	80108384M	Monesterio	Badajoz	3061
78	2016-10-20 08:46:42.823472+02	2016-10-24 10:24:32.641882+02	3384754	Celia	Herrera Garrón	2004-10-27	cherrerag04	alumnos/3384754.jpg		626395229 	06260	C/ Endrinales, 9	20537897R	Monesterio	Badajoz	3012
321	2016-10-20 08:46:54.466149+02	2016-10-24 10:24:32.667949+02	3359683	Luis	Hidalgo Artero	2000-07-06	lhidalgoa02	alumnos/3359683.jpg		 	06292	C/ Reyes Católicos, 12	20538122L	Calera de León	Badajoz	2631
95	2016-10-20 08:46:43.622023+02	2016-10-24 10:24:32.695598+02	3414356	Ángel	Iglesias Fuentes	1999-05-24	aiglesiasf02	alumnos/3414356.png		 	06260	C/ Sevilla,14,	8898355T	Monesterio	Badajoz	2632
291	2016-10-20 08:46:52.994107+02	2016-10-24 10:24:32.723306+02	3360644	Jesús	Iglesias Muñoz	2003-03-02	jiglesiasm01	alumnos/3360644.jpg		625689943 	06260	C/ Pozos, 62	20537894K	Monesterio	Badajoz	2926
54	2016-10-20 08:46:41.695084+02	2016-10-24 10:24:32.750955+02	3359710	Jaime	Jiménez Garrón	2002-12-11	jjimenezg36	alumnos/3359710.jpg		924584018 670530827	06292	C/ Callejón del Agua, 10	45973463M	Calera de León	Badajoz	2844
178	2016-10-20 08:46:47.638862+02	2016-10-24 10:24:32.778835+02	3448589	Esperanza	Jiménez Rodríguez	2000-05-12	ejimenezr12	alumnos/3448589.jpg		618701656 	06291	C/ San Blas,	7268140W	Montemolín	Badajoz	2633
276	2016-10-20 08:46:52.270694+02	2016-10-24 10:24:32.806749+02	3386128	Jesús	Lancharro Bayón	2004-08-11	jlancharrob01	alumnos/3386128.jpg		670556244 627790086	06260	C/ Noria, 6	8368099D	Monesterio	Badajoz	3013
79	2016-10-20 08:46:42.868992+02	2016-10-24 10:24:32.834756+02	3384756	Manuel	Lancharro Bayón	2004-10-06	mlancharrob01	alumnos/3384756.jpg		665843174 	06260	Pso/ Paseo de Extremadura, 303	8370372M	Monesterio	Badajoz	3014
91	2016-10-20 08:46:43.44306+02	2016-10-24 10:24:32.862988+02	3449794	Gabriel	Lancharro Girol	2002-02-18	glancharrog01	alumnos/3449794.jpg		648219813 676636822	06291	C/ Rafael Pulido, 54	7268146P	Montemolín	Badajoz	2845
123	2016-10-20 08:46:44.968293+02	2016-10-24 10:24:32.890512+02	3745801	María José	Lancharro Hernández	1973-06-14	mjlancharroh01	alumnos/3745801.jpg		690252346 	41250	C/ José María Pedrero, 2	52269743N	El Real de la Jara	Sevilla	2971
385	2016-10-20 08:46:57.598918+02	2016-10-24 10:24:32.898474+02	3448607	Verónica	Lancharro Kaddur	2000-08-07	vlancharrok01	alumnos/3448607.jpg		656552317 	06291	C/ San Blas, 3	8898484Z	Montemolín	Badajoz	2634
361	2016-10-20 08:46:56.393732+02	2016-10-24 10:24:32.926423+02	3360619	Marta	Lancharro Lora	2003-02-12	mlancharrol01	alumnos/3360619.jpg		647228092 924517179	06260	C/ Vista Hermosa, 8	20538012R	Monesterio	Badajoz	2927
312	2016-10-20 08:46:54.02064+02	2016-10-24 10:24:32.954225+02	3360637	Vicente	Lancharro Lora	2003-02-12	vlancharrol01	alumnos/3360637.jpg		647228092 924517179	06260	C/ Vista Hermosa, 8	20538013W	Monesterio	Badajoz	2928
268	2016-10-20 08:46:51.906924+02	2016-10-24 10:24:32.982082+02	3360841	Laura	Lancharro Sánchez	2001-07-14	llancharros01	alumnos/3360841.jpg		655346331 	06260	Avda/ Eduardo Naranjo, 13 A A	20537951D	Monesterio	Badajoz	2768
80	2016-10-20 08:46:42.91482+02	2016-10-24 10:24:33.009824+02	3386911	Gonzalo	Lara Bermúdez	2004-02-27	gonzalolara4	alumnos/3386911.jpg	bermudezvill2@hotmail.com	684244283 924512344	06906	C/ Espronceda, 8	8898768E	Puebla del Maestre	Badajoz	3015
204	2016-10-20 08:46:48.859096+02	2016-10-24 10:24:33.037317+02	3264445	Marina	Lara Garrote	2003-04-21	marina2003	alumnos/3264445.jpg	elogg@hotmail.es	606042033 924512003	06906	C/ Queipo de Llano, 117	8898770R	Puebla del Maestre	Badajoz	2929
211	2016-10-20 08:46:49.17761+02	2016-10-24 10:24:33.065548+02	3360819	Carolina	Lavado González	2001-01-05	clavadog02	alumnos/3360819.jpg		924517168 605014946	06260	C/ Gallego Paz, 14	8893897G	Monesterio	Badajoz	2744
261	2016-10-20 08:46:51.555921+02	2016-10-24 10:24:33.094386+02	3360649	Carlos	Ledesma Caro	2003-11-20	cledesmac01	alumnos/3360649.jpg		619276971 619276971	06260	C/ Manuel Pecellín Lancharro, 14	20965925E	Monesterio	Badajoz	2930
136	2016-10-20 08:46:45.616209+02	2016-10-24 10:24:33.122411+02	3360776	Luis	Ledesma Caro	2002-02-14	lledesmac01	alumnos/3360776.jpg		619276971 619276971	06260	C/ Manuel Pecellín Lancharro, 14	20965924K	Monesterio	Badajoz	2846
229	2016-10-20 08:46:50.043888+02	2016-10-24 10:24:33.150109+02	3611427	Ana	Linares Guerrero	1999-04-28	alinaresg01	alumnos/3611427.jpg		620028443 924511839	06908	C/ Travesía, 5	78764966V	Santa María de la Nava	Badajoz	2573
122	2016-10-20 08:46:44.92213+02	2016-10-24 10:24:33.177722+02	3384984	Mario	Llimona Cabeza	2004-04-22	mllimonac01	alumnos/3384984.jpg		924517312 628104897	06260	Pso/ Extremadura, 176	7269127T	Monesterio	Badajoz	3016
238	2016-10-20 08:46:50.45677+02	2016-10-24 10:24:33.205557+02	3359692	Diego	López Balsera	1999-08-01	drufoc01	alumnos/3359692.png		 	06292	C/ Avda. Del Parque, 46	20540644B	Calera de León	Badajoz	2635
24	2016-10-20 08:46:40.274549+02	2016-10-24 10:24:33.233546+02	3360609	Celia	López Cerón	2003-07-27	clopezc19	alumnos/3360609.jpg		 	06260	C/ Margarita Nielken, 9	7268096G	Monesterio	Badajoz	2931
67	2016-10-20 08:46:42.325293+02	2016-10-24 10:24:33.261617+02	3359720	Claudia	López Cordero	2003-06-17	clopezc34	alumnos/3359720.jpg		924584022 680424001	06292	C/ Río Ardila, 1	20538143V	Calera de León	Badajoz	2932
351	2016-10-20 08:46:55.891558+02	2016-10-24 10:24:33.289773+02	3772140	Estefanía	López Domínguez	1998-12-24	elopezd09	alumnos/3772140.jpg		647037857 	06906	C/ Barriada las Reliquias, 6	48123551F	Puebla del Maestre	Badajoz	3055
371	2016-10-20 08:46:56.879666+02	2016-10-24 10:24:33.320361+02	3384992	Marcos	López Pereira	2004-06-27	mlopezp15	alumnos/3384992.jpg	victorialopezpereira1@gmail.com	616740574 	06260	C/ Espronceda, 30	20537816N	Monesterio	Badajoz	3017
334	2016-10-20 08:46:55.064779+02	2016-10-24 10:24:33.354564+02	3360577	Victoria	López Pereira	2002-03-05	vlopezp06	alumnos/3360577.jpg	victorialopezpereira1@gmail.com	620642732 678098877	06260	C/ Espronceda, 30	7268205K	Monesterio	Badajoz	2849
205	2016-10-20 08:46:48.905286+02	2016-10-24 10:24:33.388652+02	3360642	Laura	López Sánchez	2003-07-01	llopezs07	alumnos/3360642.jpg		654506877 924516743	06260	C/ Romeral, 3	20538064F	Monesterio	Badajoz	2933
236	2016-10-20 08:46:50.364941+02	2016-10-24 10:24:33.418909+02	3360622	Manuel	López Villalba	2003-12-30	mlopezv04	alumnos/3360622.jpg		615420255 924516752	06260	C/ Concha Espina, 5 A	9209906Q	Monesterio	Badajoz	2934
340	2016-10-20 08:46:55.362586+02	2016-10-24 10:24:33.442971+02	3264433	Natalia	Lozano Vargas	2002-06-11	nlozanov03	alumnos/3264433.png		682544079 647850378	06907	C/ Puebla, 49	8898476Y	Pallarés	Badajoz	2877
98	2016-10-20 08:46:43.760706+02	2016-10-24 10:24:33.468873+02	3360781	Andrea	Luque Calderón	2002-05-10	aluquec01	alumnos/3360781.jpg		654809116 	06260	C/ Libertad, 54	20537907B	Monesterio	Badajoz	2847
197	2016-10-20 08:46:48.531553+02	2016-10-24 10:24:33.487921+02	3360999	Rubén	Luque Calderón	1998-05-22	rluquec01	alumnos/3360999.jpg		646803875 	06260	C/ Libertad, 54	45557649P	Monesterio	Badajoz	2426
186	2016-10-20 08:46:48.002312+02	2016-10-24 10:24:33.507725+02	3531353	Leire	Luque Pérez	2002-01-02	lluquep01	alumnos/3531353.jpg	monicayleire@hotmail.com	685988631 685988632	06260	C/ Dolores Ibarruri, 27	45971243Q	Monesterio	Badajoz	2848
174	2016-10-20 08:46:47.449617+02	2016-10-24 10:24:33.535362+02	3775025	Alicia	Luque Romero	1997-06-27	cahernandezl01	alumnos/3775025.jpg		682468560 	41250	C/ Párroco Antonio Rosendo, 31	47563193K	El Real de la Jara	Sevilla	3068
85	2016-10-20 08:46:43.178407+02	2016-10-24 10:24:33.563107+02	3452571	Adrián	Macedo Pereira	1999-11-28	amacedop02	alumnos/3452571.jpg		722383396 924510086	06291	C/ San Blas, 1	8370548C	Montemolín	Badajoz	2785
375	2016-10-20 08:46:57.076169+02	2016-10-24 10:24:33.59065+02	3264414	María Cristina	Machio Rodríguez	2000-05-08	cmachior01	alumnos/3264414.jpg		924512050 636218696	06906	Bda/ Las Reliquias, 16	80242946V	Puebla del Maestre	Badajoz	2764
362	2016-10-20 08:46:56.43737+02	2016-10-24 10:24:33.618652+02	3360646	Violeta	Macías Ledesma	2003-05-31	vmaciasl01	alumnos/3360646.jpg		652682818 	06260	C/ Rosa de Luxemburgo, 11	20538025Z	Monesterio	Badajoz	2935
248	2016-10-20 08:46:50.953667+02	2016-10-24 10:24:33.646297+02	3264415	Ainhoa	Marín Durán	2000-08-01	amarind03	alumnos/3264415.jpg	felisadurancaballero@gmail.com	620060111 637790507	06906	C/ Churruca, 5 a	8897559D	Puebla del Maestre	Badajoz	2669
324	2016-10-20 08:46:54.604358+02	2016-10-24 10:24:33.673785+02	3386908	Hugo	Marín Durán	2004-12-01	hugomarin4	alumnos/3386908.jpg	felisadurancaballero@gmail.com	620060111 637790507	06906	C/ Churruca, 5 a	8368693M	Puebla del Maestre	Badajoz	3019
327	2016-10-20 08:46:54.743571+02	2016-10-24 10:24:33.699618+02	3775027	Manuel	Márquez Domínguez	1976-07-02	inaranjom01	alumnos/3775027.jpg		954733208 	41250	C/ Jerónimo Albez, 15	77585766G	El Real de la Jara	Sevilla	3064
383	2016-10-20 08:46:57.498257+02	2016-10-24 10:24:33.70665+02	3359696	Irene	Martín Carrasco	2001-11-26	imartinc17	alumnos/3359696.jpg		924584119 660968225	06292	C/ Carolina Coronado, 28	45970259K	Calera de León	Badajoz	2850
277	2016-10-20 08:46:52.316447+02	2016-10-24 10:24:33.734003+02	3360633	Javier	Martínez Girol	2003-07-31	jmartinezg19	alumnos/3360633.jpg		656272072 616327372	06260	C/ Cerro de la Fuente, 5	20969302H	Monesterio	Badajoz	3018
356	2016-10-20 08:46:56.123919+02	2016-10-24 10:24:33.761413+02	3264403	María del Valle	Matamoros Vázquez	1999-01-30	mdvmatamorosv01	alumnos/3264403.jpg		924511126 659034046	06907	C/ Puebla, 52	8370556M	Pallarés	Badajoz	2977
47	2016-10-20 08:46:41.374388+02	2016-10-24 10:24:33.788764+02	3359680	Daniel	Mateos Díaz	2000-03-27	dmateosd04	alumnos/3359680.jpg		 	06292	C/ Espronceda, 12	7268155V	Calera de León	Badajoz	2636
121	2016-10-20 08:46:44.876937+02	2016-10-24 10:24:33.816168+02	3360799	Rocío	Mateos García	2000-12-08	rmateosg04	alumnos/3360799.jpg		635464216 924517205	06260	C/ Tentudia, 51	7268191F	Monesterio	Badajoz	2670
363	2016-10-20 08:46:56.487179+02	2016-10-24 10:24:33.843828+02	3360648	Álvaro	Matito Garrón	2003-07-30	amatitog01	alumnos/3360648.jpg		924517156 690328006	06260	C/ Cerro de la Fuente, 14	29545714Y	Monesterio	Badajoz	2937
246	2016-10-20 08:46:50.862151+02	2016-10-24 10:24:33.872684+02	3360710	Isabel	Matito Garrón	1999-06-27	imatitog01	alumnos/3360710.jpg		626056371 	06260	C/ Cerro de la Fuente, 14	29545711A	Monesterio	Badajoz	2546
40	2016-10-20 08:46:41.047398+02	2016-10-24 10:24:33.896563+02	3359690	Ángel Manuel	Megías Cubero	2000-10-30	ammegiasc01	alumnos/3359690.jpg		 	06292	C/ Avda del Parque, 42	20538119Q	Calera de León	Badajoz	2637
374	2016-10-20 08:46:57.025712+02	2016-10-24 10:24:33.914396+02	3359671	Andrés	Megías Fernández	1999-06-28	amegiasf01	alumnos/3359671.jpg		924584063 637283554	06290	C/ Núñez de Balboa, 4	8370445D	Calera de León	Badajoz	2547
103	2016-10-20 08:46:44.028635+02	2016-10-24 10:24:33.940415+02	3384996	Adrián	Megías Garrote	2004-12-06	amegiasg01	alumnos/3384996.jpg		658207894 	06260	C/ Barrio de la Cruz, 106	20537953B	Monesterio	Badajoz	3051
322	2016-10-20 08:46:54.511531+02	2016-10-24 10:24:33.965104+02	3360764	Alejandra	Megías Garrote	2000-12-31	amegiasg02	alumnos/3360764.jpg		 	06260	C/ Barrio de la Cruz, 106,	7268080B	Monesterio	Badajoz	2638
5	2016-10-20 08:46:39.355035+02	2016-10-24 10:24:33.988948+02	3360996	Mario	Megías Guerrero	1998-09-15	mmegiasg04	alumnos/3360996.jpg		685334862 	06260	C/ Endrinales, 7 1º A	7269119S	Monesterio	Badajoz	2433
36	2016-10-20 08:46:40.836166+02	2016-10-24 10:24:34.013496+02	3385001	Izan	Megías Neguillo	2004-01-02	imegiasn01	alumnos/3385001.jpg		 	06260	C/ Elías Torres, 4	8898370S	Monesterio	Badajoz	3020
81	2016-10-20 08:46:42.959693+02	2016-10-24 10:24:34.037757+02	3385008	Tania	Megías Pecellín	2004-12-17	tmegiasp01	alumnos/3385008.jpg		670283087 665911724	06260	C/ Dolores Ibarruri, 2	8370392W	Monesterio	Badajoz	3021
192	2016-10-20 08:46:48.272624+02	2016-10-24 10:24:34.062128+02	3360832	Gonzalo	Megías Sánchez	2001-04-21	gmegiass01	alumnos/3360832.jpg	juliasanlan14@gmail.com	652067968 652067968	06260	C/ Dolores Ibarruri, 12	45969062C	Monesterio	Badajoz	2745
368	2016-10-20 08:46:56.726283+02	2016-10-24 10:24:34.088635+02	3748297	Rosa María	Méndez Rodríguez	1974-12-14	mhernandezf03	alumnos/3748297.jpg	rurobensa@hotmail.com	649892883 924516675	06260	C/ Las Espeñas, 12 13	44429613F	Monesterio	Badajoz	2984
104	2016-10-20 08:46:44.073807+02	2016-10-24 10:24:34.096421+02	3386629	Alejandra	Méndez Valverde	2004-11-16	amendezv04	alumnos/3386629.jpg		924584011 616328977	06292	C/ Eduardo Acosta, 11	20538128W	Calera de León	Badajoz	3047
39	2016-10-20 08:46:41.001798+02	2016-10-24 10:24:34.121544+02	3359681	María	Méndez Valverde	2000-12-16	mmendezv06	alumnos/3359681.jpg		924584011 616328977	06292	C/ Eduardo Acosta, 11	7268122F	Calera de León	Badajoz	2672
94	2016-10-20 08:46:43.577686+02	2016-10-24 10:24:34.146478+02	3199231	Laura	Mendo Lancharro	1989-03-16	jfvargass01	alumnos/3199231.bmp		690831482 667610050	06291	C/ San Blas, 11	8893903X	Montemolín	Badajoz	1627
307	2016-10-20 08:46:53.767781+02	2016-10-24 10:24:34.174149+02	3360770	Julio	Mestre Nogués	2002-11-25	jmestren01	alumnos/3360770.jpg		924517244 607298892	06260	C/ Zurbarán, 23	20540678E	Monesterio	Badajoz	2851
332	2016-10-20 08:46:54.971984+02	2016-10-24 10:24:34.200803+02	3360795	Manuel	Mestre Nogués	2000-03-18	mmestren01	alumnos/3360795.jpg		 	06260	C/ Zurbarán, 23 IZ	8893884Z	Monesterio	Badajoz	2639
41	2016-10-20 08:46:41.094597+02	2016-10-24 10:24:34.227315+02	3720880	María	Molano Romero	1981-01-26	mmolanor04	alumnos/3720880.jpg	sisuka689@gmail.com	620553369 	06907	C/ Cervantes, 15	76251884F	Pallarés	Badajoz	2883
221	2016-10-20 08:46:49.678713+02	2016-10-24 10:24:34.235238+02	3386915	Nuria	Molero Galván	2004-07-01	nuriamolero4	alumnos/3386915.jpg	aragalvanrubio@gmail.com	686027310 924512152	06906	C/ Hernán Cortés, 17	8368692G	Puebla del Maestre	Badajoz	3022
298	2016-10-20 08:46:53.332771+02	2016-10-24 10:24:34.263034+02	3360736	Cristina	Molina Jiménez	1999-02-24	cmolinaj01	alumnos/3360736.jpg		687014335 	06260	C/ Las Espeñas, 4	80239677Z	Monesterio	Badajoz	2548
106	2016-10-20 08:46:44.179523+02	2016-10-24 10:24:34.290581+02	3264434	Paula	Monjo Granadero	2002-01-15	pmonjog01	alumnos/3264434.jpg		682828903 	06907	C/ Puebla, 32	8370555G	Pallarés	Badajoz	2852
82	2016-10-20 08:46:43.004824+02	2016-10-24 10:24:34.318026+02	3385013	Julián	Monjo Murillo	2004-06-25	jmonjom01	alumnos/3385013.jpg		600433056 678099877	06260	C/ Cerro de la Fuente, 2	45158553P	Monesterio	Badajoz	3023
167	2016-10-20 08:46:47.091289+02	2016-10-24 10:24:34.345522+02	3414242	María José	Monjo Murillo	2002-09-01	mjmonjom01	alumnos/3414242.jpg		600433056 	06260	C/ Cerro de la Fuente, 2	7269224M	Monesterio	Badajoz	2853
364	2016-10-20 08:46:56.535427+02	2016-10-24 10:24:34.373968+02	3360677	Andrea	Mora López	2003-01-20	amoral01	alumnos/3360677.jpg	francisco.mora.sanchez@gmail.com	924516464 679345239	06260	C/ Juan Pablo II, 30	7269207B	Monesterio	Badajoz	2938
138	2016-10-20 08:46:45.709684+02	2016-10-24 10:24:34.402577+02	3385021	Alejandro	Morillo Pavón	2004-01-15	amorillop01	alumnos/3385021.jpg		697409727 	06260	C/ Río Culebrín, 26	20537794J	Monesterio	Badajoz	3052
156	2016-10-20 08:46:46.590363+02	2016-10-24 10:24:34.435358+02	3360645	Andrea	Morón Iglesias	2003-06-23	amoroni01	alumnos/3360645.jpg	petermoron71@gmail.com	619657789 629477285	06260	C/ Los Cotos, 13	20538031C	Monesterio	Badajoz	2939
43	2016-10-20 08:46:41.18683+02	2016-10-24 10:24:34.469312+02	3775018	María	Muñoz Romero	1997-11-08	ajcarrascol01	alumnos/3775018.jpg		689065031 	06260	C/ Doctor Fleming, 43	21154269L	El Real de la Jara	Sevilla	3067
86	2016-10-20 08:46:43.223324+02	2016-10-24 10:24:34.492701+02	3264416	David	Murillo Delgado	2000-06-13	dmurillod01	alumnos/3264416.jpg		 	06908	C/ Fuentes, 13	20540619D	Santa María de la Nava	Badajoz	2747
392	2016-10-20 08:46:57.94177+02	2016-10-24 10:24:34.525367+02	3264417	Marta	Murillo Delgado	2000-06-13	mmurillod02	alumnos/3264417.jpg		 	06908	C/ Fuentes, 13	20540618P	Santa María de la Nava	Badajoz	2671
37	2016-10-20 08:46:40.902524+02	2016-10-24 10:24:34.553574+02	3385025	Carlos	Naranjo Calderón	2004-05-30	cnaranjoc01	alumnos/3385025.jpg		625351017 	06260	Pso/ Extremadura, 258	20537770N	Monesterio	Badajoz	3024
9	2016-10-20 08:46:39.530678+02	2016-10-24 10:24:34.581711+02	3360757	Sergio	Naranjo Calderón	2000-03-25	snaranjoc04	alumnos/3360757.jpg		 	06260	C/ Paseo de Extremadura, 258,	7268108Q	Monesterio	Badajoz	2640
83	2016-10-20 08:46:43.067938+02	2016-10-24 10:24:34.609435+02	3385033	Juan Carlos	Naranjo Delagado	2004-03-07	jcnaranjod01	alumnos/3385033.jpg		676766715 	06260	C/ Barrio de la Cruz, 66 A	20537827T	Monesterio	Badajoz	3025
325	2016-10-20 08:46:54.650762+02	2016-10-24 10:24:34.637354+02	3385037	Ismael	Naranjo Mejías	2004-12-06	inaranjom01	alumnos/3385037.jpg		657520363 	06260	C/ Concha Espina, 7	20537904P	Monesterio	Badajoz	3026
182	2016-10-20 08:46:47.823024+02	2016-10-24 10:24:34.665453+02	3360582	Juan Antonio	Navarro Rodríguez	2002-06-05	janavarror01	alumnos/3360582.jpg		642128868 	06260	C/ Tierno Galván, 21	7268086V	Monesterio	Badajoz	2940
253	2016-10-20 08:46:51.18502+02	2016-10-24 10:24:34.693721+02	3360605	Míriam	Nogués Domínguez	2001-12-22	mnoguesd01	alumnos/3360605.jpg		670473376 	06260	C/ Doctor Alarcón, 11	20537888S	Monesterio	Badajoz	2748
394	2016-10-20 08:46:58.045631+02	2016-10-24 10:24:34.722025+02	3427735	Erika	Núñez Ramos	2000-02-16	enuñezr07	alumnos/3427735.jpg		678084445 674334070	06260	C/ Libertad, 75	28985608L	Monesterio	Badajoz	2891
89	2016-10-20 08:46:43.354654+02	2016-10-24 10:24:34.750385+02	3427733	José	Núñez Ramos	2002-09-24	jnuñezr14	alumnos/3360768_412YSZl.jpg		674334070 674334070	06260	C/ Libertad, 75		Monesterio	Badajoz	2941
271	2016-10-20 08:46:52.043581+02	2016-10-24 10:24:34.778863+02	3359686	Raquel	Oliva González	2000-02-10	rolivag03	alumnos/3359686.jpg		 	06292	C/ Pedro de Valdivia, 10 A	7268120M	Calera de León	Badajoz	2641
239	2016-10-20 08:46:50.505129+02	2016-10-24 10:24:34.807116+02	3360843	José Carlos	Oliva Mayoral	2001-09-26	jcolivam01	alumnos/3360843.jpg	m.oliva.mayoral@hotmail.com	66688486 924516036	06260	C/ 1º Mayo, 12 1º D	20537778C	Monesterio	Badajoz	2749
157	2016-10-20 08:46:46.635225+02	2016-10-24 10:24:34.835202+02	3359719	Agustín	Oliva Trenado	2003-04-16	aolivat01	alumnos/3359719.jpg		924584001 679937836	06292	C/ Bravo Murillo, 13	20538108M	Calera de León	Badajoz	2942
101	2016-10-20 08:46:43.935981+02	2016-10-24 10:24:34.862967+02	3436138	Andrei-Vasile	Onel 	1999-06-20	aonel03	alumnos/3436138.jpg		634929944 	06260	C/ Paseo de Extremadura-305. Portal-2, 303 3 1 B	Y2081223J	Monesterio	Badajoz	2673
181	2016-10-20 08:46:47.777718+02	2016-10-24 10:24:34.889007+02	3410723	Robinson	Orejuela Solórzano	1999-11-12	rorejuelas01	alumnos/3410723.png		626623209 693584254	06260	C/ Era de Don Pedro, 3	X7818251E	Monesterio	Badajoz	2674
102	2016-10-20 08:46:43.982614+02	2016-10-24 10:24:34.91644+02	3360753	Lucía	Pacheco Calderón	2000-10-17	lpachecoc01	alumnos/3360753.jpg	diepachecocardoso@hotmail.com	627431718 924517093	06260	C/ 1º de Mayo, 31	7268178V	Monesterio	Badajoz	2642
59	2016-10-20 08:46:41.926528+02	2016-10-24 10:24:34.944117+02	3360568	Joaquín	Pagador Areses	2002-02-19	jpagadora01	alumnos/3360568.jpg		656234544 	06260	C/ Vicente Alexandre, 4	7268195B	Monesterio	Badajoz	2854
135	2016-10-20 08:46:45.567495+02	2016-10-24 10:24:34.972096+02	3360804	María José	Pallero Carrasco	2000-07-17	mjpalleroc01	alumnos/3360804.jpg		 	06260	C/ Pozos, 42	7268185R	Monesterio	Badajoz	2643
341	2016-10-20 08:46:55.411154+02	2016-10-24 10:24:34.999757+02	3360625	Rubén	Palomo Pelayo	2003-04-18	rpalomop01	alumnos/3360625.jpg		924113126 627730682	06260	C/ Tierno Galván, 33	20538037A	Monesterio	Badajoz	2943
206	2016-10-20 08:46:48.951185+02	2016-10-24 10:24:35.028047+02	3359716	Sonia	Paniagua Blanco	2003-09-12	spaniaguab07	alumnos/3359716.jpg		924584004 616338078	06292	C/ Eugenio Hermoso, 4	20538115N	Calera de León	Badajoz	2944
187	2016-10-20 08:46:48.047247+02	2016-10-24 10:24:35.057201+02	3359687	Dalía	Paniagua González	2000-02-13	dpaniaguag04	alumnos/3359687.jpg		683150662 	06292	C/  Pedro de Valdivía, 10	7268121Y	Calera de León	Badajoz	2644
38	2016-10-20 08:46:40.955806+02	2016-10-24 10:24:35.085068+02	3359724	José	Paniagua González	2003-09-28	jpaniaguag05	alumnos/3359724.jpg		683150662 	06292	C/  Pedro de Valdivía, 10	20538140Z	Calera de León	Badajoz	3027
107	2016-10-20 08:46:44.236622+02	2016-10-24 10:24:35.112681+02	3360777	David	Parra Cubero	2002-09-02	dparrac01	alumnos/3360777.jpg	aliciamonesterio@hotmail.com	628292138 	06260	C/ Endrinales, 1 1º B	7269193C	Monesterio	Badajoz	2855
179	2016-10-20 08:46:47.68664+02	2016-10-24 10:24:35.140104+02	3360803	Carmen	Parra Sánchez	2000-08-25	cparras01	alumnos/3360803.jpg	cortijocotos@telefonica.net	924517167 685819962	06260	C/ Bovedo, 10 1º B,	7268100P	Monesterio	Badajoz	2645
145	2016-10-20 08:46:46.041978+02	2016-10-24 10:24:35.167915+02	3360820	Antonio	Pavón Nogués	2001-11-04	apavonn01	alumnos/3360820.jpg		639647438 639647438	06260	C/ Endrinales, 1 2º B	20537876A	Monesterio	Badajoz	2751
355	2016-10-20 08:46:56.077101+02	2016-10-24 10:24:35.19584+02	3360821	Rocío	Pavón Nogués	2001-11-04	rpavonn01	alumnos/3360821.jpg		639647438 	06260	C/ Endrinales, 1 2º B	20537877G	Monesterio	Badajoz	2752
328	2016-10-20 08:46:54.789847+02	2016-10-24 10:24:35.215701+02	3360722	Francisco Javier	Paz Pecellín	1999-05-25	fjpazp01	alumnos/3360722.jpg		638497840 	06260	C/ Tentudía, 47,	8893887V	Monesterio	Badajoz	2549
242	2016-10-20 08:46:50.646243+02	2016-10-24 10:24:35.24402+02	3452554	Zaida	Pecellín Jaro	2001-08-27	zpecellinj01	alumnos/3452554.jpg		627654598 678204319	06291	C/ Pizarra, 46	45968609G	Montemolín	Badajoz	2774
96	2016-10-20 08:46:43.666405+02	2016-10-24 10:24:35.272286+02	3360792	Javier	Pecellín Martínez	2000-09-12	jpecellinm01	alumnos/3360792.png		 	06260	C/ Santa Ana, 22	8370375P	Monesterio	Badajoz	2646
68	2016-10-20 08:46:42.371587+02	2016-10-24 10:24:35.30019+02	3360620	María	Pecellín Nogués	2003-02-25	mpecellinn01	alumnos/3360620.jpg	joseanpecellin@hotmail.com	636547092 	06260	C/ Avda. Portugal, 18	8368089E	Monesterio	Badajoz	3028
25	2016-10-20 08:46:40.318705+02	2016-10-24 10:24:35.328221+02	3360657	David	Pecellín Sánchez	2003-01-07	dpecellins01	alumnos/3360657.jpg	alba_pecesan@hotmail.com	664171702 	06260	C/ Margarita Nelken, 3	9220440Q	Monesterio	Badajoz	2945
314	2016-10-20 08:46:54.13986+02	2016-10-24 10:24:35.355961+02	3385524	Carlos Javier	Perera Sánchez	2004-06-03	cjpereras01	alumnos/3385524.jpg		654237553 	06260	Avda/ Portugal, 26	20538011T	Monesterio	Badajoz	3029
336	2016-10-20 08:46:55.181093+02	2016-10-24 10:24:35.383873+02	3360806	Miguel Ángel	Pérez Sánchez	2000-08-31	maperezs06	alumnos/3360806.png		 	06260	C/ Vasco Núñez, 3	7268075Y	Monesterio	Badajoz	2675
90	2016-10-20 08:46:43.398957+02	2016-10-24 10:24:35.411501+02	3525706	Adrián	Pérez Vargas	2003-07-30	aperezv26	alumnos/3525706.jpg		681283358 	06260	C/ Juan Pablo II, 3		Monesterio	Badajoz	2949
170	2016-10-20 08:46:47.233602+02	2016-10-24 10:24:35.439594+02	3360738	Concepción	Pérez-Carrasco Gómez	1999-12-03	cperez-carrascog01	alumnos/3360738.jpg	cgomal@gmail.com	924516171 658873377	06260	C/ Cerezo, 20	20538065P	Monesterio	Badajoz	2552
247	2016-10-20 08:46:50.907835+02	2016-10-24 10:24:35.467222+02	3360807	Andrés	Pizarro Delgado	2000-06-02	apizarrod04	alumnos/3360807.jpg		630860786 630860786	06260	C/ Río Culebrin, 6	20538017Y	Monesterio	Badajoz	2647
313	2016-10-20 08:46:54.092892+02	2016-10-24 10:24:35.492988+02	3360641	Daniel	Pizarro Delgado	2003-06-02	dpizarrod01	alumnos/3360641.jpg		646651513 924516865	06260	C/ Río Culebrin, 6	20538018F	Monesterio	Badajoz	2946
262	2016-10-20 08:46:51.600463+02	2016-10-24 10:24:35.520518+02	3264443	Lucía	Pizarro Girol	2003-09-07	luciapg1	alumnos/3264443.jpg		648218968 	06906	C/ Las Reliquias, 30	9218463V	Puebla del Maestre	Badajoz	2947
51	2016-10-20 08:46:41.556804+02	2016-10-24 10:24:35.553381+02	3264404	Javier	Pizarro Roldán	1999-08-17	jpizarror02	alumnos/3264404.jpg		 	06906	C/ Cervantes, 5	8368688T	Puebla del Maestre	Badajoz	2684
230	2016-10-20 08:46:50.089637+02	2016-10-24 10:24:35.587292+02	3775064	David	Pulgarín Caballero	1999-06-21	dpulgarinc01	alumnos/3611427_SOq90Oa.jpg		620177822 	06260	C/ Tierno Galván, 9	54186099P	Monesterio	Badajoz	3056
294	2016-10-20 08:46:53.144206+02	2016-10-24 10:24:35.620509+02	3360701	Alfonso	Pulice Barbecho	1998-04-24	apuliceb01	alumnos/3360701.jpg		605014963 	06260	C/ Pablo Iglesias, 30	8890776B	Monesterio	Badajoz	2441
113	2016-10-20 08:46:44.510787+02	2016-10-24 10:24:35.651894+02	3385582	Teresa	Pulice Barbecho	2004-05-18	tpuliceb01	alumnos/3385582.jpg		924517098 	06260	C/ Pablo Iglesias, 30	45968972E	Monesterio	Badajoz	3030
69	2016-10-20 08:46:42.418741+02	2016-10-24 10:24:35.677779+02	3385590	Antonio	Quintero Chávez	2004-01-06	aquinteroc01	alumnos/3385590.jpg	carmen.tauro96@hotmail.com	616909998 680644163	06260	Pso/ Extremadura, 171 1	8368097F	Monesterio	Badajoz	3031
235	2016-10-20 08:46:50.319136+02	2016-10-24 10:24:35.704176+02	3360744	Manuel	Quintero Chávez	1999-04-26	mquinteroc01	alumnos/3360744.jpg	antonioquintero171@gmail.com	924516645 680644163	06260	C/ Paseo de Extremadura, 171 1º	8893886Q	Monesterio	Badajoz	2553
265	2016-10-20 08:46:51.735309+02	2016-10-24 10:24:35.73164+02	3385598	Carlos	Ramayo Garrón	2004-07-06	cramayog01	alumnos/3385598.jpg		667361768 	06260	C/ Torrecilla, 28	20537869L	Monesterio	Badajoz	3032
14	2016-10-20 08:46:39.786698+02	2016-10-24 10:24:35.759078+02	3359707	Jesús	Rebollo Cubero	2002-08-14	jrebolloc04	alumnos/3359707.jpg	transportesrebollo@gmail.com	924113138 722651046	06290	C/ Nuestra Señora de los Dolores, 30 A	80237269K	Calera de León	Badajoz	2856
146	2016-10-20 08:46:46.092725+02	2016-10-24 10:24:35.788448+02	3360788	Lucía	Reyes Calcatierra	2002-05-20	lreyesc03	alumnos/3360788.jpg		675957882 924516762	06260	C/ Cerro de la Fuente, 12	8898347S	Monesterio	Badajoz	2857
26	2016-10-20 08:46:40.362643+02	2016-10-24 10:24:35.817289+02	3360643	Carlos	Reyes Chaves	2003-08-23	creyesc04	alumnos/3360643.jpg	amachalan@hotmail.com	675255799 645822413	06260	C/ Barrio de la Cruz, 128	20537815B	Monesterio	Badajoz	2950
315	2016-10-20 08:46:54.18734+02	2016-10-24 10:24:35.844955+02	3386918	María	Reyes Domínguez	2004-02-09	mariareyes4	alumnos/3386918.jpg	carmen.dominguez@eltinahon.com	607749350 924511858	06908	C/ Zurbarán, 30	54438779X	Santa María de la Nava	Badajoz	3033
210	2016-10-20 08:46:49.131945+02	2016-10-24 10:24:35.873374+02	3386062	Erika	Robledo Carballar	2004-03-17	erobledoc01	alumnos/3386062.jpg		605213843 655266285	06260	C/ Tentudía, 43 1	20537785G	Monesterio	Badajoz	3034
344	2016-10-20 08:46:55.560224+02	2016-10-24 10:24:35.901262+02	3360855	Daniel	Robles Bautista	2001-10-20	droblesb01	alumnos/3360855.jpg		606828204 	06260	C/ Puerto Encinillas, 4	47545899T	Monesterio	Badajoz	2753
158	2016-10-20 08:46:46.68127+02	2016-10-24 10:24:35.929143+02	3360655	Ignacio	Rodríguez De la Vega	2003-08-29	irodriguezd11	alumnos/3360655.jpg		615517134 65996560	06260	C/ Bº de la Cruz, 24	77639118L	Monesterio	Badajoz	2951
254	2016-10-20 08:46:51.231343+02	2016-10-24 10:24:35.956754+02	3452557	Francisco Jesús	Rodríguez López	2001-11-27	fjrodriguezl11	alumnos/3452557.jpg		639127152 686249052	06291	C/ Llerena, 42	80242018D	Montemolín	Badajoz	2775
282	2016-10-20 08:46:52.533511+02	2016-10-24 10:24:35.9847+02	3360845	Miguel	Rodríguez Martínez	2001-01-05	mrodriguezm62	alumnos/3360845.jpg		924516043 615180287	06260	C/ Tentudia, 32,	7269179Y	Monesterio	Badajoz	2754
280	2016-10-20 08:46:52.445699+02	2016-10-24 10:24:36.012304+02	3752676	Antonio Fernando	Rodríguez Nieto	2001-10-13	cmfernandezr01	alumnos/3452574_19DCN4W.jpg		672090422 	06292	C/ Eduardo Acosta, 30	54182555Y	Calera de León	Badajoz	3063
376	2016-10-20 08:46:57.127467+02	2016-10-24 10:24:36.03988+02	3264430	Cristian	Rodríguez Quinta	2001-03-26	crodriguezq01	alumnos/3264430.jpg		924511869 638751064	06908	C/ Zurbarán, 17	20538231J	Santa María de la Nava	Badajoz	2755
70	2016-10-20 08:46:42.465165+02	2016-10-24 10:24:36.067536+02	3386073	Alejandro	Romero Chávez	2004-09-12	aromeroc10	alumnos/3386073.jpg		649317671 	06260	C/ Ronda Bodonal de la Sierra, 48	20537817J	Monesterio	Badajoz	3035
27	2016-10-20 08:46:40.409249+02	2016-10-24 10:24:36.095071+02	3386945	Alejandro	Rubio Navarro	2004-05-20	alejandrorubio4	alumnos/3386945.jpg	jamcopito@gmail.com	619589423 616781182	06906	Bda/ Las Reliquias, 22	45969761Y	Puebla del Maestre	Badajoz	3036
53	2016-10-20 08:46:41.648753+02	2016-10-24 10:24:36.122928+02	3264420	Sheila	Rubio Navarro	2000-12-28	srubion01	alumnos/3264420.jpg	jamcopito@gmail.com	619589423 616781182	06906	Bda/ Las Reliquias, 22	8897555M	Puebla del Maestre	Badajoz	2651
237	2016-10-20 08:46:50.41064+02	2016-10-24 10:24:36.14889+02	3360822	David	Rufo Calderón	2001-03-09	drufoc01	alumnos/3360822.jpg		62778762 	06260	C/ De la Radio, 7	7268105J	Monesterio	Badajoz	2756
283	2016-10-20 08:46:52.579803+02	2016-10-24 10:24:36.176084+02	3689002	Tania de Fátima	Ruivo Rita	1999-10-05	tdfruivor01	alumnos/3689002.jpg		 	06260	C/ Finca el Romeral,	Y3047963V	Monesterio	Badajoz	2788
342	2016-10-20 08:46:55.46066+02	2016-10-24 10:24:36.204127+02	3756181	Rafael	Ruiz Puentenueva	2002-02-13	rruizp08	alumnos/3756181.jpg		633721773 	06260	C/ Barrio de la Cruz, 1	54603407G	Monesterio	Badajoz	2987
13	2016-10-20 08:46:39.723971+02	2016-10-24 10:24:36.231869+02	3264431	Elisabeth	Sabido Molero	2001-12-02	esabidom01	alumnos/3264431.jpg		639253022 	06908	C/ Zurbarán, 36	20538230N	Santa María de la Nava	Badajoz	2765
46	2016-10-20 08:46:41.327681+02	2016-10-24 10:24:36.259925+02	3360598	Carlos	Sánchez Arencón	2002-02-17	csancheza20	alumnos/3360598.jpg		924516674 675260769	06260	C/ San Idelfonso, 64	7269118Z	Monesterio	Badajoz	2859
99	2016-10-20 08:46:43.805494+02	2016-10-24 10:24:36.287787+02	3360751	Fernando	Sánchez Calderón	2000-08-27	fsanchezc12	alumnos/3360751.jpg		664512808 	06260	C/ Cañuelo, 43	7269205D	Monesterio	Badajoz	2652
207	2016-10-20 08:46:48.996574+02	2016-10-24 10:24:36.315564+02	3360654	María	Sánchez Calderón	2003-09-23	msanchezc56	alumnos/3360654.jpg		924517213 664512808	06260	C/ Cañuelo, 43	7269206X	Monesterio	Badajoz	2953
17	2016-10-20 08:46:39.929113+02	2016-10-24 10:24:36.340884+02	3360626	Fernando	Sánchez Carvajal	2003-06-26	fsanchezc17	alumnos/3360626.jpg		689184057 	06260	C/ Hornos, 20	7269219T	Monesterio	Badajoz	3038
309	2016-10-20 08:46:53.862413+02	2016-10-24 10:24:36.368543+02	3386099	Julia	Sánchez Chávez	2004-04-10	jsanchezc23	alumnos/3386099.jpg		689216333 	06260	C/ Sierra de Aguafría, 7	8368092W	Monesterio	Badajoz	3039
124	2016-10-20 08:46:45.01601+02	2016-10-24 10:24:36.396062+02	3360726	Lourdes	Sánchez Chávez	1999-09-11	lsanchezc15	alumnos/3360726.jpg		689216333 	06260	C/ Sierra de Aguafría, 7	8893893T	Monesterio	Badajoz	2556
130	2016-10-20 08:46:45.330455+02	2016-10-24 10:24:36.423693+02	3407156	Andrea	Sánchez De la Torre	2001-07-28	asanchezd07	alumnos/3407156.jpg		924516316 	06260	C/ Tierno Galván, 11		Monesterio	Badajoz	2776
308	2016-10-20 08:46:53.815319+02	2016-10-24 10:24:36.451931+02	3360784	Irene	Sánchez Duqueso	2002-04-22	isanchezd08	alumnos/3360784.jpg		924516184 	06260	C/ Libertad, 14	7268165G	Monesterio	Badajoz	2860
381	2016-10-20 08:46:57.396742+02	2016-10-24 10:24:36.480101+02	3360630	Álvaro	Sánchez Miranda	2003-10-28	asanchezm101	alumnos/3360630.jpg		617155549 	06260	C/ Cañuelo, 36	8898349V	Monesterio	Badajoz	2954
87	2016-10-20 08:46:43.267018+02	2016-10-24 10:24:36.508054+02	3360728	Lucía	Sánchez Moreno	1999-02-27	lsanchezm37	alumnos/3360728.jpg		656442539 	06260	C/ Robledillo, 12	7269201M	Monesterio	Badajoz	2557
84	2016-10-20 08:46:43.131499+02	2016-10-24 10:24:36.535929+02	3264394	Ana María	Sánchez Moya	1998-12-10	asanchezm184	alumnos/3264394.jpg		679205935 	06906	C/ Salvador Rueda, 8	8368686K	Puebla del Maestre	Badajoz	2447
18	2016-10-20 08:46:39.974454+02	2016-10-24 10:24:36.563659+02	3386937	Carlos	Sánchez Moya	2004-11-15	carlossanchez4	alumnos/3386937.jpg		638153975 	06906	C/ Salvador Rueda, 8	20538079E	Puebla del Maestre	Badajoz	3040
110	2016-10-20 08:46:44.37293+02	2016-10-24 10:24:36.591326+02	3386938	Alba	Sánchez Romero	2004-06-21	albasanchez4	alumnos/3386938.jpg	federemo@hotmail.es	628223449 924512260	06906	C/ Fuentes, 5	45877210F	Puebla del Maestre	Badajoz	3041
255	2016-10-20 08:46:51.277507+02	2016-10-24 10:24:36.618757+02	3360782	Noelia	Sánchez Serrano	2002-05-14	nsanchezs04	alumnos/3360782.jpg		 	06260	C/ La Noria, 32	7269220R	Monesterio	Badajoz	2861
195	2016-10-20 08:46:48.40927+02	2016-10-24 10:24:36.646309+02	3360585	Sara	Santillana Garrote	2002-11-05	ssantillanag01	alumnos/3360585.jpg		677771187 659294178	06260	C/ Ramón y Cajal, 47	45968781S	Monesterio	Badajoz	2858
193	2016-10-20 08:46:48.320903+02	2016-10-24 10:24:36.680951+02	3360833	Carmen	Sayago Macarro	2001-09-22	csayagom01	alumnos/3360833.jpg	csayagom01@gmail.com	618742022 628347446	06260	C/ Margarita Nelken, 4	7269208N	Monesterio	Badajoz	2757
263	2016-10-20 08:46:51.645428+02	2016-10-24 10:24:36.715663+02	3360636	Darío	Sevilla Fernández	2003-07-16	dsevillaf01	alumnos/3360636.jpg	aseviortiz@gmail.com	606382176 924516842	06260	C/ De la Radio, 22	7269212Q	Monesterio	Badajoz	2952
175	2016-10-20 08:46:47.497439+02	2016-10-24 10:24:36.748967+02	3264407	Jorge	Silva Caballero	1999-01-28	jsilvac04	alumnos/3264407.jpg		 	06906	Bda/ Las Reliquias, 29	8897548K	Puebla del Maestre	Badajoz	2697
150	2016-10-20 08:46:46.303259+02	2016-10-24 10:24:36.776087+02	3495687	Ana Rita	Soares Dos Santos	2004-06-15	arsoaresd01	alumnos/3495687.jpg		646158163 662278287	06260	C/ Finca el Romeral,	X0471288D	Monesterio	Badajoz	3037
159	2016-10-20 08:46:46.726321+02	2016-10-24 10:24:36.803587+02	3359723	María	Torrado Boton	2003-05-12	mtorradob05	alumnos/3359723.jpg		924584168 686218922	06292	C/ Espronceda, 25 A	20538113X	Calera de León	Badajoz	2955
4	2016-10-20 08:46:39.30751+02	2016-10-24 10:24:36.831072+02	3359679	Raquel	Torrado Botón	2000-10-18	rtorradob04	alumnos/3359679.jpg		620934532 	06292	C/ Espronceda, 25 A	20538114B	Calera de León	Badajoz	2676
100	2016-10-20 08:46:43.889948+02	2016-10-24 10:24:36.85665+02	3359672	Paula	Torrado Rodríguez	1999-03-20	ptorrador01	alumnos/3359672.jpg	torradogarron@hotmail.com	924584280 667091687	06292	C/ Río Ardila, 2	8370444P	Calera de León	Badajoz	2559
19	2016-10-20 08:46:40.024483+02	2016-10-24 10:24:36.885238+02	3360631	Víctor	Torres Granadero	2003-06-07	vtorresg05	alumnos/3360631.jpg		620841687 	06260	C/ Francisco Pizarro, 25	7269213V	Monesterio	Badajoz	3042
190	2016-10-20 08:46:48.183623+02	2016-10-24 10:24:36.913231+02	3360579	Enrique	Vadillo Calvo	2002-06-01	evadilloc03	alumnos/3360579.jpg		924516878 	06260	C/ El Cerezo, 16	7268088L	Monesterio	Badajoz	2862
6	2016-10-20 08:46:39.398942+02	2016-10-24 10:24:36.940807+02	3360730	Antonio	Valencia Isla	1999-08-07	avalenciai01	alumnos/3360730.jpg		 	06260	C/ Ramón y Cajal, 16	7268169P	Monesterio	Badajoz	2560
350	2016-10-20 08:46:55.845357+02	2016-10-24 10:24:36.968786+02	3359678	Manuel	Valencia Torrado	2000-05-05	mvalenciat01	alumnos/3359678.jpg		924584093 606770858	06292	C/ Virgen de Tentudia, 3	20540641P	Calera de León	Badajoz	2975
7	2016-10-20 08:46:39.442599+02	2016-10-24 10:24:36.996346+02	3264408	Cristina	Valiente Delgado	1999-07-08	cvaliented01	alumnos/3264408.jpg		646981884 	06908	C/ Fuente, 23	29546331W	Santa María de la Nava	Badajoz	2561
391	2016-10-20 08:46:57.890097+02	2016-10-24 10:24:37.02467+02	3264421	Mirella	Valiente Delgado	2000-09-05	mvaliented01	alumnos/3264421.png		 	06908	C/ Fuente, 23	29546333G	Santa María de la Nava	Badajoz	2677
301	2016-10-20 08:46:53.47482+02	2016-10-24 10:24:37.053062+02	3264423	Laura	Valverde Garrote	2000-09-21	lvalverdeg01	alumnos/3264423.jpg		 	06907	C/ Puebla, 7	8898479D	Pallarés	Badajoz	2654
168	2016-10-20 08:46:47.136795+02	2016-10-24 10:24:37.081442+02	3459690	Celia	Valverde Martínez	1993-12-11	mjmonjom01	alumnos/3459690.jpg		608352506 	06240	C/ Raso, 5 2º C	44789995W	Fuente de Cantos	Badajoz	3065
337	2016-10-20 08:46:55.227008+02	2016-10-24 10:24:37.089357+02	3448612	Antonio Luis	Valverde Tabales	2000-11-29	maperezs06	alumnos/3448612.jpg		628999026 676890957	06291	C/ Virgen de Gracia, 3	8368975B	Montemolín	Badajoz	2759
393	2016-10-20 08:46:57.99362+02	2016-10-24 10:24:37.109393+02	3360846	Laura	Vargas Adame	2001-12-19	lvargasa03	alumnos/3360846.jpg		677820935 625776572	06260	C/ Vasco Núñez, 38	7269203F	Monesterio	Badajoz	2760
306	2016-10-20 08:46:53.717703+02	2016-10-24 10:24:37.137581+02	3360823	Andrés	Vargas Bayón	2001-06-28	avargasb01	alumnos/3360823.jpg		656774747 924517214	06260	C/ Los Mesones, 12	7269180F	Monesterio	Badajoz	2761
386	2016-10-20 08:46:57.64763+02	2016-10-24 10:24:37.164432+02	3360651	Álvaro	Vargas Iglesias	2003-12-06	avargasi01	alumnos/3360651.jpg		624516859 615607747	06260	C/ Hornos, 3	20537786M	Monesterio	Badajoz	2956
92	2016-10-20 08:46:43.489088+02	2016-10-24 10:24:37.191068+02	3360581	María de los Ángeles	Vargas Pozuelo	2002-03-14	mdlavargasp01	alumnos/3360581.jpg		654727003 924516504	06260	C/ Cañuelo, 39	53933352P	Monesterio	Badajoz	2863
93	2016-10-20 08:46:43.534317+02	2016-10-24 10:24:37.21886+02	3360627	José Francisco	Vargas Sánchez	2003-04-12	jfvargass01	alumnos/3360627.jpg		665100607 	06260	C/ Tierno Galván, 3	8898369Z	Monesterio	Badajoz	2957
60	2016-10-20 08:46:41.994233+02	2016-10-24 10:24:37.246908+02	3360634	Adrián	Vargas Tomillo	2003-07-04	avargast01	alumnos/3360634.jpg	angelatomillo@gmail.com	633126891 615492187	06260	C/ Vasco Núñez, 55 I	45969442D	Monesterio	Badajoz	3043
343	2016-10-20 08:46:55.512154+02	2016-10-24 10:24:37.266905+02	3360739	Roberto	Vargas Tomillo	1999-09-03	rvargast03	alumnos/3360739.png	angelatomillo@gmail.com	635551297 615492187	06260	C/ Vasco Núñez, 55 I	45969440F	Monesterio	Badajoz	2678
48	2016-10-20 08:46:41.420831+02	2016-10-24 10:24:37.286608+02	3360638	Carlos	Vasco Martínez	2003-03-08	cvascom01	alumnos/3360638.jpg		652545064 	06260	C/ Dolores Ibarruri, 5	8898360M	Monesterio	Badajoz	2959
194	2016-10-20 08:46:48.365223+02	2016-10-24 10:24:37.314435+02	3360834	María	Vasco Sánchez	2001-08-25	mvascos01	alumnos/3360834.jpg		924516729 665815121	06260	C/ Calilla, 2 D	7268174J	Monesterio	Badajoz	2762
257	2016-10-20 08:46:51.368964+02	2016-10-24 10:24:37.341914+02	3360678	Cristina	Vasco Vicente	2003-09-16	cvascov01	alumnos/3360678.jpg		657471379 645790302	06260	C/ Pablo Iglesias, 20	80239251W	Monesterio	Badajoz	3044
284	2016-10-20 08:46:52.629393+02	2016-10-24 10:24:37.369636+02	3360659	Marina	Vasco Vicente	1999-09-04	mvascov01	alumnos/3360659.jpg		655421420 	06260	C/ Pablo Iglesias, 20	80239249T	Monesterio	Badajoz	2564
215	2016-10-20 08:46:49.361222+02	2016-10-24 10:24:37.397915+02	3360835	Pablo	Vázquez Delgado	2001-03-18	pvazquezd01	alumnos/3360835.jpg		924516740 635273663	06260	C/ Elías Torres, 9	8370394G	Monesterio	Badajoz	2763
112	2016-10-20 08:46:44.462666+02	2016-10-24 10:24:37.425919+02	3360624	Pablo	Vázquez Guerrero	2003-01-23	pvazquezg02	alumnos/3360624.jpg		605102401 924516114	06260	C/ Tentudía, 24	20537945A	Monesterio	Badajoz	2960
188	2016-10-20 08:46:48.093264+02	2016-10-24 10:24:37.454368+02	3360741	Carmen	Vázquez Pérez	1999-06-19	cvazquezp03	alumnos/3360741.jpg		618627847 629034915	06260	C/ Eduardo Acosta, 22	20537772Z	Monesterio	Badajoz	2567
365	2016-10-20 08:46:56.584832+02	2016-10-24 10:24:37.482746+02	3360614	Sandra	Vázquez Pérez	2003-01-08	svazquezp08	alumnos/3360614.jpg		924518154 618627847	06260	C/ Eduardo Acosta, 22	20537773S	Monesterio	Badajoz	2961
274	2016-10-20 08:46:52.177877+02	2016-10-24 10:24:37.511112+02	3360714	José Antonio	Vázquez Rodríguez	1999-08-09	javazquezr02	alumnos/3360714.jpg		 	06260	C/ Espronceda, 23	20537974D	Monesterio	Badajoz	2568
61	2016-10-20 08:46:42.046699+02	2016-10-24 10:24:37.538954+02	3413669	Miguel Ángel	Velasco Campano	2004-02-10	mavelascoc02	alumnos/3413669.jpg		603703320 	06260	Avda/ Ramón y Cajal, 36 B	20537957S	Monesterio	Badajoz	3045
115	2016-10-20 08:46:44.601522+02	2016-10-24 10:24:37.567156+02	3360847	José Manuel	Velázquez Vasco	2001-04-14	jmvelazquezv01	alumnos/3360847.jpg		626393164 924516202	06260	C/ Eduardo Acosta, 40	7268198Z	Monesterio	Badajoz	2766
62	2016-10-20 08:46:42.093353+02	2016-10-24 10:24:37.595204+02	3386105	Lucía	Villalba Andrés	2004-06-16	lvillalbaa01	alumnos/3386105.jpg		665728455 665918409	06260	C/ Cerro de la Fuente, 4	20537801C	Monesterio	Badajoz	3046
250	2016-10-20 08:46:51.047007+02	2016-10-24 10:24:37.623279+02	3386089	Lucía	Villalba Delgado	2004-03-10	lvillalbad01	alumnos/3386089.jpg		657401339 610230973	06260	C/ Costiución, 63	20537821V	Monesterio	Badajoz	3048
3	2016-10-20 08:46:39.260373+02	2016-10-24 10:24:37.651538+02	3386113	Manuel	Villalba García	2004-10-01	mvillalbag01	alumnos/3386113.jpg		636405106 	06260	C/ Cañuelo, 45	20537870C	Monesterio	Badajoz	3054
57	2016-10-20 08:46:41.834555+02	2016-10-24 10:24:37.680305+02	3264424	Javier	Villalba Moya	2000-07-24	jvillalbam04	alumnos/3264424.jpg		 	06906	C/ Hernán Cortés, 26	8368685C	Puebla del Maestre	Badajoz	2655
147	2016-10-20 08:46:46.144791+02	2016-10-24 10:24:37.7084+02	3360586	Daniel	Villalba Vasco	2002-09-25	dvillalbav01	alumnos/3360586.jpg		645911120 656973725	06260	C/ Pozos, 44 A	20537814X	Monesterio	Badajoz	2864
390	2016-10-20 08:46:57.839294+02	2016-10-24 10:24:37.735901+02	3528410	Fabián Tudor	Zamfir 	2001-03-22	fzamfir03	alumnos/3528410.jpg		697557011 674445952	06260	C/ Los Mesones, 19 2 C	12567633	Monesterio	Badajoz	2865
338	2016-10-20 08:46:55.272024+02	2016-10-24 10:24:37.764284+02	3686082	Florea	Zamfir 	2002-10-08	fzamfir04	alumnos/3686082.jpg		 642180020	06260	C/ Barrio de la Cruz, 87		Monesterio	Badajoz	2962
208	2016-10-20 08:46:49.041877+02	2016-10-24 10:24:37.798743+02	3359715	Cristina	Zapata Barbecho	2003-01-15	czapatab01	alumnos/3359715.jpg		924584182 924584182	06292	C/ Virgen de Tentudia, 22	9221177V	Calera de León	Badajoz	2963
339	2016-10-20 08:46:55.317345+02	2016-10-24 10:24:37.831805+02	3359673	Nuria	Zapata Barbecho	1999-10-13	nzapatab02	alumnos/3359673.jpg		608223910 924584182	06292	C/ Virgen de Tentudia, 22	9221176Q	Calera de León	Badajoz	2569
264	2016-10-20 08:46:51.69047+02	2016-10-24 10:24:37.864749+02	3359713	Laura	Zapata Botón	2003-03-24	lzapatab01	alumnos/3359713.jpg	destello71@hotmail.com	679516094 679516094	06292	C/ San Isidro, 1	20538141S	Calera de León	Badajoz	2964
302	2016-10-20 08:46:53.523286+02	2016-10-24 10:24:37.895659+02	3359682	Clara	Zapata Méndez	2000-02-28	czapatam08	alumnos/3359682.jpg		 	06260	C/ Espronceda, 3	7268157L	Calera de León	Badajoz	2680
345	2016-10-20 08:46:55.606507+02	2016-10-24 10:24:37.923623+02	3359717	Clara	Zapata Real	2003-06-21	czapatar02	alumnos/3359717.jpg		658524090 658524090	06290	C/ Eduardo Acosta, 25	26558393V	Calera de León	Badajoz	2965
251	2016-10-20 08:46:51.092865+02	2016-10-24 10:24:37.951142+02	3386554	Jesús	Zapata Real	2004-08-23	jzapatar01	alumnos/3386554.jpg		576126255 	06290	C/ Pedro de Valdivia, 8	20969087X	Calera de León	Badajoz	3049
132	2016-10-20 08:46:45.424725+02	2016-10-24 10:24:37.978727+02	3359708	Juan José	Zapata Real	2002-12-23	jjzapatar03	alumnos/3359708.jpg		676126255 	06292	C/ Pedro de Valdivia, 8 A	20969086D	Calera de León	Badajoz	2866
224	2016-10-20 08:46:49.815045+02	2016-10-24 10:24:38.006483+02	3360743	Laura	Zoilo Calderón	1999-03-15	lzoiloc01	alumnos/3360743.jpg		655266321 	06260	C/ Libertad, 96	7268207T	Monesterio	Badajoz	2570
209	2016-10-20 08:46:49.086868+02	2016-10-24 10:24:38.034121+02	3360617	Clara	Zoilo Villalba	2003-11-26	czoilov01	alumnos/3360617.jpg	jazoilo@hotmail.com	646579686 659847972	06260	C/ Calilla, 28	20965894Z	Monesterio	Badajoz	2966
\.


--
-- Name: alumnos_alumno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('alumnos_alumno_id_seq', 394, true);


--
-- Data for Name: alumnos_tutor; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY alumnos_tutor (id, created, modified, dni, nombre, apellidos, domicilio, codigo_postal, municipio, provincia, foto, telefono1, telefono2, email) FROM stdin;
16	2016-10-21 12:41:07.018698+02	2016-10-24 10:24:27.481929+02	33972298X	Julián	Ambrona Ledesma	C/ Espronceda Nº 8	06260	Monesterio	Badajoz		625354255	924516455	
18	2016-10-21 12:41:07.265003+02	2016-10-24 10:24:27.509839+02	8826045W	Daniel	Ambrona Garrote	C/ Las Espeñas Nº 12 P 7	06260	Monesterio	Badajoz		610256474	924516907	
21	2016-10-21 12:41:07.751066+02	2016-10-24 10:24:27.557936+02	76106764V	Julián	Arroyo Egido	C/ Cristóbal Colón Nº 8	06292	Calera de León	Badajoz		679340856	924584021	
22	2016-10-21 12:41:07.826846+02	2016-10-24 10:24:27.565905+02	8801591C	Elisa	Boton Gata	C/ Cristóbal Colón Nº 8	06292	Calera de León	Badajoz		650678147	924584101	
23	2016-10-21 12:41:08.002986+02	2016-10-24 10:24:27.586053+02	76251793P	Juan Carlos	Artero Gordito	Avda/ Del Parque Nº 12	06290	Calera de León	Badajoz		628332171	924584117	
28	2016-10-21 12:41:08.553565+02	2016-10-24 10:24:27.675314+02	76251781L	Luciano	Balsera Artero	C/ Río Ardila Nº 3	06292	Calera de León	Badajoz		678641882	924584245	
29	2016-10-21 12:41:08.811399+02	2016-10-24 10:24:27.725335+02	80076872A	David	Barragán Garrón	C/ Labrador Nº 44	06260	Monesterio	Badajoz		667435383		
32	2016-10-21 12:41:09.199227+02	2016-10-24 10:24:27.766841+02	80055568C	Feliciano	Barragán Bermúdez	C/ Francisco Pizarro Nº 6	06260	Monesterio	Badajoz		646574496		
34	2016-10-21 12:41:09.443013+02	2016-10-24 10:24:27.797436+02	28753016A	José Antonio	Barragán Perdigón	C/ Queipo de Llano Nº 100	06906	Puebla del Maestre	Badajoz		652346843	924113149	
36	2016-10-21 12:41:09.680691+02	2016-10-24 10:24:27.832122+02	8890961N	Domingo	Barragá González	C/ Rosa de Luxemburgo Nº 16	06260	Monesterio	Badajoz		661734715	924516901	
37	2016-10-21 12:41:09.848041+02	2016-10-24 10:24:27.85645+02	8795989F	Serapio	Barragán Bermúdez	C/ Pozos Nº 25	06260	Monesterio	Badajoz		679075287	924516425	
40	2016-10-21 12:41:10.158659+02	2016-10-24 10:24:27.897403+02	8820560Z	Salvador	Barroso Gato	C/ Ramón y Cajal Nº 37	06906	Puebla del Maestre	Badajoz		686612940	924512234	
42	2016-10-21 12:41:10.451831+02	2016-10-24 10:24:27.924758+02	76246719V	Salvador	Barroso Lara	C/ Calvo Sotelo Nº 50	06906	Puebla del Maestre	Badajoz		630821080	924512310	
43	2016-10-21 12:41:10.659898+02	2016-10-24 10:24:27.944246+02	76246306H	Ramón	Bautista Carballar	C/ De la Radio,36 Nº	06260	Monesterio	Badajoz		655871858		
30	2016-10-21 12:41:08.904658+02	2016-10-24 10:24:27.74115+02	8884787W	Rosa María	Delgado Contreras	C/ Labrador Nº 44	06260	Monesterio	Badajoz		667435375	924516578	
31	2016-10-21 12:41:09.111887+02	2016-10-24 10:24:27.759479+02	80055509F	María del Carmen	Delgado Cuello	C/ Francisco Pizarro Nº 6	06260	Monesterio	Badajoz		680562156		
44	2016-10-21 12:41:10.746322+02	2016-10-24 10:24:27.951967+02	76246516K	Maxima	Delgado Cantillo	C/ De la Radio,36 Nº	06260	Monesterio	Badajoz			924516836	
46	2016-10-21 12:41:11.07594+02	2016-10-24 10:24:28.015939+02	76246262C	José Antonio	Bautista Vasco	C/ C / Sierra del Castillo Nº 17	06260	Monesterio	Badajoz		667512595		
48	2016-10-21 12:41:11.38911+02	2016-10-24 10:24:28.043078+02	76246460B	Manuel	Bayón Granadero	C/ De la Radio Nº 28	06260	Monesterio	Badajoz		625594414		
49	2016-10-21 12:41:11.462301+02	2016-10-24 10:24:28.050904+02	80053104V	María Inmaculada	Caballero Zapata	C/ De la Radio Nº 28	06260	Monesterio	Badajoz		657368326		
24	2016-10-21 12:41:08.076517+02	2016-10-24 10:24:27.593926+02	44782266R	Purificación	Fernández Balsera	Avda/ Del Parque Nº 12	06290	Calera de León	Badajoz		646478646	924584117	
27	2016-10-21 12:41:08.48014+02	2016-10-24 10:24:27.667441+02	48812598C	Cándida	Durán Baños	C/ Río Ardila Nº 3	06292	Calera de León	Badajoz		678641883	924584245	
51	2016-10-21 12:41:11.701149+02	2016-10-24 10:24:28.091444+02	33974685M	Carmelo	Bayón Vargas	C/ Ramón y Cajal Nº 22	06260	Monesterio	Badajoz		686069278		
52	2016-10-21 12:41:11.90841+02	2016-10-24 10:24:28.112523+02	80036762M	Rufino	Bayón Vargas	C/ Robledillo Nº 2	06260	Monesterio	Badajoz		638967464	924516760	
54	2016-10-21 12:41:12.202869+02	2016-10-24 10:24:28.140355+02	8884580	Rufino	Bayón Vargas	C/ Robledillo Nº 2	06260	Monesterio	Badajoz		638967464	924516760	
57	2016-10-21 12:41:12.534731+02	2016-10-24 10:24:28.203591+02	11402297R	Javier	Benítez González	C/ Francisco Pizarro Nº 27 P 1A	06260	Monesterio	Badajoz		676467022		
59	2016-10-21 12:41:12.901561+02	2016-10-24 10:24:28.239361+02	76251817D	José Joaquín	Botón Díaz	C/ Espronceda Nº 17	06292	Calera de León	Badajoz		689945115	924584264	
61	2016-10-21 12:41:13.143008+02	2016-10-24 10:24:28.290323+02	8860079L	Francisco	Caballero Alvarado	Bda/ Las Reliquias Nº 19	06906	Puebla del Maestre	Badajoz				
63	2016-10-21 12:41:13.424104+02	2016-10-24 10:24:28.315645+02	8779909	Horacio	Calderón Oliva	C/ Plaza del Pueblo Nº 14	06260	Monesterio	Badajoz		620013695	924516800	
64	2016-10-21 12:41:13.630598+02	2016-10-24 10:24:28.333288+02	80055873A	Indalecio	Calderón Terrón	C/ Los Pozos Nº 34	06260	Monesterio	Badajoz		677478001		
65	2016-10-21 12:41:13.718441+02	2016-10-24 10:24:28.341024+02	8884669E	María Dolores	Barragán González	C/ Pozo Nº 34	06260	Monesterio	Badajoz		677806254		
66	2016-10-21 12:41:13.885106+02	2016-10-24 10:24:28.36076+02	76246416J	José	Calderón Igelsias	C/ Sierra del Castillo Nº 3	06260	Monesterio	Badajoz		606866053		
13	2016-10-21 12:41:06.698322+02	2016-10-24 10:24:27.44603+02	34782056F	María del Carmen	González Durán		06908	Montemolín	Badajoz		669054440	924511817	
33	2016-10-21 12:41:09.369698+02	2016-10-24 10:24:27.787883+02	44783669R	Rocío	Guillén García	C/ Queipo de Llano Nº 100	06906	Puebla del Maestre	Badajoz		652346844	924113149	
60	2016-10-21 12:41:13.068765+02	2016-10-24 10:24:28.259077+02	28914667X	Cándida	Gordito Romero	Bda/ Las Reliquias Nº 19	06906	Puebla del Maestre	Badajoz		660821287		
68	2016-10-21 12:41:14.124098+02	2016-10-24 10:24:28.415956+02	76246332K	José Antonio	Calderón Zapata	C/ Juan Pablo II Nº 28	06260	Monesterio	Badajoz		674910974		
7	2016-10-21 12:41:05.882227+02	2016-10-24 10:24:27.362373+02	76246718Q	Cecilia	Lara Danta	Bda/ Las Reliquias Nº 8	06906	Puebla del Maestre	Badajoz		620655030	924512324	
15	2016-10-21 12:41:06.943896+02	2016-10-24 10:24:27.473965+02	76246357T	Isabel María	López Calderón	C/ Espronceda Nº 8	06260	Monesterio	Badajoz		652771286	924516455	
69	2016-10-21 12:41:14.197464+02	2016-10-24 10:24:28.423767+02	80055689A	Isabel María	Carballar Galán	C/ Juan Pablo II Nº 28	06260	Monesterio	Badajoz		629144336		
70	2016-10-21 12:41:14.437584+02	2016-10-24 10:24:28.443674+02	80036789D	Esperanza	Delgado Ruiz	C/ Labrador Nº 10	06260	Monesterio	Badajoz		630509308	924516416	
71	2016-10-21 12:41:14.513172+02	2016-10-24 10:24:28.451668+02	8812958W	Valentín	Calderón Bautista	C/ C / Labrador Nº 10	06260	Monesterio	Badajoz		659417223	924516750	
35	2016-10-21 12:41:09.607205+02	2016-10-24 10:24:27.821847+02	50212009L	Sonia	Martínez Bautista	C/ Rosa de Luxemburgo Nº 16	06260	Monesterio	Badajoz		670310554	924516901	
39	2016-10-21 12:41:10.086336+02	2016-10-24 10:24:27.889631+02	76246752G	María Carmen	Maldonado Rodríguez	C/ Ramón y Cajal Nº 37	06906	Puebla del Maestre	Badajoz		699250219	924512234	
50	2016-10-21 12:41:11.627722+02	2016-10-24 10:24:28.083448+02	29802523C	María del Carmen	Macías Falcón	C/ Ramón y Cajal Nº 22	06260	Monesterio	Badajoz		696459342		
58	2016-10-21 12:41:12.82649+02	2016-10-24 10:24:28.231562+02	47017696S	Guadalupe	Maldonado Morales	C/ Espronceda Nº 17	06292	Calera de León	Badajoz		659695430	924584264	
4	2016-10-21 12:40:58.692123+02	2016-10-24 10:24:27.315027+02	76246760N	Manuel	Abril Caballero	C/ Barriada las Reliquias Nº 18	06906	Puebla del Maestre	Badajoz		690764414	924512330	
6	2016-10-21 12:41:05.714106+02	2016-10-24 10:24:27.342015+02	3072244L	Pablo	Alcantarilla Izquierdo	C/ Rafael Alberti Nº 15	06260	Monesterio	Badajoz		699525348	924516669	
8	2016-10-21 12:41:05.962903+02	2016-10-24 10:24:27.370358+02	80035707P	José Manuel	Almagro Muñoz	Bda/ Las Reliquias Nº 8	06906	Puebla del Maestre	Badajoz		620655030	924512324	
9	2016-10-21 12:41:06.170493+02	2016-10-24 10:24:27.390211+02	10089831F	Rubén Darío	Almeida Fernández	C/ Las Espeñas Nº 12 P 13	06260	Monesterio	Badajoz		691021023	633766388	
12	2016-10-21 12:41:06.532313+02	2016-10-24 10:24:27.42595+02	34778394W	Antonio	Alonso Vasco	C/ Libertad Nº 66	06260	Monesterio	Badajoz		651850047	924516095	
14	2016-10-21 12:41:06.772716+02	2016-10-24 10:24:27.454036+02	8820818L	José Luis	Álvarez Cano		06908	Montemolín	Badajoz		608201091	924511884	
20	2016-10-21 12:41:07.531489+02	2016-10-24 10:24:27.537925+02	76246458D	Ángel Manuel	Ambrona Garrote	Pso/ Extremadura Nº 255	06260	Monesterio	Badajoz		627956138	924518146	
26	2016-10-21 12:41:08.313927+02	2016-10-24 10:24:27.621368+02	44276328V	José Luis	Ávila Morales		06260	Monesterio	Badajoz				
62	2016-10-21 12:41:13.327587+02	2016-10-24 10:24:28.307953+02	80036831M	Josefa María	Aceitón Terrón	C/ Plaza del Pueblo Nº 14	06260	Monesterio	Badajoz		651937523	924516800	
73	2016-10-21 12:41:14.760658+02	2016-10-24 10:24:28.507545+02	80055723Z	Antonia Ana	Gallego Aradillo	C/ El Cerezo Nº 27	06260	Monesterio	Badajoz		625387027		
75	2016-10-21 12:41:15.15077+02	2016-10-24 10:24:28.535528+02	8841396N	Ana María	Garrote Donoso	C/ Cabarco Nº 7	06260	Monesterio	Badajoz		665278804	924516834	
76	2016-10-21 12:41:15.334791+02	2016-10-24 10:24:28.555674+02	80055459A	Alfonso	Calderón Dorado	C/ Zurbarán Nº 25	06260	Monesterio	Badajoz		653923712		
77	2016-10-21 12:41:15.408839+02	2016-10-24 10:24:28.563945+02	8884591J	Rosa María	Guareño Reyes	C/ Zurbarán Nº 25	06260	Monesterio	Badajoz		653923732		
79	2016-10-21 12:41:15.646755+02	2016-10-24 10:24:28.593279+02	76246381R	Ceferino	Calderón Chaves		06260	Monesterio	Badajoz		635403942		
81	2016-10-21 12:41:15.884052+02	2016-10-24 10:24:28.622731+02	80036950D	Francisco	Calderón Matitos	C/ Ramón y Cajal Nº 5	06260	Monesterio	Badajoz		666567947	924516872	
82	2016-10-21 12:41:16.056871+02	2016-10-24 10:24:28.642533+02	28717320A	José Manuel	Calderón Ledesma	C/ Cañuelo Nº 41	06260	Monesterio	Badajoz		626053923	619445526	
85	2016-10-21 12:41:16.405915+02	2016-10-24 10:24:28.678258+02	33976112Y	José Antonio	Calderón Bautista	C/ La Noria Nº 30	06260	Monesterio	Badajoz		620867569	924516750	
87	2016-10-21 12:41:16.702695+02	2016-10-24 10:24:28.72607+02	76246387F	Gabino	Calderón Terrón	C/ C / Sierra de la Cruz Nº 3	06260	Monesterio	Badajoz		678409303		
88	2016-10-21 12:41:16.952599+02	2016-10-24 10:24:28.754255+02	27286583G	Domingo	Calvo Fernández	C/ Ntra. Sra. De los Dolores Nº 35	06292	Calera de León	Badajoz		648261472	924584139	
90	2016-10-21 12:41:17.195933+02	2016-10-24 10:24:28.782133+02	34780158H	María del Carmen	Ferrero Gómez	C/ Puebla Nº 6	06907	Montemolín	Badajoz		681005404	924511157	
91	2016-10-21 12:41:17.268812+02	2016-10-24 10:24:28.790107+02	80037198G	Felipe	Campanario Rodríguez	C/ Puebla Nº 6	06907	Montemolín	Badajoz		636538880	924511157	
92	2016-10-21 12:41:17.432227+02	2016-10-24 10:24:28.837947+02	44775553G	Antonio	Campanario Pereira	C/ Calvario Nº 40	06291	Montemolín	Badajoz		622026440		
93	2016-10-21 12:41:17.5055+02	2016-10-24 10:24:28.845889+02	71763748E	Mari Luz	Rueda Campanario	C/ Calvario Nº 40	06291	Montemolín	Badajoz		603549461		
95	2016-10-21 12:41:17.8431+02	2016-10-24 10:24:28.874026+02	28742741D	Pedro Jesús	Campos Vera	C/ Pablo Iglesias Nº 21	06260	Monesterio	Badajoz		666014571	924517470	
96	2016-10-21 12:41:18.047517+02	2016-10-24 10:24:28.894994+02	34780348R	María Gemma	Sayago Gallego	C/ Huerta Murcia Nº 52	06260	Monesterio	Badajoz		675949265		
97	2016-10-21 12:41:18.13419+02	2016-10-24 10:24:28.904656+02	8855650Y	Antonio	Cardoso Garrón	C/ Huerta Murcia Nº 52	06260	Monesterio	Badajoz		657942989	924517225	
98	2016-10-21 12:41:18.318635+02	2016-10-24 10:24:28.928947+02	44775097P	Francisco José	Carrasco Ortega	C/ Cañuelo Nº 30	06260	Monesterio	Badajoz		635630486	924516098	
100	2016-10-21 12:41:18.558312+02	2016-10-24 10:24:28.961411+02	44780797G	Rafael	Carrasco Megías	C/ Bravo Murillo Nº 29	06292	Calera de León	Badajoz		622301243		
102	2016-10-21 12:41:18.80057+02	2016-10-24 10:24:28.994761+02	33977162	Antonio Francisco	Carrasco Becerra	C/ Sierra del Castillo Nº 11	06260	Monesterio	Badajoz		627745618		
103	2016-10-21 12:41:18.873586+02	2016-10-24 10:24:29.003726+02	76246435	María del Rosario	Granadero Garrote	C/ Sierra del Castillo Nº 11	06260	Monesterio	Badajoz		665423482		
104	2016-10-21 12:41:19.037715+02	2016-10-24 10:24:29.023683+02	44783864N	Antonio Jesús	Carrasco Acosta	C/ Elías Torres Nº 13	06260	Monesterio	Badajoz		687422904	924517054	
105	2016-10-21 12:41:19.113107+02	2016-10-24 10:24:29.03036+02	80067915Q	Luz María	Lancharro Parra	C/ Elías Torres Nº 13	06260	Monesterio	Badajoz		648078658		
106	2016-10-21 12:41:19.283591+02	2016-10-24 10:24:29.047908+02	76246681W	Santiago	Carrasco García	C/ La Puebla Nº 74	06907	Montemolín	Badajoz		630383196	924113326	
107	2016-10-21 12:41:19.374691+02	2016-10-24 10:24:29.054595+02	8854860K	Pilar	Márquez Romero	C/ La Puebla Nº 74	06907	Montemolín	Badajoz		924511051		
109	2016-10-21 12:41:19.6725+02	2016-10-24 10:24:29.08011+02	8828225C	Antonio Jesús	Carrasco Díaz	C/ Juan Carlos I Nº 2	06292	Calera de León	Badajoz		699886085	924584184	
110	2016-10-21 12:41:19.861875+02	2016-10-24 10:24:29.098978+02	76246540E	Manuel	Carrasco Barragán	C/ Rafael Alberti Nº 16	06260	Monesterio	Badajoz		635549990	924516920	
111	2016-10-21 12:41:19.933662+02	2016-10-24 10:24:29.106712+02	80055902D	Antonia	Sánchez Guareño	C/ Rafael Alberti Nº 16	06260	Monesterio	Badajoz		635549991	924516707	
67	2016-10-21 12:41:13.958659+02	2016-10-24 10:24:28.368577+02	76246353L	Sabina	Bayón Rodríguez	C/ Sierra del Castillo Nº 3	06260	Monesterio	Badajoz		610637827		
72	2016-10-21 12:41:14.679377+02	2016-10-24 10:24:28.499823+02	34773916D	Francisco Javier	Calderón Bautista	C/ El Cerezo Nº 27	06260	Monesterio	Badajoz		658850859		
74	2016-10-21 12:41:15.05897+02	2016-10-24 10:24:28.527564+02	76246248Y	José	Calderón Barragán	C/ Cabarco Nº 7	06260	Monesterio	Badajoz		600572779	924516834	
78	2016-10-21 12:41:15.574675+02	2016-10-24 10:24:28.584887+02	34780802H	Rosa	Márquez Matito		06260	Monesterio	Badajoz		679017898		
94	2016-10-21 12:41:17.753451+02	2016-10-24 10:24:28.866195+02	2849372D	María Ángeles	Barrero Montero	C/ Pablo Iglesias Nº 21	06260	Monesterio	Badajoz		662278442	924517470	
99	2016-10-21 12:41:18.392369+02	2016-10-24 10:24:28.938397+02	34777525F	Carmen	Álvarez Guareño	C/ Cañuelo Nº 30	06260	Monesterio	Badajoz		609714128	609714128	
101	2016-10-21 12:41:18.632479+02	2016-10-24 10:24:28.970975+02	76251269J	María de los Ángeles	Blanco Guerrero	C/ García de Paredes Nº 26	06240	Fuente de Cantos	Badajoz		618585432		
112	2016-10-21 12:41:20.135389+02	2016-10-24 10:24:29.134672+02	28904675T	Ovidio	Castro Silva	C/ Los Almendros Nº 8	06260	Monesterio	Badajoz		603434871		
113	2016-10-21 12:41:20.208079+02	2016-10-24 10:24:29.142479+02	44787695W	Ángela María	Jaramillo Vega	C/ Los Almendros Nº 8	06260	Monesterio	Badajoz		603434871	924517227	
114	2016-10-21 12:41:20.374499+02	2016-10-24 10:24:29.162167+02	33974063G	Antonio Bernardo	Chavero Villalba	C/ Sierra del Castillo Nº 13	06260	Monesterio	Badajoz		661958887		
115	2016-10-21 12:41:20.448772+02	2016-10-24 10:24:29.170457+02	76246269M	Manuela	López Lancharro	C/ Sierra del Castillo Nº 13	06260	Monesterio	Badajoz		661958877		
116	2016-10-21 12:41:20.615914+02	2016-10-24 10:24:29.191335+02	33978743S	Natividad	Sánchez López	C/ Paseo de Extremadura Nº 104	06260	Monesterio	Badajoz		616199535	924517330	
117	2016-10-21 12:41:20.688475+02	2016-10-24 10:24:29.199399+02	80055469D	José	Chavero Hernández	C/ Paseo de Extremadura Nº 104	06260	Monesterio	Badajoz		678409309	924517330	
119	2016-10-21 12:41:20.955918+02	2016-10-24 10:24:29.228117+02	80055875M	José Carlos	Chavero Valiente	C/ Río Viar Nº 23 P 2B	06260	Monesterio	Badajoz		678247390	924516150	
120	2016-10-21 12:41:21.164229+02	2016-10-24 10:24:29.248916+02	80055595R	José Luis	Chaves García	C/ Bovedo Nº 10 P 2ºA	06260	Monesterio	Badajoz		685847416		
121	2016-10-21 12:41:21.250309+02	2016-10-24 10:24:29.257189+02	44782114X	María del Rosario	Romero Rodríguez	C/ Bovedo Nº 10 P 2ºA	06260	Monesterio	Badajoz		663314105	924517304	
122	2016-10-21 12:41:21.423892+02	2016-10-24 10:24:29.277976+02	76246198W	Isabel	Gata Galán	C/ García de Paredes Nº 5	06292	Calera de León	Badajoz		648133788	924584080	
123	2016-10-21 12:41:21.499118+02	2016-10-24 10:24:29.286153+02	8820975S	Manuel	Chávez Durán	C/ García de Paredes Nº 5	06292	Calera de León	Badajoz		648133788	924584080	
124	2016-10-21 12:41:21.664338+02	2016-10-24 10:24:29.333932+02	34777458D	José	Chávez Durán	C/ Barrio de la Cruz Nº 45	06260	Monesterio	Badajoz		650618713	924516688	
125	2016-10-21 12:41:21.736364+02	2016-10-24 10:24:29.341936+02	76246372S	Isabel	González Chaves	C/ Barrio de la Cruz Nº 45	06260	Monesterio	Badajoz		649658760	924516688	
126	2016-10-21 12:41:21.9752+02	2016-10-24 10:24:29.390219+02	76251758L	Francisco Javier	Chávez Gordito	C/ Plaza de Cervantes Nº 2	06292	Calera de León	Badajoz		696658155	924584062	
127	2016-10-21 12:41:22.0479+02	2016-10-24 10:24:29.398221+02	80062668J	María del Carmen	Hoyos Sánchez	C/ Plaza de Cervantes Nº 2	06292	Calera de León	Badajoz		633406259	924584002	
128	2016-10-21 12:41:22.287633+02	2016-10-24 10:24:29.418347+02	34775988B	Luis	Cobos Muñoz	C/ Tierno Galván Nº 7	06260	Monesterio	Badajoz		652559487		
129	2016-10-21 12:41:22.375118+02	2016-10-24 10:24:29.426373+02	80055515J	Brígida	Martínez Redondo	C/ Tierno Galván Nº 7	06260	Monesterio	Badajoz		652559637		
130	2016-10-21 12:41:22.587464+02	2016-10-24 10:24:29.446336+02	34779615G	Antonio	Colorado Regaña	C/ Cañuelo Nº 4 P 2ºB	06260	Monesterio	Badajoz		685148428		
131	2016-10-21 12:41:22.67366+02	2016-10-24 10:24:29.454205+02	80055463F	Carmen	Ferreira Muñoz	C/ Cañuelo Nº 4 P 2ºB	06260	Monesterio	Badajoz		685148425		
132	2016-10-21 12:41:22.848194+02	2016-10-24 10:24:29.472484+02	76246347J	Manuel	Colorado Regaña	C/ Ntra. Sra. De los Dolores Nº 4	06260	Monesterio	Badajoz		618742036		
133	2016-10-21 12:41:22.922186+02	2016-10-24 10:24:29.480569+02	853556Y	Mercedes	Megías López	C/ Pablo Iglesias Nº 10	06260	Monesterio	Badajoz		667361769		
134	2016-10-21 12:41:23.08742+02	2016-10-24 10:24:29.500718+02	46666529N	Antonio	Conde Caño	Rda/ Bodonal de la Sierra Nº 120	06260	Monesterio	Badajoz		627790426		
136	2016-10-21 12:41:23.322845+02	2016-10-24 10:24:29.585976+02	33975294Q	Antonio Manuel	Contreras Márquez	C/ Hernando de Soto Nº 3	06292	Calera de León	Badajoz		600703854		
137	2016-10-21 12:41:23.395471+02	2016-10-24 10:24:29.593952+02	39378872C	María	Chaves Argemi	C/ Hernando de Soto Nº 3	06292	Calera de León	Badajoz		619783113		
138	2016-10-21 12:41:23.706861+02	2016-10-24 10:24:29.613679+02	80037102T	Luis	Contreras Fernández	C/ Reyes Católicos Nº 35	06292	Calera de León	Badajoz		628366563	924584207	
139	2016-10-21 12:41:23.791454+02	2016-10-24 10:24:29.621471+02	8980886F	Elisa	Durán Boton	C/ Reyes Católicos Nº 35	06292	Calera de León	Badajoz		629766393	924584207	
140	2016-10-21 12:41:24.00006+02	2016-10-24 10:24:29.641754+02	33978182Y	Eduardo	Contreras Moya	C/ Los Cotos Nº 9	06260	Monesterio	Badajoz		609759484	924516266	
141	2016-10-21 12:41:24.088729+02	2016-10-24 10:24:29.649816+02	34774562B	María José	Ferreira Delgado	C/ Los Cotos Nº 9	06260	Monesterio	Badajoz		615662980		
142	2016-10-21 12:41:24.274471+02	2016-10-24 10:24:29.669586+02	76246220R	Domingo	Contreras Real	C/ Cañuelo Nº 51	06260	Monesterio	Badajoz		620391046		
143	2016-10-21 12:41:24.347674+02	2016-10-24 10:24:29.677297+02	80055403Q	María Manuela	Iglesias Diéguez		06260	Monesterio	Badajoz		687392274		
144	2016-10-21 12:41:24.514753+02	2016-10-24 10:24:29.696954+02	75421351G	Juan Antonio	Córdoba Martínez	C/ Ronda de Cabeza la Vaca Nº 15	06260	Monesterio	Badajoz		677300579		
145	2016-10-21 12:41:24.588631+02	2016-10-24 10:24:29.704654+02	80040333B	María de la Cruz	Barranco Rubio	C/ Ronda de Cabeza la Vaca Nº 15	06260	Monesterio	Badajoz		677824683		
146	2016-10-21 12:41:24.752775+02	2016-10-24 10:24:29.724381+02	27307570S	María de los Ángeles	D'Acosta Díaz	C/ La Trocha, S / N Nº	06260	Monesterio	Badajoz		660195489		
147	2016-10-21 12:41:24.919652+02	2016-10-24 10:24:29.743904+02	76246730M	Carmen	Lozano González	Pl/ Manuel Durán Nº 13	06906	Puebla del Maestre	Badajoz		649157411	924512373	
148	2016-10-21 12:41:24.99246+02	2016-10-24 10:24:29.751937+02	76252433G	José Miguel	Crisóstomo Barragán	Pl/ Manuel Durán Nº 13	06906	Puebla del Maestre	Badajoz		660588252	924512373	
149	2016-10-21 12:41:25.159533+02	2016-10-24 10:24:29.791258+02	76251814Y	Celia	Carrasco Eslava	C/ Río Ardila Nº 7	06292	Calera de León	Badajoz		680392606	924584082	
150	2016-10-21 12:41:25.426191+02	2016-10-24 10:24:29.811096+02	76253101M	Nuria	González Gaviro	Avda/ Ntra. Sra. De los Dolores Nº 29	06290	Calera de León	Badajoz		696082804	924584183	
151	2016-10-21 12:41:25.516122+02	2016-10-24 10:24:29.818895+02	76251771D	David	Cubero Zambrano	Avda/ Ntra. Sra. De los Dolores Nº 29	06290	Calera de León	Badajoz		608137661	924584183	
153	2016-10-21 12:41:25.787008+02	2016-10-24 10:24:29.846256+02	8809306F	Antonio Olegario	Cubero Chávez	C/ Pedro de Valdivia Nº 13	06292	Calera de León	Badajoz		620928749	924584262	
154	2016-10-21 12:41:25.953185+02	2016-10-24 10:24:29.865913+02	80055715	Lucía	González Ferreira	C/ Pablo Iglesias Nº 8	06260	Monesterio	Badajoz		652504029		
155	2016-10-21 12:41:26.026826+02	2016-10-24 10:24:29.873616+02	34781826	Antonio	Cubo Hernández	C/ Pablo Iglesias Nº 8	06260	Monesterio	Badajoz				
156	2016-10-21 12:41:26.191904+02	2016-10-24 10:24:29.893225+02	37737971P	Concepción	Bayón Duqueso	C/ Espronceda, 12 1º A Nº	06260	Monesterio	Badajoz		617576149	924517185	
157	2016-10-21 12:41:26.266664+02	2016-10-24 10:24:29.900725+02	97551633R	Blas	Dacosta Gómez	C/ Espronceda, 12 1º A Nº	06260	Monesterio	Badajoz		617576149		
158	2016-10-21 12:41:26.429969+02	2016-10-24 10:24:29.918707+02	X2918609R	El Mati	Dahiri Dahiri	C/ Cañuelo Nº 35	06260	Monesterio	Badajoz		632267584		
159	2016-10-21 12:41:26.501843+02	2016-10-24 10:24:29.926564+02	X3679324Z	Mina	Lekhdar 	C/ Cañuelo Nº 35	06260	Monesterio	Badajoz		632841651		
160	2016-10-21 12:41:26.665452+02	2016-10-24 10:24:29.946114+02	34776967R	Esperanza	Romero Terrón	C/ Queipo de Llano Nº 70	06906	Puebla del Maestre	Badajoz			690772683	
161	2016-10-21 12:41:26.748775+02	2016-10-24 10:24:29.953943+02	76252439X	David	Danta Barrada	C/ Queipo de Llano Nº 70	06906	Puebla del Maestre	Badajoz			678647008	
162	2016-10-21 12:41:26.957639+02	2016-10-24 10:24:30.00108+02	47216828J	Azucena	San Juan Lahoz	C/ Queipo de Llano Nº	06906	Puebla del Maestre	Badajoz		673246970		
163	2016-10-21 12:41:27.04623+02	2016-10-24 10:24:30.008552+02	46878661S	Sergio	Danta Moya	C/ Queipo de Llano Nº	06906	Puebla del Maestre	Badajoz		673246976	916722380	
164	2016-10-21 12:41:27.304731+02	2016-10-24 10:24:30.027934+02	33477174F	Rosa María	Córdoba Ortega	C/ Medio Grande Nº 44	06291	Montemolín	Badajoz		666805626		
165	2016-10-21 12:41:27.468649+02	2016-10-24 10:24:30.053065+02	11916204L	María José	Delgado Sayago	C/ Reyes Lancharro Nº 16 E B P 7	06260	Monesterio	Badajoz		603822648		
166	2016-10-21 12:41:27.633837+02	2016-10-24 10:24:30.07686+02	834899E	Almudena	Aguilar Méndez	C/ Avenida del Parque Nº 16	06292	Calera de León	Badajoz		699185760		
167	2016-10-21 12:41:27.706281+02	2016-10-24 10:24:30.086639+02	33975290N	Antonio	Delgado Santos	C/ Avenida del Parque Nº 16	06292	Calera de León	Badajoz		648261512	924584174	
168	2016-10-21 12:41:27.871046+02	2016-10-24 10:24:30.110859+02	8796814G	Leocadio	Delgado Garrón	C/ Constitución Nº 21	06260	Monesterio	Badajoz		696802895	924516840	
169	2016-10-21 12:41:27.943074+02	2016-10-24 10:24:30.120213+02	80036929B	María José	Calderón Bautista	C/ Constitución Nº 21	06260	Monesterio	Badajoz		654241870	924516840	
170	2016-10-21 12:41:28.107257+02	2016-10-24 10:24:30.141782+02	18033914M	María Pilar	González Garrón	C/ Zurbarán Nº 44	06260	Monesterio	Badajoz		655245123		
171	2016-10-21 12:41:28.195279+02	2016-10-24 10:24:30.148245+02	76246512V	Feliciano	Delgado Sayago	C/ Zurbarán Nº 44	06260	Monesterio	Badajoz		683268583		
172	2016-10-21 12:41:28.402171+02	2016-10-24 10:24:30.167499+02	28479965P	Valentina	Romero Granadero	C/ Endrinales Nº 7 P 2B	06260	Monesterio	Badajoz		675734662		
173	2016-10-21 12:41:28.493684+02	2016-10-24 10:24:30.175247+02	75538073R	Ramón	Delgado Márquez	C/ Endrinales Nº 7 P 2B	06260	Monesterio	Badajoz		648714575		
174	2016-10-21 12:41:28.668017+02	2016-10-24 10:24:30.222737+02	80036855Y	Eugenio	Delgado Gallardo	C/ La Noria Nº 37	06260	Monesterio	Badajoz		620068576	924517215	
176	2016-10-21 12:41:28.983558+02	2016-10-24 10:24:30.250889+02	80040047R	Purificación	Domínguez Moreno	C/ Avda de San Marcos Nº 11 P 1ºA	06292	Calera de León	Badajoz		627780503	627780503	
177	2016-10-21 12:41:29.056503+02	2016-10-24 10:24:30.258878+02	80037068N	Domingo	Díaz Ramírez	C/ Avda de San Marcos Nº 11 P 1ºA	06292	Calera de León	Badajoz		625179086	627780503	
178	2016-10-21 12:41:29.223222+02	2016-10-24 10:24:30.279619+02	8884435H	María del Carmen	Blanco Baños	C/ Maestre Gonzalo Mexías Nº 6	06292	Calera de León	Badajoz		657418184		
179	2016-10-21 12:41:29.295692+02	2016-10-24 10:24:30.287422+02	8887838V	Juan Diego	Domínguez Cañizares	C/ Maestre Gonzalo Mexías Nº 6	06292	Calera de León	Badajoz		682457325		
180	2016-10-21 12:41:29.460795+02	2016-10-24 10:24:30.307373+02	76245987K	Daniel	Domínguez Durán	C/ Paseo de Extremadura Nº 23	06260	Monesterio	Badajoz		679692325	924517262	
181	2016-10-21 12:41:29.533969+02	2016-10-24 10:24:30.315141+02	76246331C	Manuela	Campano Sánchez	C/ Paseo de Extremadura Nº 23	06260	Monesterio	Badajoz			924517262	
182	2016-10-21 12:41:29.744066+02	2016-10-24 10:24:30.334752+02	44782963P	María Isabel	Sabido Ríos	C/ Sierra del Castillo 6 Nº  P 1A	06260	Monesterio	Badajoz		634712870		
183	2016-10-21 12:41:29.840364+02	2016-10-24 10:24:30.342535+02	8847578F	Francisco Javier	Domínguez Carballo	C/ Sierra del Castillo 6 Nº  P 1A	06260	Monesterio	Badajoz		636280037		
184	2016-10-21 12:41:30.036073+02	2016-10-24 10:24:30.362475+02	38105940F	M Rosa	Uguina Moya	C/ Reliquias Nº 44	06906	Puebla del Maestre	Badajoz		661874273		
185	2016-10-21 12:41:30.109418+02	2016-10-24 10:24:30.370299+02	76246710P	Pedro	Domínguez Roguera	C/ Reliquias Nº 44	06906	Puebla del Maestre	Badajoz		661868699		
187	2016-10-21 12:41:30.349266+02	2016-10-24 10:24:30.398009+02	80037180D	Francisco Javier	Domínguez Calderón	C/ Fuente Nº 3	06908	Montemolín	Badajoz		689030873	924511866	
188	2016-10-21 12:41:30.514047+02	2016-10-24 10:24:30.417907+02	28724474G	Antonio Manuel	Donoso Sayago	C/ La Noria Nº 19	06260	Monesterio	Badajoz		658549202	924516875	
189	2016-10-21 12:41:30.587436+02	2016-10-24 10:24:30.425678+02	76246396Q	Cesarina	Calderón Nevado	C/ La Noria Nº 19	06260	Monesterio	Badajoz		653707978	924516875	
191	2016-10-21 12:41:30.825626+02	2016-10-24 10:24:30.453268+02	76246472T	José Antonio	Duqueso Fernández	C/ Rafael Alberti Nº 10	06260	Monesterio	Badajoz		658107432	924516307	
192	2016-10-21 12:41:30.990719+02	2016-10-24 10:24:30.470227+02	34781862C	María del Mar	Mejías Terrón	C/ Paseo de Extremadura Nº 27	06260	Monesterio	Badajoz		651932764		
193	2016-10-21 12:41:31.075335+02	2016-10-24 10:24:30.476789+02	80037093	Manuel	Durán Chávez	C/ Paseo de Extremadura Nº 27	06260	Monesterio	Badajoz		646924571		
195	2016-10-21 12:41:31.385793+02	2016-10-24 10:24:30.500174+02	33922612G	José	Escudero Alonso	C/ Hernán Cortes Nº 1	06906	Puebla del Maestre	Badajoz		649336431	924512331	
196	2016-10-21 12:41:31.561888+02	2016-10-24 10:24:30.516813+02	80042895C	María de Lourdes	Santos Hipólito	C/ Las Espeñas Nº 1	06260	Monesterio	Badajoz		679075290	924516423	
197	2016-10-21 12:41:31.634916+02	2016-10-24 10:24:30.523424+02	8818372B	Antonio Agustín	Espacio Garrón	C/ Las Espeñas Nº 1	06260	Monesterio	Badajoz		699501681	924516423	
198	2016-10-21 12:41:31.802819+02	2016-10-24 10:24:30.541669+02	80036755K	Domingo	Esteban Pecellín	C/ Ronda de Bodonal de la Sierra Nº 118	06260	Monesterio	Badajoz		655155791		
199	2016-10-21 12:41:31.87614+02	2016-10-24 10:24:30.549055+02	34778365L	Virginia	Delgado Pecellín	C/ Ronda de Bodonal de la Sierra Nº 118	06260	Monesterio	Badajoz		691014259		
200	2016-10-21 12:41:32.040341+02	2016-10-24 10:24:30.567427+02	34780770D	Dolores	González Ferreira	C/ Luis Chamizo Nº 25	06260	Monesterio	Badajoz		625643009	924517155	
201	2016-10-21 12:41:32.113176+02	2016-10-24 10:24:30.574674+02	76246459X	Francisco José	Esteban Pecellín	C/ Luis Chamizo Nº 25	06260	Monesterio	Badajoz				
203	2016-10-21 12:41:32.352424+02	2016-10-24 10:24:30.600737+02	8786680J	Antonio	Esteban Fenandez	C/ Cervantes Nº 1	06907	Montemolín	Badajoz		655226249	924511118	
204	2016-10-21 12:41:32.536081+02	2016-10-24 10:24:30.644981+02	36931743E	Carlos	Estévez Espinosa	C/ Juan Pablo II Nº 26	06260	Monesterio	Badajoz		645882370	924113157	
205	2016-10-21 12:41:32.629334+02	2016-10-24 10:24:30.652321+02	46665289Z	María Teresa	Baños López	C/ Juan Pablo II Nº 26	06260	Monesterio	Badajoz		645878082		
206	2016-10-21 12:41:32.921832+02	2016-10-24 10:24:30.668935+02	75440851T	Santiago	Expósito Maya	C/ San Ildefonso Nº 41	06260	Monesterio	Badajoz		627857836	924516473	
207	2016-10-21 12:41:32.993979+02	2016-10-24 10:24:30.676015+02	80055856D	Josefa	Granadero Garrote	C/ San Ildefonso Nº 41	06260	Monesterio	Badajoz		687244494	924516473	
208	2016-10-21 12:41:33.160994+02	2016-10-24 10:24:30.694511+02	76246244W	José	Fernández Lancharrro	C/ Rosa de Luxenburgo Nº 13	06260	Monesterio	Badajoz		630158148		
209	2016-10-21 12:41:33.233689+02	2016-10-24 10:24:30.701814+02	80053109E	María del Pilar	Cañizares Lavado	C/ Rosa de Luxenburgo Nº 13	06260	Monesterio	Badajoz		626666459		
210	2016-10-21 12:41:33.402442+02	2016-10-24 10:24:30.720176+02	76246185N	José Manuel	Fernández Fernández	C/ Río Ardila Nº 5	06292	Calera de León	Badajoz		648069906	924584186	
211	2016-10-21 12:41:33.475804+02	2016-10-24 10:24:30.727351+02	76251806K	Isabel María	Cubero Rodríguez	C/ Río Ardila Nº 5	06292	Calera de León	Badajoz			924584186	
212	2016-10-21 12:41:33.643966+02	2016-10-24 10:24:30.744161+02	50067588S	María Amelia	Fernández Fernández	C/ San Marcos Nº 9 P BD	06292	Calera de León	Badajoz			924584186	
213	2016-10-21 12:41:33.717101+02	2016-10-24 10:24:30.75143+02	80037069J	Francisco	Fernández Albújar	C/ San Marcos Nº 9 P BD	06292	Calera de León	Badajoz		676028525	924584034	
214	2016-10-21 12:41:33.883778+02	2016-10-24 10:24:30.768251+02	16034651V	José Alejandro	Fernández Muñoz	C/ Río Culebrín Nº 2	06260	Monesterio	Badajoz		608436643	924516303	
215	2016-10-21 12:41:33.967518+02	2016-10-24 10:24:30.775515+02	76246470	María Josefa	Garrote Pecellín	C/ Río Culebrín Nº 2	06260	Monesterio	Badajoz				
216	2016-10-21 12:41:34.173144+02	2016-10-24 10:24:30.792235+02	80055852M	Eva María	González Romero	C/ Barrio de la Cruz Nº 115	06260	Monesterio	Badajoz		605014946	924516609	
217	2016-10-21 12:41:34.266243+02	2016-10-24 10:24:30.799591+02	76251776Z	Ángel Manuel	Fernández Balsera	C/ Barrio de la Cruz Nº 115	06260	Monesterio	Badajoz		652372307	924516609	
218	2016-10-21 12:41:34.449591+02	2016-10-24 10:24:30.818024+02	34774133L	Antonio	Fernández Nevado	C/ Reyes Católicos Nº 11	06290	Calera de León	Badajoz		609181027	924584012	
219	2016-10-21 12:41:34.52227+02	2016-10-24 10:24:30.825284+02	76251802V	Josefa	Megías López	C/ Reyes Católicos Nº 11	06290	Calera de León	Badajoz		646171178	924584012	
221	2016-10-21 12:41:34.908776+02	2016-10-24 10:24:30.879652+02	76246761J	Eduarda	Sánchez Gato	Bda/ Las Reliquias Nº 9	06906	Puebla del Maestre	Badajoz		626297502	924512163	
222	2016-10-21 12:41:34.983503+02	2016-10-24 10:24:30.886148+02	80033690S	José Miguel	Fernández Romero	Bda/ Las Reliquias Nº 9	06906	Puebla del Maestre	Badajoz		620060073	924512163	
223	2016-10-21 12:41:35.14773+02	2016-10-24 10:24:30.905661+02	38379800Q	Antonio	Fernández Gutiérrez	C/ Mesones Nº 21	06260	Monesterio	Badajoz		669835046	924516663	
224	2016-10-21 12:41:35.220756+02	2016-10-24 10:24:30.913323+02	76246457P	Concepción	Vasco Vargas	C/ Mesones Nº 21	06260	Monesterio	Badajoz		689025216	924516663	
225	2016-10-21 12:41:35.387395+02	2016-10-24 10:24:30.954586+02	76251803H	María de los Ángeles	Zapata Mejías	C/ García de Paredes Nº 9	06292	Calera de León	Badajoz		615191484	676595395	
226	2016-10-21 12:41:35.477696+02	2016-10-24 10:24:30.962127+02	8817785E	Manuel	Fernández Domínguez	C/ García de Paredes Nº 9	06292	Calera de León	Badajoz		676595395	615191484	
227	2016-10-21 12:41:35.77327+02	2016-10-24 10:24:30.979438+02	34774563N	Miguel Ángel	Ferreira Delgado	C/ Ramón y Cajal Nº 44	06260	Monesterio	Badajoz			924516710	
228	2016-10-21 12:41:35.863916+02	2016-10-24 10:24:30.986567+02	76246349S	María Reyes	Lancharro Mejías	C/ Ramón y Cajal Nº 44	06260	Monesterio	Badajoz		636448056	924516710	
229	2016-10-21 12:41:36.045471+02	2016-10-24 10:24:31.005767+02	28875760L	Fructuoso M	Ferreira Delgado	C/ Sevilla,9 Nº	06260	Monesterio	Badajoz		645834021	924516007	
231	2016-10-21 12:41:36.284897+02	2016-10-24 10:24:31.03322+02	28488282E	Miguel Ángel	Filigrana Fuentes	Bda/ Las Reliquias Nº 25	06906	Puebla del Maestre	Badajoz		689642283	677867839	
232	2016-10-21 12:41:36.358168+02	2016-10-24 10:24:31.041121+02	52697648W	Ana	Guillén García	Bda/ Las Reliquias Nº 25	06906	Puebla del Maestre	Badajoz		677867839	655203600	
233	2016-10-21 12:41:36.523507+02	2016-10-24 10:24:31.060918+02	33978021Y	Manuel	Flores López	C/ Travesía de los Galanes Nº 2	06292	Calera de León	Badajoz		676727138	689885019	
234	2016-10-21 12:41:36.596691+02	2016-10-24 10:24:31.068882+02	76251812G	Carmen	Baños Balsera	C/ Travesía de los Galanes Nº 2	06292	Calera de León	Badajoz		676727138	689885019	
236	2016-10-21 12:41:36.83454+02	2016-10-24 10:24:31.096721+02	53051048F	José Luis	Flores Campanario	C/ Montemolin Nº 17	06907	Montemolín	Badajoz		617822159		
237	2016-10-21 12:41:37.008891+02	2016-10-24 10:24:31.116793+02	9202229K	María del Rosario	Cano Vázquez	C/ Pizarro Nº 12	06292	Calera de León	Badajoz		639231291	66906817	
238	2016-10-21 12:41:37.098186+02	2016-10-24 10:24:31.124614+02	76251800S	Rafael	Galán Caballero	C/ Pizarro Nº 12	06292	Calera de León	Badajoz		669068117		
239	2016-10-21 12:41:37.308725+02	2016-10-24 10:24:31.179919+02	34777795R	Gloria	Ferrero Gómez	C/ Llerena Nº 6	06907	Montemolín	Badajoz		679954596	924511082	
240	2016-10-21 12:41:37.382309+02	2016-10-24 10:24:31.191533+02	50721466A	José Joaquín	Galván Fernández	C/ Llerena Nº 6	06907	Montemolín	Badajoz		652987674	924511082	
241	2016-10-21 12:41:37.619732+02	2016-10-24 10:24:31.216022+02	76246682A	Dimas	García García	C/ Puebla Nº 47	06907	Montemolín	Badajoz		924511115	68993628	
242	2016-10-21 12:41:37.692552+02	2016-10-24 10:24:31.22586+02	76246687P	María Felisa	Campanario Rodríguez	C/ Puebla Nº 47	06907	Montemolín	Badajoz		924511115	68993628	
243	2016-10-21 12:41:37.858525+02	2016-10-24 10:24:31.248392+02	80055520H	Feliciano	García Barragán								
244	2016-10-21 12:41:37.932105+02	2016-10-24 10:24:31.256912+02	80055876Y	Manuela	Chavero Valiente								
245	2016-10-21 12:41:38.097465+02	2016-10-24 10:24:31.274632+02	80035633A	Epifanio	García Olivera	C/ Bastiana Nº 6	06291	Montemolín	Badajoz		615274579	615274541	
246	2016-10-21 12:41:38.170877+02	2016-10-24 10:24:31.282192+02	34777806N	Soledad	Galván Campanario	C/ Bastiana Nº 6	06291	Montemolín	Badajoz		615274541		
247	2016-10-21 12:41:38.341667+02	2016-10-24 10:24:31.300977+02	33973064V	Manuela	Garrote Donoso	C/ Libertad Nº 26	06260	Monesterio	Badajoz		686374994	924516975	
248	2016-10-21 12:41:38.432153+02	2016-10-24 10:24:31.308317+02	76246341F	Diego	García Pacheco	C/ Libertad Nº 26	06260	Monesterio	Badajoz		617350773	924516975	
249	2016-10-21 12:41:38.635854+02	2016-10-24 10:24:31.326836+02	80025309Y	Rafael	García Porras	C/ Paseo de Extremadura Nº 192	06260	Monesterio	Badajoz		608621975	924517136	
251	2016-10-21 12:41:38.897329+02	2016-10-24 10:24:31.35274+02	34777839E	Natividad	Abril Vara	Bda/ Las Reliquias Nº 28	06906	Puebla del Maestre	Badajoz		608498369	924512368	
252	2016-10-21 12:41:38.970382+02	2016-10-24 10:24:31.360082+02	9178217K	Miguel Ángel	Garrote Guerrero	Bda/ Las Reliquias Nº 28	06906	Puebla del Maestre	Badajoz		677481829	924512368	
254	2016-10-21 12:41:39.20853+02	2016-10-24 10:24:31.406938+02	39677454Q	Lourdes	Fuentes Granadero	C/ Bovedo Nº 1	06260	Monesterio	Badajoz		615123505	924517123	
253	2016-10-21 12:41:39.135868+02	2016-10-24 10:24:31.414822+02	33973137K	Jerónimo	Garrote Sánchez	C/ Bovedo Nº 1	06260	Monesterio	Badajoz		608415959	924517123	
255	2016-10-21 12:41:39.448848+02	2016-10-24 10:24:31.43494+02	28547524Q	Antonio	Garrote Ledesma	C/ Cervantes Nº 14	06260	Monesterio	Badajoz		660416298	924516516	
256	2016-10-21 12:41:39.521213+02	2016-10-24 10:24:31.442843+02	80036820V	Francisca Inmaculada	García Areses	C/ Cervantes Nº 14	06260	Monesterio	Badajoz		671934130	924516516	
257	2016-10-21 12:41:39.686693+02	2016-10-24 10:24:31.463398+02	28721758W	Josefa	Garrón Garrón	C/ Endrinales Nº 11	06260	Monesterio	Badajoz		655049617		
258	2016-10-21 12:41:39.759835+02	2016-10-24 10:24:31.471307+02	28873662Z	José Carlos	Garrote Chaves	C/ Endrinales Nº 11	06260	Monesterio	Badajoz		692156779		
259	2016-10-21 12:41:39.967569+02	2016-10-24 10:24:31.491104+02	76246385M	José Antonio	Garrote Donoso	C/ Los Almendros Nº 5	06260	Monesterio	Badajoz		635464214	924517291	
260	2016-10-21 12:41:40.068159+02	2016-10-24 10:24:31.499117+02	76246557Q	María José	Garrón Abadín	C/ Los Almendros Nº 5	06260	Monesterio	Badajoz		646029474	924517291	
261	2016-10-21 12:41:40.249204+02	2016-10-24 10:24:31.519363+02	33977425P	Antonio	Garrote Carrasco	C/ Barrio de la Cruz Nº 126	06260	Monesterio	Badajoz		687444929		
262	2016-10-21 12:41:40.321672+02	2016-10-24 10:24:31.527254+02	76251888B	María Eulalia	Ledesma Alvarado	C/ Barrio de la Cruz Nº 126	06260	Monesterio	Badajoz		678242908		
263	2016-10-21 12:41:40.486862+02	2016-10-24 10:24:31.547076+02	76246596D	María José	Mateos Mateos	C/ Pozos Nº 8	06260	Monesterio	Badajoz		685852619	924516619	
264	2016-10-21 12:41:40.558545+02	2016-10-24 10:24:31.555011+02	8785771R	Feliciano	Garrote Garrón	C/ Pozos Nº 8	06260	Monesterio	Badajoz		635439065		
265	2016-10-21 12:41:40.722382+02	2016-10-24 10:24:31.575621+02	76246282V	Antonio	Garrote Megías	C/ Zurbarán, 64 Nº	06260	Monesterio	Badajoz		625482352	924516143	
266	2016-10-21 12:41:40.794936+02	2016-10-24 10:24:31.584092+02	76246527D	Luisa	Megías Vargas	C/ Zurbarán, 64 Nº	06260	Monesterio	Badajoz		648874642	924516143	
267	2016-10-21 12:41:40.960126+02	2016-10-24 10:24:31.604343+02	8830074Y	Antonio	Gata Chávez	C/ Templarios Nº 36	06260	Monesterio	Badajoz		615309223	924516968	
268	2016-10-21 12:41:41.033216+02	2016-10-24 10:24:31.61198+02	16286599T	María Isabel	Rodríguez García	C/ Templarios Nº 36	06260	Monesterio	Badajoz		639926584	924516968	
269	2016-10-21 12:41:41.210653+02	2016-10-24 10:24:31.632433+02	34780385S	Carmen	Rodríguez Fernández	C/ Río Ardila Nº 4	06292	Calera de León	Badajoz		638392537	924584073	
270	2016-10-21 12:41:41.303455+02	2016-10-24 10:24:31.64186+02	52234816E	Juan	Gavira Rivero	C/ Río Ardila Nº 4	06292	Calera de León	Badajoz		687473948	924584073	
271	2016-10-21 12:41:41.512202+02	2016-10-24 10:24:31.661962+02	X4103887C	Zydrune	Kereviciute 	C/ Maestre Gonzalo Mexias Nº 28	06290	Calera de León	Badajoz		629330373	924584069	
272	2016-10-21 12:41:41.692501+02	2016-10-24 10:24:31.684218+02	38137634T	Carolina	Grau Páez	C/ Churruca Nº	06906	Puebla del Maestre	Badajoz		639681103	924512296	
273	2016-10-21 12:41:41.765008+02	2016-10-24 10:24:31.692353+02	76252429T	Francisco Javier	Giles Navarro	C/ Churruca Nº	06906	Puebla del Maestre	Badajoz		619110554	924512296	
274	2016-10-21 12:41:41.929912+02	2016-10-24 10:24:31.712682+02	29055011P	Juan Manuel	Godino Ramos	Pso/ Extremadura Nº 1 P 2ºD	06260	Monesterio	Badajoz		627412908		
275	2016-10-21 12:41:42.003585+02	2016-10-24 10:24:31.720569+02	29055371T	Rita	Gómez González	Pso/ Extremadura Nº 1 P 2ºD	06260	Monesterio	Badajoz		609253454		
277	2016-10-21 12:41:42.334415+02	2016-10-24 10:24:31.760403+02	80055685E	Fernando José	González Ferreira	C/ Arroyo del Moro Nº 20	06260	Monesterio	Badajoz				
278	2016-10-21 12:41:42.40944+02	2016-10-24 10:24:31.768249+02	8884764W	Ana Belén	Bernáldez Redondo	C/ Arroyo del Moro Nº 20	06260	Monesterio	Badajoz		665837223	665837223	
279	2016-10-21 12:41:42.573597+02	2016-10-24 10:24:31.788028+02	80055684K	Juan Antonio	González Ferreira	C/ Almendro Nº 2	06260	Monesterio	Badajoz		625635082		
280	2016-10-21 12:41:42.654073+02	2016-10-24 10:24:31.795993+02	80055880X	María	Cardoso Ibarra	C/ Almendro Nº 2	06260	Monesterio	Badajoz		691141644		
281	2016-10-21 12:41:42.870035+02	2016-10-24 10:24:31.816036+02	33975985V	Manuel	González Iglesias	C/ Cristóbal Colón Nº 3	06292	Calera de León	Badajoz		659313417	924584078	
282	2016-10-21 12:41:42.959503+02	2016-10-24 10:24:31.824108+02	80037048S	Carmen	Cubero Barragán	C/ Cristóbal Colón Nº 3	06292	Calera de León	Badajoz		606171901	924584078	
283	2016-10-21 12:41:43.141448+02	2016-10-24 10:24:31.871566+02	33975913Z	Rafael	González Granadero	C/ Barrio de la Cruz Nº 123	06260	Monesterio	Badajoz		607299185		
284	2016-10-21 12:41:43.216885+02	2016-10-24 10:24:31.879314+02	80036788P	Agustina	Delgado Ruiz	C/ Barrio de la Cruz Nº 123	06260	Monesterio	Badajoz		679986134		
285	2016-10-21 12:41:43.463871+02	2016-10-24 10:24:31.897197+02	44778681G	Natividad	González Fernández	C/ Avda. De Portugal Nº 15	06260	Monesterio	Badajoz		609758419		
287	2016-10-21 12:41:43.705692+02	2016-10-24 10:24:31.924983+02	76119109B	Consuelo	Fernández Parrón	C/ Camping Tentudia Carretera 630 Km 727 Nº 727	06260	Monesterio	Badajoz		635063809		
288	2016-10-21 12:41:43.779646+02	2016-10-24 10:24:31.932839+02	44407053X	Francisco Javier	González Curiel	C/ Los Cosos Nº 30	10440	Aldeanueva de la Vera	Cáceres		606349969		
290	2016-10-21 12:41:44.023389+02	2016-10-24 10:24:31.961153+02	34775821M	Teófilo	González Reyes	C/ San Pedro Nº 40 P 1º	06260	Monesterio	Badajoz		615309315		
292	2016-10-21 12:41:44.319794+02	2016-10-24 10:24:31.988298+02	76246406A	José	González Cantillo	C/ Cerro de la Fuente Nº 9	06260	Monesterio	Badajoz		625323304		
293	2016-10-21 12:41:44.517746+02	2016-10-24 10:24:32.006407+02	8827770W	Antonio	González Reyes	C/ Juan Ramón Jiménez Nº 15	06260	Monesterio	Badajoz		605132167	924518011	
294	2016-10-21 12:41:44.59343+02	2016-10-24 10:24:32.014284+02	80055409E	María Martina	Vasco Ruiz	C/ Juan Ramón Jiménez Nº 15	06260	Monesterio	Badajoz		674518295	924518011	
295	2016-10-21 12:41:44.762585+02	2016-10-24 10:24:32.060577+02	36566825E	Josefa	Vázquez Lancharro	Avda/ Portugal Nº 15	06260	Monesterio	Badajoz		656428781		
286	2016-10-21 12:41:43.537928+02	2016-10-24 10:24:32.068373+02	76246480P	Daniel	González Fernández		06260	Monesterio	Badajoz		680235654		
296	2016-10-21 12:41:45.024149+02	2016-10-24 10:24:32.088065+02	80025713L	José	González Delgado	C/ Libertad Nº 19	06260	Monesterio	Badajoz				
297	2016-10-21 12:41:45.098792+02	2016-10-24 10:24:32.0959+02	X3046419T	Marisol	Villacis Barrera	C/ Libertad Nº 19	06260	Monesterio	Badajoz		659602152	924517296	
298	2016-10-21 12:41:45.265064+02	2016-10-24 10:24:32.115731+02	28439509D	Ramón	Gordito Rubio	C/ Dolores Ibarruri Nº 33	06260	Monesterio	Badajoz		615370932	954733374	
299	2016-10-21 12:41:45.339329+02	2016-10-24 10:24:32.123727+02	3273901N	Jennifer	Rivera Rosado	C/ Dolores Ibarruri Nº 33	06260	Monesterio	Badajoz		661539600	954733374	
300	2016-10-21 12:41:45.51253+02	2016-10-24 10:24:32.143567+02	76251760K	Ángel Luis	Gordito López	C/ San Isidro Nº 16	06260	Monesterio	Badajoz		658976677		
301	2016-10-21 12:41:45.602293+02	2016-10-24 10:24:32.151619+02	80055863Q	Ana María	Velázquez Vázquez	C/ San Isidro Nº 16	06260	Monesterio	Badajoz		674098810		
302	2016-10-21 12:41:45.806188+02	2016-10-24 10:24:32.171596+02	34773724R	José	Granadero Romero	C/ Ranchuelo Nº 24	06291	Montemolín	Badajoz		637134205		
303	2016-10-21 12:41:45.893156+02	2016-10-24 10:24:32.179506+02	34778308P	Rosa	Larrayad Pereira	C/ Ranchuelo Nº 24	06291	Montemolín	Badajoz		722159047	924510153	
304	2016-10-21 12:41:46.067469+02	2016-10-24 10:24:32.199332+02	80055532F	Ana Belén	Villalba Talamino	C/ Barrio de la Cruz Nº 68	06260	Monesterio	Badajoz		676654825		
305	2016-10-21 12:41:46.143992+02	2016-10-24 10:24:32.207152+02	80055542V	José Manuel	Granadero Fuentes	C/ Barrio de la Cruz Nº 68	06260	Monesterio	Badajoz		637409979		
306	2016-10-21 12:41:46.313237+02	2016-10-24 10:24:32.227971+02	44778894X	Francisco	Granados Jerez	C/ Santa Ana Nº 7 P 1º	06260	Monesterio	Badajoz		655812198	924517086	
307	2016-10-21 12:41:46.387943+02	2016-10-24 10:24:32.236177+02	80055745	Isabel M	Calderón Zapata	C/ Santa Ana Nº	06260	Monesterio	Badajoz			924517086	
309	2016-10-21 12:41:46.638224+02	2016-10-24 10:24:32.271681+02	38445535T	Juan Carlos	Guareño Garrote	C/ P. Extremadura Nº 240 P x	06260	Monesterio	Badajoz		660178762	924516092	
310	2016-10-21 12:41:46.816929+02	2016-10-24 10:24:32.294353+02	28899616R	Magdalena	Valencia Herrojo	C/ Cañuelo Nº 23	06260	Monesterio	Badajoz		642136606	924516701	
311	2016-10-21 12:41:46.893438+02	2016-10-24 10:24:32.30337+02	76246529B	José	Guareño Delgado	C/ Cañuelo Nº 23	06260	Monesterio	Badajoz		639978102	924516701	
312	2016-10-21 12:41:47.091308+02	2016-10-24 10:24:32.321601+02	52262471P	Ángel	Guerrero Pérez	C/ San Blas Nº 7	06291	Montemolín	Badajoz		686041696	675577726	
313	2016-10-21 12:41:47.181165+02	2016-10-24 10:24:32.328933+02	8823926E	Cele	Noguera Campanario	C/ San Blas Nº 7	06291	Montemolín	Badajoz		686041696		
314	2016-10-21 12:41:47.384294+02	2016-10-24 10:24:32.34755+02	X127390V	Abdelgani	Harhaoui 		06260	Monesterio	Badajoz				
315	2016-10-21 12:41:47.460075+02	2016-10-24 10:24:32.355189+02	X3201977D	Hanan	Elabbassi 	C/ Juan Ramón Jiménez Nº 4	06260	Monesterio	Badajoz		630709586		
316	2016-10-21 12:41:47.62849+02	2016-10-24 10:24:32.402142+02	X2535928V	Mohamed	Herba 	C/ Paseo de Extremadura Nº 180 P 1	06260	Monesterio	Badajoz		631263641		
317	2016-10-21 12:41:47.701956+02	2016-10-24 10:24:32.410008+02	X1935598X	Malika	Herba 	C/ Paseo de Extremadura Nº 180 P 1	06260	Monesterio	Badajoz		631262730		
318	2016-10-21 12:41:47.961331+02	2016-10-24 10:24:32.430056+02	28488273J	Gabriel	Hermoso Morales	C/ Elías Torres Nº 26	06260	Monesterio	Badajoz		607439499		
320	2016-10-21 12:41:48.213851+02	2016-10-24 10:24:32.485886+02	76246386Y	José Antonio	Hernández Chavero	C/ Hernán Cortes Nº 1	06260	Monesterio	Badajoz		648230121		
321	2016-10-21 12:41:48.288634+02	2016-10-24 10:24:32.493731+02	76246469C	Estrella	Bayón Bayón	C/ Hernán Cortes Nº 1	06260	Monesterio	Badajoz		648230122		
322	2016-10-21 12:41:48.566259+02	2016-10-24 10:24:32.513586+02	34782624T	Sofía	Cardoso Romero		06260	Monesterio	Badajoz		646152295	924516775	
323	2016-10-21 12:41:48.661687+02	2016-10-24 10:24:32.52139+02	80055659L	Francisco Manuel	Hernández Cantillo		06260	Monesterio	Badajoz		625593724	646152295	
324	2016-10-21 12:41:48.864969+02	2016-10-24 10:24:32.569086+02	76246384G	Francisco	Hernández Chavero	C/ Sevilla Nº 18	06260	Monesterio	Badajoz		670570007		
325	2016-10-21 12:41:48.94182+02	2016-10-24 10:24:32.576581+02	34779102C	María Luisa	Fernández Agudo	C/ Sevilla Nº 18	06260	Monesterio	Badajoz		648230120		
326	2016-10-21 12:41:49.183721+02	2016-10-24 10:24:32.594183+02	2353766S	María Edith	Lucio Gómez								
328	2016-10-21 12:41:49.425914+02	2016-10-24 10:24:32.622029+02	80108383G	María Edith	Lucio Gómez	C/ Almendros Nº 7	06260	Monesterio	Badajoz		608924542	666313030	
327	2016-10-21 12:41:49.25712+02	2016-10-24 10:24:32.629882+02	76246532Z	Francisco	Hernández Benegas	C/ Almendros Nº 7	06260	Monesterio	Badajoz		647656337	924516355	
329	2016-10-21 12:41:49.613177+02	2016-10-24 10:24:32.649518+02	76246427R	Carmen	Garrón Garrón	C/ Endrinales Nº 9	06260	Monesterio	Badajoz		626395229		
330	2016-10-21 12:41:49.688784+02	2016-10-24 10:24:32.656394+02	28733120W	José María	Herrera Parreño	C/ Endrinales Nº 9	06260	Monesterio	Badajoz		607731564	924149030	
331	2016-10-21 12:41:49.861101+02	2016-10-24 10:24:32.675727+02	34775363F	Isidoro	Hidalgo Macarro	C/ Reyes Católicos Nº 12	06292	Calera de León	Badajoz		669695189	924584056	
332	2016-10-21 12:41:49.94718+02	2016-10-24 10:24:32.683616+02	41086743A	Purificación	Artero Roque	C/ Reyes Católicos Nº 12	06292	Calera de León	Badajoz		648710059	924584056	
333	2016-10-21 12:41:50.152556+02	2016-10-24 10:24:32.703434+02	80055663T	Manuela	Fuentes Donoso	C/ Sevilla,14 Nº	06260	Monesterio	Badajoz		625522822	924516213	
334	2016-10-21 12:41:50.240978+02	2016-10-24 10:24:32.711226+02	76246543W	Eduardo	Iglesias Bayón	C/ Sevilla,14 Nº	06260	Monesterio	Badajoz		630254403	924516213	
335	2016-10-21 12:41:50.429458+02	2016-10-24 10:24:32.731109+02	8884587D	Juan Carlos	Iglesias Sánchez	C/ Pozos Nº 62	06260	Monesterio	Badajoz		675151529	924516526	
336	2016-10-21 12:41:50.501991+02	2016-10-24 10:24:32.738904+02	8884688H	Rosa María	Muñoz Bernardino	C/ Pozos Nº 62	06260	Monesterio	Badajoz		646153937	924516526	
337	2016-10-21 12:41:50.670133+02	2016-10-24 10:24:32.758809+02	34778449B	Mónica	Garrón Chávez	C/ Callejón del Agua Nº 10	06292	Calera de León	Badajoz		638401084	924584018	
338	2016-10-21 12:41:50.746813+02	2016-10-24 10:24:32.766733+02	70798352M	Jaime	Jiménez Blázquez	C/ Callejón del Agua Nº 10	06292	Calera de León	Badajoz		670530827	924584018	
339	2016-10-21 12:41:50.915434+02	2016-10-24 10:24:32.786793+02	80037143H	Antonio	Jiménez Galván	C/ San Blas Nº	06291	Montemolín	Badajoz		657838182	924510233	
340	2016-10-21 12:41:50.991789+02	2016-10-24 10:24:32.794657+02	76246690B	Francisca	Rodríguez Macarro	C/ San Blas Nº	06291	Montemolín	Badajoz		628646017	924510233	
341	2016-10-21 12:41:51.161574+02	2016-10-24 10:24:32.814594+02	34781100V	María Luisa	Bayón Megías	C/ Noria Nº 6	06260	Monesterio	Badajoz		670556244		
342	2016-10-21 12:41:51.235536+02	2016-10-24 10:24:32.822541+02	44775089T	Manuel	Lancharro Osuna	C/ Noria Nº 6	06260	Monesterio	Badajoz		687790086		
343	2016-10-21 12:41:51.411959+02	2016-10-24 10:24:32.842793+02	8856772R	Concepción	Bayón Vargas	Pso/ Paseo de Extremadura Nº 303	06260	Monesterio	Badajoz		605783696		
344	2016-10-21 12:41:51.508132+02	2016-10-24 10:24:32.850889+02	76246275X	Manuel Agustín	Lancharro Calderón	Pso/ Paseo de Extremadura Nº 303	06260	Monesterio	Badajoz		665843174		
345	2016-10-21 12:41:51.709335+02	2016-10-24 10:24:32.870708+02	80037132F	Manuel	Lancharro Carrasco	C/ Rafael Pulido Nº 54	06291	Montemolín	Badajoz		676636822	619166731	
346	2016-10-21 12:41:51.799548+02	2016-10-24 10:24:32.878532+02	76246729G	María Dolores	Girol Díaz	C/ Rafael Pulido Nº 54	06291	Montemolín	Badajoz		619166731	676636822	
347	2016-10-21 12:41:52.010371+02	2016-10-24 10:24:32.906413+02	33976803F	Antonio	Lancharro Campano	C/ San Blas Nº 3	06291	Montemolín	Badajoz		615590728		
348	2016-10-21 12:41:52.085031+02	2016-10-24 10:24:32.914353+02	45285585B	Malika	Kaddur Vekay	C/ San Blas Nº 3	06291	Montemolín	Badajoz		663271891		
349	2016-10-21 12:41:52.259855+02	2016-10-24 10:24:32.962005+02	33972845M	Teresa	Lora Marchena	C/ Vista Hermosa Nº 8	06260	Monesterio	Badajoz		647228092	924517179	
350	2016-10-21 12:41:52.334498+02	2016-10-24 10:24:32.97005+02	80036982H	Vicente	Lancharro Terrón	C/ Vista Hermosa Nº 8	06260	Monesterio	Badajoz			924517179	
351	2016-10-21 12:41:52.584199+02	2016-10-24 10:24:32.989911+02	76246364F	Manuel	Lancharro Chavero	Avda/ Eduardo Naranjo Nº 13 E A	06260	Monesterio	Badajoz		699505701		
352	2016-10-21 12:41:52.659736+02	2016-10-24 10:24:32.997909+02	76246517E	Victoria	Sánchez Calderón	Avda/ Eduardo Naranjo Nº 13 E A	06260	Monesterio	Badajoz		616281558	924517014	
353	2016-10-21 12:41:52.836432+02	2016-10-24 10:24:33.017607+02	44775609Z	Encarnación	Bermúdez Villalba	C/ Espronceda Nº 8	06906	Puebla del Maestre	Badajoz		924512344	636747430	
354	2016-10-21 12:41:52.930012+02	2016-10-24 10:24:33.02537+02	33978252F	Sixto	Lara Moya	C/ Espronceda Nº 8	06906	Puebla del Maestre	Badajoz		924512344	680217595	
355	2016-10-21 12:41:53.134437+02	2016-10-24 10:24:33.045239+02	34774329P	Andrés	Lara Caballero	C/ Queipo de Llano Nº 117	06906	Puebla del Maestre	Badajoz		646353422	924512003	
356	2016-10-21 12:41:53.227006+02	2016-10-24 10:24:33.053211+02	8848357G	Eloína	Garrote Guerrero	C/ Queipo de Llano Nº 117	06906	Puebla del Maestre	Badajoz		606042033	924512003	
357	2016-10-21 12:41:53.403882+02	2016-10-24 10:24:33.07359+02	76246570Y	María del Mar	González Romero	C/ Gallego Paz Nº 14	06260	Monesterio	Badajoz		646152866	924517168	
358	2016-10-21 12:41:53.478498+02	2016-10-24 10:24:33.08203+02	80039999E	José Manuel	Lavado Gómez	C/ Gallego Paz Nº 14	06260	Monesterio	Badajoz				
359	2016-10-21 12:41:53.644394+02	2016-10-24 10:24:33.130259+02	28857806M	Juan Carlos	Ledesma Mestre	C/ Manuel Pecellín Lancharro Nº 14	06260	Monesterio	Badajoz			924516144	
360	2016-10-21 12:41:53.721507+02	2016-10-24 10:24:33.138034+02	9192982C	María Elena	Caro Puertolas	C/ Manuel Pecellín Lancharro Nº 14	06260	Monesterio	Badajoz		619276971	924516144	
361	2016-10-21 12:41:53.966789+02	2016-10-24 10:24:33.157859+02	28924194S	Francisco Javier	Linares Moya	C/ Travesía Nº 5	06908	Montemolín	Badajoz		675072333		
362	2016-10-21 12:41:54.039629+02	2016-10-24 10:24:33.16571+02	8797661T	Isabel María	Guerrero Sánchez	C/ Travesía Nº 5	06908	Montemolín	Badajoz		619130649		
363	2016-10-21 12:41:54.207319+02	2016-10-24 10:24:33.185597+02	80055555F	María del Carmen	Cabeza Sánchez	Pso/ Extremadura Nº 176	06260	Monesterio	Badajoz		675053442		
364	2016-10-21 12:41:54.283239+02	2016-10-24 10:24:33.19357+02	80055501E	José Carlos	Llimona Sánchez	Pso/ Extremadura Nº 176	06260	Monesterio	Badajoz		628104897		
365	2016-10-21 12:41:54.493289+02	2016-10-24 10:24:33.213514+02	34779018M	Rosa María	Balsera Artero	C/ Avda. Del Parque Nº 46	06292	Calera de León	Badajoz		628175606	924584196	
366	2016-10-21 12:41:54.585277+02	2016-10-24 10:24:33.221332+02	76251779V	Manuel	López Calderón	C/ Avda. Del Parque Nº 46	06292	Calera de León	Badajoz		628175606	924584196	
367	2016-10-21 12:41:54.781601+02	2016-10-24 10:24:33.241495+02	44782510S	María Luisa	Cerón García	C/ Margarita Nielken Nº 9	06260	Monesterio	Badajoz		628855449	924517464	
368	2016-10-21 12:41:54.855207+02	2016-10-24 10:24:33.249446+02	80055892E	Gregorio	López Campano	C/ Margarita Nielken Nº 9	06260	Monesterio	Badajoz		610226957	924517464	
369	2016-10-21 12:41:55.023563+02	2016-10-24 10:24:33.26962+02	34780540D	Ángel	López Calderón	C/ Río Ardila Nº 1	06292	Calera de León	Badajoz		680424001	657478529	
370	2016-10-21 12:41:55.098594+02	2016-10-24 10:24:33.277624+02	80053129L	Dolores	Cordero Macías	C/ Río Ardila Nº 1	06292	Calera de León	Badajoz		657478529	680424001	
371	2016-10-21 12:41:55.263037+02	2016-10-24 10:24:33.297715+02	75419305M	Juan Ángel	López Jiménez	C/ Barriada las Reliquias Nº 6	06906	Puebla del Maestre	Badajoz		699876894		
372	2016-10-21 12:41:55.336805+02	2016-10-24 10:24:33.305688+02	7544176S	Rocío	Domínguez Baños	C/ Barriada las Reliquias Nº 6	06906	Puebla del Maestre	Badajoz				
373	2016-10-21 12:41:55.502688+02	2016-10-24 10:24:33.364238+02	44785081X	Carmen	Pereira Rosario		06260	Monesterio	Badajoz		616740574		
374	2016-10-21 12:41:55.575928+02	2016-10-24 10:24:33.373881+02	79261845G	Jerónimo	López Garrón		06260	Monesterio	Badajoz				
375	2016-10-21 12:41:55.828839+02	2016-10-24 10:24:33.39809+02	28494561G	Francisco Javier	López Isidoro	C/ Sierra del Castillo Nº 2 P 1A	06260	Monesterio	Badajoz		685819943		
376	2016-10-21 12:41:55.920326+02	2016-10-24 10:24:33.407295+02	80055760M	Manuela	Sánchez Sánchez	C/ El Romeral Nº 3	06260	Monesterio	Badajoz		615663507	924516404	
377	2016-10-21 12:41:56.131096+02	2016-10-24 10:24:33.425633+02	33976424L	José Antonio	López Calderón	C/ Concha Espina Nº 5	06260	Monesterio	Badajoz		686747355		
378	2016-10-21 12:41:56.216998+02	2016-10-24 10:24:33.432279+02	80055538J	María José	Villalba Gallego	C/ Concha Espina Nº 5	06260	Monesterio	Badajoz		615420255		
379	2016-10-21 12:41:56.383796+02	2016-10-24 10:24:33.45034+02	8850531Q	Tomás	Lozano González	C/ Puebla Nº 49	06907	Montemolín	Badajoz		647850378	924511162	
380	2016-10-21 12:41:56.458303+02	2016-10-24 10:24:33.457586+02	8884515Y	María Teresa	Vargas Villalba	C/ Puebla Nº 49	06907	Montemolín	Badajoz		690830407	924511162	
381	2016-10-21 12:41:56.629429+02	2016-10-24 10:24:33.495821+02	76246295F	Salvadora	Calderón Iglesias	C/ Libertad Nº 54	06260	Monesterio	Badajoz		646803875	924516177	
382	2016-10-21 12:41:56.851324+02	2016-10-24 10:24:33.515635+02	53076578F	Mónica	Pérez Santiago	C/ Dolores Ibarruri Nº 27	06260	Monesterio	Badajoz		685988632		
383	2016-10-21 12:41:56.928142+02	2016-10-24 10:24:33.523435+02	53078859B	Samuel	Luque García	C/ Dolores Ibarruri Nº 27	06260	Monesterio	Badajoz		657220083		
384	2016-10-21 12:41:57.095772+02	2016-10-24 10:24:33.543157+02	28678559C	Ángel	Luque Martín	C/ Párroco Antonio Rosendo Nº 31	41250	El Real de la Jara	Sevilla		606003127		
385	2016-10-21 12:41:57.169572+02	2016-10-24 10:24:33.551123+02	75419336J	María Ángeles	Romero Vázquez	C/ Párroco Antonio Rosendo Nº 31	41250	El Real de la Jara	Sevilla		660158854		
386	2016-10-21 12:41:57.377718+02	2016-10-24 10:24:33.570892+02	76246623J	Francisco Javier	Macedo García	C/ San Blas Nº 1	06291	Montemolín	Badajoz			924510086	
387	2016-10-21 12:41:57.475674+02	2016-10-24 10:24:33.578735+02	44785080D	Sandra	Pereira Rosario	C/ San Blas Nº 1	06291	Montemolín	Badajoz		722383396	924510086	
388	2016-10-21 12:41:57.657397+02	2016-10-24 10:24:33.598572+02	33533730Y	María Concepción	Rodríguez Silva	Bda/ Las Reliquias Nº 16	06906	Puebla del Maestre	Badajoz		650966790	924512050	
389	2016-10-21 12:41:57.729774+02	2016-10-24 10:24:33.606644+02	76252434M	Laureano	Machío Murillo	Bda/ Las Reliquias Nº 16	06906	Puebla del Maestre	Badajoz		636218696		
390	2016-10-21 12:41:57.898892+02	2016-10-24 10:24:33.6264+02	34774755C	Joaquín	Macías Rodríguez	C/ Rosa de Luxemburgo Nº 11	06260	Monesterio	Badajoz		682933397	924517111	
391	2016-10-21 12:41:57.973021+02	2016-10-24 10:24:33.634219+02	76246537L	Rosario	Ledesma Garrón	C/ Rosa de Luxemburgo Nº 11	06260	Monesterio	Badajoz		645776384	924517111	
392	2016-10-21 12:41:58.137495+02	2016-10-24 10:24:33.681706+02	76246743H	Felisa	Durán Caballero	C/ Churruca Nº 5	06906	Puebla del Maestre	Badajoz		637790507	924512335	
393	2016-10-21 12:41:58.211244+02	2016-10-24 10:24:33.689474+02	80037283C	Eduardo	Marín Roldán	C/ Churruca Nº 5	06906	Puebla del Maestre	Badajoz		620030111	924512335	
394	2016-10-21 12:41:58.491011+02	2016-10-24 10:24:33.714426+02	46540144N	Juan Carlos	Martín Baños	C/ Carolina Coronado Nº 28	06292	Calera de León	Badajoz		620767911	924584119	
395	2016-10-21 12:41:58.56446+02	2016-10-24 10:24:33.722185+02	76246206X	María Dolores	Carrasco Díaz	C/ Carolina Coronado Nº 28	06292	Calera de León	Badajoz		660968225	924584119	
396	2016-10-21 12:41:58.77957+02	2016-10-24 10:24:33.741721+02	79261181F	Pilar	Girol Vázquez	C/ Cerro de la Fuente Nº 5	06260	Monesterio	Badajoz		656272072		
397	2016-10-21 12:41:58.869743+02	2016-10-24 10:24:33.749581+02	80055755T	Urbano	Martínez Infante	C/ Cerro de la Fuente Nº 5	06260	Monesterio	Badajoz		616327372		
398	2016-10-21 12:41:59.043672+02	2016-10-24 10:24:33.769182+02	34773295D	José Antonio	Matamoros Rodríguez	C/ Puebla Nº 52	06907	Montemolín	Badajoz		690830404	924511126	
399	2016-10-21 12:41:59.117776+02	2016-10-24 10:24:33.776917+02	34780153J	Milagros	Vázquez Indiano	C/ Puebla Nº 52	06907	Montemolín	Badajoz		646573183	924511126	
400	2016-10-21 12:41:59.283743+02	2016-10-24 10:24:33.796552+02	80037073V	Eugenio	Mateos Gata	C/ Espronceda Nº 12	06292	Calera de León	Badajoz		648511386		
401	2016-10-21 12:41:59.356465+02	2016-10-24 10:24:33.804297+02	80040043C	Carmen	Díaz Trenado	C/ Espronceda Nº 12	06292	Calera de León	Badajoz		608620569		
402	2016-10-21 12:41:59.524132+02	2016-10-24 10:24:33.823867+02	34781986Y	Manuel José	Mateos Pagador	C/ Tentudia Nº 51	06260	Monesterio	Badajoz		635464216		
403	2016-10-21 12:41:59.59675+02	2016-10-24 10:24:33.831669+02	80055626D	Antonia	García Pacheco	C/ Tentudia Nº 51	06260	Monesterio	Badajoz		654159563	924517205	
404	2016-10-21 12:41:59.763498+02	2016-10-24 10:24:33.852152+02	33972973	Antonio	Matito Pecellín	C/ Cerro de la Fuente Nº 14	06260	Monesterio	Badajoz		690388006		
406	2016-10-21 12:42:00.03651+02	2016-10-24 10:24:33.879591+02	33972973H	Antonio	Matitos Pecellín		06260	Monesterio	Badajoz		690328006		
405	2016-10-21 12:41:59.836749+02	2016-10-24 10:24:33.88625+02	76246230B	Antonia María	Garrón Chávez	C/ Cerro de la Fuente Nº 14	06260	Monesterio	Badajoz		650063403	924517156	
407	2016-10-21 12:42:00.271019+02	2016-10-24 10:24:33.903331+02	8813376Y	Ángel	Megías Artero	C/ Avda del Parque Nº 42	06292	Calera de León	Badajoz		680593318	924584246	
408	2016-10-21 12:42:00.446883+02	2016-10-24 10:24:33.921773+02	34776968W	José Antonio	Megías Artero	C/ Núñez de Balboa Nº 4	06290	Calera de León	Badajoz				
409	2016-10-21 12:42:00.522051+02	2016-10-24 10:24:33.929188+02	76251820N	Concepción	Fernández Albujar	C/ Núñez de Balboa Nº 4	06290	Calera de León	Badajoz		637283554	924584063	
411	2016-10-21 12:42:00.760945+02	2016-10-24 10:24:33.971863+02	76246554J	Francisco	Megías Gómez	C/ Barrio de la Cruz Nº 106	06260	Monesterio	Badajoz		687422885	924516603	
410	2016-10-21 12:42:00.688372+02	2016-10-24 10:24:33.979169+02	80055749V	Faustina	Garrote Chaves	C/ Barrio de la Cruz Nº 106	06260	Monesterio	Badajoz		665509659	924516603	
413	2016-10-21 12:42:01.07455+02	2016-10-24 10:24:34.003335+02	76246317Y	María del Carmen	Guerrero Sayago	C/ Endrinales Portal 7 1ºA Nº	06260	Monesterio	Badajoz		605979330		
414	2016-10-21 12:42:01.238771+02	2016-10-24 10:24:34.020639+02	52691005Y	Isidora	Neguillo Ortega	C/ Elías Torres Nº 4	06260	Monesterio	Badajoz		665617121		
415	2016-10-21 12:42:01.31181+02	2016-10-24 10:24:34.027803+02	27321174A	Francisco José	Megías Uceda	C/ Sindicatos Nº 6	41000	Monesterio	Sevilla		678964625		
416	2016-10-21 12:42:01.509184+02	2016-10-24 10:24:34.044958+02	28764958P	María	Pecellín Contreras	C/ Dolores Ibarruri Nº 2	06260	Monesterio	Badajoz		665911724	670283087	
417	2016-10-21 12:42:01.599045+02	2016-10-24 10:24:34.052162+02	80055885S	Pedro	Megías Terrón	C/ Dolores Ibarruri Nº 2	06260	Monesterio	Badajoz		670283087	924516436	
418	2016-10-21 12:42:01.798161+02	2016-10-24 10:24:34.068939+02	76246320D	Julia	Sánchez Lancharro	C/ Dolores Ibarruri Nº 12	06260	Monesterio	Badajoz		652067968	670283083	
419	2016-10-21 12:42:01.871868+02	2016-10-24 10:24:34.076685+02	76246350Q	Francisco	Megías Terrón	C/ Dolores Ibarruri Nº 12	06260	Monesterio	Badajoz		670283083	924516426	
420	2016-10-21 12:42:02.07471+02	2016-10-24 10:24:34.129133+02	76251898K	María Felisa	Valverde Moya	C/ Eduardo Acosta Nº 11	06292	Calera de León	Badajoz		616328977	924584011	
422	2016-10-21 12:42:02.391636+02	2016-10-24 10:24:34.154326+02	76251887X	Clara	Lancharro Campanario	C/ San Blas Nº 11	06291	Montemolín	Badajoz		690831482		
425	2016-10-21 12:42:02.704266+02	2016-10-24 10:24:34.215325+02	76246419Q	Rocío	Nogués Chaves	C/ Zurbarán Nº 23	06260	Monesterio	Badajoz		617456337	924517244	
427	2016-10-21 12:42:03.161993+02	2016-10-24 10:24:34.243119+02	76252454W	Montserrat	Galván Rubio		06906	Puebla del Maestre	Badajoz		686027310		
10	2016-10-21 12:41:06.265953+02	2016-10-24 10:24:27.398087+02	44429613F	Rosa María	Méndez Rodríguez	C/ Las Espeñas Nº 12 P 13	06260	Monesterio	Badajoz		649892883	924516675	
25	2016-10-21 12:41:08.241364+02	2016-10-24 10:24:27.613672+02	26041211J	Laura Belén	Moral Vico	C/ Las Linas Nº 8	06260	Monesterio	Badajoz		619294316		
38	2016-10-21 12:41:09.92216+02	2016-10-24 10:24:27.865782+02	80043340M	Carmen	Miranda Girol	C/ Pozos Nº 25	06260	Monesterio	Badajoz		663993001	924516425	
89	2016-10-21 12:41:17.028126+02	2016-10-24 10:24:28.762034+02	80040044K	Joaquina	Miranda Santana	C/ Ntra. Sra. De los Dolores Nº 35	06292	Calera de León	Badajoz		662007994	924584139	
108	2016-10-21 12:41:19.579606+02	2016-10-24 10:24:29.072682+02	28914187J	Isabel María	Morales Artero	C/ Juan Carlos I Nº 2	06292	Calera de León	Badajoz		692583277	924584184	
276	2016-10-21 12:41:42.168758+02	2016-10-24 10:24:31.740555+02	80055915E	María Julia	Monjo Monjo	C/ Cabarco Nº 8	06260	Monesterio	Badajoz		691113575	689297214	
319	2016-10-21 12:41:48.036859+02	2016-10-24 10:24:32.437955+02	52269820C	Mercedes	Morato Burgos	C/ Elías Torres Nº 26	06260	Monesterio	Badajoz		600427845		
412	2016-10-21 12:42:01.001541+02	2016-10-24 10:24:33.996133+02	33971945W	Robustiano	Mejías Vargas	C/ Endrinales Portal 7 1ºA Nº	06260	Monesterio	Badajoz		605348227		
421	2016-10-21 12:42:02.149223+02	2016-10-24 10:24:34.136541+02	8813375M	José Antonio	Méndez Artero	C/ Eduardo Acosta Nº 11	06292	Calera de León	Badajoz		608253172	924584011	
423	2016-10-21 12:42:02.46635+02	2016-10-24 10:24:34.162156+02	8830143Y	Francisco José	Mendo Romero	C/ San Blas Nº 11	06291	Montemolín	Badajoz		667610050		
424	2016-10-21 12:42:02.631669+02	2016-10-24 10:24:34.181995+02	7624284L	Manuel	Mestres Naranjo	C/ Zurbarán Nº 23	06260	Monesterio	Badajoz		607298892	924517244	
426	2016-10-21 12:42:02.891526+02	2016-10-24 10:24:34.207495+02	76246284L	Manuel	Mestre Naranjo	C/ Zurbarán Nº 23	06260	Monesterio	Badajoz		607298892	924517244	
428	2016-10-21 12:42:03.248114+02	2016-10-24 10:24:34.251048+02	76251941H	Félix	Molero Arroyo		06906	Puebla del Maestre	Badajoz		620675891		
429	2016-10-21 12:42:03.417055+02	2016-10-24 10:24:34.27087+02	80038121F	Rafaela	Jiménez Castillo	C/ Las Espeñas Nº 4	06260	Monesterio	Badajoz		687014335		
430	2016-10-21 12:42:03.492441+02	2016-10-24 10:24:34.278713+02	8796793Y	Juan	Molina López	C/ Las Espeñas Nº 4	06260	Monesterio	Badajoz		650501053		
431	2016-10-21 12:42:03.659322+02	2016-10-24 10:24:34.298401+02	34778762W	José Antonio	Monjo Santos	C/ Puebla Nº 32	06907	Montemolín	Badajoz		696355054	924511133	
432	2016-10-21 12:42:03.731122+02	2016-10-24 10:24:34.306128+02	76251893Q	María Dolores	Granadero Romero	C/ Puebla Nº 32	06907	Montemolín	Badajoz		606415740	924511133	
434	2016-10-21 12:42:03.971883+02	2016-10-24 10:24:34.353488+02	80055631Z	Julián	Monjo Pagador	C/ Cerro de la Fuente Nº 2	06260	Monesterio	Badajoz		678099877	924516893	
433	2016-10-21 12:42:03.897634+02	2016-10-24 10:24:34.361409+02	48817324P	María José	Murillo Zapata	C/ Cerro de la Fuente Nº 2	06260	Monesterio	Badajoz		600433056	924516893	
80	2016-10-21 12:41:15.810516+02	2016-10-24 10:24:28.614825+02	8792713C	Manuela	Palacios Garrote	C/ Ramón y Cajal Nº 5	06260	Monesterio	Badajoz		660377090	924516872	
135	2016-10-21 12:41:23.159375+02	2016-10-24 10:24:29.509014+02	46667053F	María del Pilar	Moruno Baños	Rda/ Bodonal de la Sierra Nº 120	06260	Monesterio	Badajoz		677095257		
194	2016-10-21 12:41:31.295723+02	2016-10-24 10:24:30.493418+02	33928339G	María de los Ángeles	Muñoz Martínez	C/ Hernán Cortes Nº 1	06906	Puebla del Maestre	Badajoz		628126380	924512331	
202	2016-10-21 12:41:32.279154+02	2016-10-24 10:24:30.593434+02	80037216E	Manuela	Ortiz Candel	C/ Cervantes Nº 1	06907	Montemolín	Badajoz		691643033	924511118	
235	2016-10-21 12:41:36.76059+02	2016-10-24 10:24:31.088787+02	34777797A	María de los Ángeles	Moro Rosales	C/ Montemolin Nº 17	06907	Montemolín	Badajoz		617822159		
250	2016-10-21 12:41:38.724821+02	2016-10-24 10:24:31.334139+02	8805308B	Josefa	Muñiz Jaramillo	C/ Paseo de Extremadura Nº 192	06260	Monesterio	Badajoz		626787752	924516012	
289	2016-10-21 12:41:43.947568+02	2016-10-24 10:24:31.954588+02	80055828G	Sonia	Nogués Chávez	C/ San Pedro Nº 40 P 1º	06260	Monesterio	Badajoz		651916442		
308	2016-10-21 12:41:46.562316+02	2016-10-24 10:24:32.256617+02	76246462J	María del Pilar	Muñoz Real	C/ P. Extremadura Nº 240 P x	06260	Monesterio	Badajoz		636933226	924516092	
17	2016-10-21 12:41:07.190943+02	2016-10-24 10:24:27.501941+02	34776178V	María Dolores	Rebollo Chávez		06260	Monesterio	Badajoz		606581864	924516661	
45	2016-10-21 12:41:10.911928+02	2016-10-24 10:24:27.96914+02	80036910S	Carmen	Peraza Calcatierra	C/ Barrio de la Cruz Nº 36	06260	Monesterio	Badajoz		629126655	924517282	
47	2016-10-21 12:41:11.148149+02	2016-10-24 10:24:28.023588+02	80045038R	Blasa	Ramos Moya	C/ C / Sierra del Castillo Nº 17	06260	Monesterio	Badajoz		677746506		
220	2016-10-21 12:41:34.687702+02	2016-10-24 10:24:30.863368+02	76251868Z	Sacramento	Ramos Jaro	C/ Llerena Nº 17	06291	Montemolín	Badajoz		618451084		
230	2016-10-21 12:41:36.119524+02	2016-10-24 10:24:31.013065+02	80036466P	Salud	Pizarro Lora	C/ Sevilla,9 Nº	06260	Monesterio	Badajoz		645834021	924516007	
291	2016-10-21 12:41:44.231228+02	2016-10-24 10:24:31.980749+02	18236651C	Cristina	Pecellín Sayago	C/ Cerro de la Fuente Nº 9	06260	Monesterio	Badajoz		625323305		
5	2016-10-21 12:41:05.638887+02	2016-10-24 10:24:27.334059+02	28475100L	Reyes	Romero Terrón		06260	Monesterio	Badajoz		616470362	924516669	
41	2016-10-21 12:41:10.359225+02	2016-10-24 10:24:27.916976+02	76246712X	Antonia	Roguera Abril	C/ Calvo Sotelo Nº 50	06906	Puebla del Maestre	Badajoz		620923874	924512310	
53	2016-10-21 12:41:12.001449+02	2016-10-24 10:24:28.120336+02	9204041Q	Antonia	Rodríguez Macarro	C/ Robledillo Nº 2	06260	Monesterio	Badajoz		659401583	924516760	
55	2016-10-21 12:41:12.28191+02	2016-10-24 10:24:28.148348+02	9204041	Antonia	Rodríguez Macarro	C/ Robledillo Nº 2	06260	Monesterio	Badajoz		659401583	924516760	
56	2016-10-21 12:41:12.456374+02	2016-10-24 10:24:28.195869+02	34038994Y	Dolores María	Rubio Lora	C/ Rosa de Luxemburgo Nº 12	06260	Monesterio	Badajoz		617743061		
3	2016-10-21 12:40:57.458936+02	2016-10-24 10:24:27.307464+02	8846363B	María José	Santana Lancharro	C/ Barriada las Reliquias Nº 18	06906	Puebla del Maestre	Badajoz		653463029		
11	2016-10-21 12:41:06.459554+02	2016-10-24 10:24:27.41802+02	76246562K	Begoña	Sánchez Núñez	C/ Rosa de Luxemburgo Nº 9	06260	Monesterio	Badajoz		647933915	924516298	
83	2016-10-21 12:41:16.131298+02	2016-10-24 10:24:28.650477+02	76246319P	Manuela	Sánchez Tomillo	C/ Cañuelo Nº 41	06260	Monesterio	Badajoz		619445526	924516829	
84	2016-10-21 12:41:16.310853+02	2016-10-24 10:24:28.670243+02	28726959M	Daniela	Sánchez Villalba	C/ La Noria Nº 30	06260	Monesterio	Badajoz		653956147	924517048	
19	2016-10-21 12:41:07.43403+02	2016-10-24 10:24:27.529954+02	80055493Z	María Concepción	Vila Lobón	Pso/ Extremadura Nº 255	06260	Monesterio	Badajoz		665828948	924518146	
86	2016-10-21 12:41:16.615984+02	2016-10-24 10:24:28.734182+02	76246337A	Dolores	Vasco Garrón	C/ Sierra de la Cruz, 3 Nº	06260	Monesterio	Badajoz		665783689		
118	2016-10-21 12:41:20.86341+02	2016-10-24 10:24:29.219969+02	8884519X	María José	Velázquez Vázquez	C/ Río Viar Nº 23 P 2B	06260	Monesterio	Badajoz		640274932		
152	2016-10-21 12:41:25.714535+02	2016-10-24 10:24:29.83854+02	76246223G	María Dolores	Zapata Cubero	C/ Pedro de Valdivia Nº 13	06292	Calera de León	Badajoz		638515299	924584262	
175	2016-10-21 12:41:28.740239+02	2016-10-24 10:24:30.230704+02	80044330Y	Antonia	Zambrano Toribio	C/ La Noria Nº 37	06260	Monesterio	Badajoz		638553756	924517215	
186	2016-10-21 12:41:30.275275+02	2016-10-24 10:24:30.389976+02	28719832P	María del Carmen	Vaz Geraldes	C/ Fuente Nº 3	06908	Montemolín	Badajoz		610443489	924511866	
190	2016-10-21 12:41:30.751412+02	2016-10-24 10:24:30.445779+02	76246371Z	Clara Isabel	Villalba Ambrona	C/ Rafael Alberti Nº 10	06260	Monesterio	Badajoz		658107432	924516307	
435	2016-10-21 12:42:04.213989+02	2016-10-24 10:24:34.382117+02	76246535V	Antonia	López Delgado	C/ Juan Pablo II Nº 30	06260	Monesterio	Badajoz		646491105	924516464	
436	2016-10-21 12:42:04.291151+02	2016-10-24 10:24:34.390095+02	79263084R	Francisco	Mora Sánchez	C/ Juan Pablo II Nº 30	06260	Monesterio	Badajoz		679345239	924516464	
437	2016-10-21 12:42:04.49665+02	2016-10-24 10:24:34.410631+02	48881132Z	Eva María	Pavón Oliva	C/ Río Culebrín Nº 26	06260	Monesterio	Badajoz		697409727		
438	2016-10-21 12:42:04.591781+02	2016-10-24 10:24:34.420155+02	29042890P	Juan Antonio	Morillo Morales	C/ Río Culebrín Nº 26	06260	Monesterio	Badajoz		697403137		
439	2016-10-21 12:42:04.777124+02	2016-10-24 10:24:34.445112+02	80055404V	Begoña	Iglesias Diéguez	C/ Los Cotos Nº 13	06260	Monesterio	Badajoz		619657789		
440	2016-10-21 12:42:04.848932+02	2016-10-24 10:24:34.454635+02	9185895V	Pedro Manuel	Morón Aranda	C/ Los Cotos Nº 13	06260	Monesterio	Badajoz		629477285		
441	2016-10-21 12:42:05.014349+02	2016-10-24 10:24:34.478782+02	28492833L	María Josefa	Romero Montero	C/ Doctor Fleming Nº 43	06260	El Real de la Jara	Sevilla		662216889		
442	2016-10-21 12:42:05.179547+02	2016-10-24 10:24:34.533401+02	76246660G	Antonia	Delgado Fernández	C/ Fuentes Nº 13	06908	Montemolín	Badajoz		659790912		
443	2016-10-21 12:42:05.252239+02	2016-10-24 10:24:34.541336+02	80037175G	Manuel	Murillo Carrasco	C/ Fuentes Nº 13	06908	Montemolín	Badajoz		680689448		
444	2016-10-21 12:42:05.498276+02	2016-10-24 10:24:34.561513+02	76246360A	Encarnación	Calderón Zambrano	Pso/ Extremadura Nº 258	06260	Monesterio	Badajoz		625708235		
445	2016-10-21 12:42:05.57045+02	2016-10-24 10:24:34.56944+02	33940364T	Carlos	Naranjo Villaseñor	Pso/ Extremadura Nº 258	06260	Monesterio	Badajoz		625264033		
446	2016-10-21 12:42:05.736765+02	2016-10-24 10:24:34.58955+02	33940364	Carlos	Naranjo Villaseñor	C/ Paseo de Extremadura, 258 Nº	06260	Monesterio	Badajoz		625264033	924517300	
447	2016-10-21 12:42:05.827149+02	2016-10-24 10:24:34.597456+02	76246360	Encarni	Calderón Zambrano	C/ Paseo de Extremadura, 258 Nº	06260	Monesterio	Badajoz		625708235	924517300	
448	2016-10-21 12:42:06.042609+02	2016-10-24 10:24:34.617294+02	76246466V	María José	Delgado Sánchez	C/ Barrio de la Cruz Nº 66	06260	Monesterio	Badajoz		635748216		
449	2016-10-21 12:42:06.13328+02	2016-10-24 10:24:34.62507+02	33972971Q	Juan	Naranjo Paloma	C/ Barrio de la Cruz Nº 66	06260	Monesterio	Badajoz		630794671		
450	2016-10-21 12:42:06.308095+02	2016-10-24 10:24:34.645136+02	80055524E	Inmaculada	Mejías Gómez	C/ Concha Espina Nº 7	06260	Monesterio	Badajoz		636601245		
451	2016-10-21 12:42:06.381072+02	2016-10-24 10:24:34.653289+02	52221859Z	Francisco José	Naranjo Paloma	C/ Concha Espina Nº 7	06260	Monesterio	Badajoz		699769538		
452	2016-10-21 12:42:06.546461+02	2016-10-24 10:24:34.673473+02	28749326Q	Antonio	Navarro Núñez	C/ Tierno Galván Nº 21	06260	Monesterio	Badajoz		643369142		
453	2016-10-21 12:42:06.619258+02	2016-10-24 10:24:34.681467+02	80055571T	Ana	Rodríguez Barroso	C/ Tierno Galván Nº 21	06260	Monesterio	Badajoz		643369142		
454	2016-10-21 12:42:06.783094+02	2016-10-24 10:24:34.70173+02	27310230F	Rosario	Domínguez Pequenis	C/ Doctor Alarcón Nº 11	06260	Monesterio	Badajoz		670473376	924516351	
455	2016-10-21 12:42:06.855875+02	2016-10-24 10:24:34.709691+02	28711882Q	Fructuoso	Nogués Chávez	C/ Doctor Alarcón Nº 11	06260	Monesterio	Badajoz		647247704	630280024	
456	2016-10-21 12:42:07.02346+02	2016-10-24 10:24:34.758465+02	28831621V	María del Rosario	Ramos Pérez	C/ Libertad Nº 75	06260	Monesterio	Badajoz		678084445		
457	2016-10-21 12:42:07.096032+02	2016-10-24 10:24:34.76653+02	28818156F	José Julián	Núñez Vargas	C/ Libertad Nº 75	06260	Monesterio	Badajoz		674334070		
458	2016-10-21 12:42:07.365295+02	2016-10-24 10:24:34.786744+02	76246191H	María Dolores	González Megías	C/ Pedro de Valdivia Nº 10	06292	Calera de León	Badajoz		646165315	924584208	
459	2016-10-21 12:42:07.453215+02	2016-10-24 10:24:34.794758+02	80037013A	Manuel	Oliva Cantillo	C/ Pedro de Valdivia Nº 10	06292	Calera de León	Badajoz		646165315	924584208	
460	2016-10-21 12:42:07.653782+02	2016-10-24 10:24:34.81521+02	76246266R	José Carlos	Oliva García	C/ 1º Mayo Nº 12 P 1ºD	06260	Monesterio	Badajoz		618742018	924516036	
461	2016-10-21 12:42:07.733347+02	2016-10-24 10:24:34.823212+02	9185770F	María Ángeles	Mayoral Valencia	C/ 1º Mayo Nº 12 P 1ºD	06260	Monesterio	Badajoz		676966817		
462	2016-10-21 12:42:07.898246+02	2016-10-24 10:24:34.843054+02	76246219T	Sofía	Trenado Chávez	C/ Bravo Murillo Nº 13	06292	Calera de León	Badajoz				
463	2016-10-21 12:42:07.972586+02	2016-10-24 10:24:34.850989+02	80037063F	José	Oliva Cantillo	C/ Bravo Murillo Nº 13	06292	Calera de León	Badajoz		676937836	924584001	
464	2016-10-21 12:42:08.137763+02	2016-10-24 10:24:34.87076+02	124193	Lacramioara-Lenuta	Onel 	C/ Paseo de Extremadura-305. Portal-2 Nº 303 E 3 P 1B	06260	Monesterio	Badajoz		699206253		
465	2016-10-21 12:42:08.210237+02	2016-10-24 10:24:34.878741+02	261246	Claudiu-Cristian	Onel 	C/ Paseo de Extremadura-305. Portal-2 Nº 303 E 3 P 1B	06260	Monesterio	Badajoz		642832185		
466	2016-10-21 12:42:08.375042+02	2016-10-24 10:24:34.896552+02	6480640E	Robinson	Orejuela Donneys	C/ Era de Don Pedro Nº 3	06260	Monesterio	Badajoz		626623209		
467	2016-10-21 12:42:08.449503+02	2016-10-24 10:24:34.904387+02	3811507Q	Sandra Milena	Solozano Marquin	C/ Era de Don Pedro Nº 3	06260	Monesterio	Badajoz		693584254		
468	2016-10-21 12:42:08.614409+02	2016-10-24 10:24:34.924388+02	76246434P	María José	Calderón Matitos	C/ 1º de Mayo Nº 31	06260	Monesterio	Badajoz		617220025	924517093	
469	2016-10-21 12:42:08.688155+02	2016-10-24 10:24:34.932206+02	76246514L	Diego	Pacheco Cardoso	C/ 1º de Mayo Nº 31	06260	Monesterio	Badajoz		627431718	924431718	
470	2016-10-21 12:42:08.927796+02	2016-10-24 10:24:34.952069+02	80055396D	María José	Areses Fernández	C/ Vicente Alexandre Nº 4	06260	Monesterio	Badajoz		616185472	924516835	
471	2016-10-21 12:42:09.01934+02	2016-10-24 10:24:34.959997+02	80055479T	Salvador	Pagador González	C/ Vicente Alexandre Nº 4	06260	Monesterio	Badajoz		650441028	924516835	
472	2016-10-21 12:42:09.219012+02	2016-10-24 10:24:34.979972+02	37638895Q	José	Pallero Villa	C/ Pozos Nº 42	06260	Monesterio	Badajoz		678080003	924516360	
473	2016-10-21 12:42:09.293798+02	2016-10-24 10:24:34.987744+02	37726103P	Rosario	Carrasco Paloma	C/ Pozos Nº 42	06260	Monesterio	Badajoz		685379178	924516360	
474	2016-10-21 12:42:09.46129+02	2016-10-24 10:24:35.007567+02	44777069W	José Carlos	Palomo Sánchez	C/ Tierno Galván Nº 33	06260	Monesterio	Badajoz		647933434	924113126	
475	2016-10-21 12:42:09.534835+02	2016-10-24 10:24:35.015373+02	53272136L	María Isabel	Pelayo Rodríguez	C/ Tierno Galván Nº 33	06260	Monesterio	Badajoz		627730682	924113126	
476	2016-10-21 12:42:09.702805+02	2016-10-24 10:24:35.036771+02	52220711Q	Manuel	Paniagua Baños	C/ Eugenio Hermoso Nº 4	06292	Calera de León	Badajoz		616338078	924584004	
477	2016-10-21 12:42:09.776986+02	2016-10-24 10:24:35.045182+02	76251787W	Ana María	Blanco Gómez	C/ Eugenio Hermoso Nº 4	06292	Calera de León	Badajoz		620707319	924584004	
478	2016-10-21 12:42:09.94368+02	2016-10-24 10:24:35.092898+02	52220712V	José Luis	Paniagua Baños	C/ Eugenio Hermoso Nº 4	06292	Calera de León	Badajoz		646859968	924584208	
479	2016-10-21 12:42:10.01798+02	2016-10-24 10:24:35.10074+02	76246192L	Gloria	González Mejías	C/  Pedro de Valdivía Nº 10	06292	Calera de León	Badajoz		683150662	924584208	
480	2016-10-21 12:42:10.270409+02	2016-10-24 10:24:35.120473+02	34780386Q	María del Carmen	Cubero Rubio	C/ Endrinales Nº 1 P 1ºB	06260	Monesterio	Badajoz		695896132	924517343	
481	2016-10-21 12:42:10.363439+02	2016-10-24 10:24:35.128231+02	76246418S	Gerónimo	Parra Garrote	C/ Endrinales Nº 1 P 1ºB	06260	Monesterio	Badajoz		652156561	924517343	
482	2016-10-21 12:42:10.571034+02	2016-10-24 10:24:35.148023+02	28757880X	María del Carmen	Sánchez Hermoso	C/ Bovedo, 10 1º B Nº	06260	Monesterio	Badajoz		685819962	924517167	
483	2016-10-21 12:42:10.659045+02	2016-10-24 10:24:35.155921+02	80036882X	Antonio	Parra Garrote	C/ Bovedo, 10 1º B Nº	06260	Monesterio	Badajoz		685034175	924517167	
485	2016-10-21 12:42:10.904355+02	2016-10-24 10:24:35.18381+02	28710808T	Antonio	Pavón De la Cruz	C/ Endrinales Nº 1 P 2ºB	06260	Monesterio	Badajoz		639647438		
484	2016-10-21 12:42:10.829984+02	2016-10-24 10:24:35.203635+02	28586636M	Corazón de María	Nogués Chaves	C/ Endrinales Nº 1 P 2ºB	06260	Monesterio	Badajoz		639647438		
486	2016-10-21 12:42:11.126863+02	2016-10-24 10:24:35.223686+02	8812957R	Santiago	Paz Castro	C/ Tentudia Nº 47 P 1º	06260	Monesterio	Badajoz		686957312	924516846	
487	2016-10-21 12:42:11.200179+02	2016-10-24 10:24:35.231764+02	76246431M	Antonia	Pecellín Sayago	C/ Tentudía, 47 Nº	06260	Monesterio	Badajoz		686957312	924516846	
488	2016-10-21 12:42:11.366866+02	2016-10-24 10:24:35.251988+02	33977363S	Manuel	Pecellín Pecellín	C/ Pizarra Nº 46	06291	Montemolín	Badajoz		649829626	924510267	
489	2016-10-21 12:42:11.439879+02	2016-10-24 10:24:35.259941+02	33973657N	Josefa	Jaro Arencon	C/ Pizarra Nº 46	06291	Montemolín	Badajoz		678204319		
490	2016-10-21 12:42:11.608315+02	2016-10-24 10:24:35.280119+02	76246401K	Concepción	Martínez Villalba	C/ Santa Ana Nº 22	06260	Monesterio	Badajoz		609974503	924516308	
491	2016-10-21 12:42:11.687176+02	2016-10-24 10:24:35.287998+02	80036909Z	José	Pecellín Cardoso	C/ Santa Ana Nº 22	06260	Monesterio	Badajoz		609974503	924524218	
492	2016-10-21 12:42:11.89583+02	2016-10-24 10:24:35.308213+02	28590373Q	María del Mar	Nogués Gómez	C/ Avda. Portugal Nº 18	06260	Monesterio	Badajoz		636547092	954517337	
493	2016-10-21 12:42:11.992525+02	2016-10-24 10:24:35.316079+02	80036897W	José Antonio	Pecellín Duqueso	C/ Avda. Portugal Nº 18	06260	Monesterio	Badajoz		618733988	924517337	
494	2016-10-21 12:42:12.180867+02	2016-10-24 10:24:35.336028+02	11400835B	José Antonio	Pecellín Garrote	C/ Margarita Nelken Nº 3	06260	Monesterio	Badajoz			924518007	
495	2016-10-21 12:42:12.255807+02	2016-10-24 10:24:35.343916+02	11412303W	Yolanda	Sánchez Gutiérrez	C/ Margarita Nelken Nº 3	06260	Monesterio	Badajoz		664171702	924518007	
496	2016-10-21 12:42:12.422711+02	2016-10-24 10:24:35.363915+02	80055907Z	María Lourdes	Sánchez Pecellín	Avda/ Portugal Nº 26	06260	Monesterio	Badajoz		654237553		
497	2016-10-21 12:42:12.496238+02	2016-10-24 10:24:35.371891+02	27317170R	Antonio	Perera Vázquez	Avda/ Portugal Nº 26	06260	Monesterio	Badajoz		620832426		
498	2016-10-21 12:42:12.664919+02	2016-10-24 10:24:35.391616+02	44775149Z	José Manuel	Pérez González	C/ Vasco Núñez Nº 3	06260	Monesterio	Badajoz		619213813	924517043	
499	2016-10-21 12:42:12.739122+02	2016-10-24 10:24:35.399486+02	80055427V	Isabel	Sánchez Villalba	C/ Vasco Núñez Nº 3	06260	Monesterio	Badajoz		653679659	924516763	
500	2016-10-21 12:42:12.908221+02	2016-10-24 10:24:35.419574+02	8884517P	Josefa	Vargas Villalba								
501	2016-10-21 12:42:12.98367+02	2016-10-24 10:24:35.427599+02	28640048B	Raúl	Pérez Romero								
502	2016-10-21 12:42:13.155334+02	2016-10-24 10:24:35.44738+02	33975517D	Antonio	Pérez-Carrasco Pulido	C/ Cerezo Nº 20	06260	Monesterio	Badajoz		658873376	924516171	
503	2016-10-21 12:42:13.247722+02	2016-10-24 10:24:35.455284+02	80045235Z	Concepción	Gómez Albarrán	C/ Cerezo Nº 20	06260	Monesterio	Badajoz		658873377	924516171	
504	2016-10-21 12:42:13.465656+02	2016-10-24 10:24:35.500812+02	34776023T	José Carlos	Pizarro Lora	C/ Río Culebrin Nº 6	06260	Monesterio	Badajoz		630860786	924516865	
505	2016-10-21 12:42:13.55572+02	2016-10-24 10:24:35.508583+02	76246533S	Remedios	Delgado Ruiz	C/ Río Culebrin Nº 6	06260	Monesterio	Badajoz		649651513		
506	2016-10-21 12:42:13.805725+02	2016-10-24 10:24:35.528968+02	80037993V	María del Carmen	Girol Díaz		06906	Puebla del Maestre	Badajoz		619759758	924512017	
507	2016-10-21 12:42:13.879677+02	2016-10-24 10:24:35.538631+02	8801508Y	Manuel	Pizarro Mateos	C/ Las Reliquias Nº 30	06906	Puebla del Maestre	Badajoz		636645179	924512017	
508	2016-10-21 12:42:14.048291+02	2016-10-24 10:24:35.563259+02	28715664A	Carmen María	Roldán Villalba	C/ Cervantes Nº 5	06906	Puebla del Maestre	Badajoz		645181842	924512143	
509	2016-10-21 12:42:14.121533+02	2016-10-24 10:24:35.572781+02	9184524A	Juan	Pizarro Calderón	C/ Cervantes Nº 5	06906	Puebla del Maestre	Badajoz		689708827	924512143	
510	2016-10-21 12:42:14.288673+02	2016-10-24 10:24:35.596838+02	30207987V	David	Pulgarín González	C/ Tierno Galván Nº 9	06260	Monesterio	Badajoz		637988668		
511	2016-10-21 12:42:14.363125+02	2016-10-24 10:24:35.606327+02	30212247E	Dolores	Caballero Gómez	C/ Tierno Galván Nº 9	06260	Monesterio	Badajoz		658204311		
512	2016-10-21 12:42:14.529224+02	2016-10-24 10:24:35.629911+02	1742314H	Francisco Alfonso	Pulice 								
513	2016-10-21 12:42:14.604643+02	2016-10-24 10:24:35.659617+02	80055778T	María Teresa	Barbecho Durán	C/ Pablo Iglesias Nº 30	06260	Monesterio	Badajoz		605014935		
514	2016-10-21 12:42:14.829348+02	2016-10-24 10:24:35.667287+02	X1742314H	Francisco Alfonso	Pulice 	C/ Pablo Iglesias Nº 30	06260	Monesterio	Badajoz		658975798		
516	2016-10-21 12:42:15.112817+02	2016-10-24 10:24:35.711915+02	33975530E	Antonio	Quintero Cubero	C/ Paseo de Extremadura Nº 171 P 1º	06260	Monesterio	Badajoz		628593763	924516645	
515	2016-10-21 12:42:15.034373+02	2016-10-24 10:24:35.719705+02	28946216A	Luisa María	Chávez Vázquez	C/ Paseo de Extremadura Nº 171 P 1º	06260	Monesterio	Badajoz		680644163	924516645	
517	2016-10-21 12:42:15.352756+02	2016-10-24 10:24:35.739357+02	34780331F	Josefa	Garrón Torrado	C/ Torrecilla Nº 28	06260	Monesterio	Badajoz		667361768	924517299	
518	2016-10-21 12:42:15.427511+02	2016-10-24 10:24:35.747145+02	34775132Y	José Antonio	Ramayo Calderón	C/ Torrecilla Nº 28	06260	Monesterio	Badajoz		635974468	924517299	
519	2016-10-21 12:42:15.598716+02	2016-10-24 10:24:35.766859+02	34780384Z	Joaquín	Rebollo Balsera	C/ Nuestra Señora de los Dolores Nº 30	06290	Calera de León	Badajoz		667438705	924113138	
520	2016-10-21 12:42:15.672544+02	2016-10-24 10:24:35.774596+02	44178778X	María Purificación	Cubero Mejías	C/ Nuestra Señora de los Dolores Nº 30	06290	Calera de León	Badajoz		610831925	924113138	
521	2016-10-21 12:42:15.841519+02	2016-10-24 10:24:35.797033+02	34781644D	Félix	Reyes Guareño	C/ Cerro de la Fuente Nº 12	06260	Monesterio	Badajoz		675735498	924517072	
522	2016-10-21 12:42:15.9154+02	2016-10-24 10:24:35.805029+02	52692312W	Paula	Calcatierra Sánchez	C/ Cerro de la Fuente Nº 12	06260	Monesterio	Badajoz		675957882	924517072	
523	2016-10-21 12:42:16.090917+02	2016-10-24 10:24:35.825002+02	34778736E	Joaquín	Reyes Guareño	C/ Barrio de la Cruz Nº 128	06260	Monesterio	Badajoz		675255799		
524	2016-10-21 12:42:16.183927+02	2016-10-24 10:24:35.832914+02	76246338G	Ana María	Chaves Lancharro	C/ Barrio de la Cruz Nº 128	06260	Monesterio	Badajoz		645822413		
525	2016-10-21 12:42:16.39483+02	2016-10-24 10:24:35.853125+02	27322306P	Carmen	Domínguez Flores	C/ Zurbarán Nº 30	06906	Montemolín	Badajoz		607749350	606732211	
526	2016-10-21 12:42:16.486673+02	2016-10-24 10:24:35.861125+02	76251938S	Andrés	Reyes Álvarez	C/ Zurbarán Nº 30	06906	Montemolín	Badajoz		606732211	607749350	
527	2016-10-21 12:42:16.665423+02	2016-10-24 10:24:35.881307+02	8884500Z	Montserrat	Carballar Galán	C/ Tentudía Nº 43 P 1	06260	Monesterio	Badajoz		655266285	924516700	
528	2016-10-21 12:42:16.739666+02	2016-10-24 10:24:35.889337+02	8884642H	Jesús	Robledo González	C/ Tentudía Nº 43 P 1	06260	Monesterio	Badajoz		615333184	924516700	
529	2016-10-21 12:42:16.908597+02	2016-10-24 10:24:35.909142+02	80055486F	Eva María	Bautista Chavero	C/ Puerto Encinillas Nº 4	06260	Monesterio	Badajoz		636099735	924518162	
530	2016-10-21 12:42:16.984198+02	2016-10-24 10:24:35.917061+02	28904504J	Manuel	Robles Ferrera	C/ Puerto Encinillas Nº 4	06260	Monesterio	Badajoz		630525626	924518162	
531	2016-10-21 12:42:17.152628+02	2016-10-24 10:24:35.936931+02	34007136A	Loreto Inmaculada	De la Vega Sánchez	C/ Barrio de la Cruz Nº 24	06260	Monesterio	Badajoz		615517134	924516019	
532	2016-10-21 12:42:17.22667+02	2016-10-24 10:24:35.944743+02	44041274T	José Ignacio	Rodríguez Para	C/ Barrio de la Cruz Nº 24	06260	Monesterio	Badajoz		686073462		
533	2016-10-21 12:42:17.396891+02	2016-10-24 10:24:35.964787+02	34778442G	Francisco	Rodríguez Vázquez	C/ Llerena Nº 42	06291	Montemolín	Badajoz		619385437	924510037	
534	2016-10-21 12:42:17.471077+02	2016-10-24 10:24:35.972743+02	34780418W	Silvia	López Galván	C/ Llerena Nº 42	06291	Montemolín	Badajoz		686249052		
535	2016-10-21 12:42:17.666982+02	2016-10-24 10:24:35.99253+02	76246482X	Manuela	Martínez Suárez	C/ Tentudia Nº 32	06260	Monesterio	Badajoz		615180287		
536	2016-10-21 12:42:17.762468+02	2016-10-24 10:24:36.000368+02	76246451W	Lorenzo	Rodríguez Garrote	C/ C / Tentudía Nº 32	06260	Monesterio	Badajoz		690991835		
537	2016-10-21 12:42:17.964168+02	2016-10-24 10:24:36.020131+02	53346123S	Ana	Nieto Benítez	C/ Eduardo Acosta Nº 22	06290	Calera de León	Badajoz		672090422	924241933	
538	2016-10-21 12:42:18.038946+02	2016-10-24 10:24:36.027907+02	28717004D	Antonio	Rodríguez Nieto	C/ Eduardo Acosta Nº 30	06290	Calera de León	Badajoz		664652784		
539	2016-10-21 12:42:18.207039+02	2016-10-24 10:24:36.047665+02	76246664P	María del Monte	Quinta Vasco	C/ Zurbarán Nº 17	06908	Montemolín	Badajoz		638751064	924511869	
540	2016-10-21 12:42:18.283821+02	2016-10-24 10:24:36.055555+02	80037173W	Braulio	Rodríguez Cano	C/ Zurbarán Nº 17	06908	Montemolín	Badajoz			924511869	
541	2016-10-21 12:42:18.45216+02	2016-10-24 10:24:36.075315+02	76246336W	Francisca	Chaves García	C/ Ronda Bodonal de la Sierra Nº 48	06260	Monesterio	Badajoz		649317671	924516417	
542	2016-10-21 12:42:18.52683+02	2016-10-24 10:24:36.083177+02	80042149X	José Antonio	Romero Megías	C/ Ronda Bodonal de la Sierra Nº 48	06260	Monesterio	Badajoz		619847987		
543	2016-10-21 12:42:18.695728+02	2016-10-24 10:24:36.130919+02	34779469L	Juan Antonio	Rubio Moya	Bda/ Las Reliquias Nº 22	06906	Puebla del Maestre	Badajoz		619589423	924512347	
544	2016-10-21 12:42:18.769257+02	2016-10-24 10:24:36.138672+02	34780474N	María Victoria	Navarro Cortés	Bda/ Las Reliquias Nº 22	06906	Puebla del Maestre	Badajoz		616781182		
545	2016-10-21 12:42:19.022681+02	2016-10-24 10:24:36.156337+02	28698340K	Manuel	Rufo Gómez		06260	Monesterio	Badajoz		677267529		
546	2016-10-21 12:42:19.113875+02	2016-10-24 10:24:36.164168+02	76346363Y	Ángela	Calderón Zambrano	C/ De la Radio Nº 7	06260	Monesterio	Badajoz		627787625		
547	2016-10-21 12:42:19.329397+02	2016-10-24 10:24:36.183911+02	Y3048054Q	Fátima Da Conceicao	Ruivo Robles Rita	C/ Finca el Romeral Nº	06260	Monesterio	Badajoz		603670879		
548	2016-10-21 12:42:19.416685+02	2016-10-24 10:24:36.19173+02	Y2904292G	Antonio	Rita Pula Domínguez	C/ Finca el Romeral Nº	06260	Monesterio	Badajoz		603670879		
549	2016-10-21 12:42:19.583694+02	2016-10-24 10:24:36.211999+02	47503287F	Francisco	Ruiz Torrelosa	C/ Barrio de la Cruz Nº 1	06260	Monesterio	Badajoz		633721773		
550	2016-10-21 12:42:19.65788+02	2016-10-24 10:24:36.219816+02	47500816C	Beatriz	Puentenueva Falcón	C/ Barrio de la Cruz Nº 1	06260	Monesterio	Badajoz		633721773		
551	2016-10-21 12:42:19.825899+02	2016-10-24 10:24:36.239793+02	28764497F	Manuel	Sabido Ríos	C/ Zurbarán Nº 36	06908	Montemolín	Badajoz		680993791		
552	2016-10-21 12:42:19.900312+02	2016-10-24 10:24:36.247697+02	28779668K	María Isabel	Molero Gómez	C/ Zurbarán Nº 36	06908	Montemolín	Badajoz		686948064		
553	2016-10-21 12:42:20.069069+02	2016-10-24 10:24:36.267853+02	80055450V	José Antonio	Sánchez Moya	C/ San Idelfonso Nº 64	06260	Monesterio	Badajoz		675260769		
554	2016-10-21 12:42:20.143477+02	2016-10-24 10:24:36.2758+02	8008050W	Francisca	Arencón Garrote	C/ San Idelfonso Nº 64	06260	Monesterio	Badajoz		605840576		
555	2016-10-21 12:42:20.310699+02	2016-10-24 10:24:36.323378+02	76246477M	Bernardo	Sánchez Garrote	C/ Cañuelo Nº 43	06260	Monesterio	Badajoz		620867501	924517213	
556	2016-10-21 12:42:20.384409+02	2016-10-24 10:24:36.331103+02	80055500K	Purificación	Calderón Rodríguez	C/ Cañuelo Nº 43	06260	Monesterio	Badajoz		664512808		
557	2016-10-21 12:42:20.669698+02	2016-10-24 10:24:36.348706+02	33976085W	Ascensión	Carvajal Bustamante	C/ Paseo de Extremadura Nº 229	06260	Monesterio	Badajoz		675897774		
558	2016-10-21 12:42:20.759381+02	2016-10-24 10:24:36.356534+02	8783552J	José	Sánchez Carrillo	C/ Hornos Nº 20	06260	Monesterio	Badajoz		676631173		
559	2016-10-21 12:42:20.948853+02	2016-10-24 10:24:36.40385+02	76246288T	María Julia	Chávez Collado	C/ Sierra de Aguafría Nº 7	06260	Monesterio	Badajoz		689216333		
560	2016-10-21 12:42:21.023657+02	2016-10-24 10:24:36.411685+02	8828959H	Ramón	Sánchez Carrasco	C/ Sierra de Aguafría Nº 7	06260	Monesterio	Badajoz		659483166		
561	2016-10-21 12:42:21.266614+02	2016-10-24 10:24:36.431635+02	80055439Y	José Antonio	Sánchez Vázquez	C/ Tierno Galván Nº 11	06260	Monesterio	Badajoz		605502151		
562	2016-10-21 12:42:21.339535+02	2016-10-24 10:24:36.43963+02	53274545J	María Luisa	De la Torre Maya	C/ Tierno Galván Nº 11	06260	Monesterio	Badajoz		662053480		
563	2016-10-21 12:42:21.508133+02	2016-10-24 10:24:36.459867+02	76246281Q	Francisco	Sánchez Moya	C/ Libertad Nº 14	06260	Monesterio	Badajoz		675672578	924516184	
564	2016-10-21 12:42:21.582938+02	2016-10-24 10:24:36.467831+02	76246391B	María José	Duqueso Fernández	C/ Libertad Nº 14	06260	Monesterio	Badajoz			924516184	
565	2016-10-21 12:42:21.749972+02	2016-10-24 10:24:36.487992+02	80055587Q	Juan	Sánchez Tomillo	C/ Paseo de Extremadura Nº 48	06260	Monesterio	Badajoz		667742919		
566	2016-10-21 12:42:21.823984+02	2016-10-24 10:24:36.496021+02	8881210J	Milagros	Miranda Álvarez	C/ Cañuelo Nº 36	06260	Monesterio	Badajoz		617155549		
567	2016-10-21 12:42:22.018395+02	2016-10-24 10:24:36.515899+02	76246215C	Francisco Javier	Sánchez Pecellín	C/ Robledillo Nº 12	06260	Monesterio	Badajoz		653928968		
568	2016-10-21 12:42:22.127429+02	2016-10-24 10:24:36.523823+02	8837797R	Teresa de Jesús	Moreno Lendinel	C/ Robledillo Nº 12	06260	Monesterio	Badajoz		665784199	924516663	
569	2016-10-21 12:42:22.343433+02	2016-10-24 10:24:36.571433+02	76246737N	Manuela	Moya Santos	C/ Salvador Rueda Nº 8	06906	Puebla del Maestre	Badajoz		626294655	924512169	
570	2016-10-21 12:42:22.425664+02	2016-10-24 10:24:36.579279+02	8824639E	Francisco Javier	Sánchez Danta	C/ Salvador Rueda Nº 8	06906	Puebla del Maestre	Badajoz		690255476	924512169	
571	2016-10-21 12:42:22.670195+02	2016-10-24 10:24:36.599151+02	44782842W	María Soledad	Romero Garrote	C/ Fuente Nº 5	06906	Puebla del Maestre	Badajoz		679587285	924512260	
572	2016-10-21 12:42:22.744873+02	2016-10-24 10:24:36.606883+02	44775610S	Federico	Sánchez Gato	C/ Fuente Nº 5	06906	Puebla del Maestre	Badajoz		629803977		
573	2016-10-21 12:42:22.912172+02	2016-10-24 10:24:36.626506+02	76246456F	José	Sánchez Villalba	C/ La Noria Nº 32	06260	Monesterio	Badajoz		691014098		
574	2016-10-21 12:42:22.986316+02	2016-10-24 10:24:36.634314+02	76245952D	Teresa	Serrano Laina	C/ La Noria Nº 32	06260	Monesterio	Badajoz		675898670		
575	2016-10-21 12:42:23.154889+02	2016-10-24 10:24:36.655942+02	32030736O	Juan Jesús	Santillana López	C/ Ramón y Cajal Nº 47	06260	Monesterio	Badajoz				
576	2016-10-21 12:42:23.227928+02	2016-10-24 10:24:36.665519+02	76246549P	Asunción	Garrote Peraza	Avda/ Ramón y Cajal Nº 47	06260	Monesterio	Badajoz		677771187		
577	2016-10-21 12:42:23.395229+02	2016-10-24 10:24:36.690514+02	34778293Q	Basilio	Sayago Cardoso	C/ Margarita Nelken Nº 4	06260	Monesterio	Badajoz		618742022		
578	2016-10-21 12:42:23.49042+02	2016-10-24 10:24:36.700536+02	76251319V	Carmen	Macarro Pagador	C/ Margarita Nelken Nº 4	06260	Monesterio	Badajoz		628347446		
579	2016-10-21 12:42:23.70372+02	2016-10-24 10:24:36.725394+02	80042070T	Agustín	Sevilla Ortiz	C/ De la Radio Nº 22	06260	Monesterio	Badajoz		606382176	924516842	
580	2016-10-21 12:42:23.792098+02	2016-10-24 10:24:36.734832+02	9181284Y	María del Mar	Fernández Acedo	C/ De la Radio Nº 22	06260	Monesterio	Badajoz		609284943	924516842	
581	2016-10-21 12:42:23.973966+02	2016-10-24 10:24:36.758336+02	34776560P	Andrés	Silva Sabido	Bda/ Las Reliquias Nº 29	06906	Puebla del Maestre	Badajoz		669151229	924512207	
582	2016-10-21 12:42:24.048297+02	2016-10-24 10:24:36.765813+02	9186008S	Laura	Caballero Páez	Bda/ Las Reliquias Nº 29	06906	Puebla del Maestre	Badajoz		606908479	924512207	
583	2016-10-21 12:42:24.222609+02	2016-10-24 10:24:36.783877+02	425850L	Antonio	Do Santos Chapuza	C/ Finca el Romeral Nº	06260	Monesterio	Badajoz		662278287		
584	2016-10-21 12:42:24.296866+02	2016-10-24 10:24:36.79162+02	10104513	María Manuela	Azedo Soares	C/ Finca el Romeral Nº	06260	Monesterio	Badajoz		639936738		
585	2016-10-21 12:42:24.467494+02	2016-10-24 10:24:36.838825+02	10861360R	Mario	Torrado Garrón	C/ Espronceda Nº 25	06292	Calera de León	Badajoz		620934532	924584168	
586	2016-10-21 12:42:24.542114+02	2016-10-24 10:24:36.846583+02	76251813M	María del Carmen	Boton Díaz	C/ Espronceda Nº 25	06292	Calera de León	Badajoz		686218922	924584168	
587	2016-10-21 12:42:24.784912+02	2016-10-24 10:24:36.864314+02	34776514P	María de las Mercedes	Rodríguez Fernández	C/ Río Ardila Nº 2	06292	Calera de León	Badajoz		608621403	924584280	
588	2016-10-21 12:42:24.858416+02	2016-10-24 10:24:36.87289+02	76246202Y	Antonio	Torrado Garrón	C/ Río Ardila Nº 2	06292	Calera de León	Badajoz		608621403	924584280	
589	2016-10-21 12:42:25.062259+02	2016-10-24 10:24:36.893123+02	48813501A	Juan	Torres Prior	C/ Francisco Pizarro Nº 25	06260	Monesterio	Badajoz		620839453		
590	2016-10-21 12:42:25.159262+02	2016-10-24 10:24:36.901011+02	80055429L	Manuela	Granadero Rodríguez	C/ Francisco Pizarro Nº 25	06260	Monesterio	Badajoz		620841687		
591	2016-10-21 12:42:25.352771+02	2016-10-24 10:24:36.921063+02	8826390W	Enrique	Vadillo García	C/ El Cerezo Nº 16	06260	Monesterio	Badajoz		696162591	924516878	
592	2016-10-21 12:42:25.42525+02	2016-10-24 10:24:36.928892+02	76246499G	Carmen	Calvo Galán	C/ El Cerezo Nº 16	06260	Monesterio	Badajoz		636687798	924516878	
593	2016-10-21 12:42:25.59502+02	2016-10-24 10:24:36.948731+02	80036969M	Antonio	Valencia Mejías	C/ Ramón y Cajal Nº 16	06260	Monesterio	Badajoz		652116062	924516125	
594	2016-10-21 12:42:25.668873+02	2016-10-24 10:24:36.956714+02	8801032J	Natividad	Isla Nogués	C/ Ramón y Cajal Nº 16	06260	Monesterio	Badajoz		652116061		
595	2016-10-21 12:42:25.836723+02	2016-10-24 10:24:36.976652+02	34781207D	Estela	Torrado Garrón	C/ Virgen de Tentudia Nº 3	06292	Calera de León	Badajoz		606770858	924584093	
596	2016-10-21 12:42:25.911259+02	2016-10-24 10:24:36.984449+02	8820083C	Manuel Rodrigo	Valencia Trenado	C/ Virgen de Tentudia Nº 3	06292	Calera de León	Badajoz		686058077	924584093	
597	2016-10-21 12:42:26.079011+02	2016-10-24 10:24:37.032783+02	8819791G	José Antonio	Valiente Granadero	C/ Fuente Nº 23	06908	Montemolín	Badajoz		680539719	924511838	
598	2016-10-21 12:42:26.152564+02	2016-10-24 10:24:37.040719+02	8836573L	María Rosario	Delgado Fernández	C/ Fuente Nº 23	06908	Montemolín	Badajoz		609044701		
599	2016-10-21 12:42:26.414223+02	2016-10-24 10:24:37.061219+02	33978527Y	Manuel	Valverde Moya	C/ Puebla Nº 7	06907	Montemolín	Badajoz		696523815	924511015	
600	2016-10-21 12:42:26.508934+02	2016-10-24 10:24:37.069201+02	76246692J	M Carmen	Garrote Candel	C/ Puebla Nº 7	06907	Montemolín	Badajoz		669733352	924511015	
601	2016-10-21 12:42:26.759892+02	2016-10-24 10:24:37.097327+02	33976835Q	María Granada	Tabales Larios		06291	Montemolín	Badajoz		628994026		
602	2016-10-21 12:42:26.927777+02	2016-10-24 10:24:37.117421+02	80036862J	José	Vargas García	C/ Vasco Núñez Nº 38	06260	Monesterio	Badajoz		677820935	924516937	
603	2016-10-21 12:42:27.001393+02	2016-10-24 10:24:37.12538+02	27306041G	María Soledad	Adame Gamero	C/ Vasco Núñez Nº 38	06260	Monesterio	Badajoz		625776572	924516937	
604	2016-10-21 12:42:27.17084+02	2016-10-24 10:24:37.145531+02	28681861X	Carmen	Bayón Granadero	C/ Los Mesones Nº 12	06260	Monesterio	Badajoz		661371008		
605	2016-10-21 12:42:27.244803+02	2016-10-24 10:24:37.153455+02	8780027F	Carmelo	Vargas Atienza	C/ Los Mesones Nº 12	06260	Monesterio	Badajoz		665697691		
606	2016-10-21 12:42:27.415842+02	2016-10-24 10:24:37.171259+02	80055787D	José Manuel	Vargas Rodríguez	C/ Hornos Nº 3	06260	Monesterio	Badajoz				
607	2016-10-21 12:42:27.48908+02	2016-10-24 10:24:37.179127+02	8884699Y	Benita	Iglesias Diéguez	C/ Hornos Nº 3	06260	Monesterio	Badajoz		615607747	924516859	
608	2016-10-21 12:42:27.657172+02	2016-10-24 10:24:37.198887+02	28741064B	Elisa	Pozuelo Gómez	C/ Cañuelo Nº 39	06260	Monesterio	Badajoz		652108629		
609	2016-10-21 12:42:27.731168+02	2016-10-24 10:24:37.206839+02	8884516F	Juan	Vargas Villalba	C/ Cañuelo Nº 39	06260	Monesterio	Badajoz		652108629		
610	2016-10-21 12:42:27.936039+02	2016-10-24 10:24:37.22677+02	25148331Q	Francisca	Sánchez Durán	C/ Tierno Galván Nº 3	06260	Monesterio	Badajoz		692928162	924516475	
611	2016-10-21 12:42:28.028391+02	2016-10-24 10:24:37.234634+02	76246380T	Felipe	Vargas García	C/ Tierno Galván Nº 3	06260	Monesterio	Badajoz		692928162	924516475	
612	2016-10-21 12:42:28.231724+02	2016-10-24 10:24:37.274678+02	76251631F	Ángela	Tomillo Navarro	C/ Vasco Núñez Nº 55	06260	Monesterio	Badajoz		635551297		
613	2016-10-21 12:42:28.458821+02	2016-10-24 10:24:37.294653+02	34781809J	Juan Carlos	Vasco Hernández	C/ Dolores Ibarruri Nº 5	06260	Monesterio	Badajoz		676143796		
614	2016-10-21 12:42:28.53163+02	2016-10-24 10:24:37.302493+02	80055719X	Mari Luz	Martínez Bautista	C/ Dolores Ibarruri Nº 5	06260	Monesterio	Badajoz		652545064	924516283	
615	2016-10-21 12:42:28.701405+02	2016-10-24 10:24:37.322257+02	34780314J	Amalia	Sánchez Hernández	C/ Calilla Nº 2	06260	Monesterio	Badajoz		665815121	924516729	
616	2016-10-21 12:42:28.776716+02	2016-10-24 10:24:37.330039+02	34781752A	Teófilo	Vasco Torrado	C/ Calilla Nº 2	06260	Monesterio	Badajoz		615309177		
618	2016-10-21 12:42:29.019473+02	2016-10-24 10:24:37.377543+02	80055410T	Valentín	Vasco Ruiz	C/ Pablo Iglesias Nº 20	06260	Monesterio	Badajoz		615127856		
617	2016-10-21 12:42:28.945182+02	2016-10-24 10:24:37.385522+02	27392857H	Cristina	Vicente Romero	C/ Pablo Iglesias Nº 20	06260	Monesterio	Badajoz		675960344		
619	2016-10-21 12:42:29.272433+02	2016-10-24 10:24:37.405853+02	80036737	Manuel Jesús	Real Moñino	C/ Elías Torres Nº 9	06260	Monesterio	Badajoz		606530812		
620	2016-10-21 12:42:29.36466+02	2016-10-24 10:24:37.413808+02	80055809P	Isabel	Delgado Sánchez	C/ Elías Torres Nº 9	06260	Monesterio	Badajoz		635273663		
621	2016-10-21 12:42:29.578723+02	2016-10-24 10:24:37.434067+02	34780317Q	Isabel María	Guerrero Sayago	C/ Tentudía Nº 24	06260	Monesterio	Badajoz		675263846	924516114	
622	2016-10-21 12:42:29.666492+02	2016-10-24 10:24:37.442041+02	80045081K	Farncisco José	Vázquez Martínez	C/ Tentudía Nº 24	06260	Monesterio	Badajoz		626293971	924516114	
623	2016-10-21 12:42:29.844056+02	2016-10-24 10:24:37.490829+02	1823127D	Concepción	Pérez Santana	C/ Eduardo Acosta Nº 22	06260	Monesterio	Badajoz		618627847	924518154	
624	2016-10-21 12:42:29.92011+02	2016-10-24 10:24:37.498889+02	80036675X	Antonio	Vázquez Parra	C/ Eduardo Acosta Nº 22	06260	Monesterio	Badajoz		629034915	924518154	
625	2016-10-21 12:42:30.166292+02	2016-10-24 10:24:37.519216+02	7624635	Antonia	Rodríguez Álvarez	C/ Espronceda Nº 23	06260	Monesterio	Badajoz		675149415	924517130	
626	2016-10-21 12:42:30.24132+02	2016-10-24 10:24:37.527016+02	8796339	José Antonio	Vázquez Oliva	C/ Espronceda Nº 23	06260	Monesterio	Badajoz		675149415		
627	2016-10-21 12:42:30.409129+02	2016-10-24 10:24:37.54692+02	46665719F	Miguel Ángel	Velasco Castro	Avda/ Ramón y Cajal Nº 36	06260	Monesterio	Badajoz		603703321		
628	2016-10-21 12:42:30.483277+02	2016-10-24 10:24:37.554993+02	46669376F	María Luz	Campano Mancera	Avda/ Ramón y Cajal Nº 36	06260	Monesterio	Badajoz		603703320		
629	2016-10-21 12:42:30.654965+02	2016-10-24 10:24:37.57513+02	80036946M	Lourdes	Vasco Vargas	C/ Eduardo Acosta Nº 40	06260	Monesterio	Badajoz		652117872	924516202	
630	2016-10-21 12:42:30.729809+02	2016-10-24 10:24:37.58314+02	75535768L	José Manuel	Velázquez Mallofret	C/ Eduardo Acosta Nº 40	06260	Monesterio	Badajoz		652117871	924516202	
631	2016-10-21 12:42:30.941035+02	2016-10-24 10:24:37.603135+02	77585967K	Rosario	Andrés Fadrique	C/ Cerro de la Fuente Nº 4	06260	Monesterio	Badajoz		665478409		
632	2016-10-21 12:42:31.031567+02	2016-10-24 10:24:37.611046+02	80055570E	Antonio	Villalba Calderón	C/ Cerro de la Fuente Nº 4	06260	Monesterio	Badajoz		665946943		
633	2016-10-21 12:42:31.230688+02	2016-10-24 10:24:37.631262+02	34780810A	María Reyes	Delgado Zoilo	C/ Costiución Nº 63	06260	Monesterio	Badajoz		657401339		
634	2016-10-21 12:42:31.305505+02	2016-10-24 10:24:37.63932+02	34776980Z	José	Villalba Cantillo	C/ Costiución Nº 63	06260	Monesterio	Badajoz		610230973		
635	2016-10-21 12:42:31.47256+02	2016-10-24 10:24:37.659768+02	44778485S	María Leticia	García Espinosa	C/ Sindicatos Nº 6	41020	Sevilla	Sevilla		636405106		
636	2016-10-21 12:42:31.548106+02	2016-10-24 10:24:37.667986+02	34778735K	Manuel	Villalba Calderón	C/ San Pedro Nº 53	06260	Monesterio	Badajoz		646584636		
637	2016-10-21 12:42:31.716154+02	2016-10-24 10:24:37.688338+02	44776594X	Josefa	Moya Santos	C/ Hernán Cortés Nº 26	06906	Puebla del Maestre	Badajoz		616957416	924512343	
638	2016-10-21 12:42:31.79073+02	2016-10-24 10:24:37.696236+02	75435721E	Francisco Javier	Villalba Muñiz	C/ Hernán Cortés Nº 26	06906	Puebla del Maestre	Badajoz		618462072		
639	2016-10-21 12:42:31.960138+02	2016-10-24 10:24:37.716284+02	76246530	Francisco	Villalba Cubo	C/ Pozos Nº 44	06260	Monesterio	Badajoz		656973725		
640	2016-10-21 12:42:32.035648+02	2016-10-24 10:24:37.724039+02	80055794	Emilia	Vasco Garrón	C/ Pozos Nº 44	06260	Monesterio	Badajoz		648230122		
641	2016-10-21 12:42:32.206435+02	2016-10-24 10:24:37.743633+02	280101	Pusa	Zamfir 	C/ Los Mesones Nº 19 P 2C	06260	Monesterio	Badajoz				
642	2016-10-21 12:42:32.298291+02	2016-10-24 10:24:37.751509+02	630447	Fane	Zamfir 	C/ Los Mesones Nº 19 P 2C	06260	Monesterio	Badajoz				
643	2016-10-21 12:42:32.515954+02	2016-10-24 10:24:37.773838+02	Y1107464M	Octavian	Zamfir 	C/ Barrio de la Cruz Nº 87	06260	Monesterio	Badajoz				
644	2016-10-21 12:42:32.6085+02	2016-10-24 10:24:37.783723+02	Y1107448N	Garofita	Zamfir 	C/ Barrio de la Cruz Nº 87	06260	Monesterio	Badajoz				
645	2016-10-21 12:42:32.792002+02	2016-10-24 10:24:37.841213+02	52422655C	María Purificación	Barbecho Durán	C/ Virgen de Tentudia Nº 22	06292	Calera de León	Badajoz		626358118	924584182	
646	2016-10-21 12:42:32.866497+02	2016-10-24 10:24:37.850745+02	76251767M	Antonio	Zapata Cubero	C/ Virgen de Tentudia Nº 22	06292	Calera de León	Badajoz		626358118	924584182	
647	2016-10-21 12:42:33.108115+02	2016-10-24 10:24:37.874116+02	76251804L	Adela María	Botón Díaz	C/ San Isidro Nº 1	06292	Calera de León	Badajoz		620504123	924584281	
648	2016-10-21 12:42:33.184422+02	2016-10-24 10:24:37.883328+02	8855139R	Ángel Luis	Zapata Mejías	C/ San Isidro Nº 1 A	06292	Calera de León	Badajoz		679516094		
649	2016-10-21 12:42:33.350018+02	2016-10-24 10:24:37.903651+02	28580621Q	Antonio	Zapata Morales	C/ Espronceda Nº 3	06260	Calera de León	Badajoz		646583485	924584172	
650	2016-10-21 12:42:33.423453+02	2016-10-24 10:24:37.911633+02	76246215L	Adelaida	Méndez Contreras	C/ Espronceda Nº 3	06260	Calera de León	Badajoz		646583485	924584172	
651	2016-10-21 12:42:33.591887+02	2016-10-24 10:24:37.931397+02	34778878A	Raúl	Zapata Mejías	C/ Eduardo Acosta Nº 25	06290	Calera de León	Badajoz		627611608		
652	2016-10-21 12:42:33.667841+02	2016-10-24 10:24:37.939162+02	76251797N	María Isabel	Real Fonseca	C/ Eduardo Acosta Nº 25	06290	Calera de León	Badajoz		658524090		
654	2016-10-21 12:42:33.962533+02	2016-10-24 10:24:37.986498+02	76246183X	Casimiro	Zapata Megías	C/ Pedro de Valdivia Nº 8	06292	Calera de León	Badajoz		620421576	924584138	
653	2016-10-21 12:42:33.867722+02	2016-10-24 10:24:37.994446+02	76246193C	Josefa	Real Fonseca	C/ Pedro de Valdivia Nº 8	06292	Calera de León	Badajoz		676126255	924584138	
655	2016-10-21 12:42:34.228566+02	2016-10-24 10:24:38.014298+02	76246253B	Jerónimo	Zoilo Terrón	C/ Libertad Nº 96	06260	Monesterio	Badajoz		646272935		
656	2016-10-21 12:42:34.302389+02	2016-10-24 10:24:38.022154+02	76246395S	Feliciana	Calderón Monjo	C/ Libertad Nº 96	06260	Monesterio	Badajoz		655266321	924516269	
657	2016-10-21 12:42:34.470011+02	2016-10-24 10:24:38.041883+02	80055594T	José Agustín	Zoilo Terrón	C/ Calilla Nº 28	06260	Monesterio	Badajoz		659847972		
658	2016-10-21 12:42:34.543184+02	2016-10-24 10:24:38.049764+02	80055737M	María del Pilar	Villalba Garrote	C/ Calilla Nº 28	06260	Monesterio	Badajoz		646579686		
\.


--
-- Data for Name: alumnos_tutor_alumnos; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY alumnos_tutor_alumnos (id, tutor_id, alumno_id) FROM stdin;
1	3	320
2	4	320
3	5	303
4	6	303
5	8	331
6	7	331
7	9	50
8	10	50
9	11	200
10	12	200
11	13	272
12	14	272
13	16	105
14	15	105
15	17	144
16	18	144
17	19	116
18	20	116
19	21	140
20	22	140
21	24	212
22	23	212
23	25	10
24	26	10
25	27	297
26	28	297
27	29	127
28	30	127
29	32	201
30	31	201
31	33	151
32	34	151
33	35	21
34	36	21
35	37	141
36	38	141
37	40	252
38	39	252
39	41	49
40	42	49
41	43	219
42	44	219
43	45	164
44	46	142
45	47	142
46	48	213
47	49	213
48	50	29
49	51	29
50	52	172
51	53	172
52	54	228
53	55	228
54	56	58
55	57	58
56	58	71
57	59	71
58	60	287
59	61	287
60	62	64
61	63	64
62	64	191
63	65	191
64	66	305
65	67	305
66	68	357
67	69	357
68	70	223
69	71	223
70	72	358
71	73	358
72	74	154
73	75	154
74	76	152
75	77	152
76	78	65
77	79	65
78	80	148
79	81	148
80	82	288
81	83	288
82	84	216
83	85	216
84	86	369
85	87	369
86	88	162
87	89	162
88	90	72
89	91	72
90	92	118
91	93	118
92	94	231
93	95	231
94	96	34
95	97	34
96	98	370
97	99	370
98	100	126
99	101	126
100	102	11
101	103	11
102	104	42
103	105	42
104	106	353
105	107	353
106	108	12
107	109	12
108	110	74
109	111	74
110	112	293
111	113	293
112	114	273
113	115	273
114	116	22
115	117	22
116	118	73
117	119	73
118	120	225
119	121	225
120	122	286
121	123	286
122	124	198
123	125	198
124	126	149
125	127	149
126	128	202
127	129	202
128	130	290
129	131	290
130	132	66
131	133	66
132	134	114
133	135	114
134	136	33
135	137	33
136	138	129
137	139	129
138	140	20
139	141	20
140	142	131
141	143	131
142	144	373
143	145	373
144	146	359
145	147	143
146	148	143
147	149	354
148	150	296
149	151	296
150	152	184
151	153	184
152	154	335
153	155	335
154	156	379
155	157	379
156	158	240
157	159	240
158	160	300
159	161	300
160	162	352
161	163	352
162	164	292
163	165	232
164	166	295
165	167	295
166	168	153
167	169	153
168	170	266
169	171	266
170	172	111
171	173	111
172	174	316
173	175	316
174	176	317
175	177	317
176	178	387
177	179	387
178	180	180
179	181	180
180	182	75
181	183	75
182	184	346
183	185	346
184	186	30
185	187	30
186	188	52
187	189	52
188	190	333
189	191	333
190	192	199
191	193	199
192	194	378
193	195	378
194	196	360
195	197	360
196	198	349
197	199	349
198	200	28
199	201	28
200	202	196
201	203	196
202	204	372
203	205	372
204	206	189
205	207	189
206	208	63
207	209	63
208	210	330
209	211	330
210	212	8
211	213	8
212	214	256
213	215	256
214	216	161
215	217	161
216	218	267
217	219	267
218	220	279
219	221	258
220	222	258
221	224	32
222	223	32
223	225	160
224	226	160
225	227	88
226	228	88
227	229	56
228	230	56
229	232	234
230	231	234
231	233	270
232	234	270
233	235	166
234	236	166
235	237	304
236	238	304
237	240	55
238	239	55
239	241	16
240	242	16
241	243	169
242	244	169
243	245	259
244	246	259
245	248	299
246	247	299
247	249	285
248	250	285
249	251	137
250	252	137
251	253	125
252	254	125
253	256	165
254	255	165
255	257	155
256	258	155
257	259	1
258	260	1
259	261	171
260	262	171
261	264	217
262	263	217
263	265	31
264	266	31
265	267	366
266	268	366
267	269	203
268	270	203
269	271	311
270	272	243
271	273	243
272	274	389
273	275	389
274	276	133
275	277	388
276	278	388
277	280	185
278	279	185
279	281	318
280	282	318
281	283	109
282	284	109
283	285	233
284	286	233
285	288	220
286	287	220
287	289	35
288	290	35
289	291	275
290	292	275
291	293	108
292	294	108
293	295	281
294	296	278
295	297	278
296	298	128
297	299	128
298	300	249
299	301	249
300	302	377
301	303	377
302	304	2
303	305	2
304	306	382
305	307	382
306	308	23
307	309	23
308	310	77
309	311	77
310	312	97
311	313	97
312	314	226
313	315	226
314	316	45
315	317	45
316	318	120
317	319	120
318	320	218
319	321	218
320	322	44
321	323	44
322	324	319
323	325	319
324	326	177
325	327	177
326	328	173
327	329	78
328	330	78
329	331	321
330	332	321
331	333	95
332	334	95
333	336	291
334	335	291
335	337	54
336	338	54
337	339	178
338	340	178
339	341	276
340	342	276
341	344	79
342	343	79
343	345	91
344	346	91
345	347	385
346	348	385
347	349	361
348	350	361
349	352	268
350	351	268
351	353	80
352	354	80
353	355	204
354	356	204
355	357	211
356	358	211
357	360	261
358	359	261
359	361	229
360	362	229
361	363	122
362	364	122
363	365	238
364	366	238
365	368	24
366	367	24
367	369	67
368	370	67
369	371	351
370	372	351
371	373	371
372	374	371
373	376	205
374	375	205
375	377	236
376	378	236
377	379	340
378	380	340
379	381	98
380	382	186
381	383	186
382	384	174
383	385	174
384	386	85
385	387	85
386	388	375
387	389	375
388	390	362
389	391	362
390	392	248
391	393	248
392	394	383
393	395	383
394	396	277
395	397	277
396	398	356
397	399	356
398	400	47
399	401	47
400	402	121
401	403	121
402	404	363
403	405	363
404	406	246
405	407	40
406	408	374
407	409	374
408	410	103
409	411	103
410	412	5
411	413	5
412	414	36
413	415	36
414	416	81
415	417	81
416	418	192
417	419	192
418	420	104
419	421	104
420	422	94
421	423	94
422	424	307
423	425	307
424	426	332
425	427	221
426	428	221
427	429	298
428	430	298
429	432	106
430	431	106
431	433	82
432	434	82
433	435	364
434	436	364
435	437	138
436	438	138
437	440	156
438	439	156
439	441	43
440	442	86
441	443	86
442	444	37
443	445	37
444	446	9
445	447	9
446	448	83
447	449	83
448	450	325
449	451	325
450	452	182
451	453	182
452	454	253
453	455	253
454	456	394
455	457	394
456	458	271
457	459	271
458	460	239
459	461	239
460	462	157
461	463	157
462	464	101
463	465	101
464	466	181
465	467	181
466	468	102
467	469	102
468	470	59
469	471	59
470	472	135
471	473	135
472	474	341
473	475	341
474	476	206
475	477	206
476	478	187
477	479	187
478	480	107
479	481	107
480	482	179
481	483	179
482	484	145
483	485	145
484	486	328
485	487	328
486	488	242
487	489	242
488	490	96
489	491	96
490	492	68
491	493	68
492	494	25
493	495	25
494	496	314
495	497	314
496	498	336
497	499	336
498	500	90
499	501	90
500	502	170
501	503	170
502	504	247
503	505	247
504	506	262
505	507	262
506	508	51
507	509	51
508	510	230
509	511	230
510	512	294
511	513	294
512	514	113
513	515	69
514	516	69
515	517	265
516	518	265
517	520	14
518	519	14
519	521	146
520	522	146
521	523	26
522	524	26
523	525	315
524	526	315
525	528	210
526	527	210
527	529	344
528	530	344
529	531	158
530	532	158
531	533	254
532	534	254
533	536	282
534	535	282
535	537	280
536	538	280
537	539	376
538	540	376
539	541	70
540	542	70
541	544	27
542	543	27
543	545	237
544	546	237
545	547	283
546	548	283
547	549	342
548	550	342
549	552	13
550	551	13
551	553	46
552	554	46
553	555	99
554	556	99
555	557	17
556	558	17
557	560	309
558	559	309
559	561	130
560	562	130
561	563	308
562	564	308
563	565	381
564	566	381
565	568	87
566	567	87
567	569	84
568	570	84
569	571	110
570	572	110
571	573	255
572	574	255
573	576	195
574	575	195
575	577	193
576	578	193
577	579	263
578	580	263
579	581	175
580	582	175
581	584	150
582	583	150
583	585	159
584	586	159
585	587	100
586	588	100
587	589	19
588	590	19
589	592	190
590	591	190
591	593	6
592	594	6
593	595	350
594	596	350
595	597	7
596	598	7
597	600	301
598	599	301
599	601	337
600	602	393
601	603	393
602	604	306
603	605	306
604	606	386
605	607	386
606	608	92
607	609	92
608	610	93
609	611	93
610	612	60
611	613	48
612	614	48
613	616	194
614	615	194
615	617	257
616	618	257
617	619	215
618	620	215
619	621	112
620	622	112
621	624	188
622	623	188
623	625	274
624	626	274
625	627	61
626	628	61
627	629	115
628	630	115
629	632	62
630	631	62
631	633	250
632	634	250
633	635	3
634	636	3
635	637	57
636	638	57
637	640	147
638	639	147
639	641	390
640	642	390
641	643	338
642	644	338
643	645	208
644	646	208
645	648	264
646	647	264
647	649	302
648	650	302
649	651	345
650	652	345
651	653	251
652	654	251
653	656	224
654	655	224
655	657	209
656	658	209
657	3	134
658	4	134
659	27	117
660	28	117
661	46	310
662	47	310
663	56	214
664	57	214
665	68	289
666	69	289
667	72	15
668	73	15
669	86	183
670	87	183
671	92	380
672	93	380
673	124	139
674	125	139
675	126	163
676	127	163
677	136	269
678	137	269
679	136	384
680	137	384
681	149	347
682	162	119
683	163	119
684	174	348
685	175	348
686	204	329
687	205	329
688	220	227
689	225	260
690	226	260
691	240	76
692	239	76
693	253	323
694	254	323
695	283	244
696	284	244
697	286	281
698	286	241
699	295	241
700	316	176
701	317	176
702	320	245
703	321	245
704	324	367
705	325	367
706	327	173
707	349	312
708	350	312
709	360	136
710	359	136
711	373	334
712	374	334
713	381	197
714	392	324
715	393	324
716	405	246
717	410	322
718	411	322
719	420	39
720	421	39
721	425	332
722	433	167
723	434	167
724	442	392
725	443	392
726	456	89
727	457	89
728	478	38
729	479	38
730	484	355
731	504	313
732	505	313
733	513	113
734	515	235
735	516	235
736	544	53
737	543	53
738	555	207
739	556	207
740	560	124
741	559	124
742	569	18
743	570	18
744	585	4
745	586	4
746	597	391
747	598	391
748	612	343
749	617	284
750	618	284
751	624	365
752	623	365
753	645	339
754	646	339
755	653	132
756	654	132
\.


--
-- Name: alumnos_tutor_alumnos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('alumnos_tutor_alumnos_id_seq', 756, true);


--
-- Name: alumnos_tutor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('alumnos_tutor_id_seq', 658, true);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add group	1	add_group
2	Can change group	1	change_group
3	Can delete group	1	delete_group
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add content type	3	add_contenttype
8	Can change content type	3	change_contenttype
9	Can delete content type	3	delete_contenttype
10	Can add session	4	add_session
11	Can change session	4	change_session
12	Can delete session	4	delete_session
13	Can add site	5	add_site
14	Can change site	5	change_site
15	Can delete site	5	delete_site
16	Can add log entry	6	add_logentry
17	Can change log entry	6	change_logentry
18	Can delete log entry	6	delete_logentry
19	Can add email address	7	add_emailaddress
20	Can change email address	7	change_emailaddress
21	Can delete email address	7	delete_emailaddress
22	Can add email confirmation	8	add_emailconfirmation
23	Can change email confirmation	8	change_emailconfirmation
24	Can delete email confirmation	8	delete_emailconfirmation
25	Can add social account	9	add_socialaccount
26	Can change social account	9	change_socialaccount
27	Can delete social account	9	delete_socialaccount
28	Can add social application	10	add_socialapp
29	Can change social application	10	change_socialapp
30	Can delete social application	10	delete_socialapp
31	Can add social application token	11	add_socialtoken
32	Can change social application token	11	change_socialtoken
33	Can delete social application token	11	delete_socialtoken
34	Can add user	12	add_user
35	Can change user	12	change_user
36	Can delete user	12	delete_user
37	Can add curso	13	add_curso
38	Can change curso	13	change_curso
39	Can delete curso	13	delete_curso
40	Can add configies	14	add_configies
41	Can change configies	14	change_configies
42	Can delete configies	14	delete_configies
46	Can add alumno/a	16	add_alumno
47	Can change alumno/a	16	change_alumno
48	Can delete alumno/a	16	delete_alumno
49	Can add tutor/a	17	add_tutor
50	Can change tutor/a	17	change_tutor
51	Can delete tutor/a	17	delete_tutor
52	Can add grupo	18	add_grupo
53	Can change grupo	18	change_grupo
54	Can delete grupo	18	delete_grupo
55	Can add Grupos por curso	19	add_cursogrupo
56	Can change Grupos por curso	19	change_cursogrupo
57	Can delete Grupos por curso	19	delete_cursogrupo
58	Can add Departamentos por curso	20	add_cursodepartamento
59	Can change Departamentos por curso	20	change_cursodepartamento
60	Can delete Departamentos por curso	20	delete_cursodepartamento
61	Can add departamento	21	add_departamento
62	Can change departamento	21	change_departamento
63	Can delete departamento	21	delete_departamento
64	Can add Profesores por Departamentos y curso	22	add_cursodepartamentoprofesor
65	Can change Profesores por Departamentos y curso	22	change_cursodepartamentoprofesor
66	Can delete Profesores por Departamentos y curso	22	delete_cursodepartamentoprofesor
67	Can add curso grupo alumno	23	add_cursogrupoalumno
68	Can change curso grupo alumno	23	change_cursogrupoalumno
69	Can delete curso grupo alumno	23	delete_cursogrupoalumno
70	Can add rayuela	24	add_rayuela
71	Can change rayuela	24	change_rayuela
72	Can delete rayuela	24	delete_rayuela
73	Can add Grupos y profesore/a	25	add_cursogrupoprofesor
74	Can change Grupos y profesore/a	25	change_cursogrupoprofesor
75	Can delete Grupos y profesore/a	25	delete_cursogrupoprofesor
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('auth_permission_id_seq', 75, true);


--
-- Data for Name: configies_configies; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY configies_configies (id, created, modified, codigo_centro, nombre_centro, url_centro, email_centro, direccion_centro, telefono_centro, fax_centro, nombre_director, firma_director, logo_centro, sello_centro, curso_defecto_id) FROM stdin;
1	2016-10-18 10:17:54.507687+02	2016-10-18 10:35:14.073217+02	0600256B	I.E.S. Maestro Juan Calero	http://iesmjuancalero.juntaextremadura.net	ies.maestrojuancalero@edu.gobex.es	La Noria, 1	924023642	924023643	Manuel Nogues Chaves	configies/firma.jpg	configies/logoies.png	configies/sello.jpg	1
\.


--
-- Name: configies_configies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('configies_configies_id_seq', 1, true);


--
-- Data for Name: cursos_curso; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY cursos_curso (id, curso, retrasos_amonestacion, retrasos_trimestre, inicio_primer_trimestre, fin_primer_trimestre, inicio_segundo_trimestre, fin_segundo_trimestre, inicio_tercer_trimestre, fin_tercer_primer_trimestre, slug, created, modified) FROM stdin;
1	2016/2017	2	t	2016-09-01	2016-12-31	2017-01-01	2017-03-31	2017-04-01	2017-06-30	2016-2017	2016-10-19 10:05:17.514581+02	2016-10-19 10:05:17.986912+02
\.


--
-- Name: cursos_curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('cursos_curso_id_seq', 1, true);


--
-- Data for Name: departamentos_cursodepartamento; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY departamentos_cursodepartamento (id, created, modified, curso_id, departamento_id, jefe_id) FROM stdin;
17	2016-10-20 08:44:07.385837+02	2016-10-20 11:11:00.053509+02	1	17	34
13	2016-10-20 08:44:04.520489+02	2016-10-20 11:11:11.340504+02	1	13	51
18	2016-10-20 08:44:08.753855+02	2016-10-20 11:11:22.338539+02	1	18	52
20	2016-10-20 08:44:10.462503+02	2016-10-20 11:11:38.921774+02	1	20	50
9	2016-10-20 08:44:02.662868+02	2016-10-20 11:11:54.285812+02	1	9	16
15	2016-10-20 08:44:06.721061+02	2016-10-20 11:12:08.735105+02	1	15	40
8	2016-10-20 08:44:02.186264+02	2016-10-20 11:12:20.986951+02	1	8	15
19	2016-10-20 08:44:08.86053+02	2016-10-20 11:12:40.487045+02	1	19	42
14	2016-10-20 08:44:04.945277+02	2016-10-20 11:12:52.000911+02	1	14	25
10	2016-10-20 08:44:03.416477+02	2016-10-20 11:13:06.459762+02	1	10	39
5	2016-10-20 08:44:01.485515+02	2016-10-20 11:14:04.379098+02	1	5	49
16	2016-10-20 08:44:07.222639+02	2016-10-20 11:14:15.018038+02	1	16	33
11	2016-10-20 08:44:04.121049+02	2016-10-20 11:14:29.698182+02	1	11	43
7	2016-10-20 08:44:01.887993+02	2016-10-20 11:14:42.09524+02	1	7	13
12	2016-10-20 08:44:04.227987+02	2016-10-20 11:14:58.44853+02	1	12	22
6	2016-10-20 08:44:01.799908+02	2016-10-20 11:15:10.506346+02	1	6	19
4	2016-10-20 08:44:00.90678+02	2016-10-20 11:15:27.703404+02	1	4	10
\.


--
-- Name: departamentos_cursodepartamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('departamentos_cursodepartamento_id_seq', 20, true);


--
-- Data for Name: departamentos_cursodepartamentoprofesor; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY departamentos_cursodepartamentoprofesor (id, created, modified, curso_departamento_id, profesor_id) FROM stdin;
1	2016-10-20 08:44:00.935851+02	2016-10-20 08:44:00.936127+02	4	10
2	2016-10-20 08:44:01.498262+02	2016-10-20 08:44:01.498394+02	5	11
3	2016-10-20 08:44:01.812623+02	2016-10-20 08:44:01.812756+02	6	12
4	2016-10-20 08:44:01.900748+02	2016-10-20 08:44:01.900881+02	7	13
5	2016-10-20 08:44:02.063112+02	2016-10-20 08:44:02.063281+02	6	14
6	2016-10-20 08:44:02.198754+02	2016-10-20 08:44:02.198881+02	8	15
7	2016-10-20 08:44:02.676227+02	2016-10-20 08:44:02.676371+02	9	16
8	2016-10-20 08:44:03.06857+02	2016-10-20 08:44:03.068715+02	5	17
9	2016-10-20 08:44:03.430204+02	2016-10-20 08:44:03.43036+02	10	18
10	2016-10-20 08:44:03.7817+02	2016-10-20 08:44:03.781845+02	6	19
11	2016-10-20 08:44:03.851776+02	2016-10-20 08:44:03.851943+02	6	20
12	2016-10-20 08:44:04.133699+02	2016-10-20 08:44:04.13383+02	11	21
13	2016-10-20 08:44:04.240661+02	2016-10-20 08:44:04.240869+02	12	22
14	2016-10-20 08:44:04.533151+02	2016-10-20 08:44:04.533284+02	13	23
15	2016-10-20 08:44:04.752327+02	2016-10-20 08:44:04.752468+02	7	24
16	2016-10-20 08:44:04.958665+02	2016-10-20 08:44:04.958807+02	14	25
17	2016-10-20 08:44:05.212887+02	2016-10-20 08:44:05.213026+02	4	26
18	2016-10-20 08:44:05.597119+02	2016-10-20 08:44:05.597261+02	4	27
19	2016-10-20 08:44:06.108883+02	2016-10-20 08:44:06.109022+02	10	28
20	2016-10-20 08:44:06.419528+02	2016-10-20 08:44:06.419667+02	6	29
21	2016-10-20 08:44:06.733749+02	2016-10-20 08:44:06.733882+02	15	30
22	2016-10-20 08:44:06.84222+02	2016-10-20 08:44:06.842362+02	7	31
23	2016-10-20 08:44:07.084936+02	2016-10-20 08:44:07.085078+02	15	32
24	2016-10-20 08:44:07.235843+02	2016-10-20 08:44:07.235983+02	16	33
25	2016-10-20 08:44:07.398409+02	2016-10-20 08:44:07.398543+02	17	34
26	2016-10-20 08:44:07.541564+02	2016-10-20 08:44:07.541734+02	9	35
27	2016-10-20 08:44:07.810632+02	2016-10-20 08:44:07.810841+02	11	36
28	2016-10-20 08:44:08.070989+02	2016-10-20 08:44:08.07113+02	6	37
29	2016-10-20 08:44:08.193821+02	2016-10-20 08:44:08.19399+02	5	38
30	2016-10-20 08:44:08.448058+02	2016-10-20 08:44:08.448195+02	10	39
31	2016-10-20 08:44:08.655409+02	2016-10-20 08:44:08.655544+02	15	40
32	2016-10-20 08:44:08.766642+02	2016-10-20 08:44:08.766778+02	18	41
33	2016-10-20 08:44:08.87332+02	2016-10-20 08:44:08.873475+02	19	42
34	2016-10-20 08:44:09.071226+02	2016-10-20 08:44:09.071422+02	11	43
35	2016-10-20 08:44:09.216164+02	2016-10-20 08:44:09.216299+02	11	44
36	2016-10-20 08:44:09.406223+02	2016-10-20 08:44:09.406382+02	6	45
37	2016-10-20 08:44:09.664851+02	2016-10-20 08:44:09.664989+02	18	46
38	2016-10-20 08:44:09.924384+02	2016-10-20 08:44:09.924522+02	18	47
39	2016-10-20 08:44:10.073054+02	2016-10-20 08:44:10.073194+02	14	48
40	2016-10-20 08:44:10.279066+02	2016-10-20 08:44:10.279208+02	5	49
41	2016-10-20 08:44:10.475228+02	2016-10-20 08:44:10.475368+02	20	50
42	2016-10-20 08:44:10.71213+02	2016-10-20 08:44:10.712269+02	10	2
43	2016-10-20 08:44:10.772763+02	2016-10-20 08:44:10.772899+02	6	4
44	2016-10-20 08:44:10.840883+02	2016-10-20 08:44:10.841055+02	13	51
45	2016-10-20 08:44:11.077896+02	2016-10-20 08:44:11.07804+02	18	52
46	2016-10-20 08:44:11.337104+02	2016-10-20 08:44:11.337238+02	7	53
47	2016-10-20 08:44:11.515738+02	2016-10-20 08:44:11.515878+02	7	54
48	2016-10-20 08:44:11.637864+02	2016-10-20 08:44:11.638007+02	11	55
\.


--
-- Name: departamentos_cursodepartamentoprofesor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('departamentos_cursodepartamentoprofesor_id_seq', 48, true);


--
-- Data for Name: departamentos_departamento; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY departamentos_departamento (id, created, modified, departamento, descripcion, slug) FROM stdin;
4	2016-10-20 08:44:00.876509+02	2016-10-20 08:44:00.876807+02	Tecnologia		Tecnologia
5	2016-10-20 08:44:01.468186+02	2016-10-20 08:44:01.468369+02	Ingles		Ingles
6	2016-10-20 08:44:01.787373+02	2016-10-20 08:44:01.787527+02	Orientacion		Orientacion
7	2016-10-20 08:44:01.875456+02	2016-10-20 08:44:01.875612+02	Matematicas		Matematicas
8	2016-10-20 08:44:02.173437+02	2016-10-20 08:44:02.173728+02	Filosofia		Filosofia
9	2016-10-20 08:44:02.650087+02	2016-10-20 08:44:02.650246+02	Educacion_Fisica		Educacion-Fisica
10	2016-10-20 08:44:03.402609+02	2016-10-20 08:44:03.402914+02	Geografia_e_Historia		Geografia-e-Historia
11	2016-10-20 08:44:04.108455+02	2016-10-20 08:44:04.108615+02	Lengua_Castellana_y_Literatura		Lengua-Castellana-y-Literatura
12	2016-10-20 08:44:04.214779+02	2016-10-20 08:44:04.214942+02	Musica		Musica
13	2016-10-20 08:44:04.507554+02	2016-10-20 08:44:04.50771+02	Artes_Plasticas		Artes-Plasticas
14	2016-10-20 08:44:04.930324+02	2016-10-20 08:44:04.930477+02	Frances		Frances
15	2016-10-20 08:44:06.708434+02	2016-10-20 08:44:06.7086+02	Fam._Prof._Servicios_socioculturales_y_a_la_comunidad		Fam-Prof-Servicios-socioculturales-y-a-la-comunidad
16	2016-10-20 08:44:07.210094+02	2016-10-20 08:44:07.21025+02	Latin		Latin
17	2016-10-20 08:44:07.37278+02	2016-10-20 08:44:07.372939+02	Actividades_Complementarias_y_Extraescolares		Actividades-Complementarias-y-Extraescolares
18	2016-10-20 08:44:08.740673+02	2016-10-20 08:44:08.740998+02	Ciencias_Naturales		Ciencias-Naturales
19	2016-10-20 08:44:08.847427+02	2016-10-20 08:44:08.847601+02	Fisica_y_Quimica		Fisica-y-Quimica
20	2016-10-20 08:44:10.449499+02	2016-10-20 08:44:10.449657+02	Economia		Economia
\.


--
-- Name: departamentos_departamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('departamentos_departamento_id_seq', 20, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2016-10-17 13:24:54.023735+02	1	2016/2017	1	[{"added": {}}]	13	1
2	2016-10-17 14:31:20.770584+02	1	fmoras01	2	[{"changed": {"fields": ["foto"]}}]	12	1
3	2016-10-18 10:17:54.600183+02	1	I.E.S. Maestro Juan Calero	1	[{"added": {}}]	14	1
4	2016-10-18 10:21:52.881066+02	1	I.E.S. Maestro Juan Calero	2	[{"changed": {"fields": ["firma_director", "logo_centro", "sello_centro"]}}]	14	1
5	2016-10-18 10:32:46.474135+02	1	I.E.S. Maestro Juan Calero	2	[{"changed": {"fields": ["curso_defecto"]}}]	14	1
6	2016-10-18 10:34:15.58178+02	1	I.E.S. Maestro Juan Calero	2	[{"changed": {"fields": ["firma_director", "logo_centro", "sello_centro"]}}]	14	1
7	2016-10-18 10:35:14.078283+02	1	I.E.S. Maestro Juan Calero	2	[{"changed": {"fields": ["firma_director", "logo_centro", "sello_centro"]}}]	14	1
8	2016-10-19 13:02:08.286444+02	1	2016/2017 Profesores [rayuela/2016/10/19/ExportacionDatosProfesorado.xml]	1	[{"added": {}}]	24	1
9	2016-10-19 13:05:35.154279+02	2	2016/2017 Alumnos [rayuela/2016/10/19/ExportacionDatosAlumnado.zip]	1	[{"added": {}}]	24	1
10	2016-10-20 11:01:21.487803+02	11	2016/2017 - 1AE - Domínguez Zapata, Francisca	2	[{"changed": {"fields": ["tutor"]}}]	19	1
11	2016-10-20 11:01:36.057614+02	12	2016/2017 - 1BE - Fonseca Cantos, María del Carmen	2	[{"changed": {"fields": ["tutor"]}}]	19	1
12	2016-10-20 11:01:46.853202+02	13	2016/2017 - 1CE - Gómez Albarrán, Concepción	2	[{"changed": {"fields": ["tutor"]}}]	19	1
13	2016-10-20 11:02:30.266684+02	21	2016/2017 - 1ºAPSD - Garzón Carrascal, Almudena	2	[{"changed": {"fields": ["tutor"]}}]	19	1
14	2016-10-20 11:06:30.705967+02	14	2016/2017 - 1ºFPB - Arroyo Sánchez, Alberto Pablo	2	[{"changed": {"fields": ["tutor"]}}]	19	1
15	2016-10-20 11:06:40.629592+02	19	2016/2017 - 1ºPMAR - Da Silva Martín, Libania de los Ángel	2	[{"changed": {"fields": ["tutor"]}}]	19	1
16	2016-10-20 11:06:53.649213+02	4	2016/2017 - 2AE - Torrado Martínez, Juan Manuel	2	[{"changed": {"fields": ["tutor"]}}]	19	1
17	2016-10-20 11:07:13.012285+02	5	2016/2017 - 2BE - Vega Llano, Ana María	2	[{"changed": {"fields": ["tutor"]}}]	19	1
18	2016-10-20 11:07:23.84272+02	6	2016/2017 - 2CE - Caro Puértolas, María Elena	2	[{"changed": {"fields": ["tutor"]}}]	19	1
19	2016-10-20 11:07:36.041888+02	7	2016/2017 - 2DE - Díaz González, Luisa	2	[{"changed": {"fields": ["tutor"]}}]	19	1
20	2016-10-20 11:07:52.223646+02	22	2016/2017 - 2ºAPSD - González Martínez, Eulalia	2	[{"changed": {"fields": ["tutor"]}}]	19	1
21	2016-10-20 11:08:06.363044+02	8	2016/2017 - 2ºFPB - Solís Maya, Fernando	2	[{"changed": {"fields": ["tutor"]}}]	19	1
22	2016-10-20 11:08:19.994882+02	17	2016/2017 - 2ºPMAR - Barbecho Terrón, Manuel	2	[{"changed": {"fields": ["tutor"]}}]	19	1
23	2016-10-20 11:08:32.251844+02	9	2016/2017 - 3AE - García Rodríguez, María Angustias	2	[{"changed": {"fields": ["tutor"]}}]	19	1
24	2016-10-20 11:08:48.51738+02	10	2016/2017 - 3BE - Rodríguez Díaz, José Antonio	2	[{"changed": {"fields": ["tutor"]}}]	19	1
25	2016-10-20 11:09:07.22135+02	20	2016/2017 - 4AE - Castañeda Bellido, María Isabel	2	[{"changed": {"fields": ["tutor"]}}]	19	1
26	2016-10-20 11:09:16.812965+02	16	2016/2017 - 4BE - De la Vega Sánchez, Loreto Inmaculada	2	[{"changed": {"fields": ["tutor"]}}]	19	1
27	2016-10-20 11:09:31.846906+02	18	2016/2017 - 4º PRAGE - Ramírez Pizarro, Carmen	2	[{"changed": {"fields": ["tutor"]}}]	19	1
28	2016-10-20 11:09:46.067387+02	1	2016/2017 - B1CT - Manzano Pando, José	2	[{"changed": {"fields": ["tutor"]}}]	19	1
29	2016-10-20 11:09:58.785799+02	2	2016/2017 - B1HCS - Nogués Chavero, Pablo Luis	2	[{"changed": {"fields": ["tutor"]}}]	19	1
30	2016-10-20 11:10:09.453737+02	3	2016/2017 - B2CT - Cardoso Barbecho, José Luis	2	[{"changed": {"fields": ["tutor"]}}]	19	1
31	2016-10-20 11:10:28.027533+02	15	2016/2017 - B2HCS - Pacheco Cardoso, Diego	2	[{"changed": {"fields": ["tutor"]}}]	19	1
32	2016-10-20 11:11:00.056892+02	17	2016/2017 - Actividades_Complementarias_y_Extraescolares - Macedo García, María Josefa	2	[{"changed": {"fields": ["jefe"]}}]	20	1
33	2016-10-20 11:11:11.344171+02	13	2016/2017 - Artes_Plasticas - Torrado Martínez, Juan Manuel	2	[{"changed": {"fields": ["jefe"]}}]	20	1
34	2016-10-20 11:11:22.341864+02	18	2016/2017 - Ciencias_Naturales - Trinidad Araujo, Sagrario	2	[{"changed": {"fields": ["jefe"]}}]	20	1
35	2016-10-20 11:11:38.925188+02	20	2016/2017 - Economia - Ruiz Burgos, Ambrosio	2	[{"changed": {"fields": ["jefe"]}}]	20	1
36	2016-10-20 11:11:54.28919+02	9	2016/2017 - Educacion_Fisica - Caro Puértolas, María Elena	2	[{"changed": {"fields": ["jefe"]}}]	20	1
37	2016-10-20 11:12:08.738569+02	15	2016/2017 - Fam._Prof._Servicios_socioculturales_y_a_la_comunidad - Nogués Chavero, Sergio Gabino	2	[{"changed": {"fields": ["jefe"]}}]	20	1
38	2016-10-20 11:12:20.990362+02	8	2016/2017 - Filosofia - Cardoso Barbecho, José Luis	2	[{"changed": {"fields": ["jefe"]}}]	20	1
39	2016-10-20 11:12:40.49172+02	19	2016/2017 - Fisica_y_Quimica - Nogués Chaves, Rocío	2	[{"changed": {"fields": ["jefe"]}}]	20	1
40	2016-10-20 11:12:52.004463+02	14	2016/2017 - Frances - Fonseca Cantos, María del Carmen	2	[{"changed": {"fields": ["jefe"]}}]	20	1
41	2016-10-20 11:13:06.463812+02	10	2016/2017 - Geografia_e_Historia - Nogués Chavero, Pablo Luis	2	[{"changed": {"fields": ["jefe"]}}]	20	1
42	2016-10-20 11:14:04.382495+02	5	2016/2017 - Ingles - Rodríguez Díaz, José Antonio	2	[{"changed": {"fields": ["jefe"]}}]	20	1
43	2016-10-20 11:14:15.021586+02	16	2016/2017 - Latin - Ledesma Mestre, Juan Carlos	2	[{"changed": {"fields": ["jefe"]}}]	20	1
44	2016-10-20 11:14:29.702006+02	11	2016/2017 - Lengua_Castellana_y_Literatura - Pacheco Cardoso, Diego	2	[{"changed": {"fields": ["jefe"]}}]	20	1
45	2016-10-20 11:14:42.099361+02	7	2016/2017 - Matematicas - Báez Aradilla, José Gabriel	2	[{"changed": {"fields": ["jefe"]}}]	20	1
46	2016-10-20 11:14:58.452469+02	12	2016/2017 - Musica - Díaz González, Luisa	2	[{"changed": {"fields": ["jefe"]}}]	20	1
47	2016-10-20 11:15:10.509738+02	6	2016/2017 - Orientacion - Da Silva Martín, Libania de los Ángel	2	[{"changed": {"fields": ["jefe"]}}]	20	1
48	2016-10-20 11:15:27.70678+02	4	2016/2017 - Tecnologia - Acosta Guerrero, Víctor Manuel	2	[{"changed": {"fields": ["jefe"]}}]	20	1
49	2016-10-21 09:31:47.46347+02	3	2016/2017 Datos adicionales alumnos ODS rayuela [rayuela/2016/10/21/RegAlum.ods]	1	[{"added": {}}]	24	1
50	2016-10-21 09:32:00.813181+02	4	2016/2017 Datos de tutores legales ODS rayuela [rayuela/2016/10/21/RegTutores.ods]	1	[{"added": {}}]	24	1
51	2016-10-24 13:03:16.288441+02	10	Acosta Guerrero, Víctor Manuel	2	[{"changed": {"fields": ["foto"]}}]	12	1
52	2016-10-24 13:04:41.511207+02	12	Arroyo Sánchez, Alberto Pablo	2	[{"changed": {"fields": ["foto"]}}]	12	1
53	2016-10-24 13:08:25.413508+02	16	Caro Puértolas, María Elena	2	[{"changed": {"fields": ["foto"]}}]	12	1
54	2016-10-24 13:08:51.135196+02	17	Castañeda Bellido, María Isabel	2	[{"changed": {"fields": ["foto"]}}]	12	1
55	2016-10-24 13:09:05.769596+02	18	Corchero García, Isabel	2	[{"changed": {"fields": ["foto"]}}]	12	1
56	2016-10-24 13:09:29.110256+02	19	Da Silva Martín, Libania de los Ángel	2	[{"changed": {"fields": ["foto"]}}]	12	1
57	2016-10-24 13:10:37.598555+02	23	Domínguez Zapata, Francisca	2	[{"changed": {"fields": ["foto"]}}]	12	1
58	2016-10-24 13:11:46.042808+02	27	García Hernández, Teresa	2	[{"changed": {"fields": ["foto"]}}]	12	1
59	2016-10-24 13:13:08.912095+02	28	García Rodríguez, María Angustias	2	[{"changed": {"fields": ["foto"]}}]	12	1
60	2016-10-24 13:13:37.143781+02	29	Garduño Cobos, Eva	2	[{"changed": {"fields": ["foto"]}}]	12	1
61	2016-10-24 13:14:04.20381+02	30	Garzón Carrascal, Almudena	2	[{"changed": {"fields": ["foto"]}}]	12	1
62	2016-10-24 13:14:57.530113+02	32	González Martínez, Eulalia	2	[{"changed": {"fields": ["foto"]}}]	12	1
63	2016-10-24 13:15:32.237859+02	36	Martín Cámara, Alicia	2	[{"changed": {"fields": ["foto"]}}]	12	1
64	2016-10-24 13:15:55.805369+02	37	Méndez Torrescusa, María Concepción	2	[{"changed": {"fields": ["foto"]}}]	12	1
65	2016-10-24 13:17:10.73697+02	40	Nogués Chavero, Sergio Gabino	2	[{"changed": {"fields": ["foto"]}}]	12	1
66	2016-10-24 13:17:28.278414+02	42	Nogués Chaves, Rocío	2	[{"changed": {"fields": ["foto"]}}]	12	1
67	2016-10-24 13:17:52.696616+02	44	Picón Domínguez, María Jennifer	2	[{"changed": {"fields": ["foto"]}}]	12	1
68	2016-10-24 13:18:39.387357+02	46	Ramos Duro, Pablo	2	[{"changed": {"fields": ["foto"]}}]	12	1
69	2016-10-24 13:18:59.228599+02	47	Recio Mayorga, Joaquín	2	[{"changed": {"fields": ["foto"]}}]	12	1
70	2016-10-24 13:19:39.68959+02	49	Rodríguez Díaz, José Antonio	2	[{"changed": {"fields": ["foto"]}}]	12	1
71	2016-10-24 13:20:28.866808+02	4	Solís Maya, Fernando	2	[{"changed": {"fields": ["foto"]}}]	12	1
72	2016-10-24 13:21:01.057997+02	54	Vázquez Marrón, Alicia	2	[{"changed": {"fields": ["foto"]}}]	12	1
73	2016-10-24 13:23:14.988487+02	15	Cardoso Barbecho, José Luis	2	[{"changed": {"fields": ["foto"]}}]	12	1
74	2016-10-24 13:24:18.34828+02	38	Mesa Navarro, Rita María	2	[{"changed": {"fields": ["foto"]}}]	12	1
75	2016-10-24 13:24:59.17342+02	24	Fernández Muñoz, José Alejandro	2	[{"changed": {"fields": ["foto"]}}]	12	1
76	2016-10-24 13:25:55.193585+02	41	Nogués Chaves, Manuel	2	[{"changed": {"fields": ["foto"]}}]	12	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 76, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	auth	group
2	auth	permission
3	contenttypes	contenttype
4	sessions	session
5	sites	site
6	admin	logentry
7	account	emailaddress
8	account	emailconfirmation
9	socialaccount	socialaccount
10	socialaccount	socialapp
11	socialaccount	socialtoken
12	users	user
13	cursos	curso
14	configies	configies
16	alumnos	alumno
17	alumnos	tutor
18	grupos	grupo
19	grupos	cursogrupo
20	departamentos	cursodepartamento
21	departamentos	departamento
22	departamentos	cursodepartamentoprofesor
23	grupos	cursogrupoalumno
24	rayuela	rayuela
25	grupos	cursogrupoprofesor
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('django_content_type_id_seq', 25, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2016-10-14 13:05:31.275073+02
2	contenttypes	0002_remove_content_type_name	2016-10-14 13:05:31.300642+02
3	auth	0001_initial	2016-10-14 13:05:31.659299+02
4	auth	0002_alter_permission_name_max_length	2016-10-14 13:05:31.692897+02
5	auth	0003_alter_user_email_max_length	2016-10-14 13:05:31.712454+02
6	auth	0004_alter_user_username_opts	2016-10-14 13:05:31.726217+02
7	auth	0005_alter_user_last_login_null	2016-10-14 13:05:31.73966+02
8	auth	0006_require_contenttypes_0002	2016-10-14 13:05:31.751342+02
9	auth	0007_alter_validators_add_error_messages	2016-10-14 13:05:31.767373+02
10	auth	0008_alter_user_username_max_length	2016-10-14 13:05:31.782978+02
11	users	0001_initial	2016-10-14 13:05:32.21002+02
12	account	0001_initial	2016-10-14 13:05:32.543942+02
13	account	0002_email_max_length	2016-10-14 13:05:32.577146+02
14	admin	0001_initial	2016-10-14 13:05:32.745301+02
15	admin	0002_logentry_remove_auto_add	2016-10-14 13:05:32.768911+02
16	sessions	0001_initial	2016-10-14 13:05:32.960884+02
17	sites	0001_initial	2016-10-14 13:05:33.02785+02
18	sites	0002_alter_domain_unique	2016-10-14 13:05:33.111083+02
19	sites	0003_set_site_domain_and_name	2016-10-14 13:05:33.127986+02
20	socialaccount	0001_initial	2016-10-14 13:05:33.73035+02
21	socialaccount	0002_token_max_lengths	2016-10-14 13:05:33.98794+02
22	socialaccount	0003_extra_data_default_dict	2016-10-14 13:05:34.021217+02
23	users	0002_auto_20161014_1305	2016-10-14 13:05:34.898019+02
24	cursos	0001_initial	2016-10-17 13:22:56.185289+02
25	configies	0001_initial	2016-10-18 10:16:01.533233+02
26	alumnos	0001_initial	2016-10-18 11:12:11.193782+02
27	alumnos	0002_auto_20161018_1114	2016-10-18 11:14:55.30289+02
28	alumnos	0003_auto_20161018_1305	2016-10-18 13:05:55.297549+02
29	alumnos	0004_auto_20161018_1308	2016-10-18 13:09:26.81427+02
30	alumnos	0005_auto_20161018_1802	2016-10-19 10:05:17.418508+02
31	alumnos	0006_auto_20161018_1803	2016-10-19 10:05:17.47269+02
32	alumnos	0007_auto_20161018_1808	2016-10-19 10:05:17.496318+02
33	cursos	0002_auto_20161019_1005	2016-10-19 10:05:18.184815+02
34	grupos	0001_initial	2016-10-19 10:05:18.644068+02
35	departamentos	0001_initial	2016-10-19 10:28:44.230894+02
36	departamentos	0002_cursodepartamento_jefe	2016-10-19 11:23:54.055651+02
37	departamentos	0003_auto_20161019_1131	2016-10-19 11:31:58.685028+02
38	grupos	0002_cursogrupo_tutor	2016-10-19 11:37:39.14067+02
39	alumnos	0008_auto_20161019_1142	2016-10-19 11:43:01.134069+02
40	grupos	0003_cursogrupoalumno	2016-10-19 11:43:01.205509+02
41	grupos	0004_auto_20161019_1149	2016-10-19 11:49:29.715971+02
42	grupos	0005_auto_20161019_1151	2016-10-19 11:51:55.448822+02
43	departamentos	0004_auto_20161019_1236	2016-10-19 12:36:35.619838+02
44	grupos	0006_auto_20161019_1236	2016-10-19 12:36:35.652849+02
45	rayuela	0001_initial	2016-10-19 12:36:35.79803+02
46	departamentos	0005_auto_20161019_1359	2016-10-19 13:59:19.577799+02
47	grupos	0007_auto_20161019_1359	2016-10-19 13:59:19.779011+02
48	alumnos	0009_auto_20161019_2224	2016-10-20 08:43:28.889301+02
49	alumnos	0010_auto_20161020_0843	2016-10-20 08:43:28.943785+02
50	departamentos	0006_auto_20161019_1830	2016-10-20 08:43:29.231953+02
51	departamentos	0007_auto_20161019_1854	2016-10-20 08:43:29.273903+02
52	departamentos	0008_auto_20161019_1903	2016-10-20 08:43:29.357209+02
53	departamentos	0009_auto_20161019_1950	2016-10-20 08:43:29.394668+02
54	grupos	0008_auto_20161019_1841	2016-10-20 08:43:29.515441+02
55	grupos	0009_auto_20161019_1848	2016-10-20 08:43:29.548952+02
56	grupos	0010_auto_20161019_1851	2016-10-20 08:43:29.582232+02
57	grupos	0011_auto_20161019_2059	2016-10-20 08:43:29.610886+02
58	grupos	0012_auto_20161020_0843	2016-10-20 08:43:29.636435+02
59	users	0003_auto_20161019_1950	2016-10-20 08:43:29.660878+02
60	alumnos	0011_auto_20161020_1406	2016-10-20 14:06:28.131682+02
61	alumnos	0012_auto_20161021_0927	2016-10-21 09:27:32.188833+02
62	rayuela	0002_auto_20161021_0930	2016-10-21 09:31:00.392165+02
63	alumnos	0013_alumno_expediente	2016-10-24 10:20:09.122749+02
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('django_migrations_id_seq', 63, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
zn1pfnbh53kuyxvbxm0dugk0jhraki7u	ZjAwMzFlNjkyOWI3MmFjMzhjODgzZWZhNmI2OTdmNjFiZWFmODlkODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGVkMmI5YWUxNDUyOGNkMTk3Y2MxNmM0ZWM4YzUwZGQ1Mjg2NTk3YSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19hdXRoX2xkYXAuYmFja2VuZC5MREFQQmFja2VuZCJ9	2016-11-07 09:22:24.128624+01
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY django_site (id, domain, name) FROM stdin;
1	maestrojuancalero	Gestión Alumnado Centros Secundaria
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('django_site_id_seq', 1, false);


--
-- Data for Name: grupos_cursogrupo; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY grupos_cursogrupo (id, created, modified, curso_id, grupo_id, tutor_id) FROM stdin;
11	2016-10-20 08:44:01.564584+02	2016-10-20 11:01:21.484166+02	1	11	23
12	2016-10-20 08:44:01.602083+02	2016-10-20 11:01:36.053674+02	1	12	25
13	2016-10-20 08:44:01.641437+02	2016-10-20 11:01:46.849398+02	1	13	31
21	2016-10-20 08:44:06.759138+02	2016-10-20 11:02:30.262607+02	1	21	30
14	2016-10-20 08:44:01.837689+02	2016-10-20 11:06:30.702394+02	1	14	12
19	2016-10-20 08:44:02.33662+02	2016-10-20 11:06:40.62629+02	1	19	19
4	2016-10-20 08:44:01.139712+02	2016-10-20 11:06:53.645264+02	1	4	51
5	2016-10-20 08:44:01.179184+02	2016-10-20 11:07:13.008265+02	1	5	55
6	2016-10-20 08:44:01.220047+02	2016-10-20 11:07:23.839403+02	1	6	16
7	2016-10-20 08:44:01.259358+02	2016-10-20 11:07:36.038457+02	1	7	22
22	2016-10-20 08:44:06.79711+02	2016-10-20 11:07:52.220342+02	1	22	32
8	2016-10-20 08:44:01.304758+02	2016-10-20 11:08:06.359097+02	1	8	4
17	2016-10-20 08:44:02.098114+02	2016-10-20 11:08:19.990893+02	1	17	14
9	2016-10-20 08:44:01.354199+02	2016-10-20 11:08:32.248318+02	1	9	28
10	2016-10-20 08:44:01.409566+02	2016-10-20 11:08:48.513343+02	1	10	49
20	2016-10-20 08:44:02.565792+02	2016-10-20 11:09:07.217869+02	1	20	17
16	2016-10-20 08:44:02.016898+02	2016-10-20 11:09:16.809496+02	1	16	21
18	2016-10-20 08:44:02.135598+02	2016-10-20 11:09:31.843595+02	1	18	45
1	2016-10-20 08:44:00.981526+02	2016-10-20 11:09:46.063336+02	1	1	35
2	2016-10-20 08:44:01.058481+02	2016-10-20 11:09:58.781727+02	1	2	39
3	2016-10-20 08:44:01.099702+02	2016-10-20 11:10:09.450295+02	1	3	15
15	2016-10-20 08:44:01.926284+02	2016-10-20 11:10:28.023422+02	1	15	43
\.


--
-- Name: grupos_cursogrupo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('grupos_cursogrupo_id_seq', 22, true);


--
-- Data for Name: grupos_cursogrupoalumno; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY grupos_cursogrupoalumno (id, created, modified, alumno_id, curso_grupo_id) FROM stdin;
1	2016-10-20 08:46:39.193875+02	2016-10-20 08:46:39.194104+02	1	9
2	2016-10-20 08:46:39.239318+02	2016-10-20 08:46:39.239452+02	2	9
3	2016-10-20 08:46:39.285406+02	2016-10-20 08:46:39.285577+02	3	13
4	2016-10-20 08:46:39.335142+02	2016-10-20 08:46:39.335288+02	4	1
5	2016-10-20 08:46:39.378915+02	2016-10-20 08:46:39.379141+02	5	3
6	2016-10-20 08:46:39.423462+02	2016-10-20 08:46:39.423607+02	6	3
7	2016-10-20 08:46:39.465877+02	2016-10-20 08:46:39.466018+02	7	3
8	2016-10-20 08:46:39.509687+02	2016-10-20 08:46:39.509825+02	8	7
9	2016-10-20 08:46:39.555037+02	2016-10-20 08:46:39.555177+02	9	2
10	2016-10-20 08:46:39.599713+02	2016-10-20 08:46:39.599882+02	10	11
11	2016-10-20 08:46:39.643552+02	2016-10-20 08:46:39.643713+02	11	10
12	2016-10-20 08:46:39.693796+02	2016-10-20 08:46:39.693942+02	12	20
13	2016-10-20 08:46:39.758149+02	2016-10-20 08:46:39.7583+02	13	16
14	2016-10-20 08:46:39.819729+02	2016-10-20 08:46:39.819902+02	14	10
15	2016-10-20 08:46:39.863466+02	2016-10-20 08:46:39.863618+02	15	16
16	2016-10-20 08:46:39.907424+02	2016-10-20 08:46:39.907562+02	16	15
17	2016-10-20 08:46:39.953539+02	2016-10-20 08:46:39.953671+02	17	11
18	2016-10-20 08:46:40.000275+02	2016-10-20 08:46:40.000457+02	18	12
19	2016-10-20 08:46:40.049969+02	2016-10-20 08:46:40.050143+02	19	13
20	2016-10-20 08:46:40.101709+02	2016-10-20 08:46:40.101927+02	20	10
21	2016-10-20 08:46:40.15425+02	2016-10-20 08:46:40.154447+02	21	7
22	2016-10-20 08:46:40.207918+02	2016-10-20 08:46:40.208071+02	22	5
23	2016-10-20 08:46:40.253913+02	2016-10-20 08:46:40.254082+02	23	6
24	2016-10-20 08:46:40.298307+02	2016-10-20 08:46:40.298463+02	24	5
25	2016-10-20 08:46:40.342393+02	2016-10-20 08:46:40.342544+02	25	5
26	2016-10-20 08:46:40.388683+02	2016-10-20 08:46:40.388844+02	26	6
27	2016-10-20 08:46:40.434292+02	2016-10-20 08:46:40.434441+02	27	12
28	2016-10-20 08:46:40.477705+02	2016-10-20 08:46:40.477855+02	28	20
29	2016-10-20 08:46:40.525557+02	2016-10-20 08:46:40.525702+02	29	11
30	2016-10-20 08:46:40.573339+02	2016-10-20 08:46:40.57351+02	30	13
31	2016-10-20 08:46:40.623933+02	2016-10-20 08:46:40.624078+02	31	1
32	2016-10-20 08:46:40.667269+02	2016-10-20 08:46:40.667411+02	32	1
33	2016-10-20 08:46:40.710887+02	2016-10-20 08:46:40.711038+02	33	3
34	2016-10-20 08:46:40.756137+02	2016-10-20 08:46:40.75633+02	34	2
35	2016-10-20 08:46:40.806449+02	2016-10-20 08:46:40.80664+02	35	12
36	2016-10-20 08:46:40.872063+02	2016-10-20 08:46:40.872339+02	36	12
37	2016-10-20 08:46:40.935176+02	2016-10-20 08:46:40.935337+02	37	13
38	2016-10-20 08:46:40.981066+02	2016-10-20 08:46:40.981245+02	38	11
39	2016-10-20 08:46:41.026568+02	2016-10-20 08:46:41.026742+02	39	18
40	2016-10-20 08:46:41.073656+02	2016-10-20 08:46:41.073823+02	40	16
41	2016-10-20 08:46:41.119452+02	2016-10-20 08:46:41.119618+02	41	22
42	2016-10-20 08:46:41.165384+02	2016-10-20 08:46:41.165633+02	42	4
43	2016-10-20 08:46:41.213059+02	2016-10-20 08:46:41.213308+02	43	21
44	2016-10-20 08:46:41.259486+02	2016-10-20 08:46:41.25966+02	44	4
45	2016-10-20 08:46:41.305862+02	2016-10-20 08:46:41.30611+02	45	13
46	2016-10-20 08:46:41.352926+02	2016-10-20 08:46:41.353098+02	46	19
47	2016-10-20 08:46:41.399704+02	2016-10-20 08:46:41.399884+02	47	1
48	2016-10-20 08:46:41.445347+02	2016-10-20 08:46:41.445623+02	48	4
49	2016-10-20 08:46:41.491285+02	2016-10-20 08:46:41.49145+02	49	17
50	2016-10-20 08:46:41.536197+02	2016-10-20 08:46:41.536362+02	50	21
51	2016-10-20 08:46:41.582745+02	2016-10-20 08:46:41.582985+02	51	8
52	2016-10-20 08:46:41.627869+02	2016-10-20 08:46:41.628037+02	52	7
53	2016-10-20 08:46:41.673505+02	2016-10-20 08:46:41.673693+02	53	16
54	2016-10-20 08:46:41.720212+02	2016-10-20 08:46:41.720462+02	54	9
55	2016-10-20 08:46:41.767191+02	2016-10-20 08:46:41.767368+02	55	3
56	2016-10-20 08:46:41.813573+02	2016-10-20 08:46:41.813755+02	56	2
57	2016-10-20 08:46:41.859984+02	2016-10-20 08:46:41.860207+02	57	2
58	2016-10-20 08:46:41.906155+02	2016-10-20 08:46:41.906313+02	58	20
59	2016-10-20 08:46:41.961775+02	2016-10-20 08:46:41.961981+02	59	9
60	2016-10-20 08:46:42.024982+02	2016-10-20 08:46:42.025495+02	60	11
61	2016-10-20 08:46:42.072118+02	2016-10-20 08:46:42.072384+02	61	11
62	2016-10-20 08:46:42.118812+02	2016-10-20 08:46:42.118973+02	62	13
63	2016-10-20 08:46:42.165642+02	2016-10-20 08:46:42.165815+02	63	4
64	2016-10-20 08:46:42.211556+02	2016-10-20 08:46:42.211789+02	64	9
65	2016-10-20 08:46:42.258049+02	2016-10-20 08:46:42.258217+02	65	4
66	2016-10-20 08:46:42.303845+02	2016-10-20 08:46:42.304087+02	66	4
67	2016-10-20 08:46:42.350411+02	2016-10-20 08:46:42.350645+02	67	7
68	2016-10-20 08:46:42.397205+02	2016-10-20 08:46:42.397385+02	68	11
69	2016-10-20 08:46:42.443531+02	2016-10-20 08:46:42.443769+02	69	13
70	2016-10-20 08:46:42.490603+02	2016-10-20 08:46:42.490799+02	70	11
71	2016-10-20 08:46:42.536525+02	2016-10-20 08:46:42.53671+02	71	11
72	2016-10-20 08:46:42.583784+02	2016-10-20 08:46:42.584028+02	72	13
73	2016-10-20 08:46:42.627534+02	2016-10-20 08:46:42.627673+02	73	12
74	2016-10-20 08:46:42.670613+02	2016-10-20 08:46:42.67075+02	74	1
75	2016-10-20 08:46:42.715014+02	2016-10-20 08:46:42.715219+02	75	8
76	2016-10-20 08:46:42.758942+02	2016-10-20 08:46:42.759092+02	76	13
77	2016-10-20 08:46:42.802463+02	2016-10-20 08:46:42.802606+02	77	11
78	2016-10-20 08:46:42.847848+02	2016-10-20 08:46:42.848084+02	78	11
79	2016-10-20 08:46:42.893716+02	2016-10-20 08:46:42.893871+02	79	11
80	2016-10-20 08:46:42.939969+02	2016-10-20 08:46:42.94011+02	80	12
81	2016-10-20 08:46:42.984336+02	2016-10-20 08:46:42.984575+02	81	12
82	2016-10-20 08:46:43.037769+02	2016-10-20 08:46:43.037916+02	82	12
83	2016-10-20 08:46:43.101496+02	2016-10-20 08:46:43.101657+02	83	12
84	2016-10-20 08:46:43.156583+02	2016-10-20 08:46:43.156875+02	84	15
85	2016-10-20 08:46:43.203744+02	2016-10-20 08:46:43.203887+02	85	8
86	2016-10-20 08:46:43.246763+02	2016-10-20 08:46:43.246935+02	86	14
87	2016-10-20 08:46:43.290591+02	2016-10-20 08:46:43.290797+02	87	3
88	2016-10-20 08:46:43.334543+02	2016-10-20 08:46:43.334683+02	88	11
89	2016-10-20 08:46:43.378704+02	2016-10-20 08:46:43.378852+02	89	11
90	2016-10-20 08:46:43.42312+02	2016-10-20 08:46:43.423333+02	90	11
91	2016-10-20 08:46:43.469044+02	2016-10-20 08:46:43.469189+02	91	19
92	2016-10-20 08:46:43.514703+02	2016-10-20 08:46:43.51484+02	92	5
93	2016-10-20 08:46:43.557715+02	2016-10-20 08:46:43.557934+02	93	6
94	2016-10-20 08:46:43.60104+02	2016-10-20 08:46:43.601182+02	94	21
95	2016-10-20 08:46:43.64547+02	2016-10-20 08:46:43.645612+02	95	8
96	2016-10-20 08:46:43.693039+02	2016-10-20 08:46:43.693578+02	96	1
97	2016-10-20 08:46:43.74019+02	2016-10-20 08:46:43.74034+02	97	10
98	2016-10-20 08:46:43.785088+02	2016-10-20 08:46:43.785245+02	98	10
99	2016-10-20 08:46:43.829936+02	2016-10-20 08:46:43.830085+02	99	1
100	2016-10-20 08:46:43.915608+02	2016-10-20 08:46:43.91577+02	100	3
101	2016-10-20 08:46:43.960899+02	2016-10-20 08:46:43.961144+02	101	2
102	2016-10-20 08:46:44.007451+02	2016-10-20 08:46:44.007592+02	102	2
103	2016-10-20 08:46:44.053266+02	2016-10-20 08:46:44.053429+02	103	11
104	2016-10-20 08:46:44.09872+02	2016-10-20 08:46:44.098892+02	104	12
105	2016-10-20 08:46:44.148503+02	2016-10-20 08:46:44.148673+02	105	16
106	2016-10-20 08:46:44.213828+02	2016-10-20 08:46:44.21401+02	106	9
107	2016-10-20 08:46:44.261056+02	2016-10-20 08:46:44.261224+02	107	9
108	2016-10-20 08:46:44.306579+02	2016-10-20 08:46:44.30674+02	108	16
109	2016-10-20 08:46:44.352488+02	2016-10-20 08:46:44.352632+02	109	15
110	2016-10-20 08:46:44.397293+02	2016-10-20 08:46:44.39746+02	110	13
111	2016-10-20 08:46:44.441945+02	2016-10-20 08:46:44.442088+02	111	9
112	2016-10-20 08:46:44.489325+02	2016-10-20 08:46:44.489531+02	112	4
113	2016-10-20 08:46:44.535479+02	2016-10-20 08:46:44.535633+02	113	11
114	2016-10-20 08:46:44.580592+02	2016-10-20 08:46:44.580768+02	114	15
115	2016-10-20 08:46:44.625697+02	2016-10-20 08:46:44.625848+02	115	20
116	2016-10-20 08:46:44.671069+02	2016-10-20 08:46:44.671221+02	116	13
117	2016-10-20 08:46:44.716635+02	2016-10-20 08:46:44.716788+02	117	11
118	2016-10-20 08:46:44.762652+02	2016-10-20 08:46:44.76282+02	118	13
119	2016-10-20 08:46:44.809051+02	2016-10-20 08:46:44.809219+02	119	12
120	2016-10-20 08:46:44.855449+02	2016-10-20 08:46:44.855627+02	120	1
121	2016-10-20 08:46:44.901642+02	2016-10-20 08:46:44.901793+02	121	8
122	2016-10-20 08:46:44.947634+02	2016-10-20 08:46:44.947791+02	122	13
123	2016-10-20 08:46:44.994052+02	2016-10-20 08:46:44.994222+02	123	22
124	2016-10-20 08:46:45.041267+02	2016-10-20 08:46:45.041441+02	124	15
125	2016-10-20 08:46:45.089155+02	2016-10-20 08:46:45.089302+02	125	15
126	2016-10-20 08:46:45.135768+02	2016-10-20 08:46:45.13592+02	126	14
127	2016-10-20 08:46:45.182087+02	2016-10-20 08:46:45.182245+02	127	5
128	2016-10-20 08:46:45.23098+02	2016-10-20 08:46:45.231154+02	128	14
129	2016-10-20 08:46:45.299265+02	2016-10-20 08:46:45.299474+02	129	18
130	2016-10-20 08:46:45.356386+02	2016-10-20 08:46:45.356546+02	130	17
131	2016-10-20 08:46:45.402701+02	2016-10-20 08:46:45.402868+02	131	7
132	2016-10-20 08:46:45.449546+02	2016-10-20 08:46:45.449698+02	132	10
133	2016-10-20 08:46:45.497696+02	2016-10-20 08:46:45.497888+02	133	17
134	2016-10-20 08:46:45.545927+02	2016-10-20 08:46:45.54611+02	134	2
135	2016-10-20 08:46:45.595126+02	2016-10-20 08:46:45.595314+02	135	2
136	2016-10-20 08:46:45.641441+02	2016-10-20 08:46:45.641651+02	136	10
137	2016-10-20 08:46:45.688158+02	2016-10-20 08:46:45.688313+02	137	3
138	2016-10-20 08:46:45.734952+02	2016-10-20 08:46:45.735173+02	138	12
139	2016-10-20 08:46:45.783487+02	2016-10-20 08:46:45.783647+02	139	21
140	2016-10-20 08:46:45.829533+02	2016-10-20 08:46:45.82969+02	140	1
141	2016-10-20 08:46:45.877578+02	2016-10-20 08:46:45.877733+02	141	20
142	2016-10-20 08:46:45.925356+02	2016-10-20 08:46:45.925505+02	142	20
143	2016-10-20 08:46:45.972894+02	2016-10-20 08:46:45.973063+02	143	16
144	2016-10-20 08:46:46.020471+02	2016-10-20 08:46:46.020628+02	144	8
145	2016-10-20 08:46:46.070084+02	2016-10-20 08:46:46.070262+02	145	20
146	2016-10-20 08:46:46.120357+02	2016-10-20 08:46:46.120562+02	146	9
147	2016-10-20 08:46:46.172406+02	2016-10-20 08:46:46.172607+02	147	9
148	2016-10-20 08:46:46.226104+02	2016-10-20 08:46:46.226298+02	148	15
149	2016-10-20 08:46:46.277962+02	2016-10-20 08:46:46.278194+02	149	15
150	2016-10-20 08:46:46.335826+02	2016-10-20 08:46:46.336018+02	150	11
151	2016-10-20 08:46:46.384116+02	2016-10-20 08:46:46.384285+02	151	9
152	2016-10-20 08:46:46.43038+02	2016-10-20 08:46:46.430682+02	152	10
153	2016-10-20 08:46:46.476801+02	2016-10-20 08:46:46.476959+02	153	9
154	2016-10-20 08:46:46.522759+02	2016-10-20 08:46:46.522957+02	154	6
155	2016-10-20 08:46:46.569214+02	2016-10-20 08:46:46.569454+02	155	7
156	2016-10-20 08:46:46.614428+02	2016-10-20 08:46:46.614597+02	156	7
157	2016-10-20 08:46:46.659801+02	2016-10-20 08:46:46.659982+02	157	4
158	2016-10-20 08:46:46.705854+02	2016-10-20 08:46:46.706082+02	158	4
159	2016-10-20 08:46:46.751027+02	2016-10-20 08:46:46.75119+02	159	7
160	2016-10-20 08:46:46.796429+02	2016-10-20 08:46:46.796596+02	160	20
161	2016-10-20 08:46:46.842008+02	2016-10-20 08:46:46.842536+02	161	13
162	2016-10-20 08:46:46.889521+02	2016-10-20 08:46:46.88969+02	162	1
163	2016-10-20 08:46:46.93539+02	2016-10-20 08:46:46.935579+02	163	1
164	2016-10-20 08:46:46.980211+02	2016-10-20 08:46:46.980376+02	164	1
165	2016-10-20 08:46:47.025261+02	2016-10-20 08:46:47.025418+02	165	1
166	2016-10-20 08:46:47.070368+02	2016-10-20 08:46:47.070558+02	166	13
167	2016-10-20 08:46:47.115864+02	2016-10-20 08:46:47.116092+02	167	19
168	2016-10-20 08:46:47.164515+02	2016-10-20 08:46:47.164694+02	168	21
169	2016-10-20 08:46:47.212196+02	2016-10-20 08:46:47.212379+02	169	9
170	2016-10-20 08:46:47.259942+02	2016-10-20 08:46:47.260186+02	170	15
171	2016-10-20 08:46:47.307461+02	2016-10-20 08:46:47.307636+02	171	9
172	2016-10-20 08:46:47.365414+02	2016-10-20 08:46:47.365598+02	172	14
173	2016-10-20 08:46:47.427839+02	2016-10-20 08:46:47.4281+02	173	2
174	2016-10-20 08:46:47.47565+02	2016-10-20 08:46:47.475825+02	174	21
175	2016-10-20 08:46:47.523423+02	2016-10-20 08:46:47.523593+02	175	2
176	2016-10-20 08:46:47.57079+02	2016-10-20 08:46:47.571042+02	176	5
177	2016-10-20 08:46:47.617373+02	2016-10-20 08:46:47.617536+02	177	7
178	2016-10-20 08:46:47.664675+02	2016-10-20 08:46:47.664844+02	178	2
179	2016-10-20 08:46:47.712152+02	2016-10-20 08:46:47.712388+02	179	1
180	2016-10-20 08:46:47.757314+02	2016-10-20 08:46:47.757473+02	180	18
181	2016-10-20 08:46:47.802065+02	2016-10-20 08:46:47.802218+02	181	18
182	2016-10-20 08:46:47.847057+02	2016-10-20 08:46:47.847287+02	182	7
183	2016-10-20 08:46:47.89218+02	2016-10-20 08:46:47.892335+02	183	20
184	2016-10-20 08:46:47.937159+02	2016-10-20 08:46:47.937355+02	184	10
185	2016-10-20 08:46:47.981831+02	2016-10-20 08:46:47.982066+02	185	9
186	2016-10-20 08:46:48.026724+02	2016-10-20 08:46:48.02688+02	186	9
187	2016-10-20 08:46:48.072413+02	2016-10-20 08:46:48.072643+02	187	1
188	2016-10-20 08:46:48.117322+02	2016-10-20 08:46:48.117545+02	188	3
189	2016-10-20 08:46:48.162415+02	2016-10-20 08:46:48.162583+02	189	10
190	2016-10-20 08:46:48.207884+02	2016-10-20 08:46:48.208036+02	190	10
191	2016-10-20 08:46:48.251591+02	2016-10-20 08:46:48.251809+02	191	20
192	2016-10-20 08:46:48.296409+02	2016-10-20 08:46:48.296558+02	192	20
193	2016-10-20 08:46:48.345032+02	2016-10-20 08:46:48.345327+02	193	20
194	2016-10-20 08:46:48.389165+02	2016-10-20 08:46:48.389378+02	194	20
195	2016-10-20 08:46:48.440498+02	2016-10-20 08:46:48.440648+02	195	10
196	2016-10-20 08:46:48.509494+02	2016-10-20 08:46:48.509685+02	196	15
197	2016-10-20 08:46:48.557479+02	2016-10-20 08:46:48.558021+02	197	15
198	2016-10-20 08:46:48.604758+02	2016-10-20 08:46:48.604928+02	198	9
199	2016-10-20 08:46:48.650859+02	2016-10-20 08:46:48.651032+02	199	9
200	2016-10-20 08:46:48.697756+02	2016-10-20 08:46:48.697937+02	200	6
201	2016-10-20 08:46:48.744373+02	2016-10-20 08:46:48.744615+02	201	5
202	2016-10-20 08:46:48.792293+02	2016-10-20 08:46:48.792491+02	202	5
203	2016-10-20 08:46:48.83815+02	2016-10-20 08:46:48.838377+02	203	4
204	2016-10-20 08:46:48.884263+02	2016-10-20 08:46:48.884434+02	204	6
205	2016-10-20 08:46:48.930267+02	2016-10-20 08:46:48.930415+02	205	4
206	2016-10-20 08:46:48.975695+02	2016-10-20 08:46:48.975921+02	206	5
207	2016-10-20 08:46:49.02094+02	2016-10-20 08:46:49.021099+02	207	7
208	2016-10-20 08:46:49.066334+02	2016-10-20 08:46:49.066529+02	208	5
209	2016-10-20 08:46:49.111145+02	2016-10-20 08:46:49.111455+02	209	6
210	2016-10-20 08:46:49.15688+02	2016-10-20 08:46:49.157081+02	210	11
211	2016-10-20 08:46:49.202546+02	2016-10-20 08:46:49.202704+02	211	20
212	2016-10-20 08:46:49.247808+02	2016-10-20 08:46:49.248044+02	212	12
213	2016-10-20 08:46:49.294492+02	2016-10-20 08:46:49.294708+02	213	12
214	2016-10-20 08:46:49.340343+02	2016-10-20 08:46:49.340509+02	214	12
215	2016-10-20 08:46:49.385805+02	2016-10-20 08:46:49.386037+02	215	16
216	2016-10-20 08:46:49.431048+02	2016-10-20 08:46:49.431209+02	216	1
217	2016-10-20 08:46:49.476297+02	2016-10-20 08:46:49.476456+02	217	1
218	2016-10-20 08:46:49.528221+02	2016-10-20 08:46:49.528536+02	218	1
219	2016-10-20 08:46:49.596941+02	2016-10-20 08:46:49.597118+02	219	2
220	2016-10-20 08:46:49.657424+02	2016-10-20 08:46:49.657584+02	220	12
221	2016-10-20 08:46:49.703499+02	2016-10-20 08:46:49.703722+02	221	13
222	2016-10-20 08:46:49.749076+02	2016-10-20 08:46:49.749243+02	222	22
223	2016-10-20 08:46:49.7941+02	2016-10-20 08:46:49.794304+02	223	15
224	2016-10-20 08:46:49.839803+02	2016-10-20 08:46:49.840037+02	224	15
225	2016-10-20 08:46:49.8859+02	2016-10-20 08:46:49.886044+02	225	2
226	2016-10-20 08:46:49.931167+02	2016-10-20 08:46:49.931356+02	226	19
227	2016-10-20 08:46:49.977554+02	2016-10-20 08:46:49.97778+02	227	22
228	2016-10-20 08:46:50.023016+02	2016-10-20 08:46:50.023265+02	228	6
229	2016-10-20 08:46:50.068619+02	2016-10-20 08:46:50.06878+02	229	3
230	2016-10-20 08:46:50.114164+02	2016-10-20 08:46:50.114396+02	230	16
231	2016-10-20 08:46:50.16018+02	2016-10-20 08:46:50.160343+02	231	18
232	2016-10-20 08:46:50.2059+02	2016-10-20 08:46:50.206058+02	232	13
233	2016-10-20 08:46:50.25128+02	2016-10-20 08:46:50.251806+02	233	11
234	2016-10-20 08:46:50.297813+02	2016-10-20 08:46:50.297984+02	234	8
235	2016-10-20 08:46:50.343972+02	2016-10-20 08:46:50.344132+02	235	15
236	2016-10-20 08:46:50.389858+02	2016-10-20 08:46:50.390022+02	236	4
237	2016-10-20 08:46:50.435327+02	2016-10-20 08:46:50.435559+02	237	17
238	2016-10-20 08:46:50.482463+02	2016-10-20 08:46:50.482666+02	238	8
239	2016-10-20 08:46:50.533073+02	2016-10-20 08:46:50.533304+02	239	16
240	2016-10-20 08:46:50.578616+02	2016-10-20 08:46:50.578765+02	240	6
241	2016-10-20 08:46:50.625037+02	2016-10-20 08:46:50.625206+02	241	16
242	2016-10-20 08:46:50.684656+02	2016-10-20 08:46:50.684927+02	242	16
243	2016-10-20 08:46:50.74933+02	2016-10-20 08:46:50.749489+02	243	9
244	2016-10-20 08:46:50.795323+02	2016-10-20 08:46:50.795528+02	244	9
245	2016-10-20 08:46:50.841138+02	2016-10-20 08:46:50.841411+02	245	9
246	2016-10-20 08:46:50.886838+02	2016-10-20 08:46:50.887014+02	246	3
247	2016-10-20 08:46:50.932596+02	2016-10-20 08:46:50.932746+02	247	1
248	2016-10-20 08:46:50.978952+02	2016-10-20 08:46:50.979241+02	248	2
249	2016-10-20 08:46:51.025844+02	2016-10-20 08:46:51.026014+02	249	21
250	2016-10-20 08:46:51.072125+02	2016-10-20 08:46:51.072276+02	250	13
251	2016-10-20 08:46:51.117403+02	2016-10-20 08:46:51.117647+02	251	11
252	2016-10-20 08:46:51.164102+02	2016-10-20 08:46:51.164284+02	252	10
253	2016-10-20 08:46:51.209782+02	2016-10-20 08:46:51.209924+02	253	20
254	2016-10-20 08:46:51.256077+02	2016-10-20 08:46:51.256246+02	254	20
255	2016-10-20 08:46:51.301838+02	2016-10-20 08:46:51.301992+02	255	9
256	2016-10-20 08:46:51.347987+02	2016-10-20 08:46:51.348154+02	256	15
257	2016-10-20 08:46:51.394992+02	2016-10-20 08:46:51.395255+02	257	11
258	2016-10-20 08:46:51.442114+02	2016-10-20 08:46:51.442277+02	258	10
259	2016-10-20 08:46:51.489029+02	2016-10-20 08:46:51.489197+02	259	10
260	2016-10-20 08:46:51.535359+02	2016-10-20 08:46:51.535592+02	260	5
261	2016-10-20 08:46:51.579559+02	2016-10-20 08:46:51.579721+02	261	6
262	2016-10-20 08:46:51.625123+02	2016-10-20 08:46:51.625272+02	262	6
263	2016-10-20 08:46:51.669829+02	2016-10-20 08:46:51.67004+02	263	6
264	2016-10-20 08:46:51.715322+02	2016-10-20 08:46:51.715475+02	264	4
265	2016-10-20 08:46:51.765221+02	2016-10-20 08:46:51.765405+02	265	13
266	2016-10-20 08:46:51.829198+02	2016-10-20 08:46:51.829425+02	266	20
267	2016-10-20 08:46:51.886526+02	2016-10-20 08:46:51.886673+02	267	16
268	2016-10-20 08:46:51.930646+02	2016-10-20 08:46:51.930796+02	268	20
269	2016-10-20 08:46:51.976967+02	2016-10-20 08:46:51.977498+02	269	12
270	2016-10-20 08:46:52.022353+02	2016-10-20 08:46:52.022498+02	270	1
271	2016-10-20 08:46:52.068203+02	2016-10-20 08:46:52.068374+02	271	1
272	2016-10-20 08:46:52.11266+02	2016-10-20 08:46:52.112845+02	272	1
273	2016-10-20 08:46:52.157324+02	2016-10-20 08:46:52.157471+02	273	2
274	2016-10-20 08:46:52.202791+02	2016-10-20 08:46:52.202938+02	274	8
275	2016-10-20 08:46:52.248712+02	2016-10-20 08:46:52.248966+02	275	12
276	2016-10-20 08:46:52.296384+02	2016-10-20 08:46:52.296556+02	276	11
277	2016-10-20 08:46:52.339657+02	2016-10-20 08:46:52.339796+02	277	12
278	2016-10-20 08:46:52.38294+02	2016-10-20 08:46:52.383146+02	278	19
279	2016-10-20 08:46:52.426042+02	2016-10-20 08:46:52.426178+02	279	22
280	2016-10-20 08:46:52.469488+02	2016-10-20 08:46:52.469626+02	280	7
281	2016-10-20 08:46:52.513209+02	2016-10-20 08:46:52.513418+02	281	14
282	2016-10-20 08:46:52.558633+02	2016-10-20 08:46:52.558807+02	282	14
283	2016-10-20 08:46:52.606474+02	2016-10-20 08:46:52.606659+02	283	14
284	2016-10-20 08:46:52.655927+02	2016-10-20 08:46:52.65619+02	284	20
285	2016-10-20 08:46:52.701179+02	2016-10-20 08:46:52.701388+02	285	3
286	2016-10-20 08:46:52.745998+02	2016-10-20 08:46:52.746234+02	286	18
287	2016-10-20 08:46:52.794335+02	2016-10-20 08:46:52.794688+02	287	15
288	2016-10-20 08:46:52.845261+02	2016-10-20 08:46:52.845444+02	288	6
289	2016-10-20 08:46:52.904839+02	2016-10-20 08:46:52.905031+02	289	6
290	2016-10-20 08:46:52.972312+02	2016-10-20 08:46:52.972559+02	290	4
291	2016-10-20 08:46:53.019605+02	2016-10-20 08:46:53.019793+02	291	7
292	2016-10-20 08:46:53.072292+02	2016-10-20 08:46:53.072494+02	292	7
293	2016-10-20 08:46:53.122049+02	2016-10-20 08:46:53.122291+02	293	7
294	2016-10-20 08:46:53.169602+02	2016-10-20 08:46:53.169854+02	294	21
295	2016-10-20 08:46:53.216043+02	2016-10-20 08:46:53.21624+02	295	3
296	2016-10-20 08:46:53.263564+02	2016-10-20 08:46:53.263833+02	296	12
297	2016-10-20 08:46:53.311606+02	2016-10-20 08:46:53.311793+02	297	15
298	2016-10-20 08:46:53.358076+02	2016-10-20 08:46:53.358233+02	298	3
299	2016-10-20 08:46:53.403648+02	2016-10-20 08:46:53.403942+02	299	2
300	2016-10-20 08:46:53.452334+02	2016-10-20 08:46:53.452527+02	300	2
301	2016-10-20 08:46:53.500555+02	2016-10-20 08:46:53.50075+02	301	1
302	2016-10-20 08:46:53.550166+02	2016-10-20 08:46:53.550444+02	302	1
303	2016-10-20 08:46:53.598812+02	2016-10-20 08:46:53.598989+02	303	10
304	2016-10-20 08:46:53.646094+02	2016-10-20 08:46:53.646304+02	304	10
305	2016-10-20 08:46:53.693778+02	2016-10-20 08:46:53.69438+02	305	20
306	2016-10-20 08:46:53.744973+02	2016-10-20 08:46:53.745231+02	306	16
307	2016-10-20 08:46:53.793501+02	2016-10-20 08:46:53.793659+02	307	10
308	2016-10-20 08:46:53.840525+02	2016-10-20 08:46:53.840805+02	308	9
309	2016-10-20 08:46:53.887886+02	2016-10-20 08:46:53.888052+02	309	12
310	2016-10-20 08:46:53.934389+02	2016-10-20 08:46:53.934568+02	310	7
311	2016-10-20 08:46:53.989119+02	2016-10-20 08:46:53.989422+02	311	7
312	2016-10-20 08:46:54.07146+02	2016-10-20 08:46:54.071646+02	312	5
313	2016-10-20 08:46:54.118007+02	2016-10-20 08:46:54.118204+02	313	6
314	2016-10-20 08:46:54.166114+02	2016-10-20 08:46:54.16636+02	314	13
315	2016-10-20 08:46:54.212858+02	2016-10-20 08:46:54.213037+02	315	13
316	2016-10-20 08:46:54.259184+02	2016-10-20 08:46:54.25936+02	316	16
317	2016-10-20 08:46:54.305907+02	2016-10-20 08:46:54.306182+02	317	16
318	2016-10-20 08:46:54.352712+02	2016-10-20 08:46:54.352888+02	318	20
319	2016-10-20 08:46:54.399497+02	2016-10-20 08:46:54.399671+02	319	20
320	2016-10-20 08:46:54.445616+02	2016-10-20 08:46:54.44589+02	320	11
321	2016-10-20 08:46:54.49034+02	2016-10-20 08:46:54.490493+02	321	1
322	2016-10-20 08:46:54.5369+02	2016-10-20 08:46:54.537059+02	322	1
323	2016-10-20 08:46:54.583395+02	2016-10-20 08:46:54.583634+02	323	12
324	2016-10-20 08:46:54.62936+02	2016-10-20 08:46:54.629526+02	324	11
325	2016-10-20 08:46:54.676035+02	2016-10-20 08:46:54.676212+02	325	12
326	2016-10-20 08:46:54.722184+02	2016-10-20 08:46:54.722424+02	326	22
327	2016-10-20 08:46:54.768754+02	2016-10-20 08:46:54.768925+02	327	21
328	2016-10-20 08:46:54.814127+02	2016-10-20 08:46:54.814293+02	328	15
329	2016-10-20 08:46:54.85926+02	2016-10-20 08:46:54.859483+02	329	9
330	2016-10-20 08:46:54.90484+02	2016-10-20 08:46:54.904997+02	330	9
331	2016-10-20 08:46:54.950727+02	2016-10-20 08:46:54.95089+02	331	15
332	2016-10-20 08:46:54.996653+02	2016-10-20 08:46:54.996902+02	332	1
333	2016-10-20 08:46:55.042176+02	2016-10-20 08:46:55.042384+02	333	16
334	2016-10-20 08:46:55.097668+02	2016-10-20 08:46:55.09787+02	334	10
335	2016-10-20 08:46:55.159131+02	2016-10-20 08:46:55.159401+02	335	19
336	2016-10-20 08:46:55.205697+02	2016-10-20 08:46:55.205858+02	336	14
337	2016-10-20 08:46:55.251146+02	2016-10-20 08:46:55.251308+02	337	14
338	2016-10-20 08:46:55.296575+02	2016-10-20 08:46:55.296819+02	338	6
339	2016-10-20 08:46:55.341726+02	2016-10-20 08:46:55.341892+02	339	2
340	2016-10-20 08:46:55.388964+02	2016-10-20 08:46:55.389167+02	340	6
341	2016-10-20 08:46:55.437516+02	2016-10-20 08:46:55.438072+02	341	5
342	2016-10-20 08:46:55.489591+02	2016-10-20 08:46:55.489788+02	342	6
343	2016-10-20 08:46:55.53643+02	2016-10-20 08:46:55.53658+02	343	18
344	2016-10-20 08:46:55.585322+02	2016-10-20 08:46:55.585496+02	344	17
345	2016-10-20 08:46:55.636517+02	2016-10-20 08:46:55.636682+02	345	4
346	2016-10-20 08:46:55.68333+02	2016-10-20 08:46:55.683507+02	346	16
347	2016-10-20 08:46:55.730788+02	2016-10-20 08:46:55.731043+02	347	3
348	2016-10-20 08:46:55.777724+02	2016-10-20 08:46:55.777906+02	348	3
349	2016-10-20 08:46:55.82428+02	2016-10-20 08:46:55.824449+02	349	3
350	2016-10-20 08:46:55.870456+02	2016-10-20 08:46:55.870696+02	350	1
351	2016-10-20 08:46:55.916943+02	2016-10-20 08:46:55.91711+02	351	21
352	2016-10-20 08:46:55.963205+02	2016-10-20 08:46:55.96337+02	352	10
353	2016-10-20 08:46:56.008926+02	2016-10-20 08:46:56.009154+02	353	20
354	2016-10-20 08:46:56.05532+02	2016-10-20 08:46:56.055482+02	354	20
355	2016-10-20 08:46:56.1027+02	2016-10-20 08:46:56.102864+02	355	20
356	2016-10-20 08:46:56.149178+02	2016-10-20 08:46:56.149441+02	356	15
357	2016-10-20 08:46:56.213762+02	2016-10-20 08:46:56.213951+02	357	3
358	2016-10-20 08:46:56.278645+02	2016-10-20 08:46:56.278891+02	358	4
359	2016-10-20 08:46:56.325102+02	2016-10-20 08:46:56.325359+02	359	7
360	2016-10-20 08:46:56.372786+02	2016-10-20 08:46:56.373002+02	360	5
361	2016-10-20 08:46:56.417452+02	2016-10-20 08:46:56.417597+02	361	5
362	2016-10-20 08:46:56.463429+02	2016-10-20 08:46:56.463709+02	362	6
363	2016-10-20 08:46:56.513165+02	2016-10-20 08:46:56.513322+02	363	7
364	2016-10-20 08:46:56.561884+02	2016-10-20 08:46:56.562083+02	364	5
365	2016-10-20 08:46:56.609845+02	2016-10-20 08:46:56.61009+02	365	4
366	2016-10-20 08:46:56.657631+02	2016-10-20 08:46:56.657819+02	366	20
367	2016-10-20 08:46:56.70522+02	2016-10-20 08:46:56.705383+02	367	20
368	2016-10-20 08:46:56.753089+02	2016-10-20 08:46:56.753366+02	368	22
369	2016-10-20 08:46:56.806524+02	2016-10-20 08:46:56.806712+02	369	13
370	2016-10-20 08:46:56.855257+02	2016-10-20 08:46:56.855413+02	370	12
371	2016-10-20 08:46:56.906613+02	2016-10-20 08:46:56.906852+02	371	12
372	2016-10-20 08:46:56.956058+02	2016-10-20 08:46:56.956228+02	372	22
373	2016-10-20 08:46:57.003472+02	2016-10-20 08:46:57.003621+02	373	15
374	2016-10-20 08:46:57.054403+02	2016-10-20 08:46:57.054649+02	374	15
375	2016-10-20 08:46:57.103599+02	2016-10-20 08:46:57.103785+02	375	14
376	2016-10-20 08:46:57.154314+02	2016-10-20 08:46:57.154474+02	376	14
377	2016-10-20 08:46:57.204727+02	2016-10-20 08:46:57.205241+02	377	18
378	2016-10-20 08:46:57.253646+02	2016-10-20 08:46:57.253812+02	378	17
379	2016-10-20 08:46:57.311325+02	2016-10-20 08:46:57.311505+02	379	15
380	2016-10-20 08:46:57.373553+02	2016-10-20 08:46:57.373734+02	380	13
381	2016-10-20 08:46:57.422668+02	2016-10-20 08:46:57.422861+02	381	7
382	2016-10-20 08:46:57.470795+02	2016-10-20 08:46:57.470948+02	382	9
383	2016-10-20 08:46:57.525317+02	2016-10-20 08:46:57.525566+02	383	10
384	2016-10-20 08:46:57.576198+02	2016-10-20 08:46:57.576369+02	384	5
385	2016-10-20 08:46:57.625074+02	2016-10-20 08:46:57.625222+02	385	2
386	2016-10-20 08:46:57.673342+02	2016-10-20 08:46:57.673605+02	386	5
387	2016-10-20 08:46:57.720769+02	2016-10-20 08:46:57.720918+02	387	9
388	2016-10-20 08:46:57.768195+02	2016-10-20 08:46:57.768351+02	388	18
389	2016-10-20 08:46:57.817037+02	2016-10-20 08:46:57.817298+02	389	4
390	2016-10-20 08:46:57.8671+02	2016-10-20 08:46:57.867291+02	390	5
391	2016-10-20 08:46:57.91821+02	2016-10-20 08:46:57.918355+02	391	16
392	2016-10-20 08:46:57.969091+02	2016-10-20 08:46:57.969316+02	392	1
393	2016-10-20 08:46:58.020775+02	2016-10-20 08:46:58.021021+02	393	10
394	2016-10-20 08:46:58.072022+02	2016-10-20 08:46:58.072181+02	394	18
\.


--
-- Name: grupos_cursogrupoalumno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('grupos_cursogrupoalumno_id_seq', 394, true);


--
-- Data for Name: grupos_cursogrupoprofesor; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY grupos_cursogrupoprofesor (id, created, modified, curso_grupo_id, profesor_id) FROM stdin;
1	2016-10-20 08:44:01.02822+02	2016-10-20 08:44:01.028451+02	1	10
2	2016-10-20 08:44:01.071567+02	2016-10-20 08:44:01.071717+02	2	10
3	2016-10-20 08:44:01.113644+02	2016-10-20 08:44:01.11379+02	3	10
4	2016-10-20 08:44:01.15262+02	2016-10-20 08:44:01.152756+02	4	10
5	2016-10-20 08:44:01.191745+02	2016-10-20 08:44:01.191878+02	5	10
6	2016-10-20 08:44:01.233078+02	2016-10-20 08:44:01.233211+02	6	10
7	2016-10-20 08:44:01.272274+02	2016-10-20 08:44:01.272409+02	7	10
8	2016-10-20 08:44:01.31971+02	2016-10-20 08:44:01.319838+02	8	10
9	2016-10-20 08:44:01.373945+02	2016-10-20 08:44:01.374175+02	9	10
10	2016-10-20 08:44:01.429695+02	2016-10-20 08:44:01.42985+02	10	10
11	2016-10-20 08:44:01.518187+02	2016-10-20 08:44:01.518325+02	2	11
12	2016-10-20 08:44:01.577351+02	2016-10-20 08:44:01.577491+02	11	11
13	2016-10-20 08:44:01.616052+02	2016-10-20 08:44:01.616208+02	12	11
14	2016-10-20 08:44:01.65373+02	2016-10-20 08:44:01.653859+02	13	11
15	2016-10-20 08:44:01.672955+02	2016-10-20 08:44:01.67309+02	5	11
16	2016-10-20 08:44:01.699998+02	2016-10-20 08:44:01.700193+02	7	11
17	2016-10-20 08:44:01.728407+02	2016-10-20 08:44:01.72855+02	9	11
18	2016-10-20 08:44:01.754583+02	2016-10-20 08:44:01.754726+02	10	11
19	2016-10-20 08:44:01.850187+02	2016-10-20 08:44:01.850317+02	14	12
20	2016-10-20 08:44:01.938651+02	2016-10-20 08:44:01.93878+02	15	13
21	2016-10-20 08:44:01.958381+02	2016-10-20 08:44:01.958538+02	11	13
22	2016-10-20 08:44:01.984443+02	2016-10-20 08:44:01.984579+02	7	13
23	2016-10-20 08:44:02.029526+02	2016-10-20 08:44:02.029662+02	16	13
24	2016-10-20 08:44:02.110649+02	2016-10-20 08:44:02.11078+02	17	14
25	2016-10-20 08:44:02.148287+02	2016-10-20 08:44:02.148421+02	18	14
26	2016-10-20 08:44:02.219957+02	2016-10-20 08:44:02.220125+02	1	15
27	2016-10-20 08:44:02.24732+02	2016-10-20 08:44:02.24746+02	2	15
28	2016-10-20 08:44:02.274278+02	2016-10-20 08:44:02.274453+02	3	15
29	2016-10-20 08:44:02.304186+02	2016-10-20 08:44:02.304355+02	15	15
30	2016-10-20 08:44:02.349415+02	2016-10-20 08:44:02.34955+02	19	15
31	2016-10-20 08:44:02.369549+02	2016-10-20 08:44:02.369717+02	5	15
32	2016-10-20 08:44:02.397418+02	2016-10-20 08:44:02.397611+02	6	15
33	2016-10-20 08:44:02.425584+02	2016-10-20 08:44:02.42576+02	7	15
34	2016-10-20 08:44:02.452027+02	2016-10-20 08:44:02.452163+02	17	15
35	2016-10-20 08:44:02.479891+02	2016-10-20 08:44:02.480064+02	9	15
36	2016-10-20 08:44:02.517686+02	2016-10-20 08:44:02.517855+02	10	15
37	2016-10-20 08:44:02.585105+02	2016-10-20 08:44:02.585312+02	20	15
38	2016-10-20 08:44:02.613269+02	2016-10-20 08:44:02.613415+02	16	15
39	2016-10-20 08:44:02.695972+02	2016-10-20 08:44:02.696152+02	3	16
40	2016-10-20 08:44:02.726198+02	2016-10-20 08:44:02.726373+02	15	16
41	2016-10-20 08:44:02.757407+02	2016-10-20 08:44:02.757609+02	13	16
42	2016-10-20 08:44:02.784091+02	2016-10-20 08:44:02.784226+02	19	16
43	2016-10-20 08:44:02.810428+02	2016-10-20 08:44:02.810584+02	4	16
44	2016-10-20 08:44:02.839063+02	2016-10-20 08:44:02.839226+02	5	16
45	2016-10-20 08:44:02.865392+02	2016-10-20 08:44:02.865651+02	6	16
46	2016-10-20 08:44:02.892076+02	2016-10-20 08:44:02.892223+02	7	16
47	2016-10-20 08:44:02.918281+02	2016-10-20 08:44:02.918416+02	17	16
48	2016-10-20 08:44:02.945522+02	2016-10-20 08:44:02.945668+02	9	16
49	2016-10-20 08:44:02.973266+02	2016-10-20 08:44:02.973437+02	10	16
50	2016-10-20 08:44:03.000318+02	2016-10-20 08:44:03.000519+02	18	16
51	2016-10-20 08:44:03.026792+02	2016-10-20 08:44:03.026937+02	16	16
52	2016-10-20 08:44:03.096457+02	2016-10-20 08:44:03.096632+02	11	17
53	2016-10-20 08:44:03.122923+02	2016-10-20 08:44:03.123059+02	12	17
54	2016-10-20 08:44:03.149617+02	2016-10-20 08:44:03.149755+02	13	17
55	2016-10-20 08:44:03.177237+02	2016-10-20 08:44:03.177413+02	14	17
56	2016-10-20 08:44:03.204435+02	2016-10-20 08:44:03.204569+02	4	17
57	2016-10-20 08:44:03.231062+02	2016-10-20 08:44:03.231202+02	5	17
58	2016-10-20 08:44:03.257253+02	2016-10-20 08:44:03.257391+02	6	17
59	2016-10-20 08:44:03.305424+02	2016-10-20 08:44:03.305615+02	7	17
60	2016-10-20 08:44:03.336608+02	2016-10-20 08:44:03.336825+02	20	17
61	2016-10-20 08:44:03.366182+02	2016-10-20 08:44:03.366338+02	16	17
62	2016-10-20 08:44:03.450845+02	2016-10-20 08:44:03.450992+02	11	18
63	2016-10-20 08:44:03.479518+02	2016-10-20 08:44:03.479698+02	12	18
64	2016-10-20 08:44:03.507176+02	2016-10-20 08:44:03.507324+02	13	18
65	2016-10-20 08:44:03.533701+02	2016-10-20 08:44:03.533857+02	4	18
66	2016-10-20 08:44:03.560857+02	2016-10-20 08:44:03.561003+02	5	18
67	2016-10-20 08:44:03.588337+02	2016-10-20 08:44:03.588498+02	6	18
68	2016-10-20 08:44:03.616556+02	2016-10-20 08:44:03.6167+02	7	18
69	2016-10-20 08:44:03.650626+02	2016-10-20 08:44:03.650773+02	10	18
70	2016-10-20 08:44:03.690235+02	2016-10-20 08:44:03.690409+02	20	18
71	2016-10-20 08:44:03.729426+02	2016-10-20 08:44:03.729604+02	16	18
72	2016-10-20 08:44:03.810604+02	2016-10-20 08:44:03.810743+02	19	19
73	2016-10-20 08:44:03.878848+02	2016-10-20 08:44:03.879034+02	11	20
74	2016-10-20 08:44:03.905594+02	2016-10-20 08:44:03.905831+02	13	20
75	2016-10-20 08:44:03.933621+02	2016-10-20 08:44:03.933754+02	4	20
76	2016-10-20 08:44:03.96348+02	2016-10-20 08:44:03.963638+02	5	20
77	2016-10-20 08:44:03.993619+02	2016-10-20 08:44:03.993758+02	6	20
78	2016-10-20 08:44:04.020855+02	2016-10-20 08:44:04.021021+02	7	20
79	2016-10-20 08:44:04.047515+02	2016-10-20 08:44:04.047654+02	18	20
80	2016-10-20 08:44:04.076143+02	2016-10-20 08:44:04.076288+02	16	20
81	2016-10-20 08:44:04.152984+02	2016-10-20 08:44:04.15312+02	2	21
82	2016-10-20 08:44:04.180864+02	2016-10-20 08:44:04.181007+02	16	21
83	2016-10-20 08:44:04.260065+02	2016-10-20 08:44:04.260209+02	2	22
84	2016-10-20 08:44:04.286526+02	2016-10-20 08:44:04.286662+02	11	22
85	2016-10-20 08:44:04.31268+02	2016-10-20 08:44:04.312869+02	12	22
86	2016-10-20 08:44:04.340014+02	2016-10-20 08:44:04.340181+02	13	22
87	2016-10-20 08:44:04.367622+02	2016-10-20 08:44:04.367838+02	19	22
88	2016-10-20 08:44:04.394335+02	2016-10-20 08:44:04.394475+02	5	22
89	2016-10-20 08:44:04.420264+02	2016-10-20 08:44:04.420397+02	7	22
90	2016-10-20 08:44:04.446355+02	2016-10-20 08:44:04.446497+02	20	22
91	2016-10-20 08:44:04.472928+02	2016-10-20 08:44:04.473068+02	16	22
92	2016-10-20 08:44:04.552614+02	2016-10-20 08:44:04.552753+02	3	23
93	2016-10-20 08:44:04.579007+02	2016-10-20 08:44:04.57915+02	11	23
94	2016-10-20 08:44:04.605142+02	2016-10-20 08:44:04.605275+02	12	23
95	2016-10-20 08:44:04.633253+02	2016-10-20 08:44:04.633421+02	13	23
96	2016-10-20 08:44:04.660126+02	2016-10-20 08:44:04.660273+02	14	23
97	2016-10-20 08:44:04.686478+02	2016-10-20 08:44:04.686619+02	9	23
98	2016-10-20 08:44:04.712857+02	2016-10-20 08:44:04.712994+02	10	23
99	2016-10-20 08:44:04.784283+02	2016-10-20 08:44:04.784456+02	1	24
100	2016-10-20 08:44:04.822697+02	2016-10-20 08:44:04.822867+02	4	24
101	2016-10-20 08:44:04.861799+02	2016-10-20 08:44:04.86196+02	9	24
102	2016-10-20 08:44:04.894313+02	2016-10-20 08:44:04.894527+02	10	24
103	2016-10-20 08:44:04.979861+02	2016-10-20 08:44:04.980033+02	2	25
104	2016-10-20 08:44:05.00667+02	2016-10-20 08:44:05.006806+02	15	25
105	2016-10-20 08:44:05.033378+02	2016-10-20 08:44:05.033578+02	11	25
106	2016-10-20 08:44:05.06116+02	2016-10-20 08:44:05.061339+02	12	25
107	2016-10-20 08:44:05.089945+02	2016-10-20 08:44:05.090081+02	5	25
108	2016-10-20 08:44:05.116976+02	2016-10-20 08:44:05.117143+02	7	25
109	2016-10-20 08:44:05.144962+02	2016-10-20 08:44:05.145106+02	20	25
110	2016-10-20 08:44:05.173401+02	2016-10-20 08:44:05.173573+02	16	25
111	2016-10-20 08:44:05.239998+02	2016-10-20 08:44:05.240165+02	1	26
112	2016-10-20 08:44:05.271932+02	2016-10-20 08:44:05.27209+02	2	26
113	2016-10-20 08:44:05.301666+02	2016-10-20 08:44:05.301923+02	14	26
114	2016-10-20 08:44:05.329905+02	2016-10-20 08:44:05.33005+02	4	26
115	2016-10-20 08:44:05.361264+02	2016-10-20 08:44:05.36144+02	5	26
116	2016-10-20 08:44:05.391934+02	2016-10-20 08:44:05.392087+02	6	26
117	2016-10-20 08:44:05.418153+02	2016-10-20 08:44:05.418288+02	7	26
118	2016-10-20 08:44:05.444734+02	2016-10-20 08:44:05.444878+02	8	26
119	2016-10-20 08:44:05.473422+02	2016-10-20 08:44:05.473594+02	9	26
120	2016-10-20 08:44:05.500273+02	2016-10-20 08:44:05.500412+02	10	26
121	2016-10-20 08:44:05.528357+02	2016-10-20 08:44:05.528498+02	20	26
122	2016-10-20 08:44:05.556715+02	2016-10-20 08:44:05.556883+02	16	26
123	2016-10-20 08:44:05.624277+02	2016-10-20 08:44:05.624453+02	1	27
124	2016-10-20 08:44:05.654788+02	2016-10-20 08:44:05.654958+02	2	27
125	2016-10-20 08:44:05.68508+02	2016-10-20 08:44:05.68525+02	11	27
126	2016-10-20 08:44:05.713162+02	2016-10-20 08:44:05.713365+02	12	27
127	2016-10-20 08:44:05.740108+02	2016-10-20 08:44:05.740245+02	13	27
128	2016-10-20 08:44:05.767184+02	2016-10-20 08:44:05.767325+02	19	27
129	2016-10-20 08:44:05.79555+02	2016-10-20 08:44:05.79569+02	4	27
130	2016-10-20 08:44:05.822153+02	2016-10-20 08:44:05.822289+02	5	27
131	2016-10-20 08:44:05.850024+02	2016-10-20 08:44:05.850165+02	6	27
132	2016-10-20 08:44:05.879368+02	2016-10-20 08:44:05.879571+02	7	27
133	2016-10-20 08:44:05.91888+02	2016-10-20 08:44:05.919032+02	9	27
134	2016-10-20 08:44:05.959202+02	2016-10-20 08:44:05.95938+02	10	27
135	2016-10-20 08:44:05.998431+02	2016-10-20 08:44:05.998593+02	18	27
136	2016-10-20 08:44:06.037149+02	2016-10-20 08:44:06.037295+02	20	27
137	2016-10-20 08:44:06.06705+02	2016-10-20 08:44:06.06719+02	16	27
138	2016-10-20 08:44:06.13483+02	2016-10-20 08:44:06.134966+02	12	28
139	2016-10-20 08:44:06.161141+02	2016-10-20 08:44:06.161605+02	13	28
140	2016-10-20 08:44:06.189069+02	2016-10-20 08:44:06.189236+02	19	28
141	2016-10-20 08:44:06.216658+02	2016-10-20 08:44:06.216795+02	5	28
142	2016-10-20 08:44:06.243245+02	2016-10-20 08:44:06.243402+02	6	28
143	2016-10-20 08:44:06.269866+02	2016-10-20 08:44:06.270007+02	7	28
144	2016-10-20 08:44:06.29609+02	2016-10-20 08:44:06.296234+02	9	28
145	2016-10-20 08:44:06.323845+02	2016-10-20 08:44:06.324012+02	18	28
146	2016-10-20 08:44:06.350864+02	2016-10-20 08:44:06.351015+02	20	28
147	2016-10-20 08:44:06.377166+02	2016-10-20 08:44:06.377311+02	16	28
148	2016-10-20 08:44:06.447038+02	2016-10-20 08:44:06.447208+02	11	29
149	2016-10-20 08:44:06.477485+02	2016-10-20 08:44:06.477633+02	13	29
150	2016-10-20 08:44:06.506429+02	2016-10-20 08:44:06.506622+02	19	29
151	2016-10-20 08:44:06.535634+02	2016-10-20 08:44:06.535802+02	4	29
152	2016-10-20 08:44:06.562263+02	2016-10-20 08:44:06.562407+02	5	29
153	2016-10-20 08:44:06.591519+02	2016-10-20 08:44:06.591673+02	6	29
154	2016-10-20 08:44:06.622047+02	2016-10-20 08:44:06.622222+02	7	29
155	2016-10-20 08:44:06.649979+02	2016-10-20 08:44:06.650117+02	18	29
156	2016-10-20 08:44:06.67638+02	2016-10-20 08:44:06.676524+02	16	29
157	2016-10-20 08:44:06.771676+02	2016-10-20 08:44:06.771807+02	21	30
158	2016-10-20 08:44:06.809631+02	2016-10-20 08:44:06.809766+02	22	30
159	2016-10-20 08:44:06.86844+02	2016-10-20 08:44:06.868616+02	2	31
160	2016-10-20 08:44:06.895633+02	2016-10-20 08:44:06.895808+02	13	31
161	2016-10-20 08:44:06.924801+02	2016-10-20 08:44:06.924973+02	4	31
162	2016-10-20 08:44:06.951697+02	2016-10-20 08:44:06.951837+02	5	31
163	2016-10-20 08:44:06.978118+02	2016-10-20 08:44:06.97826+02	6	31
164	2016-10-20 08:44:07.004266+02	2016-10-20 08:44:07.004404+02	7	31
165	2016-10-20 08:44:07.032099+02	2016-10-20 08:44:07.032271+02	20	31
166	2016-10-20 08:44:07.124808+02	2016-10-20 08:44:07.124958+02	21	32
167	2016-10-20 08:44:07.16425+02	2016-10-20 08:44:07.164435+02	22	32
168	2016-10-20 08:44:07.257047+02	2016-10-20 08:44:07.257301+02	2	33
169	2016-10-20 08:44:07.28513+02	2016-10-20 08:44:07.28527+02	15	33
170	2016-10-20 08:44:07.311444+02	2016-10-20 08:44:07.311581+02	20	33
171	2016-10-20 08:44:07.338034+02	2016-10-20 08:44:07.338175+02	16	33
172	2016-10-20 08:44:07.417509+02	2016-10-20 08:44:07.417641+02	1	34
173	2016-10-20 08:44:07.444215+02	2016-10-20 08:44:07.444387+02	3	34
174	2016-10-20 08:44:07.474278+02	2016-10-20 08:44:07.474442+02	6	34
175	2016-10-20 08:44:07.500645+02	2016-10-20 08:44:07.500782+02	7	34
176	2016-10-20 08:44:07.570308+02	2016-10-20 08:44:07.570473+02	1	35
177	2016-10-20 08:44:07.59692+02	2016-10-20 08:44:07.597059+02	2	35
178	2016-10-20 08:44:07.624986+02	2016-10-20 08:44:07.625169+02	11	35
179	2016-10-20 08:44:07.654404+02	2016-10-20 08:44:07.654608+02	12	35
180	2016-10-20 08:44:07.681844+02	2016-10-20 08:44:07.682019+02	13	35
181	2016-10-20 08:44:07.709545+02	2016-10-20 08:44:07.709714+02	14	35
182	2016-10-20 08:44:07.737379+02	2016-10-20 08:44:07.737537+02	8	35
183	2016-10-20 08:44:07.768714+02	2016-10-20 08:44:07.76932+02	20	35
184	2016-10-20 08:44:07.839621+02	2016-10-20 08:44:07.83979+02	11	36
185	2016-10-20 08:44:07.867959+02	2016-10-20 08:44:07.868106+02	12	36
186	2016-10-20 08:44:07.895293+02	2016-10-20 08:44:07.895456+02	13	36
187	2016-10-20 08:44:07.921858+02	2016-10-20 08:44:07.921992+02	4	36
188	2016-10-20 08:44:07.948332+02	2016-10-20 08:44:07.948473+02	5	36
189	2016-10-20 08:44:07.976614+02	2016-10-20 08:44:07.976778+02	6	36
190	2016-10-20 08:44:08.004729+02	2016-10-20 08:44:08.004893+02	7	36
191	2016-10-20 08:44:08.031476+02	2016-10-20 08:44:08.031674+02	9	36
192	2016-10-20 08:44:08.097453+02	2016-10-20 08:44:08.097595+02	19	37
193	2016-10-20 08:44:08.12357+02	2016-10-20 08:44:08.123777+02	17	37
194	2016-10-20 08:44:08.152566+02	2016-10-20 08:44:08.15272+02	18	37
195	2016-10-20 08:44:08.228194+02	2016-10-20 08:44:08.228347+02	15	38
196	2016-10-20 08:44:08.267454+02	2016-10-20 08:44:08.2676+02	19	38
197	2016-10-20 08:44:08.310859+02	2016-10-20 08:44:08.311032+02	17	38
198	2016-10-20 08:44:08.349344+02	2016-10-20 08:44:08.349496+02	9	38
199	2016-10-20 08:44:08.380499+02	2016-10-20 08:44:08.380678+02	20	38
200	2016-10-20 08:44:08.408633+02	2016-10-20 08:44:08.408775+02	16	38
201	2016-10-20 08:44:08.477542+02	2016-10-20 08:44:08.47772+02	2	39
202	2016-10-20 08:44:08.505759+02	2016-10-20 08:44:08.50594+02	3	39
203	2016-10-20 08:44:08.532033+02	2016-10-20 08:44:08.532169+02	15	39
204	2016-10-20 08:44:08.56066+02	2016-10-20 08:44:08.560804+02	4	39
205	2016-10-20 08:44:08.588453+02	2016-10-20 08:44:08.588624+02	5	39
206	2016-10-20 08:44:08.616183+02	2016-10-20 08:44:08.616321+02	7	39
207	2016-10-20 08:44:08.681949+02	2016-10-20 08:44:08.682091+02	21	40
208	2016-10-20 08:44:08.708392+02	2016-10-20 08:44:08.70853+02	22	40
209	2016-10-20 08:44:08.786635+02	2016-10-20 08:44:08.786775+02	1	41
210	2016-10-20 08:44:08.812532+02	2016-10-20 08:44:08.812669+02	3	41
211	2016-10-20 08:44:08.892926+02	2016-10-20 08:44:08.893068+02	4	42
212	2016-10-20 08:44:08.921351+02	2016-10-20 08:44:08.921486+02	5	42
213	2016-10-20 08:44:08.949025+02	2016-10-20 08:44:08.949194+02	9	42
214	2016-10-20 08:44:08.976882+02	2016-10-20 08:44:08.977029+02	10	42
215	2016-10-20 08:44:09.003111+02	2016-10-20 08:44:09.003247+02	20	42
216	2016-10-20 08:44:09.029509+02	2016-10-20 08:44:09.029653+02	16	42
217	2016-10-20 08:44:09.098038+02	2016-10-20 08:44:09.098181+02	1	43
218	2016-10-20 08:44:09.124177+02	2016-10-20 08:44:09.124349+02	2	43
219	2016-10-20 08:44:09.150672+02	2016-10-20 08:44:09.150827+02	3	43
220	2016-10-20 08:44:09.177073+02	2016-10-20 08:44:09.177222+02	15	43
221	2016-10-20 08:44:09.242671+02	2016-10-20 08:44:09.242812+02	11	44
222	2016-10-20 08:44:09.269565+02	2016-10-20 08:44:09.269736+02	12	44
223	2016-10-20 08:44:09.297769+02	2016-10-20 08:44:09.297909+02	13	44
224	2016-10-20 08:44:09.323762+02	2016-10-20 08:44:09.323894+02	9	44
225	2016-10-20 08:44:09.352092+02	2016-10-20 08:44:09.352239+02	10	44
226	2016-10-20 08:44:09.445215+02	2016-10-20 08:44:09.445367+02	19	45
227	2016-10-20 08:44:09.484216+02	2016-10-20 08:44:09.484366+02	4	45
228	2016-10-20 08:44:09.516519+02	2016-10-20 08:44:09.516662+02	5	45
229	2016-10-20 08:44:09.543002+02	2016-10-20 08:44:09.543212+02	6	45
230	2016-10-20 08:44:09.56955+02	2016-10-20 08:44:09.569703+02	7	45
231	2016-10-20 08:44:09.597219+02	2016-10-20 08:44:09.59739+02	17	45
232	2016-10-20 08:44:09.625005+02	2016-10-20 08:44:09.625151+02	18	45
233	2016-10-20 08:44:09.692557+02	2016-10-20 08:44:09.692734+02	11	46
234	2016-10-20 08:44:09.720276+02	2016-10-20 08:44:09.720416+02	12	46
235	2016-10-20 08:44:09.749389+02	2016-10-20 08:44:09.74953+02	13	46
236	2016-10-20 08:44:09.777253+02	2016-10-20 08:44:09.777434+02	9	46
237	2016-10-20 08:44:09.804731+02	2016-10-20 08:44:09.804867+02	10	46
238	2016-10-20 08:44:09.832013+02	2016-10-20 08:44:09.832154+02	18	46
239	2016-10-20 08:44:09.858381+02	2016-10-20 08:44:09.858532+02	20	46
240	2016-10-20 08:44:09.884837+02	2016-10-20 08:44:09.885038+02	16	46
241	2016-10-20 08:44:09.951088+02	2016-10-20 08:44:09.95123+02	4	47
242	2016-10-20 08:44:09.977477+02	2016-10-20 08:44:09.977654+02	5	47
243	2016-10-20 08:44:10.004374+02	2016-10-20 08:44:10.004514+02	6	47
244	2016-10-20 08:44:10.031591+02	2016-10-20 08:44:10.031731+02	7	47
245	2016-10-20 08:44:10.10076+02	2016-10-20 08:44:10.100922+02	13	48
246	2016-10-20 08:44:10.130001+02	2016-10-20 08:44:10.130166+02	4	48
247	2016-10-20 08:44:10.158048+02	2016-10-20 08:44:10.158191+02	6	48
248	2016-10-20 08:44:10.184618+02	2016-10-20 08:44:10.184758+02	7	48
249	2016-10-20 08:44:10.211819+02	2016-10-20 08:44:10.21198+02	9	48
250	2016-10-20 08:44:10.238708+02	2016-10-20 08:44:10.238847+02	10	48
251	2016-10-20 08:44:10.305398+02	2016-10-20 08:44:10.305537+02	1	49
252	2016-10-20 08:44:10.332626+02	2016-10-20 08:44:10.332764+02	3	49
253	2016-10-20 08:44:10.361631+02	2016-10-20 08:44:10.361776+02	4	49
254	2016-10-20 08:44:10.389421+02	2016-10-20 08:44:10.389669+02	6	49
255	2016-10-20 08:44:10.416905+02	2016-10-20 08:44:10.417042+02	10	49
256	2016-10-20 08:44:10.494819+02	2016-10-20 08:44:10.494962+02	2	50
257	2016-10-20 08:44:10.53011+02	2016-10-20 08:44:10.530259+02	15	50
258	2016-10-20 08:44:10.569213+02	2016-10-20 08:44:10.569406+02	21	50
259	2016-10-20 08:44:10.608628+02	2016-10-20 08:44:10.608845+02	22	50
260	2016-10-20 08:44:10.647803+02	2016-10-20 08:44:10.647958+02	20	50
261	2016-10-20 08:44:10.676749+02	2016-10-20 08:44:10.676894+02	16	50
262	2016-10-20 08:44:10.738795+02	2016-10-20 08:44:10.738933+02	15	2
263	2016-10-20 08:44:10.800303+02	2016-10-20 08:44:10.800461+02	8	4
264	2016-10-20 08:44:10.869454+02	2016-10-20 08:44:10.869623+02	1	51
265	2016-10-20 08:44:10.895978+02	2016-10-20 08:44:10.896122+02	3	51
266	2016-10-20 08:44:10.925358+02	2016-10-20 08:44:10.925536+02	15	51
267	2016-10-20 08:44:10.955858+02	2016-10-20 08:44:10.956326+02	4	51
268	2016-10-20 08:44:10.982973+02	2016-10-20 08:44:10.983114+02	6	51
269	2016-10-20 08:44:11.00943+02	2016-10-20 08:44:11.009571+02	18	51
270	2016-10-20 08:44:11.037096+02	2016-10-20 08:44:11.037265+02	16	51
271	2016-10-20 08:44:11.104569+02	2016-10-20 08:44:11.10471+02	1	52
272	2016-10-20 08:44:11.131455+02	2016-10-20 08:44:11.131593+02	3	52
273	2016-10-20 08:44:11.158176+02	2016-10-20 08:44:11.15832+02	12	52
274	2016-10-20 08:44:11.185105+02	2016-10-20 08:44:11.185281+02	13	52
275	2016-10-20 08:44:11.214281+02	2016-10-20 08:44:11.21442+02	14	52
276	2016-10-20 08:44:11.24123+02	2016-10-20 08:44:11.241373+02	8	52
277	2016-10-20 08:44:11.269667+02	2016-10-20 08:44:11.269837+02	9	52
278	2016-10-20 08:44:11.296331+02	2016-10-20 08:44:11.296475+02	10	52
279	2016-10-20 08:44:11.365652+02	2016-10-20 08:44:11.36582+02	3	53
280	2016-10-20 08:44:11.392519+02	2016-10-20 08:44:11.392657+02	12	53
281	2016-10-20 08:44:11.419682+02	2016-10-20 08:44:11.419845+02	5	53
282	2016-10-20 08:44:11.449369+02	2016-10-20 08:44:11.449539+02	10	53
283	2016-10-20 08:44:11.476256+02	2016-10-20 08:44:11.476457+02	16	53
284	2016-10-20 08:44:11.542711+02	2016-10-20 08:44:11.542864+02	11	54
285	2016-10-20 08:44:11.56927+02	2016-10-20 08:44:11.569409+02	12	54
286	2016-10-20 08:44:11.595853+02	2016-10-20 08:44:11.595993+02	13	54
287	2016-10-20 08:44:11.669308+02	2016-10-20 08:44:11.669457+02	4	55
288	2016-10-20 08:44:11.708829+02	2016-10-20 08:44:11.708974+02	5	55
289	2016-10-20 08:44:11.747928+02	2016-10-20 08:44:11.748086+02	6	55
290	2016-10-20 08:44:11.787329+02	2016-10-20 08:44:11.787481+02	10	55
291	2016-10-20 08:44:11.826112+02	2016-10-20 08:44:11.826266+02	20	55
\.


--
-- Name: grupos_cursogrupoprofesor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('grupos_cursogrupoprofesor_id_seq', 291, true);


--
-- Data for Name: grupos_grupo; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY grupos_grupo (id, created, modified, grupo, descripcion, slug) FROM stdin;
1	2016-10-20 08:44:00.953842+02	2016-10-20 08:44:00.95421+02	B1CT		B1CT
2	2016-10-20 08:44:01.043671+02	2016-10-20 08:44:01.043865+02	B1HCS		B1HCS
3	2016-10-20 08:44:01.085839+02	2016-10-20 08:44:01.086067+02	B2CT		B2CT
4	2016-10-20 08:44:01.126095+02	2016-10-20 08:44:01.126298+02	2AE		2AE
5	2016-10-20 08:44:01.165782+02	2016-10-20 08:44:01.166011+02	2BE		2BE
6	2016-10-20 08:44:01.204939+02	2016-10-20 08:44:01.205123+02	2CE		2CE
7	2016-10-20 08:44:01.245901+02	2016-10-20 08:44:01.246101+02	2DE		2DE
8	2016-10-20 08:44:01.285561+02	2016-10-20 08:44:01.290813+02	2ºFPB		2oFPB
9	2016-10-20 08:44:01.334466+02	2016-10-20 08:44:01.334822+02	3AE		3AE
10	2016-10-20 08:44:01.393555+02	2016-10-20 08:44:01.393768+02	3BE		3BE
11	2016-10-20 08:44:01.549633+02	2016-10-20 08:44:01.549788+02	1AE		1AE
12	2016-10-20 08:44:01.589631+02	2016-10-20 08:44:01.589779+02	1BE		1BE
13	2016-10-20 08:44:01.628836+02	2016-10-20 08:44:01.628996+02	1CE		1CE
14	2016-10-20 08:44:01.825088+02	2016-10-20 08:44:01.825253+02	1ºFPB		1oFPB
15	2016-10-20 08:44:01.913242+02	2016-10-20 08:44:01.913395+02	B2HCS		B2HCS
16	2016-10-20 08:44:02.003918+02	2016-10-20 08:44:02.004073+02	4BE		4BE
17	2016-10-20 08:44:02.084072+02	2016-10-20 08:44:02.084266+02	2ºPMAR		2oPMAR
18	2016-10-20 08:44:02.1229+02	2016-10-20 08:44:02.123052+02	4º PRAGE		4o-PRAGE
19	2016-10-20 08:44:02.324017+02	2016-10-20 08:44:02.324181+02	1ºPMAR		1oPMAR
20	2016-10-20 08:44:02.546912+02	2016-10-20 08:44:02.547178+02	4AE		4AE
21	2016-10-20 08:44:06.746319+02	2016-10-20 08:44:06.746485+02	1ºAPSD		1oAPSD
22	2016-10-20 08:44:06.784352+02	2016-10-20 08:44:06.784514+02	2ºAPSD		2oAPSD
\.


--
-- Name: grupos_grupo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('grupos_grupo_id_seq', 22, true);


--
-- Data for Name: rayuela_rayuela; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY rayuela_rayuela (id, created, modified, tipo, archivo, procesado, resultado, curso_id) FROM stdin;
1	2016-10-19 13:02:08.246268+02	2016-10-20 08:44:11.840605+02	PR	rayuela/2016/10/19/ExportacionDatosProfesorado.xml	t	<h5>Resultado del proceso</h5><ul>Procesando profesor Acosta Guerrero, Víctor Manuel<li>Se ha creado el profesor Acosta Guerrero, Víctor Manuel</li><li>Se ha creado el departamento Tecnologia</li><li>Se ha creado el departamento Tecnologia en el curso 2016/2017</li><li>Se ha asignado el profesor Acosta Guerrero, Víctor Manuel al departamento 2016/2017 - Tecnologia - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha creado el grupo B1CT</li><li>Se ha creado el grupo B1CT en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo B1HCS</li><li>Se ha creado el grupo B1HCS en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo B2CT</li><li>Se ha creado el grupo B2CT en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 2AE</li><li>Se ha creado el grupo 2AE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 2BE</li><li>Se ha creado el grupo 2BE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 2CE</li><li>Se ha creado el grupo 2CE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 2DE</li><li>Se ha creado el grupo 2DE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 2ºFPB</li><li>Se ha creado el grupo 2ºFPB en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºFPB - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - 2ºFPB - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 3AE</li><li>Se ha creado el grupo 3AE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 3BE</li><li>Se ha creado el grupo 3BE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Acosta Guerrero, Víctor Manuel  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Antúnez Gabardino, María Eulalia<li>Se ha creado el profesor Antúnez Gabardino, María Eulalia</li><li>Se ha creado el departamento Ingles</li><li>Se ha creado el departamento Ingles en el curso 2016/2017</li><li>Se ha asignado el profesor Antúnez Gabardino, María Eulalia al departamento 2016/2017 - Ingles - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Antúnez Gabardino, María Eulalia  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 1AE</li><li>Se ha creado el grupo 1AE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Antúnez Gabardino, María Eulalia  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 1BE</li><li>Se ha creado el grupo 1BE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Antúnez Gabardino, María Eulalia  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 1CE</li><li>Se ha creado el grupo 1CE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Antúnez Gabardino, María Eulalia  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Antúnez Gabardino, María Eulalia  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Antúnez Gabardino, María Eulalia  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Antúnez Gabardino, María Eulalia  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Antúnez Gabardino, María Eulalia  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Arroyo Sánchez, Alberto Pablo<li>Se ha creado el profesor Arroyo Sánchez, Alberto Pablo</li><li>Se ha creado el departamento Orientacion</li><li>Se ha creado el departamento Orientacion en el curso 2016/2017</li><li>Se ha asignado el profesor Arroyo Sánchez, Alberto Pablo al departamento 2016/2017 - Orientacion - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha creado el grupo 1ºFPB</li><li>Se ha creado el grupo 1ºFPB en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºFPB - Sin asignar tutoría - Arroyo Sánchez, Alberto Pablo  al grupo 2016/2017 - 1ºFPB - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Báez Aradilla, José Gabriel<li>Se ha creado el profesor Báez Aradilla, José Gabriel</li><li>Se ha creado el departamento Matematicas</li><li>Se ha creado el departamento Matematicas en el curso 2016/2017</li><li>Se ha asignado el profesor Báez Aradilla, José Gabriel al departamento 2016/2017 - Matematicas - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha creado el grupo B2HCS</li><li>Se ha creado el grupo B2HCS en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Báez Aradilla, José Gabriel  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Báez Aradilla, José Gabriel  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Báez Aradilla, José Gabriel  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 4BE</li><li>Se ha creado el grupo 4BE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Báez Aradilla, José Gabriel  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Barbecho Terrón, Manuel<li>Se ha creado el profesor Barbecho Terrón, Manuel</li><li>Se ha asignado el profesor Barbecho Terrón, Manuel al departamento 2016/2017 - Orientacion - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha creado el grupo 2ºPMAR</li><li>Se ha creado el grupo 2ºPMAR en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºPMAR - Sin asignar tutoría - Barbecho Terrón, Manuel  al grupo 2016/2017 - 2ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 4º PRAGE</li><li>Se ha creado el grupo 4º PRAGE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - Barbecho Terrón, Manuel  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Cardoso Barbecho, José Luis<li>Se ha creado el profesor Cardoso Barbecho, José Luis</li><li>Se ha creado el departamento Filosofia</li><li>Se ha creado el departamento Filosofia en el curso 2016/2017</li><li>Se ha asignado el profesor Cardoso Barbecho, José Luis al departamento 2016/2017 - Filosofia - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 1ºPMAR</li><li>Se ha creado el grupo 1ºPMAR en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºPMAR - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - 2ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 4AE</li><li>Se ha creado el grupo 4AE en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Cardoso Barbecho, José Luis  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Caro Puértolas, María Elena<li>Se ha creado el profesor Caro Puértolas, María Elena</li><li>Se ha creado el departamento Educacion_Fisica</li><li>Se ha creado el departamento Educacion_Fisica en el curso 2016/2017</li><li>Se ha asignado el profesor Caro Puértolas, María Elena al departamento 2016/2017 - Educacion_Fisica - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºPMAR - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 2ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Caro Puértolas, María Elena  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Castañeda Bellido, María Isabel<li>Se ha creado el profesor Castañeda Bellido, María Isabel</li><li>Se ha asignado el profesor Castañeda Bellido, María Isabel al departamento 2016/2017 - Ingles - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºFPB - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 1ºFPB - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Castañeda Bellido, María Isabel  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Corchero García, Isabel<li>Se ha creado el profesor Corchero García, Isabel</li><li>Se ha creado el departamento Geografia_e_Historia</li><li>Se ha creado el departamento Geografia_e_Historia en el curso 2016/2017</li><li>Se ha asignado el profesor Corchero García, Isabel al departamento 2016/2017 - Geografia_e_Historia - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Corchero García, Isabel  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Da Silva Martín, Libania de los Ángel<li>Se ha creado el profesor Da Silva Martín, Libania de los Ángel</li><li>Se ha asignado el profesor Da Silva Martín, Libania de los Ángel al departamento 2016/2017 - Orientacion - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - Da Silva Martín, Libania de los Ángel  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor De Castro Calderón, Rosario<li>Se ha creado el profesor De Castro Calderón, Rosario</li><li>Se ha asignado el profesor De Castro Calderón, Rosario al departamento 2016/2017 - Orientacion - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - De Castro Calderón, Rosario  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - De Castro Calderón, Rosario  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - De Castro Calderón, Rosario  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - De Castro Calderón, Rosario  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - De Castro Calderón, Rosario  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - De Castro Calderón, Rosario  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - De Castro Calderón, Rosario  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - De Castro Calderón, Rosario  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor De la Vega Sánchez, Loreto Inmaculada<li>Se ha creado el profesor De la Vega Sánchez, Loreto Inmaculada</li><li>Se ha creado el departamento Lengua_Castellana_y_Literatura</li><li>Se ha creado el departamento Lengua_Castellana_y_Literatura en el curso 2016/2017</li><li>Se ha asignado el profesor De la Vega Sánchez, Loreto Inmaculada al departamento 2016/2017 - Lengua_Castellana_y_Literatura - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - De la Vega Sánchez, Loreto Inmaculada  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - De la Vega Sánchez, Loreto Inmaculada  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Díaz González, Luisa<li>Se ha creado el profesor Díaz González, Luisa</li><li>Se ha creado el departamento Musica</li><li>Se ha creado el departamento Musica en el curso 2016/2017</li><li>Se ha asignado el profesor Díaz González, Luisa al departamento 2016/2017 - Musica - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Díaz González, Luisa  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Díaz González, Luisa  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Díaz González, Luisa  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Díaz González, Luisa  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - Díaz González, Luisa  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Díaz González, Luisa  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Díaz González, Luisa  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Díaz González, Luisa  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Díaz González, Luisa  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Domínguez Zapata, Francisca<li>Se ha creado el profesor Domínguez Zapata, Francisca</li><li>Se ha creado el departamento Artes_Plasticas</li><li>Se ha creado el departamento Artes_Plasticas en el curso 2016/2017</li><li>Se ha asignado el profesor Domínguez Zapata, Francisca al departamento 2016/2017 - Artes_Plasticas - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Domínguez Zapata, Francisca  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Domínguez Zapata, Francisca  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Domínguez Zapata, Francisca  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Domínguez Zapata, Francisca  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºFPB - Sin asignar tutoría - Domínguez Zapata, Francisca  al grupo 2016/2017 - 1ºFPB - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Domínguez Zapata, Francisca  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Domínguez Zapata, Francisca  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Fernández Muñoz, José Alejandro<li>Se ha creado el profesor Fernández Muñoz, José Alejandro</li><li>Se ha asignado el profesor Fernández Muñoz, José Alejandro al departamento 2016/2017 - Matematicas - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Fernández Muñoz, José Alejandro  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Fernández Muñoz, José Alejandro  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Fernández Muñoz, José Alejandro  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Fernández Muñoz, José Alejandro  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Fonseca Cantos, María del Carmen<li>Se ha creado el profesor Fonseca Cantos, María del Carmen</li><li>Se ha creado el departamento Frances</li><li>Se ha creado el departamento Frances en el curso 2016/2017</li><li>Se ha asignado el profesor Fonseca Cantos, María del Carmen al departamento 2016/2017 - Frances - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Fonseca Cantos, María del Carmen  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Fonseca Cantos, María del Carmen  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Fonseca Cantos, María del Carmen  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Fonseca Cantos, María del Carmen  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Fonseca Cantos, María del Carmen  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Fonseca Cantos, María del Carmen  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Fonseca Cantos, María del Carmen  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Fonseca Cantos, María del Carmen  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Fuentes Barrientos, Daniel<li>Se ha creado el profesor Fuentes Barrientos, Daniel</li><li>Se ha asignado el profesor Fuentes Barrientos, Daniel al departamento 2016/2017 - Tecnologia - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºFPB - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 1ºFPB - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºFPB - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 2ºFPB - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Fuentes Barrientos, Daniel  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor García Hernández, Teresa<li>Se ha creado el profesor García Hernández, Teresa</li><li>Se ha asignado el profesor García Hernández, Teresa al departamento 2016/2017 - Tecnologia - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - García Hernández, Teresa  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor García Rodríguez, María Angustias<li>Se ha creado el profesor García Rodríguez, María Angustias</li><li>Se ha asignado el profesor García Rodríguez, María Angustias al departamento 2016/2017 - Geografia_e_Historia - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - García Rodríguez, María Angustias  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Garduño Cobos, Eva<li>Se ha creado el profesor Garduño Cobos, Eva</li><li>Se ha asignado el profesor Garduño Cobos, Eva al departamento 2016/2017 - Orientacion - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Garduño Cobos, Eva  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Garduño Cobos, Eva  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - Garduño Cobos, Eva  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Garduño Cobos, Eva  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Garduño Cobos, Eva  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Garduño Cobos, Eva  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Garduño Cobos, Eva  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - Garduño Cobos, Eva  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Garduño Cobos, Eva  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Garzón Carrascal, Almudena<li>Se ha creado el profesor Garzón Carrascal, Almudena</li><li>Se ha creado el departamento Fam._Prof._Servicios_socioculturales_y_a_la_comunidad</li><li>Se ha creado el departamento Fam._Prof._Servicios_socioculturales_y_a_la_comunidad en el curso 2016/2017</li><li>Se ha asignado el profesor Garzón Carrascal, Almudena al departamento 2016/2017 - Fam._Prof._Servicios_socioculturales_y_a_la_comunidad - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha creado el grupo 1ºAPSD</li><li>Se ha creado el grupo 1ºAPSD en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºAPSD - Sin asignar tutoría - Garzón Carrascal, Almudena  al grupo 2016/2017 - 1ºAPSD - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha creado el grupo 2ºAPSD</li><li>Se ha creado el grupo 2ºAPSD en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºAPSD - Sin asignar tutoría - Garzón Carrascal, Almudena  al grupo 2016/2017 - 2ºAPSD - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Gómez Albarrán, Concepción<li>Se ha creado el profesor Gómez Albarrán, Concepción</li><li>Se ha asignado el profesor Gómez Albarrán, Concepción al departamento 2016/2017 - Matematicas - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Gómez Albarrán, Concepción  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Gómez Albarrán, Concepción  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Gómez Albarrán, Concepción  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Gómez Albarrán, Concepción  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Gómez Albarrán, Concepción  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Gómez Albarrán, Concepción  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Gómez Albarrán, Concepción  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor González Martínez, Eulalia<li>Se ha creado el profesor González Martínez, Eulalia</li><li>Se ha asignado el profesor González Martínez, Eulalia al departamento 2016/2017 - Fam._Prof._Servicios_socioculturales_y_a_la_comunidad - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºAPSD - Sin asignar tutoría - González Martínez, Eulalia  al grupo 2016/2017 - 1ºAPSD - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºAPSD - Sin asignar tutoría - González Martínez, Eulalia  al grupo 2016/2017 - 2ºAPSD - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Ledesma Mestre, Juan Carlos<li>Se ha creado el profesor Ledesma Mestre, Juan Carlos</li><li>Se ha creado el departamento Latin</li><li>Se ha creado el departamento Latin en el curso 2016/2017</li><li>Se ha asignado el profesor Ledesma Mestre, Juan Carlos al departamento 2016/2017 - Latin - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Ledesma Mestre, Juan Carlos  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Ledesma Mestre, Juan Carlos  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Ledesma Mestre, Juan Carlos  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Ledesma Mestre, Juan Carlos  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Macedo García, María Josefa<li>Se ha creado el profesor Macedo García, María Josefa</li><li>Se ha creado el departamento Actividades_Complementarias_y_Extraescolares</li><li>Se ha creado el departamento Actividades_Complementarias_y_Extraescolares en el curso 2016/2017</li><li>Se ha asignado el profesor Macedo García, María Josefa al departamento 2016/2017 - Actividades_Complementarias_y_Extraescolares - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Macedo García, María Josefa  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Macedo García, María Josefa  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Macedo García, María Josefa  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Macedo García, María Josefa  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Manzano Pando, José<li>Se ha creado el profesor Manzano Pando, José</li><li>Se ha asignado el profesor Manzano Pando, José al departamento 2016/2017 - Educacion_Fisica - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Manzano Pando, José  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Manzano Pando, José  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Manzano Pando, José  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Manzano Pando, José  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Manzano Pando, José  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºFPB - Sin asignar tutoría - Manzano Pando, José  al grupo 2016/2017 - 1ºFPB - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºFPB - Sin asignar tutoría - Manzano Pando, José  al grupo 2016/2017 - 2ºFPB - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Manzano Pando, José  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Martín Cámara, Alicia<li>Se ha creado el profesor Martín Cámara, Alicia</li><li>Se ha asignado el profesor Martín Cámara, Alicia al departamento 2016/2017 - Lengua_Castellana_y_Literatura - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Martín Cámara, Alicia  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Martín Cámara, Alicia  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Martín Cámara, Alicia  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Martín Cámara, Alicia  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Martín Cámara, Alicia  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Martín Cámara, Alicia  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Martín Cámara, Alicia  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Martín Cámara, Alicia  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Méndez Torrescusa, María Concepción<li>Se ha creado el profesor Méndez Torrescusa, María Concepción</li><li>Se ha asignado el profesor Méndez Torrescusa, María Concepción al departamento 2016/2017 - Orientacion - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - Méndez Torrescusa, María Concepción  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºPMAR - Sin asignar tutoría - Méndez Torrescusa, María Concepción  al grupo 2016/2017 - 2ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - Méndez Torrescusa, María Concepción  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Mesa Navarro, Rita María<li>Se ha creado el profesor Mesa Navarro, Rita María</li><li>Se ha asignado el profesor Mesa Navarro, Rita María al departamento 2016/2017 - Ingles - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Mesa Navarro, Rita María  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - Mesa Navarro, Rita María  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºPMAR - Sin asignar tutoría - Mesa Navarro, Rita María  al grupo 2016/2017 - 2ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Mesa Navarro, Rita María  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Mesa Navarro, Rita María  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Mesa Navarro, Rita María  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Nogués Chavero, Pablo Luis<li>Se ha creado el profesor Nogués Chavero, Pablo Luis</li><li>Se ha asignado el profesor Nogués Chavero, Pablo Luis al departamento 2016/2017 - Geografia_e_Historia - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Nogués Chavero, Pablo Luis  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Nogués Chavero, Pablo Luis  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Nogués Chavero, Pablo Luis  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Nogués Chavero, Pablo Luis  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Nogués Chavero, Pablo Luis  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Nogués Chavero, Pablo Luis  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Nogués Chavero, Sergio Gabino<li>Se ha creado el profesor Nogués Chavero, Sergio Gabino</li><li>Se ha asignado el profesor Nogués Chavero, Sergio Gabino al departamento 2016/2017 - Fam._Prof._Servicios_socioculturales_y_a_la_comunidad - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºAPSD - Sin asignar tutoría - Nogués Chavero, Sergio Gabino  al grupo 2016/2017 - 1ºAPSD - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºAPSD - Sin asignar tutoría - Nogués Chavero, Sergio Gabino  al grupo 2016/2017 - 2ºAPSD - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Nogués Chaves, Manuel<li>Se ha creado el profesor Nogués Chaves, Manuel</li><li>Se ha creado el departamento Ciencias_Naturales</li><li>Se ha creado el departamento Ciencias_Naturales en el curso 2016/2017</li><li>Se ha asignado el profesor Nogués Chaves, Manuel al departamento 2016/2017 - Ciencias_Naturales - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Nogués Chaves, Manuel  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Nogués Chaves, Manuel  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Nogués Chaves, Rocío<li>Se ha creado el profesor Nogués Chaves, Rocío</li><li>Se ha creado el departamento Fisica_y_Quimica</li><li>Se ha creado el departamento Fisica_y_Quimica en el curso 2016/2017</li><li>Se ha asignado el profesor Nogués Chaves, Rocío al departamento 2016/2017 - Fisica_y_Quimica - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Nogués Chaves, Rocío  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Nogués Chaves, Rocío  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Nogués Chaves, Rocío  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Nogués Chaves, Rocío  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Nogués Chaves, Rocío  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Nogués Chaves, Rocío  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Pacheco Cardoso, Diego<li>Se ha creado el profesor Pacheco Cardoso, Diego</li><li>Se ha asignado el profesor Pacheco Cardoso, Diego al departamento 2016/2017 - Lengua_Castellana_y_Literatura - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Pacheco Cardoso, Diego  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Pacheco Cardoso, Diego  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Pacheco Cardoso, Diego  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Pacheco Cardoso, Diego  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Picón Domínguez, María Jennifer<li>Se ha creado el profesor Picón Domínguez, María Jennifer</li><li>Se ha asignado el profesor Picón Domínguez, María Jennifer al departamento 2016/2017 - Lengua_Castellana_y_Literatura - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Picón Domínguez, María Jennifer  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Picón Domínguez, María Jennifer  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Picón Domínguez, María Jennifer  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Picón Domínguez, María Jennifer  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Picón Domínguez, María Jennifer  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Ramírez Pizarro, Carmen<li>Se ha creado el profesor Ramírez Pizarro, Carmen</li><li>Se ha asignado el profesor Ramírez Pizarro, Carmen al departamento 2016/2017 - Orientacion - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºPMAR - Sin asignar tutoría - Ramírez Pizarro, Carmen  al grupo 2016/2017 - 1ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Ramírez Pizarro, Carmen  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Ramírez Pizarro, Carmen  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Ramírez Pizarro, Carmen  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Ramírez Pizarro, Carmen  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºPMAR - Sin asignar tutoría - Ramírez Pizarro, Carmen  al grupo 2016/2017 - 2ºPMAR - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - Ramírez Pizarro, Carmen  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Ramos Duro, Pablo<li>Se ha creado el profesor Ramos Duro, Pablo</li><li>Se ha asignado el profesor Ramos Duro, Pablo al departamento 2016/2017 - Ciencias_Naturales - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Ramos Duro, Pablo  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Ramos Duro, Pablo  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Ramos Duro, Pablo  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Ramos Duro, Pablo  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Ramos Duro, Pablo  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - Ramos Duro, Pablo  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Ramos Duro, Pablo  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Ramos Duro, Pablo  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Recio Mayorga, Joaquín<li>Se ha creado el profesor Recio Mayorga, Joaquín</li><li>Se ha asignado el profesor Recio Mayorga, Joaquín al departamento 2016/2017 - Ciencias_Naturales - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Recio Mayorga, Joaquín  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Recio Mayorga, Joaquín  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Recio Mayorga, Joaquín  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Recio Mayorga, Joaquín  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Rodríguez Bote, Alina<li>Se ha creado el profesor Rodríguez Bote, Alina</li><li>Se ha asignado el profesor Rodríguez Bote, Alina al departamento 2016/2017 - Frances - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Rodríguez Bote, Alina  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Rodríguez Bote, Alina  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Rodríguez Bote, Alina  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2DE - Sin asignar tutoría - Rodríguez Bote, Alina  al grupo 2016/2017 - 2DE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Rodríguez Bote, Alina  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Rodríguez Bote, Alina  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Rodríguez Díaz, José Antonio<li>Se ha creado el profesor Rodríguez Díaz, José Antonio</li><li>Se ha asignado el profesor Rodríguez Díaz, José Antonio al departamento 2016/2017 - Ingles - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Rodríguez Díaz, José Antonio  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Rodríguez Díaz, José Antonio  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Rodríguez Díaz, José Antonio  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Rodríguez Díaz, José Antonio  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Rodríguez Díaz, José Antonio  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Ruiz Burgos, Ambrosio<li>Se ha creado el profesor Ruiz Burgos, Ambrosio</li><li>Se ha creado el departamento Economia</li><li>Se ha creado el departamento Economia en el curso 2016/2017</li><li>Se ha asignado el profesor Ruiz Burgos, Ambrosio al departamento 2016/2017 - Economia - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1HCS - Sin asignar tutoría - Ruiz Burgos, Ambrosio  al grupo 2016/2017 - B1HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Ruiz Burgos, Ambrosio  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºAPSD - Sin asignar tutoría - Ruiz Burgos, Ambrosio  al grupo 2016/2017 - 1ºAPSD - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºAPSD - Sin asignar tutoría - Ruiz Burgos, Ambrosio  al grupo 2016/2017 - 2ºAPSD - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Ruiz Burgos, Ambrosio  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Ruiz Burgos, Ambrosio  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Sevilla Ortiz, Agustín<li>Se ha asignado el profesor Sevilla Ortiz, Agustín al departamento 2016/2017 - Geografia_e_Historia - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Sevilla Ortiz, Agustín  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Solís Maya, Fernando<li>Se ha asignado el profesor Solís Maya, Fernando al departamento 2016/2017 - Orientacion - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºFPB - Sin asignar tutoría - Solís Maya, Fernando  al grupo 2016/2017 - 2ºFPB - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Torrado Martínez, Juan Manuel<li>Se ha creado el profesor Torrado Martínez, Juan Manuel</li><li>Se ha asignado el profesor Torrado Martínez, Juan Manuel al departamento 2016/2017 - Artes_Plasticas - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Torrado Martínez, Juan Manuel  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Torrado Martínez, Juan Manuel  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2HCS - Sin asignar tutoría - Torrado Martínez, Juan Manuel  al grupo 2016/2017 - B2HCS - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Torrado Martínez, Juan Manuel  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Torrado Martínez, Juan Manuel  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4º PRAGE - Sin asignar tutoría - Torrado Martínez, Juan Manuel  al grupo 2016/2017 - 4º PRAGE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Torrado Martínez, Juan Manuel  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Trinidad Araujo, Sagrario<li>Se ha creado el profesor Trinidad Araujo, Sagrario</li><li>Se ha asignado el profesor Trinidad Araujo, Sagrario al departamento 2016/2017 - Ciencias_Naturales - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B1CT - Sin asignar tutoría - Trinidad Araujo, Sagrario  al grupo 2016/2017 - B1CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Trinidad Araujo, Sagrario  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Trinidad Araujo, Sagrario  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Trinidad Araujo, Sagrario  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1ºFPB - Sin asignar tutoría - Trinidad Araujo, Sagrario  al grupo 2016/2017 - 1ºFPB - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2ºFPB - Sin asignar tutoría - Trinidad Araujo, Sagrario  al grupo 2016/2017 - 2ºFPB - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3AE - Sin asignar tutoría - Trinidad Araujo, Sagrario  al grupo 2016/2017 - 3AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Trinidad Araujo, Sagrario  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Vázquez Burgueño, María Luisa<li>Se ha creado el profesor Vázquez Burgueño, María Luisa</li><li>Se ha asignado el profesor Vázquez Burgueño, María Luisa al departamento 2016/2017 - Matematicas - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - B2CT - Sin asignar tutoría - Vázquez Burgueño, María Luisa  al grupo 2016/2017 - B2CT - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Vázquez Burgueño, María Luisa  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Vázquez Burgueño, María Luisa  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Vázquez Burgueño, María Luisa  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4BE - Sin asignar tutoría - Vázquez Burgueño, María Luisa  al grupo 2016/2017 - 4BE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Vázquez Marrón, Alicia<li>Se ha creado el profesor Vázquez Marrón, Alicia</li><li>Se ha asignado el profesor Vázquez Marrón, Alicia al departamento 2016/2017 - Matematicas - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1AE - Sin asignar tutoría - Vázquez Marrón, Alicia  al grupo 2016/2017 - 1AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1BE - Sin asignar tutoría - Vázquez Marrón, Alicia  al grupo 2016/2017 - 1BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 1CE - Sin asignar tutoría - Vázquez Marrón, Alicia  al grupo 2016/2017 - 1CE - Sin asignar tutoría en el curso 2016/2017</li></ul><ul>Procesando profesor Vega Llano, Ana María<li>Se ha creado el profesor Vega Llano, Ana María</li><li>Se ha asignado el profesor Vega Llano, Ana María al departamento 2016/2017 - Lengua_Castellana_y_Literatura - Sin asignar jefatura en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2AE - Sin asignar tutoría - Vega Llano, Ana María  al grupo 2016/2017 - 2AE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2BE - Sin asignar tutoría - Vega Llano, Ana María  al grupo 2016/2017 - 2BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 2CE - Sin asignar tutoría - Vega Llano, Ana María  al grupo 2016/2017 - 2CE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 3BE - Sin asignar tutoría - Vega Llano, Ana María  al grupo 2016/2017 - 3BE - Sin asignar tutoría en el curso 2016/2017</li><li>Se ha asignado el profesor 2016/2017 - 4AE - Sin asignar tutoría - Vega Llano, Ana María  al grupo 2016/2017 - 4AE - Sin asignar tutoría en el curso 2016/2017</li></ul>	1
2	2016-10-19 13:05:35.137255+02	2016-10-21 09:02:04.605454+02	AL	rayuela/2016/10/19/ExportacionDatosAlumnado.zip	t	<h5>Resultado del proceso</h5><ul>Procesando alumno Garrote Garrón, María</ul><ul>Procesando alumno Granadero Villalba, Belén</ul><ul>Procesando alumno Villalba García, Manuel</ul><ul>Procesando alumno Torrado Botón, Raquel</ul><ul>Procesando alumno Megías Guerrero, Mario</ul><ul>Procesando alumno Valencia Isla, Antonio</ul><ul>Procesando alumno Valiente Delgado, Cristina</ul><ul>Procesando alumno Fernández Fernández, Saúl</ul><ul>Procesando alumno Naranjo Calderón, Sergio</ul><ul>Procesando alumno Ávila Moral, Aarón</ul><ul>Procesando alumno Carrasco Granadero, Eduardo</ul><ul>Procesando alumno Carrasco Morales, Daniel</ul><ul>Procesando alumno Sabido Molero, Elisabeth</ul><ul>Procesando alumno Rebollo Cubero, Jesús</ul><ul>Procesando alumno Calderón Gallego, Francisco Javier</ul><ul>Procesando alumno García Campanario, Ainhoa</ul><ul>Procesando alumno Sánchez Carvajal, Fernando</ul><ul>Procesando alumno Sánchez Moya, Carlos</ul><ul>Procesando alumno Torres Granadero, Víctor</ul><ul>Procesando alumno Contreras Ferreira, Laura</ul><ul>Procesando alumno Barragán Martínez, Sandra</ul><ul>Procesando alumno Chavero Sánchez, José Carlos</ul><ul>Procesando alumno Guareño Muñoz, Laura</ul><ul>Procesando alumno López Cerón, Celia</ul><ul>Procesando alumno Pecellín Sánchez, David</ul><ul>Procesando alumno Reyes Chaves, Carlos</ul><ul>Procesando alumno Rubio Navarro, Alejandro</ul><ul>Procesando alumno Esteban González, Paula</ul><ul>Procesando alumno Bayón Macías, Victoria</ul><ul>Procesando alumno Domínguez Vaz, Alicia</ul><ul>Procesando alumno Garrote Megías, Ángela</ul><ul>Procesando alumno Fernández Vasco, María de los Ángeles</ul><ul>Procesando alumno Contreras Chaves, Miguel</ul><ul>Procesando alumno Cardoso Sayago, Gemma</ul><ul>Procesando alumno González Nogués, Sonia</ul><ul>Procesando alumno Megías Neguillo, Izan</ul><ul>Procesando alumno Naranjo Calderón, Carlos</ul><ul>Procesando alumno Paniagua González, José</ul><ul>Procesando alumno Méndez Valverde, María</ul><ul>Procesando alumno Megías Cubero, Ángel Manuel</ul><ul>Procesando alumno Molano Romero, María</ul><ul>Procesando alumno Carrasco Lancharro, Antonio Jesús</ul><ul>Procesando alumno Muñoz Romero, María</ul><ul>Procesando alumno Hernández Cardoso, Gabriel</ul><ul>Procesando alumno Herba Herba, Nabil</ul><ul>Procesando alumno Sánchez Arencón, Carlos</ul><ul>Procesando alumno Mateos Díaz, Daniel</ul><ul>Procesando alumno Vasco Martínez, Carlos</ul><ul>Procesando alumno Barroso Roguera, Belén</ul><ul>Procesando alumno Almeida Méndez, Rubén</ul><ul>Procesando alumno Pizarro Roldán, Javier</ul><ul>Procesando alumno Donoso Calderón, Manuel José</ul><ul>Procesando alumno Rubio Navarro, Sheila</ul><ul>Procesando alumno Jiménez Garrón, Jaime</ul><ul>Procesando alumno Galván Ferrero, David</ul><ul>Procesando alumno Ferreira Pizarro, Carlos</ul><ul>Procesando alumno Villalba Moya, Javier</ul><ul>Procesando alumno Benítez Rubio, Laura</ul><ul>Procesando alumno Pagador Areses, Joaquín</ul><ul>Procesando alumno Vargas Tomillo, Adrián</ul><ul>Procesando alumno Velasco Campano, Miguel Ángel</ul><ul>Procesando alumno Villalba Andrés, Lucía</ul><ul>Procesando alumno Fernández Cañizares, Francisco José</ul><ul>Procesando alumno Calderón Aceiton, Elena</ul><ul>Procesando alumno Calderón Márquez, María</ul><ul>Procesando alumno Colorado Megías, David</ul><ul>Procesando alumno López Cordero, Claudia</ul><ul>Procesando alumno Pecellín Nogués, María</ul><ul>Procesando alumno Quintero Chávez, Antonio</ul><ul>Procesando alumno Romero Chávez, Alejandro</ul><ul>Procesando alumno Botón Maldonado, Antonio Luis</ul><ul>Procesando alumno Campanario Ferrero, Noelia</ul><ul>Procesando alumno Chavero Velázquez, Carla</ul><ul>Procesando alumno Carrasco Sánchez, Miguel</ul><ul>Procesando alumno Domínguez Sabido, Francisco Javier</ul><ul>Procesando alumno Galván Ferrero, Raúl</ul><ul>Procesando alumno Guareño Valencia, Alba</ul><ul>Procesando alumno Herrera Garrón, Celia</ul><ul>Procesando alumno Lancharro Bayón, Manuel</ul><ul>Procesando alumno Lara Bermúdez, Gonzalo</ul><ul>Procesando alumno Megías Pecellín, Tania</ul><ul>Procesando alumno Monjo Murillo, Julián</ul><ul>Procesando alumno Naranjo Delagado, Juan Carlos</ul><ul>Procesando alumno Sánchez Moya, Ana María</ul><ul>Procesando alumno Macedo Pereira, Adrián</ul><ul>Procesando alumno Murillo Delgado, David</ul><ul>Procesando alumno Sánchez Moreno, Lucía</ul><ul>Procesando alumno Ferreira Lancharro, Francisco Javier</ul><ul>Procesando alumno Núñez Ramos, José</ul><ul>Procesando alumno Pérez Vargas, Adrián</ul><ul>Procesando alumno Lancharro Girol, Gabriel</ul><ul>Procesando alumno Vargas Pozuelo, María de los Ángeles</ul><ul>Procesando alumno Vargas Sánchez, José Francisco</ul><ul>Procesando alumno Mendo Lancharro, Laura</ul><ul>Procesando alumno Iglesias Fuentes, Ángel</ul><ul>Procesando alumno Pecellín Martínez, Javier</ul><ul>Procesando alumno Guerrero Noguera, Ignacio</ul><ul>Procesando alumno Luque Calderón, Andrea</ul><ul>Procesando alumno Sánchez Calderón, Fernando</ul><ul>Procesando alumno Torrado Rodríguez, Paula</ul><ul>Procesando alumno Onel , Andrei-Vasile</ul><ul>Procesando alumno Pacheco Calderón, Lucía</ul><ul>Procesando alumno Megías Garrote, Adrián</ul><ul>Procesando alumno Méndez Valverde, Alejandra</ul><ul>Procesando alumno Ambrona López, Elena</ul><ul>Procesando alumno Monjo Granadero, Paula</ul><ul>Procesando alumno Parra Cubero, David</ul><ul>Procesando alumno González Vasco, Antonio</ul><ul>Procesando alumno González Delgado, Elena Isabel</ul><ul>Procesando alumno Sánchez Romero, Alba</ul><ul>Procesando alumno Delgado Romero, David</ul><ul>Procesando alumno Vázquez Guerrero, Pablo</ul><ul>Procesando alumno Pulice Barbecho, Teresa</ul><ul>Procesando alumno Conde Moruno, Carla</ul><ul>Procesando alumno Velázquez Vasco, José Manuel</ul><ul>Procesando alumno Ambrona Vila, Ángela</ul><ul>Procesando alumno Balsera Durán, Daniel</ul><ul>Procesando alumno Campanario Rueda, Desiré</ul><ul>Procesando alumno Danta San Juan, Yumara</ul><ul>Procesando alumno Hermoso Morato, Mercedes</ul><ul>Procesando alumno Mateos García, Rocío</ul><ul>Procesando alumno Llimona Cabeza, Mario</ul><ul>Procesando alumno Lancharro Hernández, María José</ul><ul>Procesando alumno Sánchez Chávez, Lourdes</ul><ul>Procesando alumno Garrote Fuentes, Álvaro</ul><ul>Procesando alumno Carrasco Blanco, Rafael</ul><ul>Procesando alumno Barragán Delgado, Nerea</ul><ul>Procesando alumno Gordito Rivera, Francisco Alejandro</ul><ul>Procesando alumno Contreras Durán, Inés</ul><ul>Procesando alumno Sánchez De la Torre, Andrea</ul><ul>Procesando alumno Contreras Iglesias, Alejandro</ul><ul>Procesando alumno Zapata Real, Juan José</ul><ul>Procesando alumno Gómez Monjo, María de los Ángeles</ul><ul>Procesando alumno Abril Santana, Míriam</ul><ul>Procesando alumno Pallero Carrasco, María José</ul><ul>Procesando alumno Ledesma Caro, Luis</ul><ul>Procesando alumno Garrote Abril, Celia</ul><ul>Procesando alumno Morillo Pavón, Alejandro</ul><ul>Procesando alumno Chávez González, Elena</ul><ul>Procesando alumno Arroyo Botón, Javier</ul><ul>Procesando alumno Barragán Miranda, Lucía</ul><ul>Procesando alumno Bautista Ramos, Belén María</ul><ul>Procesando alumno Crisóstomo Lozano, Marta</ul><ul>Procesando alumno Ambrona Rebollo, Javier</ul><ul>Procesando alumno Pavón Nogués, Antonio</ul><ul>Procesando alumno Reyes Calcatierra, Lucía</ul><ul>Procesando alumno Villalba Vasco, Daniel</ul><ul>Procesando alumno Calderón Palacios, Juan</ul><ul>Procesando alumno Chávez Hoyos, Elena</ul><ul>Procesando alumno Soares Dos Santos, Ana Rita</ul><ul>Procesando alumno Barragán Guillén, José Antonio</ul><ul>Procesando alumno Calderón Guareño, Alfonso</ul><ul>Procesando alumno Delgado Calderón, Juan</ul><ul>Procesando alumno Calderón Garrote, Javier</ul><ul>Procesando alumno Garrote Garrón, Javier</ul><ul>Procesando alumno Morón Iglesias, Andrea</ul><ul>Procesando alumno Oliva Trenado, Agustín</ul><ul>Procesando alumno Rodríguez De la Vega, Ignacio</ul><ul>Procesando alumno Torrado Boton, María</ul><ul>Procesando alumno Fernández Zapata, Andrés</ul><ul>Procesando alumno Fernández González, Marcos</ul><ul>Procesando alumno Calvo Miranda, Jorge</ul><ul>Procesando alumno Chávez Hoyos, Laura</ul><ul>Procesando alumno Bautista Peraza, Elena</ul><ul>Procesando alumno Garrote García, Ana</ul><ul>Procesando alumno Flores Moro, María Luisa</ul><ul>Procesando alumno Monjo Murillo, María José</ul><ul>Procesando alumno Valverde Martínez, Celia</ul><ul>Procesando alumno García Chavero, Adrián</ul><ul>Procesando alumno Pérez-Carrasco Gómez, Concepción</ul><ul>Procesando alumno Garrote Ledesma, Alberto</ul><ul>Procesando alumno Bayón Rodríguez, Francisco</ul><ul>Procesando alumno Hernández Lucio, Carlos Andrés</ul><ul>Procesando alumno Luque Romero, Alicia</ul><ul>Procesando alumno Silva Caballero, Jorge</ul><ul>Procesando alumno Herba Herba, Najib</ul><ul>Procesando alumno Hernández Lucio, Adrián</ul><ul>Procesando alumno Jiménez Rodríguez, Esperanza</ul><ul>Procesando alumno Parra Sánchez, Carmen</ul><ul>Procesando alumno Domínguez Campano, Isabel María</ul><ul>Procesando alumno Orejuela Solórzano, Robinson</ul><ul>Procesando alumno Navarro Rodríguez, Juan Antonio</ul><ul>Procesando alumno Calderón Vasco, David</ul><ul>Procesando alumno Cubero Zapata, Antonio</ul><ul>Procesando alumno González Cardoso, Fabián</ul><ul>Procesando alumno Luque Pérez, Leire</ul><ul>Procesando alumno Paniagua González, Dalía</ul><ul>Procesando alumno Vázquez Pérez, Carmen</ul><ul>Procesando alumno Expósito Granadero, Marcos</ul><ul>Procesando alumno Vadillo Calvo, Enrique</ul><ul>Procesando alumno Calderón Barragán, Gema</ul><ul>Procesando alumno Megías Sánchez, Gonzalo</ul><ul>Procesando alumno Sayago Macarro, Carmen</ul><ul>Procesando alumno Vasco Sánchez, María</ul><ul>Procesando alumno Santillana Garrote, Sara</ul><ul>Procesando alumno Esteban Ortiz, Alicia</ul><ul>Procesando alumno Luque Calderón, Rubén</ul><ul>Procesando alumno Chávez González, Claudia</ul><ul>Procesando alumno Durán Mejías, María del Mar</ul><ul>Procesando alumno Alonso Sánchez, Candela</ul><ul>Procesando alumno Barragán Delgado, Valeria</ul><ul>Procesando alumno Cobos Martínez, Nerea</ul><ul>Procesando alumno Gavira Rodríguez, Laura</ul><ul>Procesando alumno Lara Garrote, Marina</ul><ul>Procesando alumno López Sánchez, Laura</ul><ul>Procesando alumno Paniagua Blanco, Sonia</ul><ul>Procesando alumno Sánchez Calderón, María</ul><ul>Procesando alumno Zapata Barbecho, Cristina</ul><ul>Procesando alumno Zoilo Villalba, Clara</ul><ul>Procesando alumno Robledo Carballar, Erika</ul><ul>Procesando alumno Lavado González, Carolina</ul><ul>Procesando alumno Artero Fernández, Javier</ul><ul>Procesando alumno Bayón Caballero, Celia</ul><ul>Procesando alumno Benítez Rubio, Lucía</ul><ul>Procesando alumno Vázquez Delgado, Pablo</ul><ul>Procesando alumno Calderón Sánchez, María</ul><ul>Procesando alumno Garrote Mateos, Cristina</ul><ul>Procesando alumno Hernández Bayón, Laura</ul><ul>Procesando alumno Bautista Delgado, Diego</ul><ul>Procesando alumno González Fernández, Javier</ul><ul>Procesando alumno Molero Galván, Nuria</ul><ul>Procesando alumno Castillo Campano, Desirée</ul><ul>Procesando alumno Calderón Delgado, Carlos</ul><ul>Procesando alumno Zoilo Calderón, Laura</ul><ul>Procesando alumno Chaves Romero, Jesús</ul><ul>Procesando alumno Harkaoui Elabbassi, Amal</ul><ul>Procesando alumno Fernández Ramos, María de los Ángeles</ul><ul>Procesando alumno Bayón Rodríguez, Víctor</ul><ul>Procesando alumno Linares Guerrero, Ana</ul><ul>Procesando alumno Pulgarín Caballero, David</ul><ul>Procesando alumno Campos Barrero, Myriam</ul><ul>Procesando alumno De Ocampo Delgado, Mario</ul><ul>Procesando alumno González Fernández, Cristian</ul><ul>Procesando alumno Filigrana Guillén, Daniel</ul><ul>Procesando alumno Quintero Chávez, Manuel</ul><ul>Procesando alumno López Villalba, Manuel</ul><ul>Procesando alumno Rufo Calderón, David</ul><ul>Procesando alumno López Balsera, Diego</ul><ul>Procesando alumno Oliva Mayoral, José Carlos</ul><ul>Procesando alumno Dahiri , María</ul><ul>Procesando alumno González Vázquez, Paola</ul><ul>Procesando alumno Pecellín Jaro, Zaida</ul><ul>Procesando alumno Giles Grau, Pedro</ul><ul>Procesando alumno González Delgado, Rafael</ul><ul>Procesando alumno Hernández Bayón, Sara</ul><ul>Procesando alumno Matito Garrón, Isabel</ul><ul>Procesando alumno Pizarro Delgado, Andrés</ul><ul>Procesando alumno Marín Durán, Ainhoa</ul><ul>Procesando alumno Gordito Velázquez, Desiree</ul><ul>Procesando alumno Villalba Delgado, Lucía</ul><ul>Procesando alumno Zapata Real, Jesús</ul><ul>Procesando alumno Barroso Maldonado, María</ul><ul>Procesando alumno Nogués Domínguez, Míriam</ul><ul>Procesando alumno Rodríguez López, Francisco Jesús</ul><ul>Procesando alumno Sánchez Serrano, Noelia</ul><ul>Procesando alumno Fernández Garrote, Macarena</ul><ul>Procesando alumno Vasco Vicente, Cristina</ul><ul>Procesando alumno Fernández Sánchez, Isabel</ul><ul>Procesando alumno García Galván, Ana Isabel</ul><ul>Procesando alumno Fernández Zapata, Diego</ul><ul>Procesando alumno Ledesma Caro, Carlos</ul><ul>Procesando alumno Pizarro Girol, Lucía</ul><ul>Procesando alumno Sevilla Fernández, Darío</ul><ul>Procesando alumno Zapata Botón, Laura</ul><ul>Procesando alumno Ramayo Garrón, Carlos</ul><ul>Procesando alumno Delgado González, Sergio</ul><ul>Procesando alumno Fernández Megías, Paola</ul><ul>Procesando alumno Lancharro Sánchez, Laura</ul><ul>Procesando alumno Contreras Chaves, Raúl</ul><ul>Procesando alumno Flores Baños, Ismael</ul><ul>Procesando alumno Oliva González, Raquel</ul><ul>Procesando alumno Álvarez González, Gema</ul><ul>Procesando alumno Chavero López, Andrea</ul><ul>Procesando alumno Vázquez Rodríguez, José Antonio</ul><ul>Procesando alumno González Pecellín, Pablo</ul><ul>Procesando alumno Lancharro Bayón, Jesús</ul><ul>Procesando alumno Martínez Girol, Javier</ul><ul>Procesando alumno González Villacis, José Fernando</ul><ul>Procesando alumno Fernández Ramos, Carmen María</ul><ul>Procesando alumno Rodríguez Nieto, Antonio Fernando</ul><ul>Procesando alumno González Vázquez, José Daniel</ul><ul>Procesando alumno Rodríguez Martínez, Miguel</ul><ul>Procesando alumno Ruivo Rita, Tania de Fátima</ul><ul>Procesando alumno Vasco Vicente, Marina</ul><ul>Procesando alumno García Muñiz, Juan Carlos</ul><ul>Procesando alumno Chávez Gata, Luis Miguel</ul><ul>Procesando alumno Caballero Gordito, Tamara</ul><ul>Procesando alumno Calderón Sánchez, Carmen</ul><ul>Procesando alumno Calderón Carballar, Valeria</ul><ul>Procesando alumno Colorado Ferreira, Cristian</ul><ul>Procesando alumno Iglesias Muñoz, Jesús</ul><ul>Procesando alumno De la Coba Córdoba, Ángel</ul><ul>Procesando alumno Castro Jaramillo, Antonia</ul><ul>Procesando alumno Pulice Barbecho, Alfonso</ul><ul>Procesando alumno Delgado Aguilar, Almudena</ul><ul>Procesando alumno Cubero González, Fabián</ul><ul>Procesando alumno Balsera Durán, Alba</ul><ul>Procesando alumno Molina Jiménez, Cristina</ul><ul>Procesando alumno García Garrote, Laura</ul><ul>Procesando alumno Danta Romero, Raúl</ul><ul>Procesando alumno Valverde Garrote, Laura</ul><ul>Procesando alumno Zapata Méndez, Clara</ul><ul>Procesando alumno Alcantarilla Romero, Alejandro</ul><ul>Procesando alumno Galán Cano, Alejandro</ul><ul>Procesando alumno Calderón Bayón, Ángeles</ul><ul>Procesando alumno Vargas Bayón, Andrés</ul><ul>Procesando alumno Mestre Nogués, Julio</ul><ul>Procesando alumno Sánchez Duqueso, Irene</ul><ul>Procesando alumno Sánchez Chávez, Julia</ul><ul>Procesando alumno Bautista Ramos, Fátima</ul><ul>Procesando alumno Gedvilas Kerevicius, Danielius</ul><ul>Procesando alumno Lancharro Lora, Vicente</ul><ul>Procesando alumno Pizarro Delgado, Daniel</ul><ul>Procesando alumno Perera Sánchez, Carlos Javier</ul><ul>Procesando alumno Reyes Domínguez, María</ul><ul>Procesando alumno Delgado Zambrano, Jesús</ul><ul>Procesando alumno Díaz Domínguez, Judith</ul><ul>Procesando alumno González Cubero, Daniel</ul><ul>Procesando alumno Hernández Fernández, Carlos</ul><ul>Procesando alumno Abril Santana, Mario</ul><ul>Procesando alumno Hidalgo Artero, Luis</ul><ul>Procesando alumno Megías Garrote, Alejandra</ul><ul>Procesando alumno Garrote Fuentes, Carmen</ul><ul>Procesando alumno Marín Durán, Hugo</ul><ul>Procesando alumno Naranjo Mejías, Ismael</ul><ul>Procesando alumno Bonilla Colorado, Ana Isabel</ul><ul>Procesando alumno Márquez Domínguez, Manuel</ul><ul>Procesando alumno Paz Pecellín, Francisco Javier</ul><ul>Procesando alumno Estévez Baños, Xavier</ul><ul>Procesando alumno Fernández Cubero, Victoria</ul><ul>Procesando alumno Almagro Lara, Blanca María</ul><ul>Procesando alumno Mestre Nogués, Manuel</ul><ul>Procesando alumno Duqueso Villalba, Clara</ul><ul>Procesando alumno López Pereira, Victoria</ul><ul>Procesando alumno Cubo González, Juan José</ul><ul>Procesando alumno Pérez Sánchez, Miguel Ángel</ul><ul>Procesando alumno Valverde Tabales, Antonio Luis</ul><ul>Procesando alumno Zamfir , Florea</ul><ul>Procesando alumno Zapata Barbecho, Nuria</ul><ul>Procesando alumno Lozano Vargas, Natalia</ul><ul>Procesando alumno Palomo Pelayo, Rubén</ul><ul>Procesando alumno Ruiz Puentenueva, Rafael</ul><ul>Procesando alumno Vargas Tomillo, Roberto</ul><ul>Procesando alumno Robles Bautista, Daniel</ul><ul>Procesando alumno Zapata Real, Clara</ul><ul>Procesando alumno Domínguez Uguina, Antonio Jesús</ul><ul>Procesando alumno Cubero Carrasco, Mario</ul><ul>Procesando alumno Delgado Zambrano, María Teresa</ul><ul>Procesando alumno Esteban Delgado, María</ul><ul>Procesando alumno Valencia Torrado, Manuel</ul><ul>Procesando alumno López Domínguez, Estefanía</ul><ul>Procesando alumno Danta San Juan, Soraya</ul><ul>Procesando alumno Carrasco Márquez, Luna</ul><ul>Procesando alumno Cubero Carrasco, Candela</ul><ul>Procesando alumno Pavón Nogués, Rocío</ul><ul>Procesando alumno Matamoros Vázquez, María del Valle</ul><ul>Procesando alumno Calderón Carballar, Alberto</ul><ul>Procesando alumno Calderón Gallego, Ana</ul><ul>Procesando alumno Covilla D'Acosta, Desireé</ul><ul>Procesando alumno Espacio Santos, Ara</ul><ul>Procesando alumno Lancharro Lora, Marta</ul><ul>Procesando alumno Macías Ledesma, Violeta</ul><ul>Procesando alumno Matito Garrón, Álvaro</ul><ul>Procesando alumno Mora López, Andrea</ul><ul>Procesando alumno Vázquez Pérez, Sandra</ul><ul>Procesando alumno Gata Rodríguez, Leire</ul><ul>Procesando alumno Hernández Fernández, María</ul><ul>Procesando alumno Méndez Rodríguez, Rosa María</ul><ul>Procesando alumno Calderón Vasco, Álvaro</ul><ul>Procesando alumno Carrasco Álvarez, Adrián</ul><ul>Procesando alumno López Pereira, Marcos</ul><ul>Procesando alumno Estévez Baños, Mónica</ul><ul>Procesando alumno Córdoba Barranco, Juan Antonio</ul><ul>Procesando alumno Megías Fernández, Andrés</ul><ul>Procesando alumno Machio Rodríguez, María Cristina</ul><ul>Procesando alumno Rodríguez Quinta, Cristian</ul><ul>Procesando alumno Granadero Larrayad, Alba</ul><ul>Procesando alumno Escudero Muñoz, Gerard</ul><ul>Procesando alumno Dacosta Bayón, Raúl</ul><ul>Procesando alumno Campanario Rueda, Juan Carlos</ul><ul>Procesando alumno Sánchez Miranda, Álvaro</ul><ul>Procesando alumno Granados Calderón, Francisco</ul><ul>Procesando alumno Martín Carrasco, Irene</ul><ul>Procesando alumno Contreras Chaves, Sergio</ul><ul>Procesando alumno Lancharro Kaddur, Verónica</ul><ul>Procesando alumno Vargas Iglesias, Álvaro</ul><ul>Procesando alumno Domínguez Blanco, Jonathan</ul><ul>Procesando alumno González Bernáldez, Sira</ul><ul>Procesando alumno Godino Gómez, Alberto</ul><ul>Procesando alumno Zamfir , Fabián Tudor</ul><ul>Procesando alumno Valiente Delgado, Mirella</ul><ul>Procesando alumno Murillo Delgado, Marta</ul><ul>Procesando alumno Vargas Adame, Laura</ul><ul>Procesando alumno Núñez Ramos, Erika</ul>	1
4	2016-10-21 09:32:00.799508+02	2016-10-21 13:26:52.375888+02	TU	rayuela/2016/10/21/RegTutores.ods	t	<h5>Resultado del proceso</h5><ul><li>Procesando tutor Abril Caballero, Manuel</li><li>Procesando tutor Abril Caballero, Manuel</li><li>Procesando tutor Abril Vara, Natividad</li><li>Procesando tutor Aceitón Terrón, Josefa María</li><li>Procesando tutor Adame Gamero, María Soledad</li><li>Procesando tutor Aguilar Méndez, Almudena</li><li>Procesando tutor Alcantarilla Izquierdo, Pablo</li><li>Procesando tutor Almagro Muñoz, José Manuel</li><li>Procesando tutor Almeida Fernández, Rubén Darío</li><li>Procesando tutor Alonso Vasco, Antonio</li><li>Procesando tutor Álvarez Cano, José Luis</li><li>Procesando tutor Álvarez Guareño, Carmen</li><li>Procesando tutor Ambrona Garrote, Ángel Manuel</li><li>Procesando tutor Ambrona Garrote, Daniel</li><li>Procesando tutor Ambrona Ledesma, Julián</li><li>Procesando tutor Andrés Fadrique, Rosario</li><li>Procesando tutor Arencón Garrote, Francisca</li><li>Procesando tutor Areses Fernández, María José</li><li>Procesando tutor Arroyo Egido, Julián</li><li>Procesando tutor Artero Gordito, Juan Carlos</li><li>Procesando tutor Artero Roque, Purificación</li><li>Procesando tutor Ávila Morales, José Luis</li><li>Procesando tutor Azedo Soares, María Manuela</li><li>Procesando tutor Balsera Artero, Luciano</li><li>Procesando tutor Balsera Artero, Luciano</li><li>Procesando tutor Balsera Artero, Rosa María</li><li>Procesando tutor Baños Balsera, Carmen</li><li>Procesando tutor Baños López, María Teresa</li><li>Procesando tutor Baños López, María Teresa</li><li>Procesando tutor Barbecho Durán, María Purificación</li><li>Procesando tutor Barbecho Durán, María Purificación</li><li>Procesando tutor Barbecho Durán, María Teresa</li><li>Procesando tutor Barragá González, Domingo</li><li>Procesando tutor Barragán Bermúdez, Feliciano</li><li>Procesando tutor Barragán Bermúdez, Serapio</li><li>Procesando tutor Barragán Garrón, David</li><li>Procesando tutor Barragán González, María Dolores</li><li>Procesando tutor Barragán Perdigón, José Antonio</li><li>Procesando tutor Barranco Rubio, María de la Cruz</li><li>Procesando tutor Barrero Montero, María Ángeles</li><li>Procesando tutor Barroso Gato, Salvador</li><li>Procesando tutor Barroso Lara, Salvador</li><li>Procesando tutor Bautista Carballar, Ramón</li><li>Procesando tutor Bautista Chavero, Eva María</li><li>Procesando tutor Bautista Vasco, José Antonio</li><li>Procesando tutor Bautista Vasco, José Antonio</li><li>Procesando tutor Bayón Bayón, Estrella</li><li>Procesando tutor Bayón Bayón, Estrella</li><li>Procesando tutor Bayón Duqueso, Concepción</li><li>Procesando tutor Bayón Granadero, Carmen</li><li>Procesando tutor Bayón Granadero, Manuel</li><li>Procesando tutor Bayón Megías, María Luisa</li><li>Procesando tutor Bayón Rodríguez, Sabina</li><li>Procesando tutor Bayón Vargas, Carmelo</li><li>Procesando tutor Bayón Vargas, Concepción</li><li>Procesando tutor Bayón Vargas, Rufino</li><li>Procesando tutor Bayón Vargas, Rufino</li><li>Procesando tutor Benítez González, Javier</li><li>Procesando tutor Benítez González, Javier</li><li>Procesando tutor Bermúdez Villalba, Encarnación</li><li>Procesando tutor Bernáldez Redondo, Ana Belén</li><li>Procesando tutor Blanco Baños, María del Carmen</li><li>Procesando tutor Blanco Gómez, Ana María</li><li>Procesando tutor Blanco Guerrero, María de los Ángeles</li><li>Procesando tutor Botón Díaz, Adela María</li><li>Procesando tutor Botón Díaz, José Joaquín</li><li>Procesando tutor Boton Díaz, María del Carmen</li><li>Procesando tutor Boton Díaz, María del Carmen</li><li>Procesando tutor Boton Gata, Elisa</li><li>Procesando tutor Caballero Alvarado, Francisco</li><li>Procesando tutor Caballero Gómez, Dolores</li><li>Procesando tutor Caballero Páez, Laura</li><li>Procesando tutor Caballero Zapata, María Inmaculada</li><li>Procesando tutor Cabeza Sánchez, María del Carmen</li><li>Procesando tutor Calcatierra Sánchez, Paula</li><li>Procesando tutor Calderón Barragán, José</li><li>Procesando tutor Calderón Bautista, Francisco Javier</li><li>Procesando tutor Calderón Bautista, Francisco Javier</li><li>Procesando tutor Calderón Bautista, José Antonio</li><li>Procesando tutor Calderón Bautista, María José</li><li>Procesando tutor Calderón Bautista, Valentín</li><li>Procesando tutor Calderón Chaves, Ceferino</li><li>Procesando tutor Calderón Dorado, Alfonso</li><li>Procesando tutor Calderón Igelsias, José</li><li>Procesando tutor Calderón Iglesias, Salvadora</li><li>Procesando tutor Calderón Iglesias, Salvadora</li><li>Procesando tutor Calderón Ledesma, José Manuel</li><li>Procesando tutor Calderón Matitos, Francisco</li><li>Procesando tutor Calderón Matitos, María José</li><li>Procesando tutor Calderón Monjo, Feliciana</li><li>Procesando tutor Calderón Nevado, Cesarina</li><li>Procesando tutor Calderón Oliva, Horacio</li><li>Procesando tutor Calderón Rodríguez, Purificación</li><li>Procesando tutor Calderón Rodríguez, Purificación</li><li>Procesando tutor Calderón Terrón, Gabino</li><li>Procesando tutor Calderón Terrón, Gabino</li><li>Procesando tutor Calderón Terrón, Indalecio</li><li>Procesando tutor Calderón Zambrano, Ángela</li><li>Procesando tutor Calderón Zambrano, Encarnación</li><li>Procesando tutor Calderón Zambrano, Encarni</li><li>Procesando tutor Calderón Zapata, Isabel M</li><li>Procesando tutor Calderón Zapata, José Antonio</li><li>Procesando tutor Calderón Zapata, José Antonio</li><li>Procesando tutor Calvo Fernández, Domingo</li><li>Procesando tutor Calvo Galán, Carmen</li><li>Procesando tutor Campanario Pereira, Antonio</li><li>Procesando tutor Campanario Pereira, Antonio</li><li>Procesando tutor Campanario Rodríguez, Felipe</li><li>Procesando tutor Campanario Rodríguez, María Felisa</li><li>Procesando tutor Campano Mancera, María Luz</li><li>Procesando tutor Campano Sánchez, Manuela</li><li>Procesando tutor Campos Vera, Pedro Jesús</li><li>Procesando tutor Cano Vázquez, María del Rosario</li><li>Procesando tutor Cañizares Lavado, María del Pilar</li><li>Procesando tutor Carballar Galán, Isabel María</li><li>Procesando tutor Carballar Galán, Isabel María</li><li>Procesando tutor Carballar Galán, Montserrat</li><li>Procesando tutor Cardoso Garrón, Antonio</li><li>Procesando tutor Cardoso Ibarra, María</li><li>Procesando tutor Cardoso Romero, Sofía</li><li>Procesando tutor Caro Puertolas, María Elena</li><li>Procesando tutor Caro Puertolas, María Elena</li><li>Procesando tutor Carrasco Acosta, Antonio Jesús</li><li>Procesando tutor Carrasco Barragán, Manuel</li><li>Procesando tutor Carrasco Becerra, Antonio Francisco</li><li>Procesando tutor Carrasco Díaz, Antonio Jesús</li><li>Procesando tutor Carrasco Díaz, María Dolores</li><li>Procesando tutor Carrasco Eslava, Celia</li><li>Procesando tutor Carrasco Eslava, Celia</li><li>Procesando tutor Carrasco García, Santiago</li><li>Procesando tutor Carrasco Megías, Rafael</li><li>Procesando tutor Carrasco Ortega, Francisco José</li><li>Procesando tutor Carrasco Paloma, Rosario</li><li>Procesando tutor Carvajal Bustamante, Ascensión</li><li>Procesando tutor Castro Silva, Ovidio</li><li>Procesando tutor Cerón García, María Luisa</li><li>Procesando tutor Chavero Hernández, José</li><li>Procesando tutor Chavero Valiente, José Carlos</li><li>Procesando tutor Chavero Villalba, Antonio Bernardo</li><li>Procesando tutor Chaves Argemi, María</li><li>Procesando tutor Chaves Argemi, María</li><li>Procesando tutor Chaves Argemi, María</li><li>Procesando tutor Chaves García, Francisca</li><li>Procesando tutor Chaves García, José Luis</li><li>Procesando tutor Chaves Lancharro, Ana María</li><li>Procesando tutor Chávez Collado, María Julia</li><li>Procesando tutor Chávez Collado, María Julia</li><li>Procesando tutor Chávez Durán, José</li><li>Procesando tutor Chávez Durán, José</li><li>Procesando tutor Chávez Durán, Manuel</li><li>Procesando tutor Chávez Gordito, Francisco Javier</li><li>Procesando tutor Chávez Gordito, Francisco Javier</li><li>Procesando tutor Chávez Vázquez, Luisa María</li><li>Procesando tutor Chávez Vázquez, Luisa María</li><li>Procesando tutor Cobos Muñoz, Luis</li><li>Procesando tutor Colorado Regaña, Antonio</li><li>Procesando tutor Colorado Regaña, Manuel</li><li>Procesando tutor Conde Caño, Antonio</li><li>Procesando tutor Contreras Fernández, Luis</li><li>Procesando tutor Contreras Márquez, Antonio Manuel</li><li>Procesando tutor Contreras Márquez, Antonio Manuel</li><li>Procesando tutor Contreras Márquez, Antonio Manuel</li><li>Procesando tutor Contreras Moya, Eduardo</li><li>Procesando tutor Contreras Real, Domingo</li><li>Procesando tutor Cordero Macías, Dolores</li><li>Procesando tutor Córdoba Martínez, Juan Antonio</li><li>Procesando tutor Córdoba Ortega, Rosa María</li><li>Procesando tutor Crisóstomo Barragán, José Miguel</li><li>Procesando tutor Cubero Barragán, Carmen</li><li>Procesando tutor Cubero Chávez, Antonio Olegario</li><li>Procesando tutor Cubero Mejías, María Purificación</li><li>Procesando tutor Cubero Rodríguez, Isabel María</li><li>Procesando tutor Cubero Rubio, María del Carmen</li><li>Procesando tutor Cubero Zambrano, David</li><li>Procesando tutor Cubo Hernández, Antonio</li><li>Procesando tutor D'Acosta Díaz, María de los Ángeles</li><li>Procesando tutor Dacosta Gómez, Blas</li><li>Procesando tutor Dahiri Dahiri, El Mati</li><li>Procesando tutor Danta Barrada, David</li><li>Procesando tutor Danta Moya, Sergio</li><li>Procesando tutor Danta Moya, Sergio</li><li>Procesando tutor De la Torre Maya, María Luisa</li><li>Procesando tutor De la Vega Sánchez, Loreto Inmaculada</li><li>Procesando tutor Delgado Cantillo, Maxima</li><li>Procesando tutor Delgado Contreras, Rosa María</li><li>Procesando tutor Delgado Cuello, María del Carmen</li><li>Procesando tutor Delgado Fernández, Antonia</li><li>Procesando tutor Delgado Fernández, Antonia</li><li>Procesando tutor Delgado Fernández, María Rosario</li><li>Procesando tutor Delgado Fernández, María Rosario</li><li>Procesando tutor Delgado Gallardo, Eugenio</li><li>Procesando tutor Delgado Gallardo, Eugenio</li><li>Procesando tutor Delgado Garrón, Leocadio</li><li>Procesando tutor Delgado Márquez, Ramón</li><li>Procesando tutor Delgado Pecellín, Virginia</li><li>Procesando tutor Delgado Ruiz, Agustina</li><li>Procesando tutor Delgado Ruiz, Agustina</li><li>Procesando tutor Delgado Ruiz, Esperanza</li><li>Procesando tutor Delgado Ruiz, Remedios</li><li>Procesando tutor Delgado Ruiz, Remedios</li><li>Procesando tutor Delgado Sánchez, Isabel</li><li>Procesando tutor Delgado Sánchez, María José</li><li>Procesando tutor Delgado Santos, Antonio</li><li>Procesando tutor Delgado Sayago, Feliciano</li><li>Procesando tutor Delgado Sayago, María José</li><li>Procesando tutor Delgado Zoilo, María Reyes</li><li>Procesando tutor Díaz Ramírez, Domingo</li><li>Procesando tutor Díaz Trenado, Carmen</li><li>Procesando tutor Do Santos Chapuza, Antonio</li><li>Procesando tutor Domínguez Baños, Rocío</li><li>Procesando tutor Domínguez Calderón, Francisco Javier</li><li>Procesando tutor Domínguez Cañizares, Juan Diego</li><li>Procesando tutor Domínguez Carballo, Francisco Javier</li><li>Procesando tutor Domínguez Durán, Daniel</li><li>Procesando tutor Domínguez Flores, Carmen</li><li>Procesando tutor Domínguez Moreno, Purificación</li><li>Procesando tutor Domínguez Pequenis, Rosario</li><li>Procesando tutor Domínguez Roguera, Pedro</li><li>Procesando tutor Donoso Sayago, Antonio Manuel</li><li>Procesando tutor Duqueso Fernández, José Antonio</li><li>Procesando tutor Duqueso Fernández, María José</li><li>Procesando tutor Durán Baños, Cándida</li><li>Procesando tutor Durán Baños, Cándida</li><li>Procesando tutor Durán Boton, Elisa</li><li>Procesando tutor Durán Caballero, Felisa</li><li>Procesando tutor Durán Caballero, Felisa</li><li>Procesando tutor Durán Chávez, Manuel</li><li>Procesando tutor Elabbassi , Hanan</li><li>Procesando tutor Escudero Alonso, José</li><li>Procesando tutor Espacio Garrón, Antonio Agustín</li><li>Procesando tutor Esteban Fenandez, Antonio</li><li>Procesando tutor Esteban Pecellín, Domingo</li><li>Procesando tutor Esteban Pecellín, Francisco José</li><li>Procesando tutor Estévez Espinosa, Carlos</li><li>Procesando tutor Estévez Espinosa, Carlos</li><li>Procesando tutor Expósito Maya, Santiago</li><li>Procesando tutor Fernández Acedo, María del Mar</li><li>Procesando tutor Fernández Agudo, María Luisa</li><li>Procesando tutor Fernández Agudo, María Luisa</li><li>Procesando tutor Fernández Albujar, Concepción</li><li>Procesando tutor Fernández Albújar, Francisco</li><li>Procesando tutor Fernández Balsera, Ángel Manuel</li><li>Procesando tutor Fernández Balsera, Purificación</li><li>Procesando tutor Fernández Domínguez, Manuel</li><li>Procesando tutor Fernández Domínguez, Manuel</li><li>Procesando tutor Fernández Fernández, José Manuel</li><li>Procesando tutor Fernández Fernández, María Amelia</li><li>Procesando tutor Fernández Gutiérrez, Antonio</li><li>Procesando tutor Fernández Lancharrro, José</li><li>Procesando tutor Fernández Muñoz, José Alejandro</li><li>Procesando tutor Fernández Nevado, Antonio</li><li>Procesando tutor Fernández Parrón, Consuelo</li><li>Procesando tutor Fernández Romero, José Miguel</li><li>Procesando tutor Ferreira Delgado, Fructuoso M</li><li>Procesando tutor Ferreira Delgado, María José</li><li>Procesando tutor Ferreira Delgado, Miguel Ángel</li><li>Procesando tutor Ferreira Muñoz, Carmen</li><li>Procesando tutor Ferrero Gómez, Gloria</li><li>Procesando tutor Ferrero Gómez, Gloria</li><li>Procesando tutor Ferrero Gómez, María del Carmen</li><li>Procesando tutor Filigrana Fuentes, Miguel Ángel</li><li>Procesando tutor Flores Campanario, José Luis</li><li>Procesando tutor Flores López, Manuel</li><li>Procesando tutor Fuentes Donoso, Manuela</li><li>Procesando tutor Fuentes Granadero, Lourdes</li><li>Procesando tutor Fuentes Granadero, Lourdes</li><li>Procesando tutor Galán Caballero, Rafael</li><li>Procesando tutor Gallego Aradillo, Antonia Ana</li><li>Procesando tutor Gallego Aradillo, Antonia Ana</li><li>Procesando tutor Galván Campanario, Soledad</li><li>Procesando tutor Galván Fernández, José Joaquín</li><li>Procesando tutor Galván Fernández, José Joaquín</li><li>Procesando tutor Galván Rubio, Montserrat</li><li>Procesando tutor García Areses, Francisca Inmaculada</li><li>Procesando tutor García Espinosa, María Leticia</li><li>Procesando tutor García García, Dimas</li><li>Procesando tutor García Olivera, Epifanio</li><li>Procesando tutor García Pacheco, Antonia</li><li>Procesando tutor García Pacheco, Diego</li><li>Procesando tutor García Porras, Rafael</li><li>Procesando tutor Garrón Abadín, María José</li><li>Procesando tutor Garrón Chávez, Antonia María</li><li>Procesando tutor Garrón Chávez, Antonia María</li><li>Procesando tutor Garrón Chávez, Mónica</li><li>Procesando tutor Garrón Garrón, Carmen</li><li>Procesando tutor Garrón Garrón, Josefa</li><li>Procesando tutor Garrón Torrado, Josefa</li><li>Procesando tutor Garrote Candel, M Carmen</li><li>Procesando tutor Garrote Carrasco, Antonio</li><li>Procesando tutor Garrote Chaves, Faustina</li><li>Procesando tutor Garrote Chaves, Faustina</li><li>Procesando tutor Garrote Chaves, José Carlos</li><li>Procesando tutor Garrote Donoso, Ana María</li><li>Procesando tutor Garrote Donoso, José Antonio</li><li>Procesando tutor Garrote Donoso, Manuela</li><li>Procesando tutor Garrote Garrón, Feliciano</li><li>Procesando tutor Garrote Guerrero, Eloína</li><li>Procesando tutor Garrote Guerrero, Miguel Ángel</li><li>Procesando tutor Garrote Ledesma, Antonio</li><li>Procesando tutor Garrote Megías, Antonio</li><li>Procesando tutor Garrote Pecellín, María Josefa</li><li>Procesando tutor Garrote Peraza, Asunción</li><li>Procesando tutor Garrote Sánchez, Jerónimo</li><li>Procesando tutor Garrote Sánchez, Jerónimo</li><li>Procesando tutor Gata Chávez, Antonio</li><li>Procesando tutor Gata Galán, Isabel</li><li>Procesando tutor Gavira Rivero, Juan</li><li>Procesando tutor Giles Navarro, Francisco Javier</li><li>Procesando tutor Girol Díaz, María del Carmen</li><li>Procesando tutor Girol Díaz, María Dolores</li><li>Procesando tutor Girol Vázquez, Pilar</li><li>Procesando tutor Godino Ramos, Juan Manuel</li><li>Procesando tutor Gómez Albarrán, Concepción</li><li>Procesando tutor Gómez González, Rita</li><li>Procesando tutor González Cantillo, José</li><li>Procesando tutor González Chaves, Isabel</li><li>Procesando tutor González Chaves, Isabel</li><li>Procesando tutor González Curiel, Francisco Javier</li><li>Procesando tutor González Delgado, José</li><li>Procesando tutor González Durán, María del Carmen</li><li>Procesando tutor González Fernández, Daniel</li><li>Procesando tutor González Fernández, Daniel</li><li>Procesando tutor González Fernández, Daniel</li><li>Procesando tutor González Fernández, Natividad</li><li>Procesando tutor González Ferreira, Dolores</li><li>Procesando tutor González Ferreira, Fernando José</li><li>Procesando tutor González Ferreira, Juan Antonio</li><li>Procesando tutor González Ferreira, Lucía</li><li>Procesando tutor González Garrón, María Pilar</li><li>Procesando tutor González Gaviro, Nuria</li><li>Procesando tutor González Granadero, Rafael</li><li>Procesando tutor González Granadero, Rafael</li><li>Procesando tutor González Iglesias, Manuel</li><li>Procesando tutor González Megías, María Dolores</li><li>Procesando tutor González Mejías, Gloria</li><li>Procesando tutor González Mejías, Gloria</li><li>Procesando tutor González Reyes, Antonio</li><li>Procesando tutor González Reyes, Teófilo</li><li>Procesando tutor González Romero, Eva María</li><li>Procesando tutor González Romero, María del Mar</li><li>Procesando tutor Gordito López, Ángel Luis</li><li>Procesando tutor Gordito Romero, Cándida</li><li>Procesando tutor Gordito Rubio, Ramón</li><li>Procesando tutor Granadero Fuentes, José Manuel</li><li>Procesando tutor Granadero Garrote, Josefa</li><li>Procesando tutor Granadero Garrote, María del Rosario</li><li>Procesando tutor Granadero Rodríguez, Manuela</li><li>Procesando tutor Granadero Romero, José</li><li>Procesando tutor Granadero Romero, María Dolores</li><li>Procesando tutor Granados Jerez, Francisco</li><li>Procesando tutor Grau Páez, Carolina</li><li>Procesando tutor Guareño Delgado, José</li><li>Procesando tutor Guareño Garrote, Juan Carlos</li><li>Procesando tutor Guareño Reyes, Rosa María</li><li>Procesando tutor Guerrero Pérez, Ángel</li><li>Procesando tutor Guerrero Sánchez, Isabel María</li><li>Procesando tutor Guerrero Sayago, Isabel María</li><li>Procesando tutor Guerrero Sayago, María del Carmen</li><li>Procesando tutor Guillén García, Ana</li><li>Procesando tutor Guillén García, Rocío</li><li>Procesando tutor Harhaoui , Abdelgani</li><li>Procesando tutor Herba , Malika</li><li>Procesando tutor Herba , Malika</li><li>Procesando tutor Herba , Mohamed</li><li>Procesando tutor Herba , Mohamed</li><li>Procesando tutor Hermoso Morales, Gabriel</li><li>Procesando tutor Hernández Benegas, Francisco</li><li>Procesando tutor Hernández Cantillo, Francisco Manuel</li><li>Procesando tutor Hernández Chavero, Francisco</li><li>Procesando tutor Hernández Chavero, Francisco</li><li>Procesando tutor Hernández Chavero, José Antonio</li><li>Procesando tutor Hernández Chavero, José Antonio</li><li>Procesando tutor Herrera Parreño, José María</li><li>Procesando tutor Hidalgo Macarro, Isidoro</li><li>Procesando tutor Hoyos Sánchez, María del Carmen</li><li>Procesando tutor Hoyos Sánchez, María del Carmen</li><li>Procesando tutor Iglesias Bayón, Eduardo</li><li>Procesando tutor Iglesias Diéguez, Begoña</li><li>Procesando tutor Iglesias Diéguez, Benita</li><li>Procesando tutor Iglesias Diéguez, María Manuela</li><li>Procesando tutor Iglesias Sánchez, Juan Carlos</li><li>Procesando tutor Isla Nogués, Natividad</li><li>Procesando tutor Jaramillo Vega, Ángela María</li><li>Procesando tutor Jaro Arencon, Josefa</li><li>Procesando tutor Jiménez Blázquez, Jaime</li><li>Procesando tutor Jiménez Castillo, Rafaela</li><li>Procesando tutor Jiménez Galván, Antonio</li><li>Procesando tutor Kaddur Vekay, Malika</li><li>Procesando tutor Kereviciute , Zydrune</li><li>Procesando tutor Lancharro Calderón, Manuel Agustín</li><li>Procesando tutor Lancharro Campanario, Clara</li><li>Procesando tutor Lancharro Campano, Antonio</li><li>Procesando tutor Lancharro Carrasco, Manuel</li><li>Procesando tutor Lancharro Chavero, Manuel</li><li>Procesando tutor Lancharro Mejías, María Reyes</li><li>Procesando tutor Lancharro Osuna, Manuel</li><li>Procesando tutor Lancharro Parra, Luz María</li><li>Procesando tutor Lancharro Terrón, Vicente</li><li>Procesando tutor Lancharro Terrón, Vicente</li><li>Procesando tutor Lara Caballero, Andrés</li><li>Procesando tutor Lara Danta, Cecilia</li><li>Procesando tutor Lara Moya, Sixto</li><li>Procesando tutor Larrayad Pereira, Rosa</li><li>Procesando tutor Lavado Gómez, José Manuel</li><li>Procesando tutor Ledesma Alvarado, María Eulalia</li><li>Procesando tutor Ledesma Garrón, Rosario</li><li>Procesando tutor Ledesma Mestre, Juan Carlos</li><li>Procesando tutor Ledesma Mestre, Juan Carlos</li><li>Procesando tutor Lekhdar , Mina</li><li>Procesando tutor Linares Moya, Francisco Javier</li><li>Procesando tutor Llimona Sánchez, José Carlos</li><li>Procesando tutor López Calderón, Ángel</li><li>Procesando tutor López Calderón, Isabel María</li><li>Procesando tutor López Calderón, José Antonio</li><li>Procesando tutor López Calderón, Manuel</li><li>Procesando tutor López Campano, Gregorio</li><li>Procesando tutor López Delgado, Antonia</li><li>Procesando tutor López Galván, Silvia</li><li>Procesando tutor López Garrón, Jerónimo</li><li>Procesando tutor López Garrón, Jerónimo</li><li>Procesando tutor López Isidoro, Francisco Javier</li><li>Procesando tutor López Jiménez, Juan Ángel</li><li>Procesando tutor López Lancharro, Manuela</li><li>Procesando tutor Lora Marchena, Teresa</li><li>Procesando tutor Lora Marchena, Teresa</li><li>Procesando tutor Lozano González, Carmen</li><li>Procesando tutor Lozano González, Tomás</li><li>Procesando tutor Lucio Gómez, María Edith</li><li>Procesando tutor Luque García, Samuel</li><li>Procesando tutor Luque Martín, Ángel</li><li>Procesando tutor Macarro Pagador, Carmen</li><li>Procesando tutor Macedo García, Francisco Javier</li><li>Procesando tutor Machío Murillo, Laureano</li><li>Procesando tutor Macías Falcón, María del Carmen</li><li>Procesando tutor Macías Rodríguez, Joaquín</li><li>Procesando tutor Maldonado Morales, Guadalupe</li><li>Procesando tutor Maldonado Rodríguez, María Carmen</li><li>Procesando tutor Marín Roldán, Eduardo</li><li>Procesando tutor Marín Roldán, Eduardo</li><li>Procesando tutor Márquez Matito, Rosa</li><li>Procesando tutor Márquez Romero, Pilar</li><li>Procesando tutor Martín Baños, Juan Carlos</li><li>Procesando tutor Martínez Bautista, Mari Luz</li><li>Procesando tutor Martínez Bautista, Sonia</li><li>Procesando tutor Martínez Infante, Urbano</li><li>Procesando tutor Martínez Redondo, Brígida</li><li>Procesando tutor Martínez Suárez, Manuela</li><li>Procesando tutor Martínez Villalba, Concepción</li><li>Procesando tutor Matamoros Rodríguez, José Antonio</li><li>Procesando tutor Mateos Gata, Eugenio</li><li>Procesando tutor Mateos Mateos, María José</li><li>Procesando tutor Mateos Pagador, Manuel José</li><li>Procesando tutor Matito Pecellín, Antonio</li><li>Procesando tutor Matitos Pecellín, Antonio</li><li>Procesando tutor Mayoral Valencia, María Ángeles</li><li>Procesando tutor Megías Artero, Ángel</li><li>Procesando tutor Megías Artero, José Antonio</li><li>Procesando tutor Megías Gómez, Francisco</li><li>Procesando tutor Megías Gómez, Francisco</li><li>Procesando tutor Megías López, Josefa</li><li>Procesando tutor Megías López, Mercedes</li><li>Procesando tutor Megías Terrón, Francisco</li><li>Procesando tutor Megías Terrón, Pedro</li><li>Procesando tutor Megías Uceda, Francisco José</li><li>Procesando tutor Megías Vargas, Luisa</li><li>Procesando tutor Mejías Gómez, Inmaculada</li><li>Procesando tutor Mejías Terrón, María del Mar</li><li>Procesando tutor Mejías Vargas, Robustiano</li><li>Procesando tutor Méndez Artero, José Antonio</li><li>Procesando tutor Méndez Artero, José Antonio</li><li>Procesando tutor Méndez Contreras, Adelaida</li><li>Procesando tutor Méndez Rodríguez, Rosa María</li><li>Procesando tutor Mendo Romero, Francisco José</li><li>Procesando tutor Mestre Naranjo, Manuel</li><li>Procesando tutor Mestres Naranjo, Manuel</li><li>Procesando tutor Miranda Álvarez, Milagros</li><li>Procesando tutor Miranda Girol, Carmen</li><li>Procesando tutor Miranda Santana, Joaquina</li><li>Procesando tutor Molero Arroyo, Félix</li><li>Procesando tutor Molero Gómez, María Isabel</li><li>Procesando tutor Molina López, Juan</li><li>Procesando tutor Monjo Monjo, María Julia</li><li>Procesando tutor Monjo Pagador, Julián</li><li>Procesando tutor Monjo Pagador, Julián</li><li>Procesando tutor Monjo Santos, José Antonio</li><li>Procesando tutor Mora Sánchez, Francisco</li><li>Procesando tutor Moral Vico, Laura Belén</li><li>Procesando tutor Morales Artero, Isabel María</li><li>Procesando tutor Morato Burgos, Mercedes</li><li>Procesando tutor Moreno Lendinel, Teresa de Jesús</li><li>Procesando tutor Morillo Morales, Juan Antonio</li><li>Procesando tutor Moro Rosales, María de los Ángeles</li><li>Procesando tutor Morón Aranda, Pedro Manuel</li><li>Procesando tutor Moruno Baños, María del Pilar</li><li>Procesando tutor Moya Santos, Josefa</li><li>Procesando tutor Moya Santos, Manuela</li><li>Procesando tutor Moya Santos, Manuela</li><li>Procesando tutor Muñiz Jaramillo, Josefa</li><li>Procesando tutor Muñoz Bernardino, Rosa María</li><li>Procesando tutor Muñoz Martínez, María de los Ángeles</li><li>Procesando tutor Muñoz Real, María del Pilar</li><li>Procesando tutor Murillo Carrasco, Manuel</li><li>Procesando tutor Murillo Carrasco, Manuel</li><li>Procesando tutor Murillo Zapata, María José</li><li>Procesando tutor Murillo Zapata, María José</li><li>Procesando tutor Naranjo Paloma, Francisco José</li><li>Procesando tutor Naranjo Paloma, Juan</li><li>Procesando tutor Naranjo Villaseñor, Carlos</li><li>Procesando tutor Naranjo Villaseñor, Carlos</li><li>Procesando tutor Navarro Cortés, María Victoria</li><li>Procesando tutor Navarro Cortés, María Victoria</li><li>Procesando tutor Navarro Núñez, Antonio</li><li>Procesando tutor Neguillo Ortega, Isidora</li><li>Procesando tutor Nieto Benítez, Ana</li><li>Procesando tutor Noguera Campanario, Cele</li><li>Procesando tutor Nogués Chaves, Corazón de María</li><li>Procesando tutor Nogués Chaves, Corazón de María</li><li>Procesando tutor Nogués Chaves, Rocío</li><li>Procesando tutor Nogués Chaves, Rocío</li><li>Procesando tutor Nogués Chávez, Fructuoso</li><li>Procesando tutor Nogués Chávez, Sonia</li><li>Procesando tutor Nogués Gómez, María del Mar</li><li>Procesando tutor Núñez Vargas, José Julián</li><li>Procesando tutor Núñez Vargas, José Julián</li><li>Procesando tutor Oliva Cantillo, José</li><li>Procesando tutor Oliva Cantillo, Manuel</li><li>Procesando tutor Oliva García, José Carlos</li><li>Procesando tutor Onel , Claudiu-Cristian</li><li>Procesando tutor Onel , Lacramioara-Lenuta</li><li>Procesando tutor Orejuela Donneys, Robinson</li><li>Procesando tutor Ortiz Candel, Manuela</li><li>Procesando tutor Pacheco Cardoso, Diego</li><li>Procesando tutor Pagador González, Salvador</li><li>Procesando tutor Palacios Garrote, Manuela</li><li>Procesando tutor Pallero Villa, José</li><li>Procesando tutor Palomo Sánchez, José Carlos</li><li>Procesando tutor Paniagua Baños, José Luis</li><li>Procesando tutor Paniagua Baños, José Luis</li><li>Procesando tutor Paniagua Baños, Manuel</li><li>Procesando tutor Parra Garrote, Antonio</li><li>Procesando tutor Parra Garrote, Gerónimo</li><li>Procesando tutor Pavón De la Cruz, Antonio</li><li>Procesando tutor Pavón Oliva, Eva María</li><li>Procesando tutor Paz Castro, Santiago</li><li>Procesando tutor Pecellín Cardoso, José</li><li>Procesando tutor Pecellín Contreras, María</li><li>Procesando tutor Pecellín Duqueso, José Antonio</li><li>Procesando tutor Pecellín Garrote, José Antonio</li><li>Procesando tutor Pecellín Pecellín, Manuel</li><li>Procesando tutor Pecellín Sayago, Antonia</li><li>Procesando tutor Pecellín Sayago, Cristina</li><li>Procesando tutor Pelayo Rodríguez, María Isabel</li><li>Procesando tutor Peraza Calcatierra, Carmen</li><li>Procesando tutor Pereira Rosario, Carmen</li><li>Procesando tutor Pereira Rosario, Carmen</li><li>Procesando tutor Pereira Rosario, Sandra</li><li>Procesando tutor Perera Vázquez, Antonio</li><li>Procesando tutor Pérez González, José Manuel</li><li>Procesando tutor Pérez Santana, Concepción</li><li>Procesando tutor Pérez Santana, Concepción</li><li>Procesando tutor Pérez Santiago, Mónica</li><li>Procesando tutor Pérez-Carrasco Pulido, Antonio</li><li>Procesando tutor Pizarro Calderón, Juan</li><li>Procesando tutor Pizarro Lora, José Carlos</li><li>Procesando tutor Pizarro Lora, José Carlos</li><li>Procesando tutor Pizarro Lora, Salud</li><li>Procesando tutor Pizarro Mateos, Manuel</li><li>Procesando tutor Pozuelo Gómez, Elisa</li><li>Procesando tutor Puentenueva Falcón, Beatriz</li><li>Procesando tutor Pulgarín González, David</li><li>Procesando tutor Pulice , Francisco Alfonso</li><li>Procesando tutor Quinta Vasco, María del Monte</li><li>Procesando tutor Quintero Cubero, Antonio</li><li>Procesando tutor Quintero Cubero, Antonio</li><li>Procesando tutor Ramayo Calderón, José Antonio</li><li>Procesando tutor Ramos Jaro, Sacramento</li><li>Procesando tutor Ramos Jaro, Sacramento</li><li>Procesando tutor Ramos Moya, Blasa</li><li>Procesando tutor Ramos Moya, Blasa</li><li>Procesando tutor Ramos Pérez, María del Rosario</li><li>Procesando tutor Ramos Pérez, María del Rosario</li><li>Procesando tutor Real Fonseca, Josefa</li><li>Procesando tutor Real Fonseca, Josefa</li><li>Procesando tutor Real Fonseca, María Isabel</li><li>Procesando tutor Real Moñino, Manuel Jesús</li><li>Procesando tutor Rebollo Balsera, Joaquín</li><li>Procesando tutor Rebollo Chávez, María Dolores</li><li>Procesando tutor Reyes Álvarez, Andrés</li><li>Procesando tutor Reyes Guareño, Félix</li><li>Procesando tutor Reyes Guareño, Joaquín</li><li>Procesando tutor Rita Pula Domínguez, Antonio</li><li>Procesando tutor Rivera Rosado, Jennifer</li><li>Procesando tutor Robledo González, Jesús</li><li>Procesando tutor Robles Ferrera, Manuel</li><li>Procesando tutor Rodríguez Álvarez, Antonia</li><li>Procesando tutor Rodríguez Barroso, Ana</li><li>Procesando tutor Rodríguez Cano, Braulio</li><li>Procesando tutor Rodríguez Fernández, Carmen</li><li>Procesando tutor Rodríguez Fernández, María de las Mercedes</li><li>Procesando tutor Rodríguez García, María Isabel</li><li>Procesando tutor Rodríguez Garrote, Lorenzo</li><li>Procesando tutor Rodríguez Macarro, Antonia</li><li>Procesando tutor Rodríguez Macarro, Antonia</li><li>Procesando tutor Rodríguez Macarro, Francisca</li><li>Procesando tutor Rodríguez Nieto, Antonio</li><li>Procesando tutor Rodríguez Para, José Ignacio</li><li>Procesando tutor Rodríguez Silva, María Concepción</li><li>Procesando tutor Rodríguez Vázquez, Francisco</li><li>Procesando tutor Roguera Abril, Antonia</li><li>Procesando tutor Roldán Villalba, Carmen María</li><li>Procesando tutor Romero Garrote, María Soledad</li><li>Procesando tutor Romero Granadero, Valentina</li><li>Procesando tutor Romero Megías, José Antonio</li><li>Procesando tutor Romero Montero, María Josefa</li><li>Procesando tutor Romero Rodríguez, María del Rosario</li><li>Procesando tutor Romero Terrón, Esperanza</li><li>Procesando tutor Romero Terrón, Reyes</li><li>Procesando tutor Romero Vázquez, María Ángeles</li><li>Procesando tutor Rubio Lora, Dolores María</li><li>Procesando tutor Rubio Lora, Dolores María</li><li>Procesando tutor Rubio Moya, Juan Antonio</li><li>Procesando tutor Rubio Moya, Juan Antonio</li><li>Procesando tutor Rueda Campanario, Mari Luz</li><li>Procesando tutor Rueda Campanario, Mari Luz</li><li>Procesando tutor Rufo Gómez, Manuel</li><li>Procesando tutor Ruivo Robles Rita, Fátima Da Conceicao</li><li>Procesando tutor Ruiz Torrelosa, Francisco</li><li>Procesando tutor Sabido Ríos, Manuel</li><li>Procesando tutor Sabido Ríos, María Isabel</li><li>Procesando tutor San Juan Lahoz, Azucena</li><li>Procesando tutor San Juan Lahoz, Azucena</li><li>Procesando tutor Sánchez Calderón, Victoria</li><li>Procesando tutor Sánchez Carrasco, Ramón</li><li>Procesando tutor Sánchez Carrasco, Ramón</li><li>Procesando tutor Sánchez Carrillo, José</li><li>Procesando tutor Sánchez Danta, Francisco Javier</li><li>Procesando tutor Sánchez Danta, Francisco Javier</li><li>Procesando tutor Sánchez Durán, Francisca</li><li>Procesando tutor Sánchez Garrote, Bernardo</li><li>Procesando tutor Sánchez Garrote, Bernardo</li><li>Procesando tutor Sánchez Gato, Eduarda</li><li>Procesando tutor Sánchez Gato, Federico</li><li>Procesando tutor Sánchez Guareño, Antonia</li><li>Procesando tutor Sánchez Gutiérrez, Yolanda</li><li>Procesando tutor Sánchez Hermoso, María del Carmen</li><li>Procesando tutor Sánchez Hernández, Amalia</li><li>Procesando tutor Sánchez Lancharro, Julia</li><li>Procesando tutor Sánchez López, Natividad</li><li>Procesando tutor Sánchez Moya, Francisco</li><li>Procesando tutor Sánchez Moya, José Antonio</li><li>Procesando tutor Sánchez Núñez, Begoña</li><li>Procesando tutor Sánchez Pecellín, Francisco Javier</li><li>Procesando tutor Sánchez Pecellín, María Lourdes</li><li>Procesando tutor Sánchez Sánchez, Manuela</li><li>Procesando tutor Sánchez Tomillo, Juan</li><li>Procesando tutor Sánchez Tomillo, Manuela</li><li>Procesando tutor Sánchez Vázquez, José Antonio</li><li>Procesando tutor Sánchez Villalba, Daniela</li><li>Procesando tutor Sánchez Villalba, Isabel</li><li>Procesando tutor Sánchez Villalba, José</li><li>Procesando tutor Santana Lancharro, María José</li><li>Procesando tutor Santana Lancharro, María José</li><li>Procesando tutor Santillana López, Juan Jesús</li><li>Procesando tutor Santos Hipólito, María de Lourdes</li><li>Procesando tutor Sayago Cardoso, Basilio</li><li>Procesando tutor Sayago Gallego, María Gemma</li><li>Procesando tutor Serrano Laina, Teresa</li><li>Procesando tutor Sevilla Ortiz, Agustín</li><li>Procesando tutor Silva Sabido, Andrés</li><li>Procesando tutor Solozano Marquin, Sandra Milena</li><li>Procesando tutor Tabales Larios, María Granada</li><li>Procesando tutor Tomillo Navarro, Ángela</li><li>Procesando tutor Tomillo Navarro, Ángela</li><li>Procesando tutor Torrado Garrón, Antonio</li><li>Procesando tutor Torrado Garrón, Estela</li><li>Procesando tutor Torrado Garrón, Mario</li><li>Procesando tutor Torrado Garrón, Mario</li><li>Procesando tutor Torres Prior, Juan</li><li>Procesando tutor Trenado Chávez, Sofía</li><li>Procesando tutor Uguina Moya, M Rosa</li><li>Procesando tutor Vadillo García, Enrique</li><li>Procesando tutor Valencia Herrojo, Magdalena</li><li>Procesando tutor Valencia Mejías, Antonio</li><li>Procesando tutor Valencia Trenado, Manuel Rodrigo</li><li>Procesando tutor Valiente Granadero, José Antonio</li><li>Procesando tutor Valiente Granadero, José Antonio</li><li>Procesando tutor Valverde Moya, Manuel</li><li>Procesando tutor Valverde Moya, María Felisa</li><li>Procesando tutor Valverde Moya, María Felisa</li><li>Procesando tutor Vargas Atienza, Carmelo</li><li>Procesando tutor Vargas García, Felipe</li><li>Procesando tutor Vargas García, José</li><li>Procesando tutor Vargas Rodríguez, José Manuel</li><li>Procesando tutor Vargas Villalba, Juan</li><li>Procesando tutor Vargas Villalba, María Teresa</li><li>Procesando tutor Vasco Garrón, Dolores</li><li>Procesando tutor Vasco Garrón, Dolores</li><li>Procesando tutor Vasco Garrón, Emilia</li><li>Procesando tutor Vasco Hernández, Juan Carlos</li><li>Procesando tutor Vasco Ruiz, María Martina</li><li>Procesando tutor Vasco Ruiz, Valentín</li><li>Procesando tutor Vasco Ruiz, Valentín</li><li>Procesando tutor Vasco Torrado, Teófilo</li><li>Procesando tutor Vasco Vargas, Concepción</li><li>Procesando tutor Vasco Vargas, Lourdes</li><li>Procesando tutor Vaz Geraldes, María del Carmen</li><li>Procesando tutor Vázquez Indiano, Milagros</li><li>Procesando tutor Vázquez Lancharro, Josefa</li><li>Procesando tutor Vázquez Lancharro, Josefa</li><li>Procesando tutor Vázquez Martínez, Farncisco José</li><li>Procesando tutor Vázquez Oliva, José Antonio</li><li>Procesando tutor Vázquez Parra, Antonio</li><li>Procesando tutor Vázquez Parra, Antonio</li><li>Procesando tutor Velasco Castro, Miguel Ángel</li><li>Procesando tutor Velázquez Mallofret, José Manuel</li><li>Procesando tutor Velázquez Vázquez, Ana María</li><li>Procesando tutor Velázquez Vázquez, María José</li><li>Procesando tutor Vicente Romero, Cristina</li><li>Procesando tutor Vicente Romero, Cristina</li><li>Procesando tutor Vila Lobón, María Concepción</li><li>Procesando tutor Villacis Barrera, Marisol</li><li>Procesando tutor Villalba Ambrona, Clara Isabel</li><li>Procesando tutor Villalba Calderón, Antonio</li><li>Procesando tutor Villalba Calderón, Manuel</li><li>Procesando tutor Villalba Cantillo, José</li><li>Procesando tutor Villalba Cubo, Francisco</li><li>Procesando tutor Villalba Gallego, María José</li><li>Procesando tutor Villalba Garrote, María del Pilar</li><li>Procesando tutor Villalba Muñiz, Francisco Javier</li><li>Procesando tutor Villalba Talamino, Ana Belén</li><li>Procesando tutor Zambrano Toribio, Antonia</li><li>Procesando tutor Zambrano Toribio, Antonia</li><li>Procesando tutor Zamfir , Fane</li><li>Procesando tutor Zamfir , Garofita</li><li>Procesando tutor Zamfir , Octavian</li><li>Procesando tutor Zamfir , Pusa</li><li>Procesando tutor Zapata Cubero, Antonio</li><li>Procesando tutor Zapata Cubero, Antonio</li><li>Procesando tutor Zapata Cubero, María Dolores</li><li>Procesando tutor Zapata Megías, Casimiro</li><li>Procesando tutor Zapata Megías, Casimiro</li><li>Procesando tutor Zapata Mejías, Ángel Luis</li><li>Procesando tutor Zapata Mejías, María de los Ángeles</li><li>Procesando tutor Zapata Mejías, María de los Ángeles</li><li>Procesando tutor Zapata Mejías, Raúl</li><li>Procesando tutor Zapata Morales, Antonio</li><li>Procesando tutor Zoilo Terrón, Jerónimo</li><li>Procesando tutor Zoilo Terrón, José Agustín</li></ul>	1
3	2016-10-21 09:31:47.417221+02	2016-10-24 10:24:38.057933+02	DA	rayuela/2016/10/21/RegAlum.ods	t	<h5>Resultado del proceso</h5><ul><li>Procesando alumno Abril Santana, Mario</li><li>Procesando alumno Abril Santana, Míriam</li><li>Procesando alumno Alcantarilla Romero, Alejandro</li><li>Procesando alumno Almagro Lara, Blanca María</li><li>Procesando alumno Almeida Méndez, Rubén</li><li>Procesando alumno Alonso Sánchez, Candela</li><li>Procesando alumno Álvarez González, Gema</li><li>Procesando alumno Ambrona López, Elena</li><li>Procesando alumno Ambrona Rebollo, Javier</li><li>Procesando alumno Ambrona Vila, Ángela</li><li>Procesando alumno Arroyo Botón, Javier</li><li>Procesando alumno Artero Fernández, Javier</li><li>Procesando alumno Ávila Moral, Aarón</li><li>Procesando alumno Balsera Durán, Alba</li><li>Procesando alumno Balsera Durán, Daniel</li><li>Procesando alumno Barragán Delgado, Nerea</li><li>Procesando alumno Barragán Delgado, Valeria</li><li>Procesando alumno Barragán Guillén, José Antonio</li><li>Procesando alumno Barragán Martínez, Sandra</li><li>Procesando alumno Barragán Miranda, Lucía</li><li>Procesando alumno Barroso Maldonado, María</li><li>Procesando alumno Barroso Roguera, Belén</li><li>Procesando alumno Bautista Delgado, Diego</li><li>Procesando alumno Bautista Peraza, Elena</li><li>Procesando alumno Bautista Ramos, Belén María</li><li>Procesando alumno Bautista Ramos, Fátima</li><li>Procesando alumno Bayón Caballero, Celia</li><li>Procesando alumno Bayón Macías, Victoria</li><li>Procesando alumno Bayón Rodríguez, Francisco</li><li>Procesando alumno Bayón Rodríguez, Víctor</li><li>Procesando alumno Benítez Rubio, Laura</li><li>Procesando alumno Benítez Rubio, Lucía</li><li>Procesando alumno Bonilla Colorado, Ana Isabel</li><li>Procesando alumno Botón Maldonado, Antonio Luis</li><li>Procesando alumno Caballero Gordito, Tamara</li><li>Procesando alumno Calderón Aceiton, Elena</li><li>Procesando alumno Calderón Barragán, Gema</li><li>Procesando alumno Calderón Bayón, Ángeles</li><li>Procesando alumno Calderón Carballar, Alberto</li><li>Procesando alumno Calderón Carballar, Valeria</li><li>Procesando alumno Calderón Delgado, Carlos</li><li>Procesando alumno Calderón Gallego, Ana</li><li>Procesando alumno Calderón Gallego, Francisco Javier</li><li>Procesando alumno Calderón Garrote, Javier</li><li>Procesando alumno Calderón Guareño, Alfonso</li><li>Procesando alumno Calderón Márquez, María</li><li>Procesando alumno Calderón Palacios, Juan</li><li>Procesando alumno Calderón Sánchez, Carmen</li><li>Procesando alumno Calderón Sánchez, María</li><li>Procesando alumno Calderón Vasco, Álvaro</li><li>Procesando alumno Calderón Vasco, David</li><li>Procesando alumno Calvo Miranda, Jorge</li><li>Procesando alumno Campanario Ferrero, Noelia</li><li>Procesando alumno Campanario Rueda, Desiré</li><li>Procesando alumno Campanario Rueda, Juan Carlos</li><li>Procesando alumno Campos Barrero, Myriam</li><li>Procesando alumno Cardoso Sayago, Gemma</li><li>Procesando alumno Carrasco Álvarez, Adrián</li><li>Procesando alumno Carrasco Blanco, Rafael</li><li>Procesando alumno Carrasco Granadero, Eduardo</li><li>Procesando alumno Carrasco Lancharro, Antonio Jesús</li><li>Procesando alumno Carrasco Márquez, Luna</li><li>Procesando alumno Carrasco Morales, Daniel</li><li>Procesando alumno Carrasco Sánchez, Miguel</li><li>Procesando alumno Castillo Campano, Desirée</li><li>Procesando alumno Castro Jaramillo, Antonia</li><li>Procesando alumno Chavero López, Andrea</li><li>Procesando alumno Chavero Sánchez, José Carlos</li><li>Procesando alumno Chavero Velázquez, Carla</li><li>Procesando alumno Chaves Romero, Jesús</li><li>Procesando alumno Chávez Gata, Luis Miguel</li><li>Procesando alumno Chávez González, Claudia</li><li>Procesando alumno Chávez González, Elena</li><li>Procesando alumno Chávez Hoyos, Elena</li><li>Procesando alumno Chávez Hoyos, Laura</li><li>Procesando alumno Cobos Martínez, Nerea</li><li>Procesando alumno Colorado Ferreira, Cristian</li><li>Procesando alumno Colorado Megías, David</li><li>Procesando alumno Conde Moruno, Carla</li><li>Procesando alumno Contreras Chaves, Miguel</li><li>Procesando alumno Contreras Chaves, Raúl</li><li>Procesando alumno Contreras Chaves, Sergio</li><li>Procesando alumno Contreras Durán, Inés</li><li>Procesando alumno Contreras Ferreira, Laura</li><li>Procesando alumno Contreras Iglesias, Alejandro</li><li>Procesando alumno Córdoba Barranco, Juan Antonio</li><li>Procesando alumno Covilla D'Acosta, Desireé</li><li>Procesando alumno Crisóstomo Lozano, Marta</li><li>Procesando alumno Cubero Carrasco, Candela</li><li>Procesando alumno Cubero Carrasco, Mario</li><li>Procesando alumno Cubero González, Fabián</li><li>Procesando alumno Cubero Zapata, Antonio</li><li>Procesando alumno Cubo González, Juan José</li><li>Procesando alumno Dacosta Bayón, Raúl</li><li>Procesando alumno Dahiri , María</li><li>Procesando alumno Danta Romero, Raúl</li><li>Procesando alumno Danta San Juan, Soraya</li><li>Procesando alumno Danta San Juan, Yumara</li><li>Procesando alumno De la Coba Córdoba, Ángel</li><li>Procesando alumno De Ocampo Delgado, Mario</li><li>Procesando alumno Delgado Aguilar, Almudena</li><li>Procesando alumno Delgado Calderón, Juan</li><li>Procesando alumno Delgado González, Sergio</li><li>Procesando alumno Delgado Romero, David</li><li>Procesando alumno Delgado Zambrano, Jesús</li><li>Procesando alumno Delgado Zambrano, María Teresa</li><li>Procesando alumno Díaz Domínguez, Judith</li><li>Procesando alumno Domínguez Blanco, Jonathan</li><li>Procesando alumno Domínguez Campano, Isabel María</li><li>Procesando alumno Domínguez Sabido, Francisco Javier</li><li>Procesando alumno Domínguez Uguina, Antonio Jesús</li><li>Procesando alumno Domínguez Vaz, Alicia</li><li>Procesando alumno Donoso Calderón, Manuel José</li><li>Procesando alumno Duqueso Villalba, Clara</li><li>Procesando alumno Durán Mejías, María del Mar</li><li>Procesando alumno Escudero Muñoz, Gerard</li><li>Procesando alumno Espacio Santos, Ara</li><li>Procesando alumno Esteban Delgado, María</li><li>Procesando alumno Esteban González, Paula</li><li>Procesando alumno Esteban Ortiz, Alicia</li><li>Procesando alumno Estévez Baños, Mónica</li><li>Procesando alumno Estévez Baños, Xavier</li><li>Procesando alumno Expósito Granadero, Marcos</li><li>Procesando alumno Fernández Cañizares, Francisco José</li><li>Procesando alumno Fernández Cubero, Victoria</li><li>Procesando alumno Fernández Fernández, Saúl</li><li>Procesando alumno Fernández Garrote, Macarena</li><li>Procesando alumno Fernández González, Marcos</li><li>Procesando alumno Fernández Megías, Paola</li><li>Procesando alumno Fernández Ramos, Carmen María</li><li>Procesando alumno Fernández Ramos, María de los Ángeles</li><li>Procesando alumno Fernández Sánchez, Isabel</li><li>Procesando alumno Fernández Vasco, María de los Ángeles</li><li>Procesando alumno Fernández Zapata, Andrés</li><li>Procesando alumno Fernández Zapata, Diego</li><li>Procesando alumno Ferreira Lancharro, Francisco Javier</li><li>Procesando alumno Ferreira Pizarro, Carlos</li><li>Procesando alumno Filigrana Guillén, Daniel</li><li>Procesando alumno Flores Baños, Ismael</li><li>Procesando alumno Flores Moro, María Luisa</li><li>Procesando alumno Galán Cano, Alejandro</li><li>Procesando alumno Galván Ferrero, David</li><li>Procesando alumno Galván Ferrero, Raúl</li><li>Procesando alumno García Campanario, Ainhoa</li><li>Procesando alumno García Chavero, Adrián</li><li>Procesando alumno García Galván, Ana Isabel</li><li>Procesando alumno García Garrote, Laura</li><li>Procesando alumno García Muñiz, Juan Carlos</li><li>Procesando alumno Garrote Abril, Celia</li><li>Procesando alumno Garrote Fuentes, Álvaro</li><li>Procesando alumno Garrote Fuentes, Carmen</li><li>Procesando alumno Garrote García, Ana</li><li>Procesando alumno Garrote Garrón, Javier</li><li>Procesando alumno Garrote Garrón, María</li><li>Procesando alumno Garrote Ledesma, Alberto</li><li>Procesando alumno Garrote Mateos, Cristina</li><li>Procesando alumno Garrote Megías, Ángela</li><li>Procesando alumno Gata Rodríguez, Leire</li><li>Procesando alumno Gavira Rodríguez, Laura</li><li>Procesando alumno Gedvilas Kerevicius, Danielius</li><li>Procesando alumno Giles Grau, Pedro</li><li>Procesando alumno Godino Gómez, Alberto</li><li>Procesando alumno Gómez Monjo, María de los Ángeles</li><li>Procesando alumno González Bernáldez, Sira</li><li>Procesando alumno González Cardoso, Fabián</li><li>Procesando alumno González Cubero, Daniel</li><li>Procesando alumno González Delgado, Elena Isabel</li><li>Procesando alumno González Delgado, Rafael</li><li>Procesando alumno González Fernández, Cristian</li><li>Procesando alumno González Fernández, Javier</li><li>Procesando alumno González Nogués, Sonia</li><li>Procesando alumno González Pecellín, Pablo</li><li>Procesando alumno González Vasco, Antonio</li><li>Procesando alumno González Vázquez, José Daniel</li><li>Procesando alumno González Vázquez, Paola</li><li>Procesando alumno González Villacis, José Fernando</li><li>Procesando alumno Gordito Rivera, Francisco Alejandro</li><li>Procesando alumno Gordito Velázquez, Desiree</li><li>Procesando alumno Granadero Larrayad, Alba</li><li>Procesando alumno Granadero Villalba, Belén</li><li>Procesando alumno Granados Calderón, Francisco</li><li>Procesando alumno Guareño Muñoz, Laura</li><li>Procesando alumno Guareño Valencia, Alba</li><li>Procesando alumno Guerrero Noguera, Ignacio</li><li>Procesando alumno Harkaoui Elabbassi, Amal</li><li>Procesando alumno Herba Herba, Nabil</li><li>Procesando alumno Herba Herba, Najib</li><li>Procesando alumno Hermoso Morato, Mercedes</li><li>Procesando alumno Hernández Bayón, Laura</li><li>Procesando alumno Hernández Bayón, Sara</li><li>Procesando alumno Hernández Cardoso, Gabriel</li><li>Procesando alumno Hernández Fernández, Carlos</li><li>Procesando alumno Hernández Fernández, María</li><li>Procesando alumno Hernández Lucio, Adrián</li><li>Procesando alumno Hernández Lucio, Carlos Andrés</li><li>Procesando alumno Herrera Garrón, Celia</li><li>Procesando alumno Hidalgo Artero, Luis</li><li>Procesando alumno Iglesias Fuentes, Ángel</li><li>Procesando alumno Iglesias Muñoz, Jesús</li><li>Procesando alumno Jiménez Garrón, Jaime</li><li>Procesando alumno Jiménez Rodríguez, Esperanza</li><li>Procesando alumno Lancharro Bayón, Jesús</li><li>Procesando alumno Lancharro Bayón, Manuel</li><li>Procesando alumno Lancharro Girol, Gabriel</li><li>Procesando alumno Lancharro Hernández, María José</li><li>Procesando alumno Lancharro Kaddur, Verónica</li><li>Procesando alumno Lancharro Lora, Marta</li><li>Procesando alumno Lancharro Lora, Vicente</li><li>Procesando alumno Lancharro Sánchez, Laura</li><li>Procesando alumno Lara Bermúdez, Gonzalo</li><li>Procesando alumno Lara Garrote, Marina</li><li>Procesando alumno Lavado González, Carolina</li><li>Procesando alumno Ledesma Caro, Carlos</li><li>Procesando alumno Ledesma Caro, Luis</li><li>Procesando alumno Linares Guerrero, Ana</li><li>Procesando alumno Llimona Cabeza, Mario</li><li>Procesando alumno López Balsera, Diego</li><li>Procesando alumno López Cerón, Celia</li><li>Procesando alumno López Cordero, Claudia</li><li>Procesando alumno López Domínguez, Estefanía</li><li>Procesando alumno López Pereira, Marcos</li><li>Procesando alumno López Pereira, Victoria</li><li>Procesando alumno López Sánchez, Laura</li><li>Procesando alumno López Villalba, Manuel</li><li>Procesando alumno Lozano Vargas, Natalia</li><li>Procesando alumno Luque Calderón, Andrea</li><li>Procesando alumno Luque Calderón, Rubén</li><li>Procesando alumno Luque Pérez, Leire</li><li>Procesando alumno Luque Romero, Alicia</li><li>Procesando alumno Macedo Pereira, Adrián</li><li>Procesando alumno Machio Rodríguez, María Cristina</li><li>Procesando alumno Macías Ledesma, Violeta</li><li>Procesando alumno Marín Durán, Ainhoa</li><li>Procesando alumno Marín Durán, Hugo</li><li>Procesando alumno Márquez Domínguez, Manuel</li><li>Procesando alumno Martín Carrasco, Irene</li><li>Procesando alumno Martínez Girol, Javier</li><li>Procesando alumno Matamoros Vázquez, María del Valle</li><li>Procesando alumno Mateos Díaz, Daniel</li><li>Procesando alumno Mateos García, Rocío</li><li>Procesando alumno Matito Garrón, Álvaro</li><li>Procesando alumno Matito Garrón, Isabel</li><li>Procesando alumno Megías Cubero, Ángel Manuel</li><li>Procesando alumno Megías Fernández, Andrés</li><li>Procesando alumno Megías Garrote, Adrián</li><li>Procesando alumno Megías Garrote, Alejandra</li><li>Procesando alumno Megías Guerrero, Mario</li><li>Procesando alumno Megías Neguillo, Izan</li><li>Procesando alumno Megías Pecellín, Tania</li><li>Procesando alumno Megías Sánchez, Gonzalo</li><li>Procesando alumno Méndez Rodríguez, Rosa María</li><li>Procesando alumno Méndez Valverde, Alejandra</li><li>Procesando alumno Méndez Valverde, María</li><li>Procesando alumno Mendo Lancharro, Laura</li><li>Procesando alumno Mestre Nogués, Julio</li><li>Procesando alumno Mestre Nogués, Manuel</li><li>Procesando alumno Molano Romero, María</li><li>Procesando alumno Molero Galván, Nuria</li><li>Procesando alumno Molina Jiménez, Cristina</li><li>Procesando alumno Monjo Granadero, Paula</li><li>Procesando alumno Monjo Murillo, Julián</li><li>Procesando alumno Monjo Murillo, María José</li><li>Procesando alumno Mora López, Andrea</li><li>Procesando alumno Morillo Pavón, Alejandro</li><li>Procesando alumno Morón Iglesias, Andrea</li><li>Procesando alumno Muñoz Romero, María</li><li>Procesando alumno Murillo Delgado, David</li><li>Procesando alumno Murillo Delgado, Marta</li><li>Procesando alumno Naranjo Calderón, Carlos</li><li>Procesando alumno Naranjo Calderón, Sergio</li><li>Procesando alumno Naranjo Delagado, Juan Carlos</li><li>Procesando alumno Naranjo Mejías, Ismael</li><li>Procesando alumno Navarro Rodríguez, Juan Antonio</li><li>Procesando alumno Nogués Domínguez, Míriam</li><li>Procesando alumno Núñez Ramos, Erika</li><li>Procesando alumno Núñez Ramos, José</li><li>Procesando alumno Oliva González, Raquel</li><li>Procesando alumno Oliva Mayoral, José Carlos</li><li>Procesando alumno Oliva Trenado, Agustín</li><li>Procesando alumno Onel , Andrei-Vasile</li><li>Procesando alumno Orejuela Solórzano, Robinson</li><li>Procesando alumno Pacheco Calderón, Lucía</li><li>Procesando alumno Pagador Areses, Joaquín</li><li>Procesando alumno Pallero Carrasco, María José</li><li>Procesando alumno Palomo Pelayo, Rubén</li><li>Procesando alumno Paniagua Blanco, Sonia</li><li>Procesando alumno Paniagua González, Dalía</li><li>Procesando alumno Paniagua González, José</li><li>Procesando alumno Parra Cubero, David</li><li>Procesando alumno Parra Sánchez, Carmen</li><li>Procesando alumno Pavón Nogués, Antonio</li><li>Procesando alumno Pavón Nogués, Rocío</li><li>Procesando alumno Paz Pecellín, Francisco Javier</li><li>Procesando alumno Pecellín Jaro, Zaida</li><li>Procesando alumno Pecellín Martínez, Javier</li><li>Procesando alumno Pecellín Nogués, María</li><li>Procesando alumno Pecellín Sánchez, David</li><li>Procesando alumno Perera Sánchez, Carlos Javier</li><li>Procesando alumno Pérez Sánchez, Miguel Ángel</li><li>Procesando alumno Pérez Vargas, Adrián</li><li>Procesando alumno Pérez-Carrasco Gómez, Concepción</li><li>Procesando alumno Pizarro Delgado, Andrés</li><li>Procesando alumno Pizarro Delgado, Daniel</li><li>Procesando alumno Pizarro Girol, Lucía</li><li>Procesando alumno Pizarro Roldán, Javier</li><li>Procesando alumno Pulgarín Caballero, David</li><li>Procesando alumno Pulice Barbecho, Alfonso</li><li>Procesando alumno Pulice Barbecho, Teresa</li><li>Procesando alumno Quintero Chávez, Antonio</li><li>Procesando alumno Quintero Chávez, Manuel</li><li>Procesando alumno Ramayo Garrón, Carlos</li><li>Procesando alumno Rebollo Cubero, Jesús</li><li>Procesando alumno Reyes Calcatierra, Lucía</li><li>Procesando alumno Reyes Chaves, Carlos</li><li>Procesando alumno Reyes Domínguez, María</li><li>Procesando alumno Robledo Carballar, Erika</li><li>Procesando alumno Robles Bautista, Daniel</li><li>Procesando alumno Rodríguez De la Vega, Ignacio</li><li>Procesando alumno Rodríguez López, Francisco Jesús</li><li>Procesando alumno Rodríguez Martínez, Miguel</li><li>Procesando alumno Rodríguez Nieto, Antonio Fernando</li><li>Procesando alumno Rodríguez Quinta, Cristian</li><li>Procesando alumno Romero Chávez, Alejandro</li><li>Procesando alumno Rubio Navarro, Alejandro</li><li>Procesando alumno Rubio Navarro, Sheila</li><li>Procesando alumno Rufo Calderón, David</li><li>Procesando alumno Ruivo Rita, Tania de Fátima</li><li>Procesando alumno Ruiz Puentenueva, Rafael</li><li>Procesando alumno Sabido Molero, Elisabeth</li><li>Procesando alumno Sánchez Arencón, Carlos</li><li>Procesando alumno Sánchez Calderón, Fernando</li><li>Procesando alumno Sánchez Calderón, María</li><li>Procesando alumno Sánchez Carvajal, Fernando</li><li>Procesando alumno Sánchez Chávez, Julia</li><li>Procesando alumno Sánchez Chávez, Lourdes</li><li>Procesando alumno Sánchez De la Torre, Andrea</li><li>Procesando alumno Sánchez Duqueso, Irene</li><li>Procesando alumno Sánchez Miranda, Álvaro</li><li>Procesando alumno Sánchez Moreno, Lucía</li><li>Procesando alumno Sánchez Moya, Ana María</li><li>Procesando alumno Sánchez Moya, Carlos</li><li>Procesando alumno Sánchez Romero, Alba</li><li>Procesando alumno Sánchez Serrano, Noelia</li><li>Procesando alumno Santillana Garrote, Sara</li><li>Procesando alumno Sayago Macarro, Carmen</li><li>Procesando alumno Sevilla Fernández, Darío</li><li>Procesando alumno Silva Caballero, Jorge</li><li>Procesando alumno Soares Dos Santos, Ana Rita</li><li>Procesando alumno Torrado Boton, María</li><li>Procesando alumno Torrado Botón, Raquel</li><li>Procesando alumno Torrado Rodríguez, Paula</li><li>Procesando alumno Torres Granadero, Víctor</li><li>Procesando alumno Vadillo Calvo, Enrique</li><li>Procesando alumno Valencia Isla, Antonio</li><li>Procesando alumno Valencia Torrado, Manuel</li><li>Procesando alumno Valiente Delgado, Cristina</li><li>Procesando alumno Valiente Delgado, Mirella</li><li>Procesando alumno Valverde Garrote, Laura</li><li>Procesando alumno Valverde Martínez, Celia</li><li>Procesando alumno Valverde Tabales, Antonio Luis</li><li>Procesando alumno Vargas Adame, Laura</li><li>Procesando alumno Vargas Bayón, Andrés</li><li>Procesando alumno Vargas Iglesias, Álvaro</li><li>Procesando alumno Vargas Pozuelo, María de los Ángeles</li><li>Procesando alumno Vargas Sánchez, José Francisco</li><li>Procesando alumno Vargas Tomillo, Adrián</li><li>Procesando alumno Vargas Tomillo, Roberto</li><li>Procesando alumno Vasco Martínez, Carlos</li><li>Procesando alumno Vasco Sánchez, María</li><li>Procesando alumno Vasco Vicente, Cristina</li><li>Procesando alumno Vasco Vicente, Marina</li><li>Procesando alumno Vázquez Delgado, Pablo</li><li>Procesando alumno Vázquez Guerrero, Pablo</li><li>Procesando alumno Vázquez Pérez, Carmen</li><li>Procesando alumno Vázquez Pérez, Sandra</li><li>Procesando alumno Vázquez Rodríguez, José Antonio</li><li>Procesando alumno Velasco Campano, Miguel Ángel</li><li>Procesando alumno Velázquez Vasco, José Manuel</li><li>Procesando alumno Villalba Andrés, Lucía</li><li>Procesando alumno Villalba Delgado, Lucía</li><li>Procesando alumno Villalba García, Manuel</li><li>Procesando alumno Villalba Moya, Javier</li><li>Procesando alumno Villalba Vasco, Daniel</li><li>Procesando alumno Zamfir , Fabián Tudor</li><li>Procesando alumno Zamfir , Florea</li><li>Procesando alumno Zapata Barbecho, Cristina</li><li>Procesando alumno Zapata Barbecho, Nuria</li><li>Procesando alumno Zapata Botón, Laura</li><li>Procesando alumno Zapata Méndez, Clara</li><li>Procesando alumno Zapata Real, Clara</li><li>Procesando alumno Zapata Real, Jesús</li><li>Procesando alumno Zapata Real, Juan José</li><li>Procesando alumno Zoilo Calderón, Laura</li><li>Procesando alumno Zoilo Villalba, Clara</li></ul>	1
\.


--
-- Name: rayuela_rayuela_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('rayuela_rayuela_id_seq', 4, true);


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY socialaccount_socialaccount (id, provider, uid, last_login, date_joined, extra_data, user_id) FROM stdin;
\.


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('socialaccount_socialaccount_id_seq', 1, false);


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY socialaccount_socialapp (id, provider, name, client_id, secret, key) FROM stdin;
\.


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('socialaccount_socialapp_id_seq', 1, false);


--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
\.


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('socialaccount_socialapp_sites_id_seq', 1, false);


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
\.


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('socialaccount_socialtoken_id_seq', 1, false);


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY users_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, name, dni, es_usuario, foto, id_usuario, usuario_rayuela) FROM stdin;
2	!C8rXYgeAqW7BR8ey5thMRZk4QNZzkSeZu6c8Bv7I	2016-10-17 14:25:33.762482+02	f	asevillao01	Agustín	Sevilla Ortiz		t	t	2016-10-14 14:16:14.517013+02	Agustin Sevilla Ortiz	80042070T	t		17905	asevillao01
1	pbkdf2_sha256$30000$wP95IAkOkttY$p4rNWRa/C5JZi441FBj5dyLjs8XktKiEqghp6qgvBeU=	2016-10-24 10:22:24.074509+02	t	fmoras01	Francisco	Mora Sánchez	francisco.mora.sanchez@gmail.com	t	t	2016-10-14 13:11:31+02	Francisco Mora Sánchez	79263084R	f	usuarios/fmoras01/minipaco.jpg		fmoras01
10		\N	f	vacosta9	Víctor Manuel	Acosta Guerrero		t	t	2016-10-20 08:44:00+02		44777120F	t	usuarios/vacosta9/Acosta_Guerrero_Victor.png	26563	vacosta9
12		\N	f	aparroyos01	Alberto Pablo	Arroyo Sánchez		t	t	2016-10-20 08:44:01+02		70886062Q	t	usuarios/aparroyos01/Alberto_Pablo_Arroyo_Sánchez1.JPG	630730	aparroyos01
16		\N	f	caro72	María Elena	Caro Puértolas		t	t	2016-10-20 08:44:02+02		9192982C	t	usuarios/caro72/caro_elena.jpg	20022	caro72
4	!cgfEhzg8usTeaxH2PqQb8irzOkkGRxrV9Of3uz9c	2016-10-17 14:30:13+02	f	fsolism03	Fernando	Solís Maya		t	t	2016-10-17 14:30:13+02	Fernando Solis Maya	8840281R	t	usuarios/fsolism03/Fernando_Solis_Maya1.JPG	611307	fsolism03
15		\N	f	jolucarbar1	José Luis	Cardoso Barbecho		t	t	2016-10-20 08:44:02+02		28868404T	t	usuarios/jolucarbar1/Barbecho.jpg	20021	jolucarbar1
3	!DLt0cLXfe1cKfZVrkJlTMCBxXzDrbzgTDxqGkgWh	2016-10-17 14:28:50.987349+02	f	profesor	profesor	profesor		t	t	2016-10-17 14:28:50.93752+02	profesor profesor	76246535V	f			profesor
11		\N	f	meantunezg01	María Eulalia	Antúnez Gabardino		t	t	2016-10-20 08:44:01.44889+02		76253873H	t		523780	meantunezg01
13		\N	f	jgfdcep08	José Gabriel	Báez Aradilla		t	t	2016-10-20 08:44:01.862735+02		33971303G	t		500	jgfdcep08
14		\N	f	mbarbechot01	Manuel	Barbecho Terrón		t	t	2016-10-20 08:44:02.042336+02		34780107J	t		22152	mbarbechot01
20		\N	f	rdec01	Rosario	De Castro Calderón		t	t	2016-10-20 08:44:03.830388+02		80055898M	t		27533	rdec01
21		\N	f	lidel01	Loreto Inmaculada	De la Vega Sánchez		t	t	2016-10-20 08:44:04.095699+02		34007136A	t		20023	lidel01
22		\N	f	ldiazg01	Luisa	Díaz González		t	t	2016-10-20 08:44:04.200131+02		33976182F	t		24364	ldiazg01
25		\N	f	sabema01	María del Carmen	Fonseca Cantos		t	t	2016-10-20 08:44:04.917216+02		44781196N	t		20089	sabema01
26		\N	f	dfuentesb02	Daniel	Fuentes Barrientos		t	t	2016-10-20 08:44:05.193461+02		76245693A	t		372175	dfuentesb02
31		\N	f	cgomeza01	Concepción	Gómez Albarrán		t	t	2016-10-20 08:44:06.822341+02		80045235Z	t		20026	cgomeza01
33		\N	f	jcledesmam01	Juan Carlos	Ledesma Mestre		t	t	2016-10-20 08:44:07.193934+02		28857806M	t		20029	jcledesmam01
34		\N	f	mjmacedog01	María Josefa	Macedo García		t	t	2016-10-20 08:44:07.360219+02		8813331F	t		17013	mjmacedog01
35		\N	f	manpan64	José	Manzano Pando		t	t	2016-10-20 08:44:07.520197+02		80036994F	t		20031	manpan64
39		\N	f	plnogues3	Pablo Luis	Nogués Chavero		t	t	2016-10-20 08:44:08.428305+02		80055490B	t		19460	plnogues3
43		\N	f	dpachecoc01	Diego	Pacheco Cardoso		t	t	2016-10-20 08:44:09.049173+02		76246514L	t		20162	dpachecoc01
45		\N	f	cramirezp02	Carmen	Ramírez Pizarro		t	t	2016-10-20 08:44:09.376407+02		44775743X	t		402297	cramirezp02
48		\N	f	arodriguezb46	Alina	Rodríguez Bote		t	t	2016-10-20 08:44:10.052228+02		76040487A	t		392039	arodriguezb46
50		\N	f	aruizb25	Ambrosio	Ruiz Burgos		t	t	2016-10-20 08:44:10.436715+02		5671869T	t		612018	aruizb25
51		\N	f	torrado27	Juan Manuel	Torrado Martínez		t	t	2016-10-20 08:44:10.820106+02		80070615W	t		19344	torrado27
52		\N	f	strinidada01	Sagrario	Trinidad Araujo		t	t	2016-10-20 08:44:11.05797+02		34030840V	t		17014	strinidada01
53		\N	f	mlvazquezb01	María Luisa	Vázquez Burgueño		t	t	2016-10-20 08:44:11.316923+02		8782151S	t		20037	mlvazquezb01
55		\N	f	amvegal01	Ana María	Vega Llano		t	t	2016-10-20 08:44:11.616702+02		8882790Y	t		296918	amvegal01
17		\N	f	micastañedab01	María Isabel	Castañeda Bellido		t	t	2016-10-20 08:44:03+02		48975590B	t	usuarios/micastañedab01/Mª_Isabel_Castañeda.jpg	587421	micastañedab01
18		\N	f	icorcherog01	Isabel	Corchero García		t	t	2016-10-20 08:44:03+02		80056374K	t	usuarios/icorcherog01/Isabel_Corchero_García.jpg	543342	icorcherog01
19		\N	f	ldasilvam01	Libania de los Ángel	Da Silva Martín		t	t	2016-10-20 08:44:03+02		28767334S	t	usuarios/ldasilvam01/Da_Silva_Martín_Libiana.JPG	41476	ldasilvam01
23		\N	f	fdominguezz01	Francisca	Domínguez Zapata		t	t	2016-10-20 08:44:04+02		80044334X	t	usuarios/fdominguezz01/Domínguez_Zapata_Francisca.jpg	23826	fdominguezz01
27		\N	f	tgarciah01	Teresa	García Hernández		t	t	2016-10-20 08:44:05+02		8803001G	t	usuarios/tgarciah01/García_Hernández_Teresa.jpg	38352	tgarciah01
28		\N	f	magarciar06	María Angustias	García Rodríguez		t	t	2016-10-20 08:44:06+02		44293882E	t	usuarios/magarciar06/García_Rodríguez_Mª_Angustias.JPG	21079	magarciar06
29		\N	f	egarduñoc01	Eva	Garduño Cobos		t	t	2016-10-20 08:44:06+02		80060693Q	t	usuarios/egarduñoc01/Eva_Garduño_Cobos.JPG	222399	egarduñoc01
30		\N	f	agarzonc02	Almudena	Garzón Carrascal		t	t	2016-10-20 08:44:06+02		34774310N	t	usuarios/agarzonc02/Garzón_Carrascal_Almudena.jpg	381681	agarzonc02
32		\N	f	laligm9	Eulalia	González Martínez		t	t	2016-10-20 08:44:07+02		9200307P	t	usuarios/laligm9/Eulalia_González_Martínez.jpg	413172	laligm9
36		\N	f	amartinc02	Alicia	Martín Cámara		t	t	2016-10-20 08:44:07+02		80056769W	t	usuarios/amartinc02/Martín_Cámara_Alicia.jpg	23884	amartinc02
37		\N	f	mcmendezt01	María Concepción	Méndez Torrescusa		t	t	2016-10-20 08:44:08+02		76250157M	t	usuarios/mcmendezt01/mendez_torrescusa_m_concepcion.jpg	21546	mcmendezt01
40		\N	f	sergnog01	Sergio Gabino	Nogués Chavero		t	t	2016-10-20 08:44:08+02		80055489X	t	usuarios/sergnog01/Sergio_Nogues_Chavero.jpg	293943	sergnog01
42		\N	f	rnoguesc01	Rocío	Nogués Chaves		t	t	2016-10-20 08:44:08+02		76246419Q	t	usuarios/rnoguesc01/Nogués_Rocio.jpg	238928	rnoguesc01
44		\N	f	mjpicond02	María Jennifer	Picón Domínguez		t	t	2016-10-20 08:44:09+02		80060180D	t	usuarios/mjpicond02/Picón_Domínguez_Mª_Jennifer.jpg	627948	mjpicond02
46		\N	f	pramosd01	Pablo	Ramos Duro		t	t	2016-10-20 08:44:09+02		33978980E	t	usuarios/pramosd01/pablo_ramos.jpg	21579	pramosd01
47		\N	f	jreciom11	Joaquín	Recio Mayorga		t	t	2016-10-20 08:44:09+02		80086124D	t	usuarios/jreciom11/Joaquín_Reico_Mayorga.JPG	627287	jreciom11
49		\N	f	jarodriguezd01	José Antonio	Rodríguez Díaz		t	t	2016-10-20 08:44:10+02		76246519R	t	usuarios/jarodriguezd01/Rodríguez_Díaz_Antonio.jpg	22422	jarodriguezd01
54		\N	f	avazquezm36	Alicia	Vázquez Marrón		t	t	2016-10-20 08:44:11+02		8882167G	t	usuarios/avazquezm36/Vázquez_Marrón_Alicia.jpg	479556	avazquezm36
38		\N	f	gitanos16	Rita María	Mesa Navarro		t	t	2016-10-20 08:44:08+02		27308458Y	t	usuarios/gitanos16/Rita1.jpg	20032	gitanos16
24		\N	f	alejandr0	José Alejandro	Fernández Muñoz		t	t	2016-10-20 08:44:04+02		16034651V	t	usuarios/alejandr0/Alejandro.jpg	3619	alejandr0
41		\N	f	mnoguesc01	Manuel	Nogués Chaves		t	t	2016-10-20 08:44:08+02		33972972V	t	usuarios/mnoguesc01/dsc01812.jpg	17808	mnoguesc01
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('users_user_groups_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('users_user_id_seq', 55, true);


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: gesties
--

COPY users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gesties
--

SELECT pg_catalog.setval('users_user_user_permissions_id_seq', 1, false);


--
-- Name: account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: alumnos_alumno_nie_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY alumnos_alumno
    ADD CONSTRAINT alumnos_alumno_nie_key UNIQUE (nie);


--
-- Name: alumnos_alumno_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY alumnos_alumno
    ADD CONSTRAINT alumnos_alumno_pkey PRIMARY KEY (id);


--
-- Name: alumnos_tutor_alumnos_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY alumnos_tutor_alumnos
    ADD CONSTRAINT alumnos_tutor_alumnos_pkey PRIMARY KEY (id);


--
-- Name: alumnos_tutor_alumnos_tutor_id_86b742c8_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY alumnos_tutor_alumnos
    ADD CONSTRAINT alumnos_tutor_alumnos_tutor_id_86b742c8_uniq UNIQUE (tutor_id, alumno_id);


--
-- Name: alumnos_tutor_dni_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY alumnos_tutor
    ADD CONSTRAINT alumnos_tutor_dni_key UNIQUE (dni);


--
-- Name: alumnos_tutor_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY alumnos_tutor
    ADD CONSTRAINT alumnos_tutor_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: configies_configies_codigo_centro_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY configies_configies
    ADD CONSTRAINT configies_configies_codigo_centro_key UNIQUE (codigo_centro);


--
-- Name: configies_configies_nombre_centro_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY configies_configies
    ADD CONSTRAINT configies_configies_nombre_centro_key UNIQUE (nombre_centro);


--
-- Name: configies_configies_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY configies_configies
    ADD CONSTRAINT configies_configies_pkey PRIMARY KEY (id);


--
-- Name: cursos_curso_curso_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY cursos_curso
    ADD CONSTRAINT cursos_curso_curso_key UNIQUE (curso);


--
-- Name: cursos_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY cursos_curso
    ADD CONSTRAINT cursos_curso_pkey PRIMARY KEY (id);


--
-- Name: cursos_curso_slug_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY cursos_curso
    ADD CONSTRAINT cursos_curso_slug_key UNIQUE (slug);


--
-- Name: departamentos_cursodepartam_curso_departamento_id_3afd27c3_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY departamentos_cursodepartamentoprofesor
    ADD CONSTRAINT departamentos_cursodepartam_curso_departamento_id_3afd27c3_uniq UNIQUE (curso_departamento_id, profesor_id);


--
-- Name: departamentos_cursodepartamento_curso_id_6c5ff8ce_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY departamentos_cursodepartamento
    ADD CONSTRAINT departamentos_cursodepartamento_curso_id_6c5ff8ce_uniq UNIQUE (curso_id, departamento_id);


--
-- Name: departamentos_cursodepartamento_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY departamentos_cursodepartamento
    ADD CONSTRAINT departamentos_cursodepartamento_pkey PRIMARY KEY (id);


--
-- Name: departamentos_cursodepartamentoprofesor_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY departamentos_cursodepartamentoprofesor
    ADD CONSTRAINT departamentos_cursodepartamentoprofesor_pkey PRIMARY KEY (id);


--
-- Name: departamentos_departamento_departamento_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY departamentos_departamento
    ADD CONSTRAINT departamentos_departamento_departamento_key UNIQUE (departamento);


--
-- Name: departamentos_departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY departamentos_departamento
    ADD CONSTRAINT departamentos_departamento_pkey PRIMARY KEY (id);


--
-- Name: departamentos_departamento_slug_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY departamentos_departamento
    ADD CONSTRAINT departamentos_departamento_slug_key UNIQUE (slug);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: grupos_cursogrupo_curso_id_4d6c247c_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY grupos_cursogrupo
    ADD CONSTRAINT grupos_cursogrupo_curso_id_4d6c247c_uniq UNIQUE (curso_id, grupo_id);


--
-- Name: grupos_cursogrupo_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY grupos_cursogrupo
    ADD CONSTRAINT grupos_cursogrupo_pkey PRIMARY KEY (id);


--
-- Name: grupos_cursogrupoalumno_curso_grupo_id_3c3e626e_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY grupos_cursogrupoalumno
    ADD CONSTRAINT grupos_cursogrupoalumno_curso_grupo_id_3c3e626e_uniq UNIQUE (curso_grupo_id, alumno_id);


--
-- Name: grupos_cursogrupoalumno_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY grupos_cursogrupoalumno
    ADD CONSTRAINT grupos_cursogrupoalumno_pkey PRIMARY KEY (id);


--
-- Name: grupos_cursogrupoprofesor_curso_grupo_id_a004363d_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY grupos_cursogrupoprofesor
    ADD CONSTRAINT grupos_cursogrupoprofesor_curso_grupo_id_a004363d_uniq UNIQUE (curso_grupo_id, profesor_id);


--
-- Name: grupos_cursogrupoprofesor_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY grupos_cursogrupoprofesor
    ADD CONSTRAINT grupos_cursogrupoprofesor_pkey PRIMARY KEY (id);


--
-- Name: grupos_grupo_grupo_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY grupos_grupo
    ADD CONSTRAINT grupos_grupo_grupo_key UNIQUE (grupo);


--
-- Name: grupos_grupo_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY grupos_grupo
    ADD CONSTRAINT grupos_grupo_pkey PRIMARY KEY (id);


--
-- Name: grupos_grupo_slug_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY grupos_grupo
    ADD CONSTRAINT grupos_grupo_slug_key UNIQUE (slug);


--
-- Name: rayuela_rayuela_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY rayuela_rayuela
    ADD CONSTRAINT rayuela_rayuela_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_provider_fc810c6e_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_fc810c6e_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_71a9a768_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_socialapp_id_71a9a768_uniq UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialtoken_app_id_fca4e0ac_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_fca4e0ac_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups_user_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions_user_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: gesties; Tablespace: 
--

ALTER TABLE ONLY users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- Name: account_emailaddress_e8701ad4; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX account_emailaddress_e8701ad4 ON account_emailaddress USING btree (user_id);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailconfirmation_6f1edeac; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX account_emailconfirmation_6f1edeac ON account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: alumnos_alumno_apellidos_06e9a4a8_idx; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX alumnos_alumno_apellidos_06e9a4a8_idx ON alumnos_alumno USING btree (apellidos, nombre);


--
-- Name: alumnos_alumno_d56f5e97; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX alumnos_alumno_d56f5e97 ON alumnos_alumno USING btree (dni);


--
-- Name: alumnos_alumno_dni_93dac264_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX alumnos_alumno_dni_93dac264_like ON alumnos_alumno USING btree (dni varchar_pattern_ops);


--
-- Name: alumnos_alumno_nie_6aeae958_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX alumnos_alumno_nie_6aeae958_like ON alumnos_alumno USING btree (nie varchar_pattern_ops);


--
-- Name: alumnos_tutor_alumnos_1ba55b7f; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX alumnos_tutor_alumnos_1ba55b7f ON alumnos_tutor_alumnos USING btree (tutor_id);


--
-- Name: alumnos_tutor_alumnos_684f96c4; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX alumnos_tutor_alumnos_684f96c4 ON alumnos_tutor_alumnos USING btree (alumno_id);


--
-- Name: alumnos_tutor_apellidos_a5f82b50_idx; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX alumnos_tutor_apellidos_a5f82b50_idx ON alumnos_tutor USING btree (apellidos, nombre);


--
-- Name: alumnos_tutor_dni_52cf6cfd_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX alumnos_tutor_dni_52cf6cfd_like ON alumnos_tutor USING btree (dni varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: configies_configies_b56b7eb3; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX configies_configies_b56b7eb3 ON configies_configies USING btree (curso_defecto_id);


--
-- Name: configies_configies_codigo_centro_2b945e2a_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX configies_configies_codigo_centro_2b945e2a_like ON configies_configies USING btree (codigo_centro varchar_pattern_ops);


--
-- Name: configies_configies_nombre_centro_c47c470f_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX configies_configies_nombre_centro_c47c470f_like ON configies_configies USING btree (nombre_centro varchar_pattern_ops);


--
-- Name: cursos_curso_curso_d210845b_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX cursos_curso_curso_d210845b_like ON cursos_curso USING btree (curso varchar_pattern_ops);


--
-- Name: cursos_curso_slug_283a0fb8_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX cursos_curso_slug_283a0fb8_like ON cursos_curso USING btree (slug varchar_pattern_ops);


--
-- Name: departamentos_cursodepartamento_6f899f0d; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX departamentos_cursodepartamento_6f899f0d ON departamentos_cursodepartamento USING btree (curso_id);


--
-- Name: departamentos_cursodepartamento_bac5e582; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX departamentos_cursodepartamento_bac5e582 ON departamentos_cursodepartamento USING btree (jefe_id);


--
-- Name: departamentos_cursodepartamento_f5acfb16; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX departamentos_cursodepartamento_f5acfb16 ON departamentos_cursodepartamento USING btree (departamento_id);


--
-- Name: departamentos_cursodepartamentoprofesor_21c9ccfc; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX departamentos_cursodepartamentoprofesor_21c9ccfc ON departamentos_cursodepartamentoprofesor USING btree (profesor_id);


--
-- Name: departamentos_cursodepartamentoprofesor_b166dad0; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX departamentos_cursodepartamentoprofesor_b166dad0 ON departamentos_cursodepartamentoprofesor USING btree (curso_departamento_id);


--
-- Name: departamentos_departamento_departamento_e4cb4797_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX departamentos_departamento_departamento_e4cb4797_like ON departamentos_departamento USING btree (departamento varchar_pattern_ops);


--
-- Name: departamentos_departamento_slug_617629a2_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX departamentos_departamento_slug_617629a2_like ON departamentos_departamento USING btree (slug varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX django_site_domain_a2e37b91_like ON django_site USING btree (domain varchar_pattern_ops);


--
-- Name: grupos_cursogrupo_1ba55b7f; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX grupos_cursogrupo_1ba55b7f ON grupos_cursogrupo USING btree (tutor_id);


--
-- Name: grupos_cursogrupo_6f899f0d; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX grupos_cursogrupo_6f899f0d ON grupos_cursogrupo USING btree (curso_id);


--
-- Name: grupos_cursogrupo_acaeb2d6; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX grupos_cursogrupo_acaeb2d6 ON grupos_cursogrupo USING btree (grupo_id);


--
-- Name: grupos_cursogrupoalumno_684f96c4; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX grupos_cursogrupoalumno_684f96c4 ON grupos_cursogrupoalumno USING btree (alumno_id);


--
-- Name: grupos_cursogrupoalumno_7ac491b9; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX grupos_cursogrupoalumno_7ac491b9 ON grupos_cursogrupoalumno USING btree (curso_grupo_id);


--
-- Name: grupos_cursogrupoprofesor_21c9ccfc; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX grupos_cursogrupoprofesor_21c9ccfc ON grupos_cursogrupoprofesor USING btree (profesor_id);


--
-- Name: grupos_cursogrupoprofesor_7ac491b9; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX grupos_cursogrupoprofesor_7ac491b9 ON grupos_cursogrupoprofesor USING btree (curso_grupo_id);


--
-- Name: grupos_grupo_grupo_18f352e0_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX grupos_grupo_grupo_18f352e0_like ON grupos_grupo USING btree (grupo varchar_pattern_ops);


--
-- Name: grupos_grupo_slug_fb0e83b9_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX grupos_grupo_slug_fb0e83b9_like ON grupos_grupo USING btree (slug varchar_pattern_ops);


--
-- Name: rayuela_rayuela_6f899f0d; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX rayuela_rayuela_6f899f0d ON rayuela_rayuela USING btree (curso_id);


--
-- Name: socialaccount_socialaccount_e8701ad4; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX socialaccount_socialaccount_e8701ad4 ON socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_9365d6e7; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX socialaccount_socialapp_sites_9365d6e7 ON socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_fe95b0a0; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX socialaccount_socialapp_sites_fe95b0a0 ON socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_8a089c2a; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX socialaccount_socialtoken_8a089c2a ON socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_f382adfe; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX socialaccount_socialtoken_f382adfe ON socialaccount_socialtoken USING btree (app_id);


--
-- Name: users_user_d56f5e97; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX users_user_d56f5e97 ON users_user USING btree (dni);


--
-- Name: users_user_dni_cd65baa8_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX users_user_dni_cd65baa8_like ON users_user USING btree (dni varchar_pattern_ops);


--
-- Name: users_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX users_user_groups_0e939a4f ON users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX users_user_groups_e8701ad4 ON users_user_groups USING btree (user_id);


--
-- Name: users_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX users_user_user_permissions_8373b171 ON users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX users_user_user_permissions_e8701ad4 ON users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: gesties; Tablespace: 
--

CREATE INDEX users_user_username_06e46fe6_like ON users_user USING btree (username varchar_pattern_ops);


--
-- Name: D9274a36eacd5200483d55f199940a1a; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY departamentos_cursodepartamentoprofesor
    ADD CONSTRAINT "D9274a36eacd5200483d55f199940a1a" FOREIGN KEY (curso_departamento_id) REFERENCES departamentos_cursodepartamento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_em_email_address_id_5b7f8c58_fk_account_emailaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_em_email_address_id_5b7f8c58_fk_account_emailaddress_id FOREIGN KEY (email_address_id) REFERENCES account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailaddress_user_id_2c513194_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: alumnos_tutor_alumnos_alumno_id_fb6a3f63_fk_alumnos_alumno_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY alumnos_tutor_alumnos
    ADD CONSTRAINT alumnos_tutor_alumnos_alumno_id_fb6a3f63_fk_alumnos_alumno_id FOREIGN KEY (alumno_id) REFERENCES alumnos_alumno(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: alumnos_tutor_alumnos_tutor_id_1080d5ab_fk_alumnos_tutor_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY alumnos_tutor_alumnos
    ADD CONSTRAINT alumnos_tutor_alumnos_tutor_id_1080d5ab_fk_alumnos_tutor_id FOREIGN KEY (tutor_id) REFERENCES alumnos_tutor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: configies_configie_curso_defecto_id_284ad3b3_fk_cursos_curso_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY configies_configies
    ADD CONSTRAINT configies_configie_curso_defecto_id_284ad3b3_fk_cursos_curso_id FOREIGN KEY (curso_defecto_id) REFERENCES cursos_curso(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: depar_departamento_id_a41035b7_fk_departamentos_departamento_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY departamentos_cursodepartamento
    ADD CONSTRAINT depar_departamento_id_a41035b7_fk_departamentos_departamento_id FOREIGN KEY (departamento_id) REFERENCES departamentos_departamento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departamentos_cursodepart_profesor_id_b94107ce_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY departamentos_cursodepartamentoprofesor
    ADD CONSTRAINT departamentos_cursodepart_profesor_id_b94107ce_fk_users_user_id FOREIGN KEY (profesor_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departamentos_cursodeparta_curso_id_5af057ad_fk_cursos_curso_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY departamentos_cursodepartamento
    ADD CONSTRAINT departamentos_cursodeparta_curso_id_5af057ad_fk_cursos_curso_id FOREIGN KEY (curso_id) REFERENCES cursos_curso(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departamentos_cursodepartamen_jefe_id_c120b68a_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY departamentos_cursodepartamento
    ADD CONSTRAINT departamentos_cursodepartamen_jefe_id_c120b68a_fk_users_user_id FOREIGN KEY (jefe_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: grupos_cursogru_curso_grupo_id_4253ab39_fk_grupos_cursogrupo_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupoprofesor
    ADD CONSTRAINT grupos_cursogru_curso_grupo_id_4253ab39_fk_grupos_cursogrupo_id FOREIGN KEY (curso_grupo_id) REFERENCES grupos_cursogrupo(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: grupos_cursogru_curso_grupo_id_8a35f915_fk_grupos_cursogrupo_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupoalumno
    ADD CONSTRAINT grupos_cursogru_curso_grupo_id_8a35f915_fk_grupos_cursogrupo_id FOREIGN KEY (curso_grupo_id) REFERENCES grupos_cursogrupo(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: grupos_cursogrupo_curso_id_ba77fd44_fk_cursos_curso_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupo
    ADD CONSTRAINT grupos_cursogrupo_curso_id_ba77fd44_fk_cursos_curso_id FOREIGN KEY (curso_id) REFERENCES cursos_curso(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: grupos_cursogrupo_grupo_id_c4ae3a18_fk_grupos_grupo_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupo
    ADD CONSTRAINT grupos_cursogrupo_grupo_id_c4ae3a18_fk_grupos_grupo_id FOREIGN KEY (grupo_id) REFERENCES grupos_grupo(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: grupos_cursogrupo_tutor_id_8d638827_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupo
    ADD CONSTRAINT grupos_cursogrupo_tutor_id_8d638827_fk_users_user_id FOREIGN KEY (tutor_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: grupos_cursogrupoalumno_alumno_id_23acb6e8_fk_alumnos_alumno_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupoalumno
    ADD CONSTRAINT grupos_cursogrupoalumno_alumno_id_23acb6e8_fk_alumnos_alumno_id FOREIGN KEY (alumno_id) REFERENCES alumnos_alumno(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: grupos_cursogrupoprofesor_profesor_id_0dd7f071_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY grupos_cursogrupoprofesor
    ADD CONSTRAINT grupos_cursogrupoprofesor_profesor_id_0dd7f071_fk_users_user_id FOREIGN KEY (profesor_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: rayuela_rayuela_curso_id_e26f1a32_fk_cursos_curso_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY rayuela_rayuela
    ADD CONSTRAINT rayuela_rayuela_curso_id_e26f1a32_fk_cursos_curso_id FOREIGN KEY (curso_id) REFERENCES cursos_curso(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialacc_account_id_951f210e_fk_socialaccount_socialaccount_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialacc_account_id_951f210e_fk_socialaccount_socialaccount_id FOREIGN KEY (account_id) REFERENCES socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccou_socialapp_id_97fb6e7d_fk_socialaccount_socialapp_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccou_socialapp_id_97fb6e7d_fk_socialaccount_socialapp_id FOREIGN KEY (socialapp_id) REFERENCES socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_soc_app_id_636a42d7_fk_socialaccount_socialapp_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_soc_app_id_636a42d7_fk_socialaccount_socialapp_id FOREIGN KEY (app_id) REFERENCES socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount_user_id_8146e70c_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_user_id_8146e70c_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_site_site_id_2579dee5_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_site_site_id_2579dee5_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_pe_permission_id_0b93982e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_pe_permission_id_0b93982e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gesties
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--


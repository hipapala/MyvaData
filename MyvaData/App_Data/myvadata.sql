--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.6
-- Dumped by pg_dump version 9.3.6
-- Started on 2016-02-28 00:22:34

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2006 (class 1262 OID 33038)
-- Name: myvadata; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE myvadata WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


ALTER DATABASE myvadata OWNER TO postgres;

\connect myvadata

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 180 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2009 (class 0 OID 0)
-- Dependencies: 180
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 175 (class 1259 OID 33110)
-- Name: MV_Field; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "MV_Field" (
    id integer NOT NULL,
    format integer NOT NULL,
    title character varying(512),
    created timestamp with time zone DEFAULT now() NOT NULL,
    modified timestamp with time zone DEFAULT now() NOT NULL,
    group_id integer,
    required boolean DEFAULT false NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public."MV_Field" OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 33108)
-- Name: MV_Field_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "MV_Field_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MV_Field_id_seq" OWNER TO postgres;

--
-- TOC entry 2011 (class 0 OID 0)
-- Dependencies: 174
-- Name: MV_Field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "MV_Field_id_seq" OWNED BY "MV_Field".id;


--
-- TOC entry 177 (class 1259 OID 33125)
-- Name: MV_List; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "MV_List" (
    id integer NOT NULL,
    title character varying(512),
    created timestamp with time zone DEFAULT now() NOT NULL,
    modified timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."MV_List" OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 33123)
-- Name: MV_Group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "MV_Group_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MV_Group_id_seq" OWNER TO postgres;

--
-- TOC entry 2014 (class 0 OID 0)
-- Dependencies: 176
-- Name: MV_Group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "MV_Group_id_seq" OWNED BY "MV_List".id;


--
-- TOC entry 173 (class 1259 OID 33080)
-- Name: MV_Item; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "MV_Item" (
    id integer NOT NULL,
    group_id integer,
    created timestamp with time zone DEFAULT now() NOT NULL,
    modified timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."MV_Item" OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 33078)
-- Name: MV_Item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "MV_Item_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MV_Item_id_seq" OWNER TO postgres;

--
-- TOC entry 2017 (class 0 OID 0)
-- Dependencies: 172
-- Name: MV_Item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "MV_Item_id_seq" OWNED BY "MV_Item".id;


--
-- TOC entry 179 (class 1259 OID 33138)
-- Name: MV_Option; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "MV_Option" (
    id integer NOT NULL,
    field_id integer NOT NULL,
    title character varying(512),
    created timestamp with time zone DEFAULT now() NOT NULL,
    modified timestamp with time zone DEFAULT now() NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public."MV_Option" OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 33136)
-- Name: MV_List_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "MV_List_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MV_List_id_seq" OWNER TO postgres;

--
-- TOC entry 2020 (class 0 OID 0)
-- Dependencies: 178
-- Name: MV_List_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "MV_List_id_seq" OWNED BY "MV_Option".id;


--
-- TOC entry 171 (class 1259 OID 33067)
-- Name: MV_Value; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "MV_Value" (
    id integer NOT NULL,
    string_v character varying(2000),
    int_v integer,
    numeric_v numeric,
    date_v timestamp without time zone,
    list_id integer,
    created timestamp with time zone DEFAULT now() NOT NULL,
    modified timestamp with time zone DEFAULT now() NOT NULL,
    item_id integer NOT NULL,
    field_id integer NOT NULL
);


ALTER TABLE public."MV_Value" OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 33065)
-- Name: MV_Value_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "MV_Value_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MV_Value_id_seq" OWNER TO postgres;

--
-- TOC entry 2023 (class 0 OID 0)
-- Dependencies: 170
-- Name: MV_Value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "MV_Value_id_seq" OWNED BY "MV_Value".id;


--
-- TOC entry 1857 (class 2604 OID 33113)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Field" ALTER COLUMN id SET DEFAULT nextval('"MV_Field_id_seq"'::regclass);


--
-- TOC entry 1854 (class 2604 OID 33083)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Item" ALTER COLUMN id SET DEFAULT nextval('"MV_Item_id_seq"'::regclass);


--
-- TOC entry 1861 (class 2604 OID 33128)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_List" ALTER COLUMN id SET DEFAULT nextval('"MV_Group_id_seq"'::regclass);


--
-- TOC entry 1864 (class 2604 OID 33141)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Option" ALTER COLUMN id SET DEFAULT nextval('"MV_List_id_seq"'::regclass);


--
-- TOC entry 1851 (class 2604 OID 33070)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Value" ALTER COLUMN id SET DEFAULT nextval('"MV_Value_id_seq"'::regclass);


--
-- TOC entry 1997 (class 0 OID 33110)
-- Dependencies: 175
-- Data for Name: MV_Field; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (37, 4, 'The number of employees', '2016-02-27 23:14:45.283+02', '2016-02-27 23:15:11.29259+02', 10, false, 6);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (38, 1, 'Is a commercial company', '2016-02-27 23:15:58.957+02', '2016-02-27 23:17:18.934891+02', 10, false, 7);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (34, 0, 'Company code', '2016-02-27 23:11:17.292+02', '2016-02-27 23:19:03.437868+02', 10, true, 2);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (36, 1, 'Activity sector', '2016-02-27 23:12:27.307+02', '2016-02-27 23:19:09.564219+02', 10, true, 4);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (33, 0, 'Name', '2016-02-27 23:11:01.3+02', '2016-02-27 23:19:09.566219+02', 10, true, 3);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (24, 3, 'Application date', '2016-02-27 19:51:54.407+02', '2016-02-27 19:52:20.401455+02', 9, true, 2);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (39, 3, 'Date', '2016-02-27 23:30:28.61+02', '2016-02-27 23:30:38.581628+02', 11, true, 1);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (27, 1, 'Sex', '2016-02-27 19:52:32.4+02', '2016-02-27 19:52:36.428372+02', 9, true, 5);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (28, 0, 'Address', '2016-02-27 19:52:58.433+02', '2016-02-27 19:53:04.401972+02', 9, false, 6);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (40, 0, 'Title', '2016-02-27 23:30:42.56+02', '2016-02-27 23:30:46.556084+02', 11, false, 2);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (29, 1, 'Country', '2016-02-27 19:53:10.408+02', '2016-02-27 19:53:16.409659+02', 9, true, 7);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (41, 0, 'Location', '2016-02-27 23:30:50.565+02', '2016-02-27 23:30:54.553542+02', 11, false, 3);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (30, 3, 'Date of birth', '2016-02-27 19:54:40.398+02', '2016-02-27 19:55:16.405522+02', 9, false, 8);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (31, 2, 'Favorite sports', '2016-02-27 19:59:20.415+02', '2016-02-27 20:00:20.40591+02', 9, false, 9);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (25, 0, 'Firstname', '2016-02-27 19:52:10.397+02', '2016-02-27 20:08:05.888534+02', 9, true, 3);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (26, 0, 'Lastname', '2016-02-27 19:52:22.429+02', '2016-02-27 20:09:00.526659+02', 9, true, 4);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (32, 3, 'Founding date', '2016-02-27 23:10:31.354+02', '2016-02-27 23:10:59.337179+02', 10, true, 1);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (42, 1, 'Event type', '2016-02-27 23:31:00.527+02', '2016-02-27 23:31:24.557258+02', 11, true, 4);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (43, 4, 'Tickets number', '2016-02-27 23:31:52.61+02', '2016-02-27 23:32:10.555889+02', 11, false, 5);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (44, 0, 'Title', '2016-02-27 23:35:17.894+02', '2016-02-27 23:35:27.883175+02', 12, true, 1);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (35, 0, 'Adress', '2016-02-27 23:11:31.291+02', '2016-02-27 23:14:24.400908+02', 10, false, 5);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (46, 3, 'Last fix', '2016-02-27 23:36:37.898+02', '2016-02-27 23:37:00.295461+02', 12, false, 4);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (47, 3, 'Created', '2016-02-27 23:36:49.924+02', '2016-02-27 23:37:02.236572+02', 12, true, 2);
INSERT INTO "MV_Field" (id, format, title, created, modified, group_id, required, "order") VALUES (45, 2, 'Programming languages', '2016-02-27 23:35:31.842+02', '2016-02-27 23:37:02.236572+02', 12, true, 3);


--
-- TOC entry 2025 (class 0 OID 0)
-- Dependencies: 174
-- Name: MV_Field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"MV_Field_id_seq"', 47, true);


--
-- TOC entry 2026 (class 0 OID 0)
-- Dependencies: 176
-- Name: MV_Group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"MV_Group_id_seq"', 12, true);


--
-- TOC entry 1995 (class 0 OID 33080)
-- Dependencies: 173
-- Data for Name: MV_Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (15, 9, '2016-02-27 22:08:14.361+02', '2016-02-27 22:11:13.392075+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (16, 9, '2016-02-27 22:12:55.256+02', '2016-02-27 22:12:55.242901+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (17, 9, '2016-02-27 22:15:06.025+02', '2016-02-27 22:15:06.020381+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (18, 9, '2016-02-27 22:16:58.115+02', '2016-02-27 22:16:58.110792+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (19, 9, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (20, 9, '2016-02-27 22:19:44.137+02', '2016-02-27 22:19:44.132288+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (21, 9, '2016-02-27 22:23:14.298+02', '2016-02-27 22:23:14.293308+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (22, 9, '2016-02-27 22:25:05.863+02', '2016-02-27 22:25:05.859689+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (23, 9, '2016-02-27 22:28:07.037+02', '2016-02-27 22:28:07.033052+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (24, 9, '2016-02-27 22:30:12.898+02', '2016-02-27 22:30:12.893251+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (25, 9, '2016-02-27 22:51:11.611+02', '2016-02-27 22:51:11.607245+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (26, 9, '2016-02-27 22:52:49.542+02', '2016-02-27 22:52:49.537846+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (27, 9, '2016-02-27 22:54:51.419+02', '2016-02-27 22:54:51.413817+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (28, 9, '2016-02-27 22:55:38.636+02', '2016-02-27 22:55:38.632518+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (29, 9, '2016-02-27 23:03:14.588+02', '2016-02-27 23:03:14.584597+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (30, 9, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (31, 9, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (32, 10, '2016-02-27 23:18:39.331+02', '2016-02-27 23:18:39.327489+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (33, 10, '2016-02-27 23:20:56.495+02', '2016-02-27 23:20:56.491335+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (34, 10, '2016-02-27 23:21:59.206+02', '2016-02-27 23:21:59.203922+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (35, 10, '2016-02-27 23:23:30.949+02', '2016-02-27 23:23:30.946169+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (36, 10, '2016-02-27 23:24:34.741+02', '2016-02-27 23:24:34.736818+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (37, 10, '2016-02-27 23:25:27.749+02', '2016-02-27 23:25:27.74585+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (38, 11, '2016-02-27 23:34:08.672+02', '2016-02-27 23:34:08.669645+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (39, 12, '2016-02-27 23:37:39.096+02', '2016-02-27 23:37:39.09268+02');
INSERT INTO "MV_Item" (id, group_id, created, modified) VALUES (40, 9, '2016-02-27 23:55:09.302+02', '2016-02-27 23:55:09.298749+02');


--
-- TOC entry 2027 (class 0 OID 0)
-- Dependencies: 172
-- Name: MV_Item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"MV_Item_id_seq"', 40, true);


--
-- TOC entry 1999 (class 0 OID 33125)
-- Dependencies: 177
-- Data for Name: MV_List; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "MV_List" (id, title, created, modified) VALUES (9, 'Myva applications', '2016-02-27 19:51:25.454+02', '2016-02-27 19:51:25.453312+02');
INSERT INTO "MV_List" (id, title, created, modified) VALUES (10, 'Myva companies', '2016-02-27 23:10:20.165+02', '2016-02-27 23:10:20.163939+02');
INSERT INTO "MV_List" (id, title, created, modified) VALUES (11, 'Big events', '2016-02-27 23:30:25.443+02', '2016-02-27 23:30:25.442877+02');
INSERT INTO "MV_List" (id, title, created, modified) VALUES (12, 'Demo frameworks', '2016-02-27 23:35:14.75+02', '2016-02-27 23:35:14.749424+02');


--
-- TOC entry 2028 (class 0 OID 0)
-- Dependencies: 178
-- Name: MV_List_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"MV_List_id_seq"', 37, true);


--
-- TOC entry 2001 (class 0 OID 33138)
-- Dependencies: 179
-- Data for Name: MV_Option; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (10, 27, 'Male', '2016-02-27 19:52:40.446+02', '2016-02-27 19:52:40.441601+02', 1);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (11, 29, 'Tanzania', '2016-02-27 19:53:28.727+02', '2016-02-27 19:53:28.725363+02', 1);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (12, 29, 'French Southern Territories', '2016-02-27 19:53:52.419+02', '2016-02-27 19:53:52.418718+02', 2);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (13, 29, 'United Kingdom', '2016-02-27 19:54:00.412+02', '2016-02-27 19:54:00.410175+02', 3);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (14, 29, 'Monaco', '2016-02-27 19:54:10.417+02', '2016-02-27 19:54:10.415748+02', 4);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (15, 29, 'Lithuania', '2016-02-27 19:54:22.433+02', '2016-02-27 19:54:22.431435+02', 5);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (16, 29, 'Latvia', '2016-02-27 19:54:26.439+02', '2016-02-27 19:54:26.438664+02', 6);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (17, 31, 'Basketball', '2016-02-27 20:00:28.434+02', '2016-02-27 20:00:28.433369+02', 1);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (18, 31, 'Soccer', '2016-02-27 20:00:54.42+02', '2016-02-27 20:01:08.438657+02', 2);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (19, 31, 'Baseball', '2016-02-27 20:01:10.414+02', '2016-02-27 20:01:10.41377+02', 3);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (20, 31, 'Football', '2016-02-27 20:01:18.413+02', '2016-02-27 20:01:18.412228+02', 4);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (21, 31, 'Voleyball', '2016-02-27 20:01:24.401+02', '2016-02-27 20:01:24.39957+02', 5);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (22, 31, 'Cricket', '2016-02-27 20:01:40.433+02', '2016-02-27 20:01:40.431487+02', 6);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (23, 27, 'Female', '2016-02-27 20:10:36.277+02', '2016-02-27 20:10:36.012121+02', 2);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (24, 36, 'Generating data', '2016-02-27 23:12:55.307+02', '2016-02-27 23:12:55.305812+02', 1);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (25, 36, 'Storing data', '2016-02-27 23:13:29.341+02', '2016-02-27 23:13:29.339759+02', 2);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (26, 36, 'Analysis of data', '2016-02-27 23:13:49.3+02', '2016-02-27 23:13:49.299901+02', 3);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (27, 36, 'Data visualization', '2016-02-27 23:14:09.337+02', '2016-02-27 23:14:09.336047+02', 4);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (28, 38, 'Yes', '2016-02-27 23:16:18.935+02', '2016-02-27 23:16:18.934459+02', 1);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (29, 38, 'No', '2016-02-27 23:16:22.939+02', '2016-02-27 23:16:22.937688+02', 2);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (30, 42, 'Free', '2016-02-27 23:31:28.566+02', '2016-02-27 23:31:28.564487+02', 1);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (31, 42, 'Commercial', '2016-02-27 23:31:36.568+02', '2016-02-27 23:31:36.567945+02', 2);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (32, 42, 'Community', '2016-02-27 23:31:42.597+02', '2016-02-27 23:31:42.59529+02', 3);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (33, 45, 'Java', '2016-02-27 23:35:45.884+02', '2016-02-27 23:35:45.883205+02', 1);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (34, 45, 'PHP', '2016-02-27 23:35:49.931+02', '2016-02-27 23:35:49.930436+02', 2);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (35, 45, 'C#', '2016-02-27 23:35:55.859+02', '2016-02-27 23:35:55.857775+02', 3);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (36, 45, 'C++', '2016-02-27 23:36:01.847+02', '2016-02-27 23:36:01.845118+02', 4);
INSERT INTO "MV_Option" (id, field_id, title, created, modified, "order") VALUES (37, 45, 'Python', '2016-02-27 23:36:17.937+02', '2016-02-27 23:36:17.935038+02', 5);


--
-- TOC entry 1993 (class 0 OID 33067)
-- Dependencies: 171
-- Data for Name: MV_Value; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (105, NULL, NULL, NULL, '2016-02-24 00:00:00', NULL, '2016-02-27 22:30:12.898+02', '2016-02-27 22:30:12.893251+02', 24, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (106, 'Bruno', NULL, NULL, NULL, NULL, '2016-02-27 22:30:12.898+02', '2016-02-27 22:30:12.893251+02', 24, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (107, 'Pumariki', NULL, NULL, NULL, NULL, '2016-02-27 22:30:12.898+02', '2016-02-27 22:30:12.893251+02', 24, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (108, NULL, NULL, NULL, NULL, 10, '2016-02-27 22:30:12.898+02', '2016-02-27 22:30:12.893251+02', 24, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (109, 'Begedzi livano opa 1111', NULL, NULL, NULL, NULL, '2016-02-27 22:30:12.898+02', '2016-02-27 22:30:12.893251+02', 24, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (110, NULL, NULL, NULL, NULL, 13, '2016-02-27 22:30:12.898+02', '2016-02-27 22:30:12.893251+02', 24, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (111, NULL, NULL, NULL, '1979-01-01 00:00:00', NULL, '2016-02-27 22:30:12.898+02', '2016-02-27 22:30:12.893251+02', 24, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (112, NULL, NULL, NULL, NULL, 18, '2016-02-27 22:30:12.898+02', '2016-02-27 22:30:12.893251+02', 24, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (113, NULL, NULL, NULL, '2016-02-23 00:00:00', NULL, '2016-02-27 22:51:11.611+02', '2016-02-27 22:51:11.607245+02', 25, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (114, 'Kyla', NULL, NULL, NULL, NULL, '2016-02-27 22:51:11.611+02', '2016-02-27 22:51:11.607245+02', 25, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (115, 'James', NULL, NULL, NULL, NULL, '2016-02-27 22:51:11.611+02', '2016-02-27 22:51:11.607245+02', 25, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (116, NULL, NULL, NULL, NULL, 10, '2016-02-27 22:51:11.611+02', '2016-02-27 22:51:11.607245+02', 25, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (117, '4302 Curabitur Ave', NULL, NULL, NULL, NULL, '2016-02-27 22:51:11.611+02', '2016-02-27 22:51:11.607245+02', 25, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (118, NULL, NULL, NULL, NULL, 14, '2016-02-27 22:51:11.611+02', '2016-02-27 22:51:11.607245+02', 25, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (119, NULL, NULL, NULL, '1985-03-03 00:00:00', NULL, '2016-02-27 22:51:11.611+02', '2016-02-27 22:51:11.607245+02', 25, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (120, NULL, NULL, NULL, NULL, 18, '2016-02-27 22:51:11.611+02', '2016-02-27 22:51:11.607245+02', 25, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (121, NULL, NULL, NULL, '2016-02-25 00:00:00', NULL, '2016-02-27 22:52:49.542+02', '2016-02-27 22:52:49.537846+02', 26, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (31, NULL, NULL, NULL, '2016-02-05 00:00:00', NULL, '2016-02-27 22:08:14.361+02', '2016-02-27 22:11:13.392075+02', 15, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (32, 'John', NULL, NULL, NULL, NULL, '2016-02-27 22:08:14.361+02', '2016-02-27 22:11:13.392075+02', 15, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (33, 'Sperow', NULL, NULL, NULL, NULL, '2016-02-27 22:08:14.361+02', '2016-02-27 22:11:13.392075+02', 15, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (34, NULL, NULL, NULL, NULL, 10, '2016-02-27 22:08:14.361+02', '2016-02-27 22:11:13.392075+02', 15, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (35, '3121 Dictum St.', NULL, NULL, NULL, NULL, '2016-02-27 22:08:14.361+02', '2016-02-27 22:11:13.392075+02', 15, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (36, NULL, NULL, NULL, NULL, 11, '2016-02-27 22:08:14.361+02', '2016-02-27 22:11:13.392075+02', 15, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (37, NULL, NULL, NULL, '1985-02-09 00:00:00', NULL, '2016-02-27 22:08:14.361+02', '2016-02-27 22:11:13.392075+02', 15, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (40, NULL, NULL, NULL, NULL, 21, '2016-02-27 22:10:33.005+02', '2016-02-27 22:11:13.392075+02', 15, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (41, NULL, NULL, NULL, NULL, 20, '2016-02-27 22:10:51.698+02', '2016-02-27 22:11:13.392075+02', 15, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (42, NULL, NULL, NULL, '2016-02-03 00:00:00', NULL, '2016-02-27 22:12:55.256+02', '2016-02-27 22:12:55.242901+02', 16, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (43, 'Mary', NULL, NULL, NULL, NULL, '2016-02-27 22:12:55.256+02', '2016-02-27 22:12:55.242901+02', 16, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (44, 'James', NULL, NULL, NULL, NULL, '2016-02-27 22:12:55.256+02', '2016-02-27 22:12:55.242901+02', 16, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (45, NULL, NULL, NULL, NULL, 23, '2016-02-27 22:12:55.256+02', '2016-02-27 22:12:55.242901+02', 16, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (46, 'Ap #617-1146 Massa Road', NULL, NULL, NULL, NULL, '2016-02-27 22:12:55.256+02', '2016-02-27 22:12:55.242901+02', 16, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (47, NULL, NULL, NULL, NULL, 13, '2016-02-27 22:12:55.256+02', '2016-02-27 22:12:55.242901+02', 16, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (48, NULL, NULL, NULL, '1984-02-03 00:00:00', NULL, '2016-02-27 22:12:55.256+02', '2016-02-27 22:12:55.242901+02', 16, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (49, NULL, NULL, NULL, NULL, 18, '2016-02-27 22:12:55.256+02', '2016-02-27 22:12:55.242901+02', 16, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (50, NULL, NULL, NULL, '2016-02-05 00:00:00', NULL, '2016-02-27 22:15:06.025+02', '2016-02-27 22:15:06.020381+02', 17, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (51, 'Domantas', NULL, NULL, NULL, NULL, '2016-02-27 22:15:06.025+02', '2016-02-27 22:15:06.020381+02', 17, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (52, 'Evanas', NULL, NULL, NULL, NULL, '2016-02-27 22:15:06.025+02', '2016-02-27 22:15:06.020381+02', 17, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (53, NULL, NULL, NULL, NULL, 10, '2016-02-27 22:15:06.025+02', '2016-02-27 22:15:06.020381+02', 17, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (54, 'Lubas messy street 12', NULL, NULL, NULL, NULL, '2016-02-27 22:15:06.025+02', '2016-02-27 22:15:06.020381+02', 17, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (55, NULL, NULL, NULL, NULL, 14, '2016-02-27 22:15:06.025+02', '2016-02-27 22:15:06.020381+02', 17, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (56, NULL, NULL, NULL, '1983-02-02 00:00:00', NULL, '2016-02-27 22:15:06.025+02', '2016-02-27 22:15:06.020381+02', 17, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (57, NULL, NULL, NULL, '2016-02-03 00:00:00', NULL, '2016-02-27 22:16:58.115+02', '2016-02-27 22:16:58.110792+02', 18, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (58, 'Vilius', NULL, NULL, NULL, NULL, '2016-02-27 22:16:58.115+02', '2016-02-27 22:16:58.110792+02', 18, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (59, 'Abatori', NULL, NULL, NULL, NULL, '2016-02-27 22:16:58.115+02', '2016-02-27 22:16:58.110792+02', 18, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (60, NULL, NULL, NULL, NULL, 10, '2016-02-27 22:16:58.115+02', '2016-02-27 22:16:58.110792+02', 18, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (61, 'Lukas Veni soup 12', NULL, NULL, NULL, NULL, '2016-02-27 22:16:58.115+02', '2016-02-27 22:16:58.110792+02', 18, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (62, NULL, NULL, NULL, NULL, 12, '2016-02-27 22:16:58.115+02', '2016-02-27 22:16:58.110792+02', 18, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (63, NULL, NULL, NULL, '1984-05-10 00:00:00', NULL, '2016-02-27 22:16:58.115+02', '2016-02-27 22:16:58.110792+02', 18, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (64, NULL, NULL, NULL, NULL, 19, '2016-02-27 22:16:58.115+02', '2016-02-27 22:16:58.110792+02', 18, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (65, NULL, NULL, NULL, '2016-01-19 00:00:00', NULL, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (66, 'Noel', NULL, NULL, NULL, NULL, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (67, 'Nima', NULL, NULL, NULL, NULL, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (68, NULL, NULL, NULL, NULL, 10, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (69, '843-5163 Cursus Rd.', NULL, NULL, NULL, NULL, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (70, NULL, NULL, NULL, NULL, 13, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (71, NULL, NULL, NULL, '1982-11-01 00:00:00', NULL, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (72, NULL, NULL, NULL, NULL, 19, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (73, NULL, NULL, NULL, NULL, 20, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (74, NULL, NULL, NULL, NULL, 21, '2016-02-27 22:18:41.291+02', '2016-02-27 22:18:41.278693+02', 19, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (75, NULL, NULL, NULL, '2016-02-06 00:00:00', NULL, '2016-02-27 22:19:44.137+02', '2016-02-27 22:19:44.132288+02', 20, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (76, 'Virginia', NULL, NULL, NULL, NULL, '2016-02-27 22:19:44.137+02', '2016-02-27 22:19:44.132288+02', 20, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (77, 'Emma', NULL, NULL, NULL, NULL, '2016-02-27 22:19:44.137+02', '2016-02-27 22:19:44.132288+02', 20, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (78, NULL, NULL, NULL, NULL, 23, '2016-02-27 22:19:44.137+02', '2016-02-27 22:19:44.132288+02', 20, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (79, 'Virgin street 13', NULL, NULL, NULL, NULL, '2016-02-27 22:19:44.137+02', '2016-02-27 22:19:44.132288+02', 20, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (80, NULL, NULL, NULL, NULL, 16, '2016-02-27 22:19:44.137+02', '2016-02-27 22:19:44.132288+02', 20, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (81, NULL, NULL, NULL, '1985-02-02 00:00:00', NULL, '2016-02-27 22:19:44.137+02', '2016-02-27 22:19:44.132288+02', 20, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (82, NULL, NULL, NULL, NULL, 18, '2016-02-27 22:19:44.137+02', '2016-02-27 22:19:44.132288+02', 20, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (83, NULL, NULL, NULL, '2016-02-27 00:00:00', NULL, '2016-02-27 22:23:14.298+02', '2016-02-27 22:23:14.293308+02', 21, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (84, 'Kiara', NULL, NULL, NULL, NULL, '2016-02-27 22:23:14.298+02', '2016-02-27 22:23:14.293308+02', 21, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (85, 'Para', NULL, NULL, NULL, NULL, '2016-02-27 22:23:14.298+02', '2016-02-27 22:23:14.293308+02', 21, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (86, NULL, NULL, NULL, NULL, 23, '2016-02-27 22:23:14.298+02', '2016-02-27 22:23:14.293308+02', 21, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (87, 'Dzeremi road suza 1234', NULL, NULL, NULL, NULL, '2016-02-27 22:23:14.298+02', '2016-02-27 22:23:14.293308+02', 21, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (88, NULL, NULL, NULL, NULL, 12, '2016-02-27 22:23:14.298+02', '2016-02-27 22:23:14.293308+02', 21, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (89, NULL, NULL, NULL, '1985-02-16 00:00:00', NULL, '2016-02-27 22:23:14.298+02', '2016-02-27 22:23:14.293308+02', 21, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (90, NULL, NULL, NULL, NULL, 21, '2016-02-27 22:23:14.298+02', '2016-02-27 22:23:14.293308+02', 21, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (91, NULL, NULL, NULL, '2016-02-28 00:00:00', NULL, '2016-02-27 22:25:05.863+02', '2016-02-27 22:25:05.859689+02', 22, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (92, 'Hamish', NULL, NULL, NULL, NULL, '2016-02-27 22:25:05.863+02', '2016-02-27 22:25:05.859689+02', 22, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (93, 'Abdul', NULL, NULL, NULL, NULL, '2016-02-27 22:25:05.863+02', '2016-02-27 22:25:05.859689+02', 22, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (94, NULL, NULL, NULL, NULL, 10, '2016-02-27 22:25:05.863+02', '2016-02-27 22:25:05.859689+02', 22, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (95, 'Lovanova road 3', NULL, NULL, NULL, NULL, '2016-02-27 22:25:05.863+02', '2016-02-27 22:25:05.859689+02', 22, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (96, NULL, NULL, NULL, NULL, 14, '2016-02-27 22:25:05.863+02', '2016-02-27 22:25:05.859689+02', 22, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (97, NULL, NULL, NULL, '1984-02-17 00:00:00', NULL, '2016-02-27 22:25:05.863+02', '2016-02-27 22:25:05.859689+02', 22, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (98, NULL, NULL, NULL, NULL, 18, '2016-02-27 22:25:05.863+02', '2016-02-27 22:25:05.859689+02', 22, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (99, NULL, NULL, NULL, '2016-02-24 00:00:00', NULL, '2016-02-27 22:28:07.037+02', '2016-02-27 22:28:07.033052+02', 23, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (100, 'Kato', NULL, NULL, NULL, NULL, '2016-02-27 22:28:07.037+02', '2016-02-27 22:28:07.033052+02', 23, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (101, 'Vabuli', NULL, NULL, NULL, NULL, '2016-02-27 22:28:07.037+02', '2016-02-27 22:28:07.033052+02', 23, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (102, NULL, NULL, NULL, NULL, 10, '2016-02-27 22:28:07.037+02', '2016-02-27 22:28:07.033052+02', 23, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (103, 'Ap #913-3180 Mollis. Road', NULL, NULL, NULL, NULL, '2016-02-27 22:28:07.037+02', '2016-02-27 22:28:07.033052+02', 23, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (104, NULL, NULL, NULL, NULL, 11, '2016-02-27 22:28:07.037+02', '2016-02-27 22:28:07.033052+02', 23, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (122, 'Marius', NULL, NULL, NULL, NULL, '2016-02-27 22:52:49.542+02', '2016-02-27 22:52:49.537846+02', 26, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (123, 'Petrauskas', NULL, NULL, NULL, NULL, '2016-02-27 22:52:49.542+02', '2016-02-27 22:52:49.537846+02', 26, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (124, NULL, NULL, NULL, NULL, 10, '2016-02-27 22:52:49.542+02', '2016-02-27 22:52:49.537846+02', 26, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (125, 'P.O. Box 154, 7789 Nec St.', NULL, NULL, NULL, NULL, '2016-02-27 22:52:49.542+02', '2016-02-27 22:52:49.537846+02', 26, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (126, NULL, NULL, NULL, NULL, 15, '2016-02-27 22:52:49.542+02', '2016-02-27 22:52:49.537846+02', 26, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (127, NULL, NULL, NULL, '1983-02-04 00:00:00', NULL, '2016-02-27 22:52:49.542+02', '2016-02-27 22:52:49.537846+02', 26, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (128, NULL, NULL, NULL, '2016-02-26 00:00:00', NULL, '2016-02-27 22:54:51.419+02', '2016-02-27 22:54:51.413817+02', 27, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (129, 'Jesse', NULL, NULL, NULL, NULL, '2016-02-27 22:54:51.419+02', '2016-02-27 22:54:51.413817+02', 27, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (130, 'Soya', NULL, NULL, NULL, NULL, '2016-02-27 22:54:51.419+02', '2016-02-27 22:54:51.413817+02', 27, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (131, NULL, NULL, NULL, NULL, 23, '2016-02-27 22:54:51.419+02', '2016-02-27 22:54:51.413817+02', 27, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (132, 'Klipo street 2532', NULL, NULL, NULL, NULL, '2016-02-27 22:54:51.419+02', '2016-02-27 22:54:51.413817+02', 27, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (133, NULL, NULL, NULL, NULL, 14, '2016-02-27 22:54:51.419+02', '2016-02-27 22:54:51.413817+02', 27, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (134, NULL, NULL, NULL, '1986-05-07 00:00:00', NULL, '2016-02-27 22:54:51.419+02', '2016-02-27 22:54:51.413817+02', 27, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (135, NULL, NULL, NULL, NULL, 18, '2016-02-27 22:54:51.419+02', '2016-02-27 22:54:51.413817+02', 27, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (136, NULL, NULL, NULL, '2016-02-22 00:00:00', NULL, '2016-02-27 22:55:38.636+02', '2016-02-27 22:55:38.632518+02', 28, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (137, 'Priscilla', NULL, NULL, NULL, NULL, '2016-02-27 22:55:38.636+02', '2016-02-27 22:55:38.632518+02', 28, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (138, 'Sicilia', NULL, NULL, NULL, NULL, '2016-02-27 22:55:38.636+02', '2016-02-27 22:55:38.632518+02', 28, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (139, NULL, NULL, NULL, NULL, 23, '2016-02-27 22:55:38.636+02', '2016-02-27 22:55:38.632518+02', 28, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (140, 'P.O. Box 440, 9961 Quam St.', NULL, NULL, NULL, NULL, '2016-02-27 22:55:38.636+02', '2016-02-27 22:55:38.632518+02', 28, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (141, NULL, NULL, NULL, NULL, 12, '2016-02-27 22:55:38.636+02', '2016-02-27 22:55:38.632518+02', 28, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (142, NULL, NULL, NULL, '2016-02-19 00:00:00', NULL, '2016-02-27 23:03:14.588+02', '2016-02-27 23:03:14.584597+02', 29, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (143, 'Callum', NULL, NULL, NULL, NULL, '2016-02-27 23:03:14.588+02', '2016-02-27 23:03:14.584597+02', 29, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (144, 'Ganuma', NULL, NULL, NULL, NULL, '2016-02-27 23:03:14.588+02', '2016-02-27 23:03:14.584597+02', 29, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (145, NULL, NULL, NULL, NULL, 23, '2016-02-27 23:03:14.588+02', '2016-02-27 23:03:14.584597+02', 29, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (146, 'Box 243, 554 Phasellus Ave', NULL, NULL, NULL, NULL, '2016-02-27 23:03:14.588+02', '2016-02-27 23:03:14.584597+02', 29, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (147, NULL, NULL, NULL, NULL, 12, '2016-02-27 23:03:14.588+02', '2016-02-27 23:03:14.584597+02', 29, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (148, NULL, NULL, NULL, '1984-02-17 00:00:00', NULL, '2016-02-27 23:03:14.588+02', '2016-02-27 23:03:14.584597+02', 29, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (149, NULL, NULL, NULL, '2016-02-22 00:00:00', NULL, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (150, 'Moana', NULL, NULL, NULL, NULL, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (151, 'Soam', NULL, NULL, NULL, NULL, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (152, NULL, NULL, NULL, NULL, 23, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (153, '3080 Varius. Ave', NULL, NULL, NULL, NULL, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (154, NULL, NULL, NULL, NULL, 13, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (155, NULL, NULL, NULL, '1988-02-10 00:00:00', NULL, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (156, NULL, NULL, NULL, NULL, 17, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (157, NULL, NULL, NULL, NULL, 18, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (158, NULL, NULL, NULL, NULL, 19, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (159, NULL, NULL, NULL, NULL, 20, '2016-02-27 23:05:08.868+02', '2016-02-27 23:05:08.861133+02', 30, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (160, NULL, NULL, NULL, '2016-02-24 00:00:00', NULL, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02', 31, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (161, 'Joe', NULL, NULL, NULL, NULL, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02', 31, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (162, 'Vilimanas', NULL, NULL, NULL, NULL, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02', 31, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (163, NULL, NULL, NULL, NULL, 10, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02', 31, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (164, 'Ap #547-6284 Sit Avenue', NULL, NULL, NULL, NULL, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02', 31, 28);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (165, NULL, NULL, NULL, NULL, 14, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02', 31, 29);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (166, NULL, NULL, NULL, '1985-03-03 00:00:00', NULL, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02', 31, 30);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (167, NULL, NULL, NULL, NULL, 18, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02', 31, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (168, NULL, NULL, NULL, NULL, 19, '2016-02-27 23:09:24.68+02', '2016-02-27 23:09:24.674765+02', 31, 31);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (169, NULL, NULL, NULL, '1923-02-02 00:00:00', NULL, '2016-02-27 23:18:39.331+02', '2016-02-27 23:18:39.326489+02', 32, 32);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (170, 'Dictum Eleifend Nunc Institute', NULL, NULL, NULL, NULL, '2016-02-27 23:18:39.331+02', '2016-02-27 23:18:39.326489+02', 32, 33);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (171, 'DZ873434', NULL, NULL, NULL, NULL, '2016-02-27 23:18:39.331+02', '2016-02-27 23:18:39.326489+02', 32, 34);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (172, 'P.O. Box 785, 2542 Sociis Ave', NULL, NULL, NULL, NULL, '2016-02-27 23:18:39.331+02', '2016-02-27 23:18:39.326489+02', 32, 35);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (173, NULL, NULL, NULL, NULL, 25, '2016-02-27 23:18:39.331+02', '2016-02-27 23:18:39.326489+02', 32, 36);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (174, NULL, 23, NULL, NULL, NULL, '2016-02-27 23:18:39.331+02', '2016-02-27 23:18:39.327489+02', 32, 37);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (175, NULL, NULL, NULL, NULL, 28, '2016-02-27 23:18:39.331+02', '2016-02-27 23:18:39.327489+02', 32, 38);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (176, NULL, NULL, NULL, '1955-01-01 00:00:00', NULL, '2016-02-27 23:20:56.495+02', '2016-02-27 23:20:56.491335+02', 33, 32);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (177, 'Id Sapien LLC', NULL, NULL, NULL, NULL, '2016-02-27 23:20:56.495+02', '2016-02-27 23:20:56.491335+02', 33, 33);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (178, 'RFF98972', NULL, NULL, NULL, NULL, '2016-02-27 23:20:56.495+02', '2016-02-27 23:20:56.491335+02', 33, 34);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (179, '2308 Est Avenue', NULL, NULL, NULL, NULL, '2016-02-27 23:20:56.495+02', '2016-02-27 23:20:56.491335+02', 33, 35);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (180, NULL, NULL, NULL, NULL, 26, '2016-02-27 23:20:56.495+02', '2016-02-27 23:20:56.491335+02', 33, 36);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (181, NULL, 55, NULL, NULL, NULL, '2016-02-27 23:20:56.495+02', '2016-02-27 23:20:56.491335+02', 33, 37);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (182, NULL, NULL, NULL, NULL, 29, '2016-02-27 23:20:56.495+02', '2016-02-27 23:20:56.491335+02', 33, 38);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (183, NULL, NULL, NULL, '1976-02-22 00:00:00', NULL, '2016-02-27 23:21:59.206+02', '2016-02-27 23:21:59.203922+02', 34, 32);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (184, 'Odio Phasellus At Ltd', NULL, NULL, NULL, NULL, '2016-02-27 23:21:59.206+02', '2016-02-27 23:21:59.203922+02', 34, 33);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (185, 'WWW3333', NULL, NULL, NULL, NULL, '2016-02-27 23:21:59.206+02', '2016-02-27 23:21:59.203922+02', 34, 34);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (186, 'Odio Phasellus road 22', NULL, NULL, NULL, NULL, '2016-02-27 23:21:59.206+02', '2016-02-27 23:21:59.203922+02', 34, 35);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (187, NULL, NULL, NULL, NULL, 24, '2016-02-27 23:21:59.206+02', '2016-02-27 23:21:59.203922+02', 34, 36);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (188, NULL, 66, NULL, NULL, NULL, '2016-02-27 23:21:59.206+02', '2016-02-27 23:21:59.203922+02', 34, 37);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (189, NULL, NULL, NULL, NULL, 29, '2016-02-27 23:21:59.206+02', '2016-02-27 23:21:59.203922+02', 34, 38);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (190, NULL, NULL, NULL, '1967-02-02 00:00:00', NULL, '2016-02-27 23:23:30.949+02', '2016-02-27 23:23:30.946169+02', 35, 32);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (191, 'Sit Amet Company', NULL, NULL, NULL, NULL, '2016-02-27 23:23:30.949+02', '2016-02-27 23:23:30.946169+02', 35, 33);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (192, 'ERF009', NULL, NULL, NULL, NULL, '2016-02-27 23:23:30.949+02', '2016-02-27 23:23:30.946169+02', 35, 34);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (193, 'Ap #169-7771 Erat Road', NULL, NULL, NULL, NULL, '2016-02-27 23:23:30.949+02', '2016-02-27 23:23:30.946169+02', 35, 35);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (194, NULL, NULL, NULL, NULL, 27, '2016-02-27 23:23:30.949+02', '2016-02-27 23:23:30.946169+02', 35, 36);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (195, NULL, 2, NULL, NULL, NULL, '2016-02-27 23:23:30.949+02', '2016-02-27 23:23:30.946169+02', 35, 37);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (196, NULL, NULL, NULL, NULL, 28, '2016-02-27 23:23:30.949+02', '2016-02-27 23:23:30.946169+02', 35, 38);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (197, NULL, NULL, NULL, '2014-05-06 00:00:00', NULL, '2016-02-27 23:24:34.741+02', '2016-02-27 23:24:34.736818+02', 36, 32);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (198, 'Id Erat Inc', NULL, NULL, NULL, NULL, '2016-02-27 23:24:34.741+02', '2016-02-27 23:24:34.736818+02', 36, 33);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (199, 'F4334', NULL, NULL, NULL, NULL, '2016-02-27 23:24:34.741+02', '2016-02-27 23:24:34.736818+02', 36, 34);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (200, 'P.O. Box 589, 464 Eu Street', NULL, NULL, NULL, NULL, '2016-02-27 23:24:34.741+02', '2016-02-27 23:24:34.736818+02', 36, 35);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (201, NULL, NULL, NULL, NULL, 26, '2016-02-27 23:24:34.741+02', '2016-02-27 23:24:34.736818+02', 36, 36);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (202, NULL, 6, NULL, NULL, NULL, '2016-02-27 23:24:34.741+02', '2016-02-27 23:24:34.736818+02', 36, 37);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (203, NULL, NULL, NULL, NULL, 28, '2016-02-27 23:24:34.741+02', '2016-02-27 23:24:34.736818+02', 36, 38);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (204, NULL, NULL, NULL, '2015-06-09 00:00:00', NULL, '2016-02-27 23:25:27.749+02', '2016-02-27 23:25:27.74585+02', 37, 32);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (205, 'Ridiculus Company', NULL, NULL, NULL, NULL, '2016-02-27 23:25:27.749+02', '2016-02-27 23:25:27.74585+02', 37, 33);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (206, 'RDID3333', NULL, NULL, NULL, NULL, '2016-02-27 23:25:27.749+02', '2016-02-27 23:25:27.74585+02', 37, 34);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (207, 'P.O. Box 496, 8702 Netus Av.', NULL, NULL, NULL, NULL, '2016-02-27 23:25:27.749+02', '2016-02-27 23:25:27.74585+02', 37, 35);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (208, NULL, NULL, NULL, NULL, 26, '2016-02-27 23:25:27.749+02', '2016-02-27 23:25:27.74585+02', 37, 36);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (209, NULL, 33, NULL, NULL, NULL, '2016-02-27 23:25:27.749+02', '2016-02-27 23:25:27.74585+02', 37, 37);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (210, NULL, NULL, NULL, NULL, 29, '2016-02-27 23:25:27.749+02', '2016-02-27 23:25:27.74585+02', 37, 38);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (211, NULL, NULL, NULL, '2017-05-17 00:00:00', NULL, '2016-02-27 23:34:08.672+02', '2016-02-27 23:34:08.669645+02', 38, 39);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (212, 'Big data', NULL, NULL, NULL, NULL, '2016-02-27 23:34:08.672+02', '2016-02-27 23:34:08.669645+02', 38, 40);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (213, '573-5826 Felis St.', NULL, NULL, NULL, NULL, '2016-02-27 23:34:08.672+02', '2016-02-27 23:34:08.669645+02', 38, 41);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (214, NULL, NULL, NULL, NULL, 31, '2016-02-27 23:34:08.672+02', '2016-02-27 23:34:08.669645+02', 38, 42);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (215, NULL, 33, NULL, NULL, NULL, '2016-02-27 23:34:08.672+02', '2016-02-27 23:34:08.669645+02', 38, 43);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (216, 'Jakatila', NULL, NULL, NULL, NULL, '2016-02-27 23:37:39.096+02', '2016-02-27 23:37:39.09268+02', 39, 44);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (217, NULL, NULL, NULL, NULL, 34, '2016-02-27 23:37:39.096+02', '2016-02-27 23:37:39.09268+02', 39, 45);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (218, NULL, NULL, NULL, NULL, 35, '2016-02-27 23:37:39.096+02', '2016-02-27 23:37:39.09268+02', 39, 45);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (219, NULL, NULL, NULL, NULL, 36, '2016-02-27 23:37:39.096+02', '2016-02-27 23:37:39.09268+02', 39, 45);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (220, NULL, NULL, NULL, '2016-02-03 00:00:00', NULL, '2016-02-27 23:37:39.096+02', '2016-02-27 23:37:39.09268+02', 39, 46);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (221, NULL, NULL, NULL, '2005-11-25 00:00:00', NULL, '2016-02-27 23:37:39.096+02', '2016-02-27 23:37:39.09268+02', 39, 47);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (222, NULL, NULL, NULL, '2016-02-21 00:00:00', NULL, '2016-02-27 23:55:09.302+02', '2016-02-27 23:55:09.298749+02', 40, 24);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (223, 'Jonas', NULL, NULL, NULL, NULL, '2016-02-27 23:55:09.302+02', '2016-02-27 23:55:09.298749+02', 40, 25);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (224, 'Petrauskas', NULL, NULL, NULL, NULL, '2016-02-27 23:55:09.302+02', '2016-02-27 23:55:09.298749+02', 40, 26);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (225, NULL, NULL, NULL, NULL, 10, '2016-02-27 23:55:09.302+02', '2016-02-27 23:55:09.298749+02', 40, 27);
INSERT INTO "MV_Value" (id, string_v, int_v, numeric_v, date_v, list_id, created, modified, item_id, field_id) VALUES (226, NULL, NULL, NULL, NULL, 15, '2016-02-27 23:55:09.302+02', '2016-02-27 23:55:09.298749+02', 40, 29);


--
-- TOC entry 2029 (class 0 OID 0)
-- Dependencies: 170
-- Name: MV_Value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"MV_Value_id_seq"', 226, true);


--
-- TOC entry 1872 (class 2606 OID 33121)
-- Name: MV_Field_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "MV_Field"
    ADD CONSTRAINT "MV_Field_pkey" PRIMARY KEY (id);


--
-- TOC entry 1874 (class 2606 OID 33135)
-- Name: MV_Group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "MV_List"
    ADD CONSTRAINT "MV_Group_pkey" PRIMARY KEY (id);


--
-- TOC entry 1870 (class 2606 OID 33087)
-- Name: MV_Item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "MV_Item"
    ADD CONSTRAINT "MV_Item_pkey" PRIMARY KEY (id);


--
-- TOC entry 1876 (class 2606 OID 41372)
-- Name: MV_List_field_id_order_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "MV_Option"
    ADD CONSTRAINT "MV_List_field_id_order_key" UNIQUE (field_id, "order");


--
-- TOC entry 1878 (class 2606 OID 33148)
-- Name: MV_List_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "MV_Option"
    ADD CONSTRAINT "MV_List_pkey" PRIMARY KEY (id);


--
-- TOC entry 1868 (class 2606 OID 33077)
-- Name: MV_Value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "MV_Value"
    ADD CONSTRAINT "MV_Value_pkey" PRIMARY KEY (id);


--
-- TOC entry 1883 (class 2606 OID 33174)
-- Name: MV_Field_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Field"
    ADD CONSTRAINT "MV_Field_group_id_fkey" FOREIGN KEY (group_id) REFERENCES "MV_List"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1882 (class 2606 OID 33169)
-- Name: MV_Item_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Item"
    ADD CONSTRAINT "MV_Item_group_id_fkey" FOREIGN KEY (group_id) REFERENCES "MV_List"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1884 (class 2606 OID 33149)
-- Name: MV_List_field_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Option"
    ADD CONSTRAINT "MV_List_field_id_fkey" FOREIGN KEY (field_id) REFERENCES "MV_Field"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1881 (class 2606 OID 33164)
-- Name: MV_Value_field_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Value"
    ADD CONSTRAINT "MV_Value_field_id_fkey" FOREIGN KEY (field_id) REFERENCES "MV_Field"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1880 (class 2606 OID 33159)
-- Name: MV_Value_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Value"
    ADD CONSTRAINT "MV_Value_item_id_fkey" FOREIGN KEY (item_id) REFERENCES "MV_Item"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1879 (class 2606 OID 33154)
-- Name: MV_Value_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MV_Value"
    ADD CONSTRAINT "MV_Value_list_id_fkey" FOREIGN KEY (list_id) REFERENCES "MV_Option"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2008 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 2010 (class 0 OID 0)
-- Dependencies: 175
-- Name: MV_Field; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE "MV_Field" FROM PUBLIC;
REVOKE ALL ON TABLE "MV_Field" FROM postgres;
GRANT ALL ON TABLE "MV_Field" TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "MV_Field" TO myvadata;


--
-- TOC entry 2012 (class 0 OID 0)
-- Dependencies: 174
-- Name: MV_Field_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE "MV_Field_id_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "MV_Field_id_seq" FROM postgres;
GRANT ALL ON SEQUENCE "MV_Field_id_seq" TO postgres;
GRANT ALL ON SEQUENCE "MV_Field_id_seq" TO myvadata;


--
-- TOC entry 2013 (class 0 OID 0)
-- Dependencies: 177
-- Name: MV_List; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE "MV_List" FROM PUBLIC;
REVOKE ALL ON TABLE "MV_List" FROM postgres;
GRANT ALL ON TABLE "MV_List" TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "MV_List" TO myvadata;


--
-- TOC entry 2015 (class 0 OID 0)
-- Dependencies: 176
-- Name: MV_Group_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE "MV_Group_id_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "MV_Group_id_seq" FROM postgres;
GRANT ALL ON SEQUENCE "MV_Group_id_seq" TO postgres;
GRANT ALL ON SEQUENCE "MV_Group_id_seq" TO myvadata;


--
-- TOC entry 2016 (class 0 OID 0)
-- Dependencies: 173
-- Name: MV_Item; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE "MV_Item" FROM PUBLIC;
REVOKE ALL ON TABLE "MV_Item" FROM postgres;
GRANT ALL ON TABLE "MV_Item" TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "MV_Item" TO myvadata;


--
-- TOC entry 2018 (class 0 OID 0)
-- Dependencies: 172
-- Name: MV_Item_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE "MV_Item_id_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "MV_Item_id_seq" FROM postgres;
GRANT ALL ON SEQUENCE "MV_Item_id_seq" TO postgres;
GRANT ALL ON SEQUENCE "MV_Item_id_seq" TO myvadata;


--
-- TOC entry 2019 (class 0 OID 0)
-- Dependencies: 179
-- Name: MV_Option; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE "MV_Option" FROM PUBLIC;
REVOKE ALL ON TABLE "MV_Option" FROM postgres;
GRANT ALL ON TABLE "MV_Option" TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "MV_Option" TO myvadata;


--
-- TOC entry 2021 (class 0 OID 0)
-- Dependencies: 178
-- Name: MV_List_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE "MV_List_id_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "MV_List_id_seq" FROM postgres;
GRANT ALL ON SEQUENCE "MV_List_id_seq" TO postgres;
GRANT ALL ON SEQUENCE "MV_List_id_seq" TO myvadata;


--
-- TOC entry 2022 (class 0 OID 0)
-- Dependencies: 171
-- Name: MV_Value; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE "MV_Value" FROM PUBLIC;
REVOKE ALL ON TABLE "MV_Value" FROM postgres;
GRANT ALL ON TABLE "MV_Value" TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "MV_Value" TO myvadata;


--
-- TOC entry 2024 (class 0 OID 0)
-- Dependencies: 170
-- Name: MV_Value_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE "MV_Value_id_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "MV_Value_id_seq" FROM postgres;
GRANT ALL ON SEQUENCE "MV_Value_id_seq" TO postgres;
GRANT ALL ON SEQUENCE "MV_Value_id_seq" TO myvadata;


-- Completed on 2016-02-28 00:22:34

--
-- PostgreSQL database dump complete
--


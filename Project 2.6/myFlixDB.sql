--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-08-28 11:57:43

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16409)
-- Name: directors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directors (
    directorid integer NOT NULL,
    name character varying(50) NOT NULL,
    bio character varying(1000),
    birthyear date,
    deathyear date
);


ALTER TABLE public.directors OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16408)
-- Name: directors_directorid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directors_directorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directors_directorid_seq OWNER TO postgres;

--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 217
-- Name: directors_directorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directors_directorid_seq OWNED BY public.directors.directorid;


--
-- TOC entry 216 (class 1259 OID 16400)
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    genreid integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(1000)
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: genres_genreid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_genreid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_genreid_seq OWNER TO postgres;

--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 215
-- Name: genres_genreid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_genreid_seq OWNED BY public.genres.genreid;


--
-- TOC entry 220 (class 1259 OID 16421)
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movieid integer NOT NULL,
    title character varying(50) NOT NULL,
    description character varying(1000),
    directorid integer NOT NULL,
    genreid integer NOT NULL,
    imageurl character varying(300),
    featured boolean
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16420)
-- Name: movies_movieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_movieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_movieid_seq OWNER TO postgres;

--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 219
-- Name: movies_movieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_movieid_seq OWNED BY public.movies.movieid;


--
-- TOC entry 224 (class 1259 OID 16447)
-- Name: user_movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_movies (
    usermovieid integer NOT NULL,
    userid integer,
    movieid integer
);


ALTER TABLE public.user_movies OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16446)
-- Name: user_movies_usermovieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_movies_usermovieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_movies_usermovieid_seq OWNER TO postgres;

--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 223
-- Name: user_movies_usermovieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_movies_usermovieid_seq OWNED BY public.user_movies.usermovieid;


--
-- TOC entry 222 (class 1259 OID 16440)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    birth_date date
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16439)
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_userid_seq OWNER TO postgres;

--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- TOC entry 4709 (class 2604 OID 16412)
-- Name: directors directorid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors ALTER COLUMN directorid SET DEFAULT nextval('public.directors_directorid_seq'::regclass);


--
-- TOC entry 4708 (class 2604 OID 16403)
-- Name: genres genreid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN genreid SET DEFAULT nextval('public.genres_genreid_seq'::regclass);


--
-- TOC entry 4710 (class 2604 OID 16424)
-- Name: movies movieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN movieid SET DEFAULT nextval('public.movies_movieid_seq'::regclass);


--
-- TOC entry 4712 (class 2604 OID 16450)
-- Name: user_movies usermovieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies ALTER COLUMN usermovieid SET DEFAULT nextval('public.user_movies_usermovieid_seq'::regclass);


--
-- TOC entry 4711 (class 2604 OID 16443)
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- TOC entry 4873 (class 0 OID 16409)
-- Dependencies: 218
-- Data for Name: directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (1, 'Christopher Nolan', 'British-American film director, producer, and screenwriter.', '1970-07-30', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (2, 'Steven Spielberg', 'American film director, producer, and screenwriter.', '1946-12-18', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (3, 'Quentin Tarantino', 'American filmmaker and actor.', '1963-03-27', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (4, 'Martin Scorsese', 'American film director, producer, screenwriter, and actor.', '1942-11-17', NULL);


--
-- TOC entry 4871 (class 0 OID 16400)
-- Dependencies: 216
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.genres (genreid, name, description) VALUES (1, 'Action', 'A genre that emphasizes physical feats, including hand-to-hand combat, chases, and explosions.');
INSERT INTO public.genres (genreid, name, description) VALUES (2, 'Drama', 'A genre that focuses on narrative-driven stories that evoke emotions.');
INSERT INTO public.genres (genreid, name, description) VALUES (3, 'Thriller', 'A genre characterized by excitement and suspense, often involving crime or espionage.');
INSERT INTO public.genres (genreid, name, description) VALUES (4, 'Science Fiction', 'A genre dealing with imaginative and futuristic concepts.');


--
-- TOC entry 4875 (class 0 OID 16421)
-- Dependencies: 220
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (1, 'Inception', 'A thief who steals corporate secrets through the use of dream-sharing technology.', 1, 4, 'https://example.com/inception.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (2, 'The Dark Knight', 'Batman sets out to dismantle the remaining criminal organizations that plague Gotham.', 1, 1, 'https://example.com/darkknight.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (4, 'Schindler''s List', 'In German-occupied Poland, Oskar Schindler gradually becomes concerned for his Jewish workforce.', 2, 2, 'https://example.com/schindlerslist.jpg', false);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (5, 'Pulp Fiction', 'The lives of two mob hitmen, a boxer, and a gangster''s wife intertwine in four tales of violence and redemption.', 3, 3, 'https://example.com/pulpfiction.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (6, 'The Irishman', 'A mob hitman recalls his possible involvement with the slaying of Jimmy Hoffa.', 4, 2, 'https://example.com/irishman.jpg', false);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (7, 'Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.', 1, 4, 'https://example.com/interstellar.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (8, 'Kill Bill: Vol. 1', 'A former assassin, known as The Bride, wakes from a coma and seeks vengeance on those who betrayed her.', 3, 1, 'https://example.com/killbill.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (9, 'Goodfellas', 'The story of Henry Hill and his life in the mob.', 4, 2, 'https://example.com/goodfellas.jpg', false);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (10, 'E.T. the Extra-Terrestrial', 'A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.', 2, 4, 'https://example.com/et.jpg', true);


--
-- TOC entry 4879 (class 0 OID 16447)
-- Dependencies: 224
-- Data for Name: user_movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (1, 1, 1);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (2, 1, 2);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (4, 2, 4);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (5, 3, 5);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (6, 3, 6);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (7, 4, 7);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (8, 4, 8);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (9, 5, 9);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (10, 5, 10);


--
-- TOC entry 4877 (class 0 OID 16440)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (2, 'jane_smith', 'mypassword', 'jane_smith@example.com', '1990-06-20');
INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (3, 'bob_jones', 'bobspass', 'bob_jones@example.com', '1982-09-25');
INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (4, 'alice_brown', 'alicepw', 'alice_brown@example.com', '1978-12-10');
INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (5, 'charlie_green', 'charliepass', 'charlie_green@example.com', '1995-03-30');
INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (1, 'john_doe', 'password123', 'new_email@example.com', '1985-05-15');


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 217
-- Name: directors_directorid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directors_directorid_seq', 1, false);


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 215
-- Name: genres_genreid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_genreid_seq', 1, false);


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 219
-- Name: movies_movieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_movieid_seq', 1, false);


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 223
-- Name: user_movies_usermovieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_movies_usermovieid_seq', 1, false);


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 1, false);


--
-- TOC entry 4716 (class 2606 OID 16416)
-- Name: directors directors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors
    ADD CONSTRAINT directors_pkey PRIMARY KEY (directorid);


--
-- TOC entry 4714 (class 2606 OID 16407)
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genreid);


--
-- TOC entry 4718 (class 2606 OID 16428)
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movieid);


--
-- TOC entry 4722 (class 2606 OID 16452)
-- Name: user_movies user_movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies
    ADD CONSTRAINT user_movies_pkey PRIMARY KEY (usermovieid);


--
-- TOC entry 4720 (class 2606 OID 16445)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- TOC entry 4723 (class 2606 OID 16434)
-- Name: movies directorkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT directorkey FOREIGN KEY (directorid) REFERENCES public.directors(directorid);


--
-- TOC entry 4724 (class 2606 OID 16429)
-- Name: movies genrekey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT genrekey FOREIGN KEY (genreid) REFERENCES public.genres(genreid);


--
-- TOC entry 4725 (class 2606 OID 16458)
-- Name: user_movies moviekey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies
    ADD CONSTRAINT moviekey FOREIGN KEY (movieid) REFERENCES public.movies(movieid);


--
-- TOC entry 4726 (class 2606 OID 16453)
-- Name: user_movies userkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies
    ADD CONSTRAINT userkey FOREIGN KEY (userid) REFERENCES public.users(userid);


-- Completed on 2024-08-28 11:57:43

--
-- PostgreSQL database dump complete
--


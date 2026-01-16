--
-- PostgreSQL database dump
--

\restrict le6NTYvl6z3dYflhNpj0DkshKk6ArWF3tgzVoadQ1jid6PY8ujJxgJJlfc4U6x7

-- Dumped from database version 16.11 (Postgres.app)
-- Dumped by pg_dump version 16.11 (Postgres.app)

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
-- Name: appointments; Type: TABLE; Schema: public; Owner: Dalia
--

CREATE TABLE public.appointments (
    appointment_id integer NOT NULL,
    stylist_id integer,
    service_id integer,
    "time" character varying NOT NULL
);


ALTER TABLE public.appointments OWNER TO "Dalia";

--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: Dalia
--

CREATE SEQUENCE public.appointments_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointments_appointment_id_seq OWNER TO "Dalia";

--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Dalia
--

ALTER SEQUENCE public.appointments_appointment_id_seq OWNED BY public.appointments.appointment_id;


--
-- Name: appt_services; Type: TABLE; Schema: public; Owner: Dalia
--

CREATE TABLE public.appt_services (
    appt_id integer,
    service_id integer
);


ALTER TABLE public.appt_services OWNER TO "Dalia";

--
-- Name: customers; Type: TABLE; Schema: public; Owner: Dalia
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone character varying(15) NOT NULL
);


ALTER TABLE public.customers OWNER TO "Dalia";

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: Dalia
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_customer_id_seq OWNER TO "Dalia";

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Dalia
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: Dalia
--

CREATE TABLE public.services (
    service_id integer NOT NULL,
    name character varying(15) NOT NULL
);


ALTER TABLE public.services OWNER TO "Dalia";

--
-- Name: services_service_id_seq; Type: SEQUENCE; Schema: public; Owner: Dalia
--

CREATE SEQUENCE public.services_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_service_id_seq OWNER TO "Dalia";

--
-- Name: services_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Dalia
--

ALTER SEQUENCE public.services_service_id_seq OWNED BY public.services.service_id;


--
-- Name: stylist_services; Type: TABLE; Schema: public; Owner: Dalia
--

CREATE TABLE public.stylist_services (
    stylist_id integer,
    service_id integer,
    price numeric(6,2) NOT NULL
);


ALTER TABLE public.stylist_services OWNER TO "Dalia";

--
-- Name: stylists; Type: TABLE; Schema: public; Owner: Dalia
--

CREATE TABLE public.stylists (
    stylist_id integer NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE public.stylists OWNER TO "Dalia";

--
-- Name: stylists_stylist_id_seq; Type: SEQUENCE; Schema: public; Owner: Dalia
--

CREATE SEQUENCE public.stylists_stylist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stylists_stylist_id_seq OWNER TO "Dalia";

--
-- Name: stylists_stylist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Dalia
--

ALTER SEQUENCE public.stylists_stylist_id_seq OWNED BY public.stylists.stylist_id;


--
-- Name: appointments appointment_id; Type: DEFAULT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.appointments ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointments_appointment_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: services service_id; Type: DEFAULT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.services ALTER COLUMN service_id SET DEFAULT nextval('public.services_service_id_seq'::regclass);


--
-- Name: stylists stylist_id; Type: DEFAULT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.stylists ALTER COLUMN stylist_id SET DEFAULT nextval('public.stylists_stylist_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: Dalia
--

COPY public.appointments (appointment_id, stylist_id, service_id, "time") FROM stdin;
\.


--
-- Data for Name: appt_services; Type: TABLE DATA; Schema: public; Owner: Dalia
--

COPY public.appt_services (appt_id, service_id) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: Dalia
--

COPY public.customers (customer_id, name, phone) FROM stdin;
1		
2	Dalia	555-555-55-55
3	DD	553-555-65-34
4	1	111-111-11-11
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: Dalia
--

COPY public.services (service_id, name) FROM stdin;
1	cut
2	color
3	perm
4	style
5	trim
\.


--
-- Data for Name: stylist_services; Type: TABLE DATA; Schema: public; Owner: Dalia
--

COPY public.stylist_services (stylist_id, service_id, price) FROM stdin;
1	1	60.00
2	1	70.00
3	1	60.00
4	1	70.00
5	1	80.00
1	2	70.00
2	2	100.00
3	2	60.00
4	2	100.00
5	2	150.00
2	3	100.00
4	3	120.00
5	3	150.00
1	4	30.00
2	4	40.00
3	4	30.00
4	4	40.00
5	4	50.00
1	5	30.00
2	5	40.00
3	5	30.00
4	5	40.00
5	5	50.00
\.


--
-- Data for Name: stylists; Type: TABLE DATA; Schema: public; Owner: Dalia
--

COPY public.stylists (stylist_id, name) FROM stdin;
1	Juan
2	Fabio
3	Juliana
4	Amy Lou
5	James
\.


--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Dalia
--

SELECT pg_catalog.setval('public.appointments_appointment_id_seq', 1, false);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Dalia
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 4, true);


--
-- Name: services_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Dalia
--

SELECT pg_catalog.setval('public.services_service_id_seq', 5, true);


--
-- Name: stylists_stylist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Dalia
--

SELECT pg_catalog.setval('public.stylists_stylist_id_seq', 5, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_id);


--
-- Name: stylists stylists_pkey; Type: CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.stylists
    ADD CONSTRAINT stylists_pkey PRIMARY KEY (stylist_id);


--
-- Name: appt_services appt_services_appt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.appt_services
    ADD CONSTRAINT appt_services_appt_id_fkey FOREIGN KEY (appt_id) REFERENCES public.appointments(appointment_id);


--
-- Name: appt_services appt_services_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.appt_services
    ADD CONSTRAINT appt_services_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: appointments appts_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appts_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: appointments appts_stylist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appts_stylist_id_fkey FOREIGN KEY (stylist_id) REFERENCES public.stylists(stylist_id);


--
-- Name: stylist_services stylist_services_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.stylist_services
    ADD CONSTRAINT stylist_services_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: stylist_services stylist_services_stylist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Dalia
--

ALTER TABLE ONLY public.stylist_services
    ADD CONSTRAINT stylist_services_stylist_id_fkey FOREIGN KEY (stylist_id) REFERENCES public.stylists(stylist_id);


--
-- PostgreSQL database dump complete
--

\unrestrict le6NTYvl6z3dYflhNpj0DkshKk6ArWF3tgzVoadQ1jid6PY8ujJxgJJlfc4U6x7


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
-- Name: alert; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE alert (
    alert_id bigint NOT NULL,
    data_id bigint NOT NULL,
    patient_uuid character varying(100) NOT NULL,
    alert_time timestamp with time zone NOT NULL,
    alert_text character varying(5000) NOT NULL,
    transmit_success_date timestamp with time zone,
    retry_attempts integer NOT NULL
);


ALTER TABLE alert OWNER TO postgres;

--
-- Name: alert_alert_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE alert_alert_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alert_alert_id_seq OWNER TO postgres;

--
-- Name: alert_alert_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE alert_alert_id_seq OWNED BY alert.alert_id;


--
-- Name: all_hardware_downloadable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE all_hardware_downloadable (
    downloadable_uuid character varying(100) NOT NULL,
    version character varying(100) NOT NULL,
    version_author character varying(100) NOT NULL,
    version_date timestamp with time zone NOT NULL,
    script_location character varying(100) NOT NULL,
    signature character varying(10000) NOT NULL
);


ALTER TABLE all_hardware_downloadable OWNER TO postgres;

--
-- Name: all_hardware_downloadable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE all_hardware_downloadable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE all_hardware_downloadable_id_seq OWNER TO postgres;

--
-- Name: all_hardware_downloaded; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE all_hardware_downloaded (
    all_hardware_downloaded_id integer NOT NULL,
    downloaded_date timestamp with time zone,
    downloadable_uuid character varying(100) NOT NULL,
    hardware_name character varying(100) NOT NULL
);


ALTER TABLE all_hardware_downloaded OWNER TO postgres;

--
-- Name: all_hardware_downloaded_all_hardware_downloaded_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE all_hardware_downloaded_all_hardware_downloaded_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE all_hardware_downloaded_all_hardware_downloaded_id_seq OWNER TO postgres;

--
-- Name: all_hardware_downloaded_all_hardware_downloaded_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE all_hardware_downloaded_all_hardware_downloaded_id_seq OWNED BY all_hardware_downloaded.all_hardware_downloaded_id;


--
-- Name: all_hardware_downloaded_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE all_hardware_downloaded_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE all_hardware_downloaded_id_seq OWNER TO postgres;

--
-- Name: device_data_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE device_data_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE device_data_data_id_seq OWNER TO postgres;

--
-- Name: hardware; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hardware (
    hardware_name character varying(100) NOT NULL,
    mac_address character varying(100) NOT NULL,
    current_software_version character varying(100) NOT NULL,
    patient_uuid character varying(100)
);


ALTER TABLE hardware OWNER TO postgres;

--
-- Name: hardware_downloadable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hardware_downloadable (
    downloadable_uuid character varying(100) NOT NULL,
    hardware_name character varying(100) NOT NULL,
    version character varying(100) NOT NULL,
    version_author character varying(100) NOT NULL,
    version_date timestamp with time zone NOT NULL,
    downloaded_date timestamp with time zone,
    script_location character varying(100) NOT NULL,
    signature character varying(10000) NOT NULL
);


ALTER TABLE hardware_downloadable OWNER TO postgres;

--
-- Name: messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE messages_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE messages_message_id_seq OWNER TO postgres;

--
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE patient (
    patient_uuid character varying(100) NOT NULL,
    patient_group_uuid character varying
);


ALTER TABLE patient OWNER TO postgres;

--
-- Name: patient_certificate; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE patient_certificate (
    patient_uuid character varying(100) NOT NULL,
    certificate_location character varying(1000) NOT NULL
);


ALTER TABLE patient_certificate OWNER TO postgres;

--
-- Name: patient_downloadable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE patient_downloadable (
    downloadable_uuid character varying(100) NOT NULL,
    patient_uuid character varying(100) NOT NULL,
    version character varying(100) NOT NULL,
    version_author character varying(255) NOT NULL,
    version_date timestamp with time zone NOT NULL,
    downloaded_date timestamp with time zone,
    script_location character varying(100) NOT NULL,
    signature character varying(10000) NOT NULL
);


ALTER TABLE patient_downloadable OWNER TO postgres;

--
-- Name: patient_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE patient_group (
    patient_group_uuid character varying(100) NOT NULL,
    patient_group_name character varying(100)
);


ALTER TABLE patient_group OWNER TO postgres;

--
-- Name: patient_hardware_downloadable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE patient_hardware_downloadable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE patient_hardware_downloadable_id_seq OWNER TO postgres;

--
-- Name: recording_device_attribute_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE recording_device_attribute_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recording_device_attribute_attribute_id_seq OWNER TO postgres;

--
-- Name: recording_device_attribute; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE recording_device_attribute (
    attribute_id integer DEFAULT nextval('recording_device_attribute_attribute_id_seq'::regclass) NOT NULL,
    type_id integer NOT NULL,
    attribute_name character varying(100) NOT NULL,
    attribute_units character varying(100),
    attribute_type character varying(100) NOT NULL
);


ALTER TABLE recording_device_attribute OWNER TO postgres;

--
-- Name: recording_device_data; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE recording_device_data (
    data_id bigint NOT NULL,
    attribute_id integer NOT NULL,
    data_value character varying(1000) NOT NULL,
    patient_uuid character varying(100) NOT NULL,
    data_value_time timestamp with time zone NOT NULL,
    downloaded_time timestamp with time zone NOT NULL,
    schedule_effective_time timestamp with time zone,
    schedule_expiry_time timestamp with time zone
);


ALTER TABLE recording_device_data OWNER TO postgres;

--
-- Name: recording_device_data_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE recording_device_data_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recording_device_data_data_id_seq OWNER TO postgres;

--
-- Name: recording_device_data_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE recording_device_data_data_id_seq OWNED BY recording_device_data.data_id;


--
-- Name: recording_device_type_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE recording_device_type_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recording_device_type_type_id_seq OWNER TO postgres;

--
-- Name: recording_device_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE recording_device_type (
    type_id integer DEFAULT nextval('recording_device_type_type_id_seq'::regclass) NOT NULL,
    type character varying(100) NOT NULL,
    make character varying(100) NOT NULL,
    model character varying(100) NOT NULL,
    display_name character varying(1000) NOT NULL
);


ALTER TABLE recording_device_type OWNER TO postgres;

--
-- Name: alert_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alert ALTER COLUMN alert_id SET DEFAULT nextval('alert_alert_id_seq'::regclass);


--
-- Name: all_hardware_downloaded_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY all_hardware_downloaded ALTER COLUMN all_hardware_downloaded_id SET DEFAULT nextval('all_hardware_downloaded_all_hardware_downloaded_id_seq'::regclass);


--
-- Name: data_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recording_device_data ALTER COLUMN data_id SET DEFAULT nextval('recording_device_data_data_id_seq'::regclass);


--
-- Name: alert_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY alert
    ADD CONSTRAINT alert_pk PRIMARY KEY (alert_id);


--
-- Name: all_hardware_downloadable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY all_hardware_downloadable
    ADD CONSTRAINT all_hardware_downloadable_pkey PRIMARY KEY (downloadable_uuid);


--
-- Name: all_hardware_downloaded_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY all_hardware_downloaded
    ADD CONSTRAINT all_hardware_downloaded_pkey PRIMARY KEY (all_hardware_downloaded_id);


--
-- Name: hardware_downloadable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hardware_downloadable
    ADD CONSTRAINT hardware_downloadable_pkey PRIMARY KEY (downloadable_uuid);


--
-- Name: hardware_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hardware
    ADD CONSTRAINT hardware_pkey PRIMARY KEY (hardware_name);


--
-- Name: patient_certificate_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patient_certificate
    ADD CONSTRAINT patient_certificate_pk PRIMARY KEY (patient_uuid);


--
-- Name: patient_downloadable_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patient_downloadable
    ADD CONSTRAINT patient_downloadable_pk PRIMARY KEY (downloadable_uuid);


--
-- Name: patient_group_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patient_group
    ADD CONSTRAINT patient_group_pk PRIMARY KEY (patient_group_uuid);


--
-- Name: patient_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_id_pk PRIMARY KEY (patient_uuid);


--
-- Name: recording_device_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY recording_device_attribute
    ADD CONSTRAINT recording_device_attribute_pkey PRIMARY KEY (attribute_id);


--
-- Name: recording_device_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY recording_device_data
    ADD CONSTRAINT recording_device_data_pkey PRIMARY KEY (data_id);


--
-- Name: recording_device_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY recording_device_type
    ADD CONSTRAINT recording_device_type_pkey PRIMARY KEY (type_id);


--
-- Name: all_hardware_downloadable_all_hardware_downloaded_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY all_hardware_downloaded
    ADD CONSTRAINT all_hardware_downloadable_all_hardware_downloaded_fk FOREIGN KEY (downloadable_uuid) REFERENCES all_hardware_downloadable(downloadable_uuid);


--
-- Name: hardware_all_hardware_downloaded_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY all_hardware_downloaded
    ADD CONSTRAINT hardware_all_hardware_downloaded_fk FOREIGN KEY (hardware_name) REFERENCES hardware(hardware_name);


--
-- Name: hardware_hardware_downloadable_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hardware_downloadable
    ADD CONSTRAINT hardware_hardware_downloadable_fk FOREIGN KEY (hardware_name) REFERENCES hardware(hardware_name);


--
-- Name: patient_alert_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alert
    ADD CONSTRAINT patient_alert_fk FOREIGN KEY (patient_uuid) REFERENCES patient(patient_uuid);


--
-- Name: patient_group_patient_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_group_patient_fk FOREIGN KEY (patient_group_uuid) REFERENCES patient_group(patient_group_uuid);


--
-- Name: patient_hardware_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hardware
    ADD CONSTRAINT patient_hardware_fk FOREIGN KEY (patient_uuid) REFERENCES patient(patient_uuid);


--
-- Name: patient_patient_certificates_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patient_certificate
    ADD CONSTRAINT patient_patient_certificates_fk FOREIGN KEY (patient_uuid) REFERENCES patient(patient_uuid);


--
-- Name: patient_patient_downloadable_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patient_downloadable
    ADD CONSTRAINT patient_patient_downloadable_fk FOREIGN KEY (patient_uuid) REFERENCES patient(patient_uuid);


--
-- Name: patient_recording_device_data_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recording_device_data
    ADD CONSTRAINT patient_recording_device_data_fk FOREIGN KEY (patient_uuid) REFERENCES patient(patient_uuid);


--
-- Name: recording_device_attribute_recording_device_data_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recording_device_data
    ADD CONSTRAINT recording_device_attribute_recording_device_data_fk FOREIGN KEY (attribute_id) REFERENCES recording_device_attribute(attribute_id);


--
-- Name: recording_device_data_alert_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alert
    ADD CONSTRAINT recording_device_data_alert_fk FOREIGN KEY (data_id) REFERENCES recording_device_data(data_id);


--
-- Name: recording_device_type_recording_device_attribute_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recording_device_attribute
    ADD CONSTRAINT recording_device_type_recording_device_attribute_fk FOREIGN KEY (type_id) REFERENCES recording_device_type(type_id);


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


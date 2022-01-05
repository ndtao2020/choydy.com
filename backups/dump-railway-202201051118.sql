--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.3

-- Started on 2022-01-05 11:18:02

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

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 247 (class 1259 OID 17486)
-- Name: authority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authority (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authority OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 18796)
-- Name: catalog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalog (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    priority integer NOT NULL,
    parent_id bigint
);


ALTER TABLE public.catalog OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 18758)
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id uuid NOT NULL,
    content text NOT NULL,
    likes bigint,
    parent_id uuid,
    post_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created bigint NOT NULL
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17507)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    iso character varying(2) NOT NULL,
    display_name character varying(255) NOT NULL,
    iso3 character varying(3) NOT NULL,
    name character varying(255) NOT NULL,
    num_code integer NOT NULL,
    phone_code integer NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17519)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 17527)
-- Name: language; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.language (
    code character varying(2) NOT NULL,
    name character varying(255) NOT NULL,
    native_name character varying(255) NOT NULL,
    code3 character varying(3) NOT NULL,
    nativename character varying(255)
);


ALTER TABLE public.language OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 18781)
-- Name: media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media (
    id uuid NOT NULL,
    link text NOT NULL,
    type character varying(255) NOT NULL,
    post_id uuid NOT NULL
);


ALTER TABLE public.media OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 18981)
-- Name: oauth2client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth2client (
    id character varying(255) NOT NULL,
    access integer NOT NULL,
    approve boolean NOT NULL,
    domain character varying(255) NOT NULL,
    redirect character varying(255),
    refresh integer NOT NULL,
    secret character varying(255) NOT NULL
);


ALTER TABLE public.oauth2client OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 18707)
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    id uuid NOT NULL,
    comments bigint,
    content text,
    count bigint,
    shares bigint,
    title character varying(255) NOT NULL,
    user_id uuid NOT NULL,
    catalog_id bigint NOT NULL,
    disable boolean NOT NULL,
    created bigint NOT NULL
);


ALTER TABLE public.post OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 19029)
-- Name: postlike; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postlike (
    created bigint NOT NULL,
    user_id uuid NOT NULL,
    post_id uuid NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE public.postlike OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 18961)
-- Name: posttag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posttag (
    tag character varying(255) NOT NULL,
    post_id uuid NOT NULL
);


ALTER TABLE public.posttag OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 18567)
-- Name: socialnetwork; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialnetwork (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    clientid character varying(255),
    clientsecret character varying(255)
);


ALTER TABLE public.socialnetwork OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17749)
-- Name: user_sys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_sys (
    id uuid NOT NULL,
    created_by character varying(255),
    created_date timestamp without time zone,
    last_modified_by character varying(255),
    last_modified_date timestamp without time zone,
    avatar character varying(255),
    enabled boolean NOT NULL,
    name character varying(255) NOT NULL,
    password character varying(100) NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    active boolean NOT NULL,
    timezone character varying(255) NOT NULL
);


ALTER TABLE public.user_sys OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 18832)
-- Name: userauthority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userauthority (
    id uuid NOT NULL,
    authority_id character varying(255) NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.userauthority OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 18580)
-- Name: userdetail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userdetail (
    id uuid NOT NULL,
    about text,
    address text,
    birthday date,
    gender character varying(255),
    phonenumber character varying(30),
    postalcode character varying(30),
    country_iso character varying(2) NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.userdetail OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 18588)
-- Name: usersocialnetwork; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usersocialnetwork (
    id uuid NOT NULL,
    avatar character varying(255),
    email character varying(255) NOT NULL,
    phonenumber character varying(255),
    uid character varying(255) NOT NULL,
    social_network_id integer NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.usersocialnetwork OWNER TO postgres;

--
-- TOC entry 3426 (class 0 OID 17486)
-- Dependencies: 247
-- Data for Name: authority; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authority VALUES ('ADMIN', 'Quản trị viên');
INSERT INTO public.authority VALUES ('USER', 'Người dùng');
INSERT INTO public.authority VALUES ('EDITOR', 'Biên tập');


--
-- TOC entry 3437 (class 0 OID 18796)
-- Dependencies: 258
-- Data for Name: catalog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.catalog VALUES (10000, 'Video', 1, NULL);
INSERT INTO public.catalog VALUES (10001, 'Hình ảnh', 2, NULL);
INSERT INTO public.catalog VALUES (2, 'Hình ảnh', 2, NULL);
INSERT INTO public.catalog VALUES (3, 'Funny', 1, 10000);
INSERT INTO public.catalog VALUES (4, 'Bóng đá', 2, 10000);
INSERT INTO public.catalog VALUES (5, 'Thú cưng', 3, 10000);
INSERT INTO public.catalog VALUES (6, 'Video meme', 4, 10000);
INSERT INTO public.catalog VALUES (9, 'Meme Huấn Hoa Hồng', 6, 10000);
INSERT INTO public.catalog VALUES (11, 'Meme Gấu Trúc', 8, 10001);
INSERT INTO public.catalog VALUES (12, 'Meme Gốc', 3, 10001);
INSERT INTO public.catalog VALUES (13, 'Meme Chó', 4, 10001);
INSERT INTO public.catalog VALUES (14, 'Meme Mèo', 5, 10001);
INSERT INTO public.catalog VALUES (1, 'Video', 1, 10001);
INSERT INTO public.catalog VALUES (7, 'Cmt Bá đạo', 1, 10001);
INSERT INTO public.catalog VALUES (8, 'Meme Hot', 2, 10001);
INSERT INTO public.catalog VALUES (10, 'Meme Tiến Bịp', 7, 10001);


--
-- TOC entry 3435 (class 0 OID 18758)
-- Dependencies: 256
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3427 (class 0 OID 17507)
-- Dependencies: 248
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.country VALUES ('CX', 'Christmas Island', 'CXR', 'CHRISTMAS ISLAND', 162, 61);
INSERT INTO public.country VALUES ('CC', 'Cocos (Keeling) Islands', 'CCK', 'COCOS (KEELING) ISLANDS', 166, 672);
INSERT INTO public.country VALUES ('PS', 'Palestine, State of', 'PSE', 'PALESTINIAN TERRITORY, OCCUPIED', 275, 970);
INSERT INTO public.country VALUES ('IO', 'British Indian Ocean Territory', 'IOT', 'BRITISH INDIAN OCEAN TERRITORY', 86, 246);
INSERT INTO public.country VALUES ('AF', 'Afghanistan', 'AFG', 'AFGHANISTAN', 4, 93);
INSERT INTO public.country VALUES ('AL', 'Albania', 'ALB', 'ALBANIA', 8, 355);
INSERT INTO public.country VALUES ('DZ', 'Algeria', 'DZA', 'ALGERIA', 12, 213);
INSERT INTO public.country VALUES ('AS', 'American Samoa', 'ASM', 'AMERICAN SAMOA', 16, 1684);
INSERT INTO public.country VALUES ('AD', 'Andorra', 'AND', 'ANDORRA', 20, 376);
INSERT INTO public.country VALUES ('AO', 'Angola', 'AGO', 'ANGOLA', 24, 244);
INSERT INTO public.country VALUES ('AI', 'Anguilla', 'AIA', 'ANGUILLA', 660, 1264);
INSERT INTO public.country VALUES ('AG', 'Antigua and Barbuda', 'ATG', 'ANTIGUA AND BARBUDA', 28, 1268);
INSERT INTO public.country VALUES ('AR', 'Argentina', 'ARG', 'ARGENTINA', 32, 54);
INSERT INTO public.country VALUES ('AM', 'Armenia', 'ARM', 'ARMENIA', 51, 374);
INSERT INTO public.country VALUES ('AW', 'Aruba', 'ABW', 'ARUBA', 533, 297);
INSERT INTO public.country VALUES ('AU', 'Australia', 'AUS', 'AUSTRALIA', 36, 61);
INSERT INTO public.country VALUES ('AT', 'Austria', 'AUT', 'AUSTRIA', 40, 43);
INSERT INTO public.country VALUES ('AZ', 'Azerbaijan', 'AZE', 'AZERBAIJAN', 31, 994);
INSERT INTO public.country VALUES ('BS', 'Bahamas', 'BHS', 'BAHAMAS', 44, 1242);
INSERT INTO public.country VALUES ('BH', 'Bahrain', 'BHR', 'BAHRAIN', 48, 973);
INSERT INTO public.country VALUES ('BD', 'Bangladesh', 'BGD', 'BANGLADESH', 50, 880);
INSERT INTO public.country VALUES ('BB', 'Barbados', 'BRB', 'BARBADOS', 52, 1246);
INSERT INTO public.country VALUES ('BY', 'Belarus', 'BLR', 'BELARUS', 112, 375);
INSERT INTO public.country VALUES ('BE', 'Belgium', 'BEL', 'BELGIUM', 56, 32);
INSERT INTO public.country VALUES ('BZ', 'Belize', 'BLZ', 'BELIZE', 84, 501);
INSERT INTO public.country VALUES ('BJ', 'Benin', 'BEN', 'BENIN', 204, 229);
INSERT INTO public.country VALUES ('BM', 'Bermuda', 'BMU', 'BERMUDA', 60, 1441);
INSERT INTO public.country VALUES ('BT', 'Bhutan', 'BTN', 'BHUTAN', 64, 975);
INSERT INTO public.country VALUES ('BO', 'Bolivia', 'BOL', 'BOLIVIA', 68, 591);
INSERT INTO public.country VALUES ('BA', 'Bosnia and Herzegovina', 'BIH', 'BOSNIA AND HERZEGOVINA', 70, 387);
INSERT INTO public.country VALUES ('BW', 'Botswana', 'BWA', 'BOTSWANA', 72, 267);
INSERT INTO public.country VALUES ('BR', 'Brazil', 'BRA', 'BRAZIL', 76, 55);
INSERT INTO public.country VALUES ('BN', 'Brunei Darussalam', 'BRN', 'BRUNEI DARUSSALAM', 96, 673);
INSERT INTO public.country VALUES ('BG', 'Bulgaria', 'BGR', 'BULGARIA', 100, 359);
INSERT INTO public.country VALUES ('BF', 'Burkina Faso', 'BFA', 'BURKINA FASO', 854, 226);
INSERT INTO public.country VALUES ('BI', 'Burundi', 'BDI', 'BURUNDI', 108, 257);
INSERT INTO public.country VALUES ('KH', 'Cambodia', 'KHM', 'CAMBODIA', 116, 855);
INSERT INTO public.country VALUES ('CM', 'Cameroon', 'CMR', 'CAMEROON', 120, 237);
INSERT INTO public.country VALUES ('CA', 'Canada', 'CAN', 'CANADA', 124, 1);
INSERT INTO public.country VALUES ('CV', 'Cape Verde', 'CPV', 'CAPE VERDE', 132, 238);
INSERT INTO public.country VALUES ('KY', 'Cayman Islands', 'CYM', 'CAYMAN ISLANDS', 136, 1345);
INSERT INTO public.country VALUES ('CF', 'Central African Republic', 'CAF', 'CENTRAL AFRICAN REPUBLIC', 140, 236);
INSERT INTO public.country VALUES ('TD', 'Chad', 'TCD', 'CHAD', 148, 235);
INSERT INTO public.country VALUES ('CL', 'Chile', 'CHL', 'CHILE', 152, 56);
INSERT INTO public.country VALUES ('CN', 'China', 'CHN', 'CHINA', 156, 86);
INSERT INTO public.country VALUES ('CO', 'Colombia', 'COL', 'COLOMBIA', 170, 57);
INSERT INTO public.country VALUES ('KM', 'Comoros', 'COM', 'COMOROS', 174, 269);
INSERT INTO public.country VALUES ('CG', 'Congo', 'COG', 'CONGO', 178, 242);
INSERT INTO public.country VALUES ('CD', 'Congo, the Democratic Republic of the', 'COD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 180, 242);
INSERT INTO public.country VALUES ('CK', 'Cook Islands', 'COK', 'COOK ISLANDS', 184, 682);
INSERT INTO public.country VALUES ('CR', 'Costa Rica', 'CRI', 'COSTA RICA', 188, 506);
INSERT INTO public.country VALUES ('CI', 'Cote D''Ivoire', 'CIV', 'COTE D''IVOIRE', 384, 225);
INSERT INTO public.country VALUES ('HR', 'Croatia', 'HRV', 'CROATIA', 191, 385);
INSERT INTO public.country VALUES ('CU', 'Cuba', 'CUB', 'CUBA', 192, 53);
INSERT INTO public.country VALUES ('CY', 'Cyprus', 'CYP', 'CYPRUS', 196, 357);
INSERT INTO public.country VALUES ('CZ', 'Czech Republic', 'CZE', 'CZECH REPUBLIC', 203, 420);
INSERT INTO public.country VALUES ('DK', 'Denmark', 'DNK', 'DENMARK', 208, 45);
INSERT INTO public.country VALUES ('DJ', 'Djibouti', 'DJI', 'DJIBOUTI', 262, 253);
INSERT INTO public.country VALUES ('DM', 'Dominica', 'DMA', 'DOMINICA', 212, 1767);
INSERT INTO public.country VALUES ('DO', 'Dominican Republic', 'DOM', 'DOMINICAN REPUBLIC', 214, 1809);
INSERT INTO public.country VALUES ('EC', 'Ecuador', 'ECU', 'ECUADOR', 218, 593);
INSERT INTO public.country VALUES ('EG', 'Egypt', 'EGY', 'EGYPT', 818, 20);
INSERT INTO public.country VALUES ('SV', 'El Salvador', 'SLV', 'EL SALVADOR', 222, 503);
INSERT INTO public.country VALUES ('GQ', 'Equatorial Guinea', 'GNQ', 'EQUATORIAL GUINEA', 226, 240);
INSERT INTO public.country VALUES ('ER', 'Eritrea', 'ERI', 'ERITREA', 232, 291);
INSERT INTO public.country VALUES ('EE', 'Estonia', 'EST', 'ESTONIA', 233, 372);
INSERT INTO public.country VALUES ('ET', 'Ethiopia', 'ETH', 'ETHIOPIA', 231, 251);
INSERT INTO public.country VALUES ('FK', 'Falkland Islands (Malvinas)', 'FLK', 'FALKLAND ISLANDS (MALVINAS)', 238, 500);
INSERT INTO public.country VALUES ('FO', 'Faroe Islands', 'FRO', 'FAROE ISLANDS', 234, 298);
INSERT INTO public.country VALUES ('FJ', 'Fiji', 'FJI', 'FIJI', 242, 679);
INSERT INTO public.country VALUES ('FI', 'Finland', 'FIN', 'FINLAND', 246, 358);
INSERT INTO public.country VALUES ('FR', 'France', 'FRA', 'FRANCE', 250, 33);
INSERT INTO public.country VALUES ('GF', 'French Guiana', 'GUF', 'FRENCH GUIANA', 254, 594);
INSERT INTO public.country VALUES ('PF', 'French Polynesia', 'PYF', 'FRENCH POLYNESIA', 258, 689);
INSERT INTO public.country VALUES ('GA', 'Gabon', 'GAB', 'GABON', 266, 241);
INSERT INTO public.country VALUES ('GM', 'Gambia', 'GMB', 'GAMBIA', 270, 220);
INSERT INTO public.country VALUES ('GE', 'Georgia', 'GEO', 'GEORGIA', 268, 995);
INSERT INTO public.country VALUES ('DE', 'Germany', 'DEU', 'GERMANY', 276, 49);
INSERT INTO public.country VALUES ('GH', 'Ghana', 'GHA', 'GHANA', 288, 233);
INSERT INTO public.country VALUES ('GI', 'Gibraltar', 'GIB', 'GIBRALTAR', 292, 350);
INSERT INTO public.country VALUES ('GR', 'Greece', 'GRC', 'GREECE', 300, 30);
INSERT INTO public.country VALUES ('GL', 'Greenland', 'GRL', 'GREENLAND', 304, 299);
INSERT INTO public.country VALUES ('GD', 'Grenada', 'GRD', 'GRENADA', 308, 1473);
INSERT INTO public.country VALUES ('GP', 'Guadeloupe', 'GLP', 'GUADELOUPE', 312, 590);
INSERT INTO public.country VALUES ('GU', 'Guam', 'GUM', 'GUAM', 316, 1671);
INSERT INTO public.country VALUES ('GT', 'Guatemala', 'GTM', 'GUATEMALA', 320, 502);
INSERT INTO public.country VALUES ('GN', 'Guinea', 'GIN', 'GUINEA', 324, 224);
INSERT INTO public.country VALUES ('GW', 'Guinea-Bissau', 'GNB', 'GUINEA-BISSAU', 624, 245);
INSERT INTO public.country VALUES ('GY', 'Guyana', 'GUY', 'GUYANA', 328, 592);
INSERT INTO public.country VALUES ('HT', 'Haiti', 'HTI', 'HAITI', 332, 509);
INSERT INTO public.country VALUES ('VA', 'Holy See (Vatican City State)', 'VAT', 'HOLY SEE (VATICAN CITY STATE)', 336, 39);
INSERT INTO public.country VALUES ('HN', 'Honduras', 'HND', 'HONDURAS', 340, 504);
INSERT INTO public.country VALUES ('HK', 'Hong Kong', 'HKG', 'HONG KONG', 344, 852);
INSERT INTO public.country VALUES ('HU', 'Hungary', 'HUN', 'HUNGARY', 348, 36);
INSERT INTO public.country VALUES ('IS', 'Iceland', 'ISL', 'ICELAND', 352, 354);
INSERT INTO public.country VALUES ('IN', 'India', 'IND', 'INDIA', 356, 91);
INSERT INTO public.country VALUES ('ID', 'Indonesia', 'IDN', 'INDONESIA', 360, 62);
INSERT INTO public.country VALUES ('IR', 'Iran, Islamic Republic of', 'IRN', 'IRAN, ISLAMIC REPUBLIC OF', 364, 98);
INSERT INTO public.country VALUES ('IQ', 'Iraq', 'IRQ', 'IRAQ', 368, 964);
INSERT INTO public.country VALUES ('IE', 'Ireland', 'IRL', 'IRELAND', 372, 353);
INSERT INTO public.country VALUES ('IL', 'Israel', 'ISR', 'ISRAEL', 376, 972);
INSERT INTO public.country VALUES ('IT', 'Italy', 'ITA', 'ITALY', 380, 39);
INSERT INTO public.country VALUES ('JM', 'Jamaica', 'JAM', 'JAMAICA', 388, 1876);
INSERT INTO public.country VALUES ('JP', 'Japan', 'JPN', 'JAPAN', 392, 81);
INSERT INTO public.country VALUES ('JO', 'Jordan', 'JOR', 'JORDAN', 400, 962);
INSERT INTO public.country VALUES ('KZ', 'Kazakhstan', 'KAZ', 'KAZAKHSTAN', 398, 7);
INSERT INTO public.country VALUES ('KE', 'Kenya', 'KEN', 'KENYA', 404, 254);
INSERT INTO public.country VALUES ('KI', 'Kiribati', 'KIR', 'KIRIBATI', 296, 686);
INSERT INTO public.country VALUES ('KP', 'Korea, Democratic People''s Republic of', 'PRK', 'KOREA, DEMOCRATIC PEOPLE''S REPUBLIC OF', 408, 850);
INSERT INTO public.country VALUES ('KR', 'Korea, Republic of', 'KOR', 'KOREA, REPUBLIC OF', 410, 82);
INSERT INTO public.country VALUES ('KW', 'Kuwait', 'KWT', 'KUWAIT', 414, 965);
INSERT INTO public.country VALUES ('KG', 'Kyrgyzstan', 'KGZ', 'KYRGYZSTAN', 417, 996);
INSERT INTO public.country VALUES ('ME', 'Montenegro', 'MNE', 'MONTENEGRO', 499, 382);
INSERT INTO public.country VALUES ('BV', 'Bouvet Island', 'BVT', 'BOUVET ISLAND', 74, 55);
INSERT INTO public.country VALUES ('HM', 'Heard Island and Mcdonald Islands', 'HMD', 'HEARD ISLAND AND MCDONALD ISLANDS', 334, 672);
INSERT INTO public.country VALUES ('LA', 'Lao People''s Democratic Republic', 'LAO', 'LAO PEOPLE''S DEMOCRATIC REPUBLIC', 418, 856);
INSERT INTO public.country VALUES ('LV', 'Latvia', 'LVA', 'LATVIA', 428, 371);
INSERT INTO public.country VALUES ('LB', 'Lebanon', 'LBN', 'LEBANON', 422, 961);
INSERT INTO public.country VALUES ('LS', 'Lesotho', 'LSO', 'LESOTHO', 426, 266);
INSERT INTO public.country VALUES ('LR', 'Liberia', 'LBR', 'LIBERIA', 430, 231);
INSERT INTO public.country VALUES ('LY', 'Libyan Arab Jamahiriya', 'LBY', 'LIBYAN ARAB JAMAHIRIYA', 434, 218);
INSERT INTO public.country VALUES ('LI', 'Liechtenstein', 'LIE', 'LIECHTENSTEIN', 438, 423);
INSERT INTO public.country VALUES ('LT', 'Lithuania', 'LTU', 'LITHUANIA', 440, 370);
INSERT INTO public.country VALUES ('LU', 'Luxembourg', 'LUX', 'LUXEMBOURG', 442, 352);
INSERT INTO public.country VALUES ('MO', 'Macao', 'MAC', 'MACAO', 446, 853);
INSERT INTO public.country VALUES ('MK', 'Macedonia, the Former Yugoslav Republic of', 'MKD', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 807, 389);
INSERT INTO public.country VALUES ('MG', 'Madagascar', 'MDG', 'MADAGASCAR', 450, 261);
INSERT INTO public.country VALUES ('MW', 'Malawi', 'MWI', 'MALAWI', 454, 265);
INSERT INTO public.country VALUES ('MY', 'Malaysia', 'MYS', 'MALAYSIA', 458, 60);
INSERT INTO public.country VALUES ('MV', 'Maldives', 'MDV', 'MALDIVES', 462, 960);
INSERT INTO public.country VALUES ('ML', 'Mali', 'MLI', 'MALI', 466, 223);
INSERT INTO public.country VALUES ('MT', 'Malta', 'MLT', 'MALTA', 470, 356);
INSERT INTO public.country VALUES ('MH', 'Marshall Islands', 'MHL', 'MARSHALL ISLANDS', 584, 692);
INSERT INTO public.country VALUES ('MQ', 'Martinique', 'MTQ', 'MARTINIQUE', 474, 596);
INSERT INTO public.country VALUES ('MR', 'Mauritania', 'MRT', 'MAURITANIA', 478, 222);
INSERT INTO public.country VALUES ('MU', 'Mauritius', 'MUS', 'MAURITIUS', 480, 230);
INSERT INTO public.country VALUES ('MX', 'Mexico', 'MEX', 'MEXICO', 484, 52);
INSERT INTO public.country VALUES ('FM', 'Micronesia, Federated States of', 'FSM', 'MICRONESIA, FEDERATED STATES OF', 583, 691);
INSERT INTO public.country VALUES ('MD', 'Moldova, Republic of', 'MDA', 'MOLDOVA, REPUBLIC OF', 498, 373);
INSERT INTO public.country VALUES ('MC', 'Monaco', 'MCO', 'MONACO', 492, 377);
INSERT INTO public.country VALUES ('MN', 'Mongolia', 'MNG', 'MONGOLIA', 496, 976);
INSERT INTO public.country VALUES ('MS', 'Montserrat', 'MSR', 'MONTSERRAT', 500, 1664);
INSERT INTO public.country VALUES ('MA', 'Morocco', 'MAR', 'MOROCCO', 504, 212);
INSERT INTO public.country VALUES ('MZ', 'Mozambique', 'MOZ', 'MOZAMBIQUE', 508, 258);
INSERT INTO public.country VALUES ('MM', 'Myanmar', 'MMR', 'MYANMAR', 104, 95);
INSERT INTO public.country VALUES ('NA', 'Namibia', 'NAM', 'NAMIBIA', 516, 264);
INSERT INTO public.country VALUES ('NR', 'Nauru', 'NRU', 'NAURU', 520, 674);
INSERT INTO public.country VALUES ('NP', 'Nepal', 'NPL', 'NEPAL', 524, 977);
INSERT INTO public.country VALUES ('NL', 'Netherlands', 'NLD', 'NETHERLANDS', 528, 31);
INSERT INTO public.country VALUES ('NC', 'New Caledonia', 'NCL', 'NEW CALEDONIA', 540, 687);
INSERT INTO public.country VALUES ('NZ', 'New Zealand', 'NZL', 'NEW ZEALAND', 554, 64);
INSERT INTO public.country VALUES ('NI', 'Nicaragua', 'NIC', 'NICARAGUA', 558, 505);
INSERT INTO public.country VALUES ('NE', 'Niger', 'NER', 'NIGER', 562, 227);
INSERT INTO public.country VALUES ('NG', 'Nigeria', 'NGA', 'NIGERIA', 566, 234);
INSERT INTO public.country VALUES ('NU', 'Niue', 'NIU', 'NIUE', 570, 683);
INSERT INTO public.country VALUES ('NF', 'Norfolk Island', 'NFK', 'NORFOLK ISLAND', 574, 672);
INSERT INTO public.country VALUES ('MP', 'Northern Mariana Islands', 'MNP', 'NORTHERN MARIANA ISLANDS', 580, 1670);
INSERT INTO public.country VALUES ('NO', 'Norway', 'NOR', 'NORWAY', 578, 47);
INSERT INTO public.country VALUES ('OM', 'Oman', 'OMN', 'OMAN', 512, 968);
INSERT INTO public.country VALUES ('PK', 'Pakistan', 'PAK', 'PAKISTAN', 586, 92);
INSERT INTO public.country VALUES ('PW', 'Palau', 'PLW', 'PALAU', 585, 680);
INSERT INTO public.country VALUES ('PA', 'Panama', 'PAN', 'PANAMA', 591, 507);
INSERT INTO public.country VALUES ('PG', 'Papua New Guinea', 'PNG', 'PAPUA NEW GUINEA', 598, 675);
INSERT INTO public.country VALUES ('PY', 'Paraguay', 'PRY', 'PARAGUAY', 600, 595);
INSERT INTO public.country VALUES ('PE', 'Peru', 'PER', 'PERU', 604, 51);
INSERT INTO public.country VALUES ('PH', 'Philippines', 'PHL', 'PHILIPPINES', 608, 63);
INSERT INTO public.country VALUES ('PL', 'Poland', 'POL', 'POLAND', 616, 48);
INSERT INTO public.country VALUES ('PT', 'Portugal', 'PRT', 'PORTUGAL', 620, 351);
INSERT INTO public.country VALUES ('PR', 'Puerto Rico', 'PRI', 'PUERTO RICO', 630, 1787);
INSERT INTO public.country VALUES ('QA', 'Qatar', 'QAT', 'QATAR', 634, 974);
INSERT INTO public.country VALUES ('RE', 'Reunion', 'REU', 'REUNION', 638, 262);
INSERT INTO public.country VALUES ('RO', 'Romania', 'ROM', 'ROMANIA', 642, 40);
INSERT INTO public.country VALUES ('RU', 'Russian Federation', 'RUS', 'RUSSIAN FEDERATION', 643, 70);
INSERT INTO public.country VALUES ('RW', 'Rwanda', 'RWA', 'RWANDA', 646, 250);
INSERT INTO public.country VALUES ('SH', 'Saint Helena', 'SHN', 'SAINT HELENA', 654, 290);
INSERT INTO public.country VALUES ('KN', 'Saint Kitts and Nevis', 'KNA', 'SAINT KITTS AND NEVIS', 659, 1869);
INSERT INTO public.country VALUES ('LC', 'Saint Lucia', 'LCA', 'SAINT LUCIA', 662, 1758);
INSERT INTO public.country VALUES ('PM', 'Saint Pierre and Miquelon', 'SPM', 'SAINT PIERRE AND MIQUELON', 666, 508);
INSERT INTO public.country VALUES ('VC', 'Saint Vincent and the Grenadines', 'VCT', 'SAINT VINCENT AND THE GRENADINES', 670, 1784);
INSERT INTO public.country VALUES ('WS', 'Samoa', 'WSM', 'SAMOA', 882, 684);
INSERT INTO public.country VALUES ('SM', 'San Marino', 'SMR', 'SAN MARINO', 674, 378);
INSERT INTO public.country VALUES ('ST', 'Sao Tome and Principe', 'STP', 'SAO TOME AND PRINCIPE', 678, 239);
INSERT INTO public.country VALUES ('SA', 'Saudi Arabia', 'SAU', 'SAUDI ARABIA', 682, 966);
INSERT INTO public.country VALUES ('SN', 'Senegal', 'SEN', 'SENEGAL', 686, 221);
INSERT INTO public.country VALUES ('YT', 'Mayotte', 'MYT', 'MAYOTTE', 175, 269);
INSERT INTO public.country VALUES ('SC', 'Seychelles', 'SYC', 'SEYCHELLES', 690, 248);
INSERT INTO public.country VALUES ('SL', 'Sierra Leone', 'SLE', 'SIERRA LEONE', 694, 232);
INSERT INTO public.country VALUES ('SG', 'Singapore', 'SGP', 'SINGAPORE', 702, 65);
INSERT INTO public.country VALUES ('SK', 'Slovakia', 'SVK', 'SLOVAKIA', 703, 421);
INSERT INTO public.country VALUES ('SI', 'Slovenia', 'SVN', 'SLOVENIA', 705, 386);
INSERT INTO public.country VALUES ('SB', 'Solomon Islands', 'SLB', 'SOLOMON ISLANDS', 90, 677);
INSERT INTO public.country VALUES ('SO', 'Somalia', 'SOM', 'SOMALIA', 706, 252);
INSERT INTO public.country VALUES ('ZA', 'South Africa', 'ZAF', 'SOUTH AFRICA', 710, 27);
INSERT INTO public.country VALUES ('ES', 'Spain', 'ESP', 'SPAIN', 724, 34);
INSERT INTO public.country VALUES ('LK', 'Sri Lanka', 'LKA', 'SRI LANKA', 144, 94);
INSERT INTO public.country VALUES ('SD', 'Sudan', 'SDN', 'SUDAN', 736, 249);
INSERT INTO public.country VALUES ('SR', 'Suriname', 'SUR', 'SURINAME', 740, 597);
INSERT INTO public.country VALUES ('SJ', 'Svalbard and Jan Mayen', 'SJM', 'SVALBARD AND JAN MAYEN', 744, 47);
INSERT INTO public.country VALUES ('SZ', 'Swaziland', 'SWZ', 'SWAZILAND', 748, 268);
INSERT INTO public.country VALUES ('SE', 'Sweden', 'SWE', 'SWEDEN', 752, 46);
INSERT INTO public.country VALUES ('CH', 'Switzerland', 'CHE', 'SWITZERLAND', 756, 41);
INSERT INTO public.country VALUES ('SY', 'Syrian Arab Republic', 'SYR', 'SYRIAN ARAB REPUBLIC', 760, 963);
INSERT INTO public.country VALUES ('TW', 'Taiwan, Province of China', 'TWN', 'TAIWAN, PROVINCE OF CHINA', 158, 886);
INSERT INTO public.country VALUES ('TJ', 'Tajikistan', 'TJK', 'TAJIKISTAN', 762, 992);
INSERT INTO public.country VALUES ('TZ', 'Tanzania, United Republic of', 'TZA', 'TANZANIA, UNITED REPUBLIC OF', 834, 255);
INSERT INTO public.country VALUES ('TH', 'Thailand', 'THA', 'THAILAND', 764, 66);
INSERT INTO public.country VALUES ('TG', 'Togo', 'TGO', 'TOGO', 768, 228);
INSERT INTO public.country VALUES ('TK', 'Tokelau', 'TKL', 'TOKELAU', 772, 690);
INSERT INTO public.country VALUES ('TO', 'Tonga', 'TON', 'TONGA', 776, 676);
INSERT INTO public.country VALUES ('TT', 'Trinidad and Tobago', 'TTO', 'TRINIDAD AND TOBAGO', 780, 1868);
INSERT INTO public.country VALUES ('TN', 'Tunisia', 'TUN', 'TUNISIA', 788, 216);
INSERT INTO public.country VALUES ('TR', 'Turkey', 'TUR', 'TURKEY', 792, 90);
INSERT INTO public.country VALUES ('TM', 'Turkmenistan', 'TKM', 'TURKMENISTAN', 795, 7370);
INSERT INTO public.country VALUES ('TC', 'Turks and Caicos Islands', 'TCA', 'TURKS AND CAICOS ISLANDS', 796, 1649);
INSERT INTO public.country VALUES ('TV', 'Tuvalu', 'TUV', 'TUVALU', 798, 688);
INSERT INTO public.country VALUES ('UG', 'Uganda', 'UGA', 'UGANDA', 800, 256);
INSERT INTO public.country VALUES ('UA', 'Ukraine', 'UKR', 'UKRAINE', 804, 380);
INSERT INTO public.country VALUES ('AE', 'United Arab Emirates', 'ARE', 'UNITED ARAB EMIRATES', 784, 971);
INSERT INTO public.country VALUES ('GB', 'United Kingdom', 'GBR', 'UNITED KINGDOM', 826, 44);
INSERT INTO public.country VALUES ('US', 'United States', 'USA', 'UNITED STATES', 840, 1);
INSERT INTO public.country VALUES ('UY', 'Uruguay', 'URY', 'URUGUAY', 858, 598);
INSERT INTO public.country VALUES ('UZ', 'Uzbekistan', 'UZB', 'UZBEKISTAN', 860, 998);
INSERT INTO public.country VALUES ('VU', 'Vanuatu', 'VUT', 'VANUATU', 548, 678);
INSERT INTO public.country VALUES ('VE', 'Venezuela', 'VEN', 'VENEZUELA', 862, 58);
INSERT INTO public.country VALUES ('VN', 'Viet Nam', 'VNM', 'VIET NAM', 704, 84);
INSERT INTO public.country VALUES ('VG', 'Virgin Islands, British', 'VGB', 'VIRGIN ISLANDS, BRITISH', 92, 1284);
INSERT INTO public.country VALUES ('PN', 'Pitcairn', 'PCN', 'PITCAIRN', 612, 64);
INSERT INTO public.country VALUES ('VI', 'Virgin Islands, U.s.', 'VIR', 'VIRGIN ISLANDS, U.S.', 850, 1340);
INSERT INTO public.country VALUES ('WF', 'Wallis and Futuna', 'WLF', 'WALLIS AND FUTUNA', 876, 681);
INSERT INTO public.country VALUES ('EH', 'Western Sahara', 'ESH', 'WESTERN SAHARA', 732, 212);
INSERT INTO public.country VALUES ('YE', 'Yemen', 'YEM', 'YEMEN', 887, 967);
INSERT INTO public.country VALUES ('ZM', 'Zambia', 'ZMB', 'ZAMBIA', 894, 260);
INSERT INTO public.country VALUES ('ZW', 'Zimbabwe', 'ZWE', 'ZIMBABWE', 716, 263);
INSERT INTO public.country VALUES ('TL', 'Timor-Leste', 'TLS', 'TIMOR-LESTE', 626, 670);
INSERT INTO public.country VALUES ('AQ', 'Antarctica', 'ATA', 'ANTARCTICA', 10, 672);
INSERT INTO public.country VALUES ('TF', 'French Southern Territories', 'ATF', 'FRENCH SOUTHERN TERRITORIES', 260, 262);
INSERT INTO public.country VALUES ('RS', 'Serbia', 'SRB', 'SERBIA', 688, 381);
INSERT INTO public.country VALUES ('GS', 'South Georgia and the South Sandwich Islands', 'SGS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 239, 500);
INSERT INTO public.country VALUES ('UM', 'United States Minor Outlying Islands', 'UMI', 'UNITED STATES MINOR OUTLYING ISLANDS', 581, 246);
INSERT INTO public.country VALUES ('SX', 'Sint Maarten', 'SXM', 'SINT MAARTEN', 534, 590);


--
-- TOC entry 3429 (class 0 OID 17527)
-- Dependencies: 250
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.language VALUES ('mh', 'Marshallese', 'Kajin Majel', 'mah', NULL);
INSERT INTO public.language VALUES ('mn', 'Mongolian', 'Монгол хэл', 'mon', NULL);
INSERT INTO public.language VALUES ('na', 'Nauru', 'Dorerin Naoero', 'nau', NULL);
INSERT INTO public.language VALUES ('nr', 'South Ndebele', 'isiNdebele', 'nbl', NULL);
INSERT INTO public.language VALUES ('nn', 'Norwegian Nynorsk', 'Norsk nynorsk', 'nno', NULL);
INSERT INTO public.language VALUES ('om', 'Oromo', 'Afaan Oromoo', 'orm', NULL);
INSERT INTO public.language VALUES ('oc', 'Occitan', 'occitan, lenga d''òc', 'oci', NULL);
INSERT INTO public.language VALUES ('os', 'Ossetian / Ossetic', 'ирон ӕвзаг', 'oss', NULL);
INSERT INTO public.language VALUES ('pl', 'Polish', 'język polski, polszczyzna', 'pol', NULL);
INSERT INTO public.language VALUES ('qu', 'Quechua', 'Runa Simi, Kichwa', 'que', NULL);
INSERT INTO public.language VALUES ('ps', 'Pashto / Pushto', 'پښتو', 'pus', NULL);
INSERT INTO public.language VALUES ('rm', 'Romansh', 'Rumantsch Grischun', 'roh', NULL);
INSERT INTO public.language VALUES ('rn', 'Rundi', 'Ikirundi', 'run', NULL);
INSERT INTO public.language VALUES ('sm', 'Samoan', 'gagana fa''a Samoa', 'smo', NULL);
INSERT INTO public.language VALUES ('sg', 'Sango', 'yângâ tî sängö', 'sag', NULL);
INSERT INTO public.language VALUES ('sr', 'Serbian', 'српски језик', 'srp', NULL);
INSERT INTO public.language VALUES ('sl', 'Slovenian', 'Slovenski jezik, Slovenščina', 'slv', NULL);
INSERT INTO public.language VALUES ('tl', 'Tagalog', 'Wikang Tagalog', 'tgl', NULL);
INSERT INTO public.language VALUES ('ty', 'Tahitian', 'Reo Tahiti', 'tah', NULL);
INSERT INTO public.language VALUES ('tt', 'Tatar', 'татар теле, tatar tele', 'tat', NULL);
INSERT INTO public.language VALUES ('bo', 'Tibetan', 'བོད་ཡིག', 'tib', NULL);
INSERT INTO public.language VALUES ('fy', 'Western Frisian', 'Frysk', 'fry', NULL);
INSERT INTO public.language VALUES ('eo', 'Esperanto', 'Esperanto', 'epo', NULL);
INSERT INTO public.language VALUES ('cv', 'Chuvash', 'Чăваш чӗлхи', 'chv', NULL);
INSERT INTO public.language VALUES ('aa', 'Afar', 'Afar', 'aar', NULL);
INSERT INTO public.language VALUES ('av', 'Avaric', 'авар мацӀ, магӀарул мацӀ', 'ava', NULL);
INSERT INTO public.language VALUES ('af', 'Afrikaans', 'Afrikaans', 'afr', NULL);
INSERT INTO public.language VALUES ('ts', 'Tsonga', 'Xitsonga', 'tso', NULL);
INSERT INTO public.language VALUES ('as', 'Assamese', 'অসমীয়া', 'asm', NULL);
INSERT INTO public.language VALUES ('ig', 'Igbo', 'Asụsụ Igbo', 'ibo', NULL);
INSERT INTO public.language VALUES ('ae', 'Avestan', 'Avestan', 'ave', NULL);
INSERT INTO public.language VALUES ('tn', 'Tswana', 'Setswana', 'tsn', NULL);
INSERT INTO public.language VALUES ('ti', 'Tigrinya', 'ትግርኛ', 'tir', NULL);
INSERT INTO public.language VALUES ('ta', 'Tamil', 'தமிழ்', 'tam', NULL);
INSERT INTO public.language VALUES ('sv', 'Swedish', 'Svenska', 'swe', NULL);
INSERT INTO public.language VALUES ('ss', 'Swati', 'SiSwati', 'ssw', NULL);
INSERT INTO public.language VALUES ('sc', 'Sardinian', 'Sardu', 'srd', NULL);
INSERT INTO public.language VALUES ('st', 'Southern Sotho', 'Sesotho', 'sot', NULL);
INSERT INTO public.language VALUES ('sn', 'Shona', 'chiShona', 'sna', NULL);
INSERT INTO public.language VALUES ('sd', 'Sindhi', 'सिनधि', 'snd', NULL);
INSERT INTO public.language VALUES ('sk', 'Slovak', 'Slovenčina', 'slo', NULL);
INSERT INTO public.language VALUES ('si', 'Sinhalese', 'සිංහල', 'sin', NULL);
INSERT INTO public.language VALUES ('ru', 'Russian', 'Русский', 'rus', NULL);
INSERT INTO public.language VALUES ('fa', 'Persian', 'فارسی', 'per', NULL);
INSERT INTO public.language VALUES ('pt', 'Portuguese', 'Português', 'por', NULL);
INSERT INTO public.language VALUES ('es', 'Spanish / Castilian', 'Español', 'spa', NULL);
INSERT INTO public.language VALUES ('no', 'Norwegian', 'Norsk', 'nor', NULL);
INSERT INTO public.language VALUES ('zh', 'Chinese', '中文 (Zhōngwén), 汉语, 漢語', 'chi', NULL);
INSERT INTO public.language VALUES ('or', 'Oriya', 'ଓଡ଼ିଆ', 'ori', NULL);
INSERT INTO public.language VALUES ('ne', 'Nepali', 'नेपाली', 'nep', NULL);
INSERT INTO public.language VALUES ('ng', 'Ndonga', 'Oshiwambo', 'ndo', NULL);
INSERT INTO public.language VALUES ('nv', 'Navajo / Navaho', 'Diné bizaad', 'nav', NULL);
INSERT INTO public.language VALUES ('mi', 'Maori', 'te reo Māori', 'mao', NULL);
INSERT INTO public.language VALUES ('mr', 'Marathi', 'मराठी', 'mar', NULL);
INSERT INTO public.language VALUES ('mt', 'Maltese', 'Malti', 'mlt', NULL);
INSERT INTO public.language VALUES ('lg', 'Ganda', 'Luganda', 'lug', NULL);
INSERT INTO public.language VALUES ('lb', 'Luxembourgish / Letzeburgesch', 'Lëtzebuergesch', 'ltz', NULL);
INSERT INTO public.language VALUES ('ln', 'Lingala', 'Lingála', 'lin', NULL);
INSERT INTO public.language VALUES ('lv', 'Latvian', 'Latviešu', 'lav', NULL);
INSERT INTO public.language VALUES ('li', 'Limburgan / Limburger / Limburgish', 'Limburgs', 'lim', NULL);
INSERT INTO public.language VALUES ('mk', 'Macedonian', 'македонски јазик', 'mac', NULL);
INSERT INTO public.language VALUES ('la', 'Latin', 'Latina', 'lat', NULL);
INSERT INTO public.language VALUES ('kg', 'Kongo', 'KiKongo', 'kon', NULL);
INSERT INTO public.language VALUES ('ko', 'Korean', '한국어', 'kor', NULL);
INSERT INTO public.language VALUES ('lo', 'Lao', 'ພາສາລາວ', 'lao', NULL);
INSERT INTO public.language VALUES ('ky', 'Kirghiz / Kyrgyz', 'Kırgızca / Кыргызча', 'kir', NULL);
INSERT INTO public.language VALUES ('ki', 'Kikuyu / Gikuyu', 'Gĩkũyũ', 'kik', NULL);
INSERT INTO public.language VALUES ('ks', 'Kashmiri', 'कश्मीरी / كشميري', 'kas', NULL);
INSERT INTO public.language VALUES ('kr', 'Kanuri', 'Kanuri', 'kau', NULL);
INSERT INTO public.language VALUES ('kv', 'Komi', 'коми кыв', 'kom', NULL);
INSERT INTO public.language VALUES ('it', 'Italian', 'Italiano', 'ita', NULL);
INSERT INTO public.language VALUES ('kl', 'Kalaallisut / Greenlandic', 'kalaallisut, kalaallit oqaasii', 'kal', NULL);
INSERT INTO public.language VALUES ('kk', 'Kazakh', 'қазақ тілі', 'kaz', NULL);
INSERT INTO public.language VALUES ('kn', 'Kannada', 'ಕನ್ನಡ', 'kan', NULL);
INSERT INTO public.language VALUES ('ie', 'Interlingue / Occidental', 'Interlingue', 'ile', NULL);
INSERT INTO public.language VALUES ('iu', 'Inuktitut', 'ᐃᓄᒃᑎᑐᑦ', 'iku', NULL);
INSERT INTO public.language VALUES ('ii', 'Sichuan Yi / Nuosu', 'ꆇꉙ / 四川彝语', 'iii', NULL);
INSERT INTO public.language VALUES ('ny', 'Chichewa / Chewa / Nyanja', 'ChiCheŵa, chinyanja', 'nya', NULL);
INSERT INTO public.language VALUES ('io', 'Ido', 'Ido', 'ido', NULL);
INSERT INTO public.language VALUES ('is', 'Icelandic', 'Íslenska', 'ice', NULL);
INSERT INTO public.language VALUES ('nl', 'Dutch / Flemish', 'Nederlands, Vlaams', 'dut', NULL);
INSERT INTO public.language VALUES ('hu', 'Hungarian', 'Magyar', 'hun', NULL);
INSERT INTO public.language VALUES ('he', 'Hebrew', 'עברית', 'heb', NULL);
INSERT INTO public.language VALUES ('hz', 'Herero', 'Otsiherero', 'her', NULL);
INSERT INTO public.language VALUES ('ho', 'Hiri Motu', 'Hiri Motu', 'hmo', NULL);
INSERT INTO public.language VALUES ('ht', 'Haitian / Haitian Creole', 'Krèyol ayisyen', 'hat', NULL);
INSERT INTO public.language VALUES ('ha', 'Hausa', 'هَوُسَ', 'hau', NULL);
INSERT INTO public.language VALUES ('ka', 'Georgian', 'ქართული', 'geo', NULL);
INSERT INTO public.language VALUES ('gd', 'Scottish Gaelic / Gaelic', 'Gàidhlig', 'gla', NULL);
INSERT INTO public.language VALUES ('ga', 'Irish', 'Gaeilge', 'gle', NULL);
INSERT INTO public.language VALUES ('gl', 'Galician', 'Galego', 'glg', NULL);
INSERT INTO public.language VALUES ('gn', 'Guarani', 'Avañe''ẽ', 'grn', NULL);
INSERT INTO public.language VALUES ('hi', 'Hindi', 'हिन्दी, हिंदी', 'hin', NULL);
INSERT INTO public.language VALUES ('fi', 'Finnish', 'Suomi', 'fin', NULL);
INSERT INTO public.language VALUES ('fr', 'French', 'Français', 'fre', NULL);
INSERT INTO public.language VALUES ('fo', 'Faroese', 'Føroyskt', 'fao', NULL);
INSERT INTO public.language VALUES ('ff', 'Fulah', 'Fulfulde, Pulaar, Pular', 'ful', NULL);
INSERT INTO public.language VALUES ('et', 'Estonian', 'Eesti', 'est', NULL);
INSERT INTO public.language VALUES ('ee', 'Ewe', 'Eʋegbe', 'ewe', NULL);
INSERT INTO public.language VALUES ('cs', 'Czech', 'Česky', 'cze', NULL);
INSERT INTO public.language VALUES ('da', 'Danish', 'Dansk', 'dan', NULL);
INSERT INTO public.language VALUES ('co', 'Corsican', 'Corsu', 'cos', NULL);
INSERT INTO public.language VALUES ('kw', 'Cornish', 'Kernewek', 'cor', NULL);
INSERT INTO public.language VALUES ('cr', 'Cree', 'Nehiyaw, 	ᓀᐦᐃᔭᐍᐏᐣ', 'cre', NULL);
INSERT INTO public.language VALUES ('ce', 'Chechen', 'Нохчийн мотт', 'che', NULL);
INSERT INTO public.language VALUES ('my', 'Burmese', 'မြန်မာစာ', 'bur', NULL);
INSERT INTO public.language VALUES ('ba', 'Bashkir', 'Башҡорт', 'bak', NULL);
INSERT INTO public.language VALUES ('eu', 'Basque', 'Euskara', 'baq', NULL);
INSERT INTO public.language VALUES ('bg', 'Bulgarian', 'Български език', 'bul', NULL);
INSERT INTO public.language VALUES ('bi', 'Bislama', 'Bislama', 'bis', NULL);
INSERT INTO public.language VALUES ('bs', 'Bosnian', 'Bosanski', 'bos', NULL);
INSERT INTO public.language VALUES ('ay', 'Aymara', 'Aymar', 'aym', NULL);
INSERT INTO public.language VALUES ('be', 'Belarusian', 'Беларуская мова', 'bel', NULL);
INSERT INTO public.language VALUES ('hy', 'Armenian', 'Հայերեն', 'arm', NULL);
INSERT INTO public.language VALUES ('ar', 'Arabic', 'العربية', 'ara', NULL);
INSERT INTO public.language VALUES ('am', 'Amharic', 'አማርኛ', 'amh', NULL);
INSERT INTO public.language VALUES ('sq', 'Albanian', 'Shqip', 'alb', NULL);
INSERT INTO public.language VALUES ('vi', 'Vietnamese', 'Tiếng Việt', 'vie', NULL);
INSERT INTO public.language VALUES ('en', 'English', 'English', 'eng', NULL);
INSERT INTO public.language VALUES ('zu', 'Zulu', 'isiZulu', 'zul', NULL);
INSERT INTO public.language VALUES ('nd', 'North Ndebele', 'isiNdebele', 'nde', NULL);
INSERT INTO public.language VALUES ('yo', 'Yoruba', 'Yorùbá', 'yor', NULL);
INSERT INTO public.language VALUES ('yi', 'Yiddish', 'ייִדיש', 'yid', NULL);
INSERT INTO public.language VALUES ('xh', 'Xhosa', 'isiXhosa', 'xho', NULL);
INSERT INTO public.language VALUES ('wo', 'Wolof', 'Wollof', 'wol', NULL);
INSERT INTO public.language VALUES ('vo', 'Volapük', 'Volapük', 'vol', NULL);
INSERT INTO public.language VALUES ('wa', 'Walloon', 'Walon', 'wln', NULL);
INSERT INTO public.language VALUES ('ak', 'Akan', 'Akana', 'aka', NULL);
INSERT INTO public.language VALUES ('bh', 'Bihari languages', 'भोजपुरी', 'bih', NULL);
INSERT INTO public.language VALUES ('ug', 'Uyghur', 'Uyƣurqə / ئۇيغۇرچە', 'uig', NULL);
INSERT INTO public.language VALUES ('uk', 'Ukrainian', 'Українська', 'ukr', NULL);
INSERT INTO public.language VALUES ('ur', 'Urdu', 'اردو', 'urd', NULL);
INSERT INTO public.language VALUES ('uz', 'Uzbek', 'Ўзбек', 'uzb', NULL);
INSERT INTO public.language VALUES ('ve', 'Venda', 'Tshivenḓa', 'ven', NULL);
INSERT INTO public.language VALUES ('cy', 'Welsh', 'Cymraeg', 'wel', NULL);
INSERT INTO public.language VALUES ('tr', 'Turkish', 'Türkçe', 'tur', NULL);
INSERT INTO public.language VALUES ('tw', 'Twi', 'Twi', 'twi', NULL);
INSERT INTO public.language VALUES ('tk', 'Turkmen', 'Туркмен / تركمن', 'tuk', NULL);
INSERT INTO public.language VALUES ('to', 'Tonga (Tonga Islands)', 'Lea Faka-Tonga', 'ton', NULL);
INSERT INTO public.language VALUES ('th', 'Thai', 'ไทย / Phasa Thai', 'tha', NULL);
INSERT INTO public.language VALUES ('te', 'Telugu', 'తెలుగు', 'tel', NULL);
INSERT INTO public.language VALUES ('sw', 'Swahili', 'Kiswahili', 'swa', NULL);
INSERT INTO public.language VALUES ('su', 'Sundanese', 'Basa Sunda', 'sun', NULL);
INSERT INTO public.language VALUES ('sa', 'Sanskrit', 'संस्कृतम्', 'san', NULL);
INSERT INTO public.language VALUES ('pi', 'Pali', 'Pāli / पाऴि', 'pli', NULL);
INSERT INTO public.language VALUES ('se', 'Northern Sami', 'Davvisámegiella', 'sme', NULL);
INSERT INTO public.language VALUES ('el', 'Greek', 'Ελληνικά', 'gre', NULL);
INSERT INTO public.language VALUES ('za', 'Zhuang / Chuang', 'Cuengh / Tôô / 壮语', 'zha', NULL);
INSERT INTO public.language VALUES ('ro', 'Romanian / Moldavian / Moldovan', 'Română', 'rum', NULL);
INSERT INTO public.language VALUES ('ml', 'Malayalam', 'മലയാളം', 'mal', NULL);
INSERT INTO public.language VALUES ('ku', 'Kurdish', 'Kurdî / كوردی', 'kur', NULL);
INSERT INTO public.language VALUES ('kj', 'Kuanyama / Kwanyama', 'Kuanyama', 'kua', NULL);
INSERT INTO public.language VALUES ('oj', 'Ojibwa', 'ᐊᓂᔑᓈᐯᒧᐎᓐ', 'oji', NULL);
INSERT INTO public.language VALUES ('id', 'Indonesian', 'Bahasa Indonesia', 'ind', NULL);
INSERT INTO public.language VALUES ('ia', 'Interlingua', 'Interlingua', 'ina', NULL);
INSERT INTO public.language VALUES ('de', 'German', 'Deutsch', 'ger', NULL);
INSERT INTO public.language VALUES ('gu', 'Gujarati', 'ગુજરાતી', 'guj', NULL);
INSERT INTO public.language VALUES ('dz', 'Dzongkha', 'ཇོང་ཁ', 'dzo', NULL);
INSERT INTO public.language VALUES ('dv', 'Divehi / Dhivehi / Maldivian', 'ދިވެހިބަސް', 'div', NULL);
INSERT INTO public.language VALUES ('ch', 'Chamorro', 'Chamoru', 'cha', NULL);
INSERT INTO public.language VALUES ('br', 'Breton', 'Brezhoneg', 'bre', NULL);
INSERT INTO public.language VALUES ('bm', 'Bambara', 'Bamanankan', 'bam', NULL);
INSERT INTO public.language VALUES ('bn', 'Bengali', 'বাংলা', 'ben', NULL);
INSERT INTO public.language VALUES ('az', 'Azerbaijani', 'Azərbaycanca / آذربايجان', 'aze', NULL);
INSERT INTO public.language VALUES ('an', 'Aragonese', 'Aragonés', 'arg', NULL);
INSERT INTO public.language VALUES ('ab', 'Abkhazian', 'аҧсуа бызшәа, аҧсшәа', 'abk', NULL);
INSERT INTO public.language VALUES ('nb', 'Norwegian Bokmål', 'Norsk bokmål', 'nob', NULL);
INSERT INTO public.language VALUES ('km', 'Central Khmer', 'ខ្មែរ, ខេមរភាសា, ភាសាខ្មែរ', 'khm', NULL);
INSERT INTO public.language VALUES ('ca', 'Catalan / Valencian', 'Català, valencià', 'cat', NULL);
INSERT INTO public.language VALUES ('hr', 'Croatian', 'Hrvatski jezik', 'hrv', NULL);
INSERT INTO public.language VALUES ('fj', 'Fijian', 'Vosa Vakaviti', 'fij', NULL);
INSERT INTO public.language VALUES ('ik', 'Inupiaq', 'Iñupiaq, Iñupiatun', 'ipk', NULL);
INSERT INTO public.language VALUES ('ja', 'Japanese', '日本語 (にほんご)', 'jpn', NULL);
INSERT INTO public.language VALUES ('jv', 'Javanese', 'ꦧꦱꦗꦮ, Basa Jawa', 'jav', NULL);
INSERT INTO public.language VALUES ('rw', 'Kinyarwanda', 'Ikinyarwanda', 'kin', NULL);
INSERT INTO public.language VALUES ('lt', 'Lithuanian', 'lietuvių kalba', 'lit', NULL);
INSERT INTO public.language VALUES ('lu', 'Luba-Katanga', 'Kiluba', 'lub', NULL);
INSERT INTO public.language VALUES ('mg', 'Malagasy', 'fiteny malagasy', 'mlg', NULL);
INSERT INTO public.language VALUES ('ms', 'Malay', 'Bahasa Melayu, بهاس ملايو', 'may', NULL);
INSERT INTO public.language VALUES ('gv', 'Manx', 'Gaelg, Gailck', 'glv', NULL);
INSERT INTO public.language VALUES ('pa', 'Punjabi / Panjabi', 'ਪੰਜਾਬੀ / पंजाबी / پنجابي', 'pan', NULL);
INSERT INTO public.language VALUES ('cu', 'Church Slavic / Old Slavonic / Church Slavonic / Old Bulgarian / Old Church Slavonic', 'ѩзыкъ словѣньскъ', 'chu', NULL);
INSERT INTO public.language VALUES ('so', 'Somali', 'Soomaaliga, af Soomaali', 'som', NULL);
INSERT INTO public.language VALUES ('tg', 'Tajik', 'тоҷикӣ, toçikī, تاجیکی', 'tgk', NULL);


--
-- TOC entry 3436 (class 0 OID 18781)
-- Dependencies: 257
-- Data for Name: media; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.media VALUES ('85d67683-85eb-4565-adc4-db98f47acba6', '/vid/21/12/post85d67683-85eb-4565-adc4-db98f47acba6vid5.mp4', 'video/mp4', '344654d5-95e2-4f88-afa5-4ee83421669e');
INSERT INTO public.media VALUES ('7e64dff5-0fc3-47b3-903b-8511e3e16f24', '/img/21/12/post7e64dff5-0fc3-47b3-903b-8511e3e16f24tính-diem-toeic.jpg', 'image/jpeg', 'b644f2cf-6948-4a2d-97bd-ccff5a313f00');
INSERT INTO public.media VALUES ('f34f799d-4687-4132-9ec1-3b62e2350d0d', '/vid/21/12/postf34f799d-4687-4132-9ec1-3b62e2350d0dvid1.mp4', 'video/mp4', 'ea2d602f-2406-40f2-be21-cb07f316c91c');
INSERT INTO public.media VALUES ('b4f42f9a-e9be-4b6d-ac8c-ba4adce51676', '/vid/21/12/postb4f42f9a-e9be-4b6d-ac8c-ba4adce51676vid2.mp4', 'video/mp4', '19e46661-e44b-410b-a1f7-44d152ad5af9');
INSERT INTO public.media VALUES ('511942ca-d08f-4f69-89de-274dbfab7648', '/vid/21/12/post511942ca-d08f-4f69-89de-274dbfab7648vid3.mp4', 'video/mp4', 'c7ee2be8-cdfa-4d6d-8a4f-7ab358ffa253');
INSERT INTO public.media VALUES ('2ea7ad66-ce3d-4696-aec8-abc105cda965', '/vid/21/12/post2ea7ad66-ce3d-4696-aec8-abc105cda965vid4.mp4', 'video/mp4', '790098eb-d956-4994-a880-486d1cd6e53f');
INSERT INTO public.media VALUES ('001582d8-7526-4e7e-a4c2-6c9b732464e7', '/vid/21/12/post001582d8-7526-4e7e-a4c2-6c9b732464e7vid6.mp4', 'video/mp4', '2165bbc6-8467-45d8-813c-d61e7d9f3c32');
INSERT INTO public.media VALUES ('ac8469bd-9e76-4013-b94b-e0339d2b9af6', '/vid/21/12/postac8469bd-9e76-4013-b94b-e0339d2b9af6vid7.mp4', 'video/mp4', '7fde4d55-55fd-40e4-9441-6107a4592c51');
INSERT INTO public.media VALUES ('be33d6bb-2a52-4cbf-91a7-57ce306ab551', '/vid/21/12/postbe33d6bb-2a52-4cbf-91a7-57ce306ab551vid8.mp4', 'video/mp4', 'e7ea4cb9-bcb1-4d8f-bfb4-9b452b41fc9a');
INSERT INTO public.media VALUES ('1daace7a-82ef-49f3-9e4c-4e0322552f03', '/vid/21/12/post1daace7a-82ef-49f3-9e4c-4e0322552f03vid9.mp4', 'video/mp4', '02718e0b-7615-4cb2-a17c-22589167c312');
INSERT INTO public.media VALUES ('81931605-702c-41e4-a648-afd85049bd71', '/vid/21/12/post81931605-702c-41e4-a648-afd85049bd71vid10.mp4', 'video/mp4', '10c86923-393e-483c-860d-ff425ce58e42');
INSERT INTO public.media VALUES ('7758f0d9-7829-4bc1-9ab0-ca9904f2fb8f', '/img/21/12/post7758f0d9-7829-4bc1-9ab0-ca9904f2fb8fb5cf00e0da2a7e0.jpg', 'image/jpeg', '17f8ca93-d0be-4d0a-8968-1082e793b6ae');
INSERT INTO public.media VALUES ('f14e2aaf-fb23-4c54-825f-a36d814e2af6', '/vid/21/12/postf14e2aaf-fb23-4c54-825f-a36d814e2af6vid3.mp4', 'video/mp4', 'ff8c81a3-d07a-4fbb-ab5e-a9df367978b2');
INSERT INTO public.media VALUES ('33f0dde7-e2fc-4e33-bf58-d3d89520a790', '/vid/21/12/post33f0dde7-e2fc-4e33-bf58-d3d89520a790vid10.mp4', 'video/mp4', '5bb9c225-1b8e-47a8-9f8e-0f8d0d8af243');
INSERT INTO public.media VALUES ('07e14916-8c62-4e98-bafb-c126157e5238', '/vid/21/12/post07e14916-8c62-4e98-bafb-c126157e5238vid3.mp4', 'video/mp4', '912eed81-6379-464d-a974-94606bc6aea5');
INSERT INTO public.media VALUES ('4bf594d7-78be-47c1-8256-bb9841930f7b', '/vid/21/12/post4bf594d7-78be-47c1-8256-bb9841930f7bvid10.mp4', 'video/mp4', '04446624-b423-42bb-baf3-bac115e27b38');
INSERT INTO public.media VALUES ('2671ad87-5c07-4a56-a5e7-187908e49269', '/vid/21/12/post2671ad87-5c07-4a56-a5e7-187908e49269vid9.mp4', 'video/mp4', '31c06452-6802-474b-8204-eed394cf7ad9');
INSERT INTO public.media VALUES ('72ed46e5-1b6a-4fd2-a850-5a74e93b5878', '/vid/22/1/post72ed46e5-1b6a-4fd2-a850-5a74e93b5878vid5.mp4', 'video/mp4', '86c41dc1-4053-4f71-bced-852833331126');
INSERT INTO public.media VALUES ('9e383708-2354-4a01-9410-23ae5f3bfc12', '/vid/22/1/post9e383708-2354-4a01-9410-23ae5f3bfc12vid5.mp4', 'video/mp4', '9d7c6d83-5fb6-4daf-84b1-5c910f5696bf');
INSERT INTO public.media VALUES ('ccd1eb9b-6fdb-45f0-b3db-25a7426574fa', '/vid/22/1/postccd1eb9b-6fdb-45f0-b3db-25a7426574favid2.mp4', 'video/mp4', '33664b22-ad92-4075-b69a-2b6f25a2b5e1');
INSERT INTO public.media VALUES ('665c180b-3a37-43e6-94a5-49336c1e6b49', '/vid/22/1/post665c180b-3a37-43e6-94a5-49336c1e6b49vid3.mp4', 'video/mp4', '29d879bc-5720-4913-91ad-a98aab971674');
INSERT INTO public.media VALUES ('c1858e27-e801-4740-a286-3f74b38dbc21', '/vid/22/1/postc1858e27-e801-4740-a286-3f74b38dbc21vid2.mp4', 'video/mp4', '8ef7deb6-9dd4-4984-8403-b086418266ec');
INSERT INTO public.media VALUES ('4040ff65-2e38-4258-b966-7c68544a339f', '/vid/22/1/post4040ff65-2e38-4258-b966-7c68544a339fvid6.mp4', 'video/mp4', 'e4056ff6-b9af-42b1-84c5-fb53b22eaede');


--
-- TOC entry 3440 (class 0 OID 18981)
-- Dependencies: 261
-- Data for Name: oauth2client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.oauth2client VALUES ('f4aeed53675ee', 604800, true, 'choydy.com', NULL, 2592000, '$2a$10$QjF2gJn8VaT5FCtLbp8O6OPTCa5N8R4ZLgPap5ibE/iOmiMC2oH.u');


--
-- TOC entry 3434 (class 0 OID 18707)
-- Dependencies: 255
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post VALUES ('344654d5-95e2-4f88-afa5-4ee83421669e', 0, 'bcvbvcbcvbc 😀😀😀😀😀', 0, 0, 'bnvbnvbnv', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 5, false, 1640165983652);
INSERT INTO public.post VALUES ('b644f2cf-6948-4a2d-97bd-ccff5a313f00', 0, 'cvbcvbcvbcvbcb😌😌😌😌😌😌', 0, 0, 'bcvbcvbc', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 8, false, 1640418720357);
INSERT INTO public.post VALUES ('ea2d602f-2406-40f2-be21-cb07f316c91c', 0, 'fghfghfghfgh 💋💋💋💋💋', 0, 0, 'hgfhfghfghfg', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 9, false, 1640421838649);
INSERT INTO public.post VALUES ('19e46661-e44b-410b-a1f7-44d152ad5af9', 0, 'nbvnvbnvb 🐍🐍🐍🐍🐍', 0, 0, 'iyuiyu', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 10, false, 1640421862675);
INSERT INTO public.post VALUES ('c7ee2be8-cdfa-4d6d-8a4f-7ab358ffa253', 0, 'fgdfgdfgdf😊😊😊😊😊😊', 0, 0, 'bnfghgfh', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 9, false, 1640422124064);
INSERT INTO public.post VALUES ('790098eb-d956-4994-a880-486d1cd6e53f', 0, 'vbnvbnvbnvb  cvbcvbcvb😔😔😔😔😔😔😔😔😔', 0, 0, 'n bbnmbm', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 2, false, 1640422252082);
INSERT INTO public.post VALUES ('2165bbc6-8467-45d8-813c-d61e7d9f3c32', 0, 'vbnvbnvbnvbnvbnvbnvbnvbnvb', 0, 0, 'bnnvbnvbnvbnvbnvbnv', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 4, false, 1640422278884);
INSERT INTO public.post VALUES ('7fde4d55-55fd-40e4-9441-6107a4592c51', 0, 'bnmbnmbmbnmbnm', 0, 0, 'nbmbnmnmbnm', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 7, false, 1640422297500);
INSERT INTO public.post VALUES ('e7ea4cb9-bcb1-4d8f-bfb4-9b452b41fc9a', 0, 'vbnvbnvnvbnvbnvb😝😝😝😝😝😝😝', 0, 0, 'bnvbnvbn', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 8, false, 1640422343335);
INSERT INTO public.post VALUES ('02718e0b-7615-4cb2-a17c-22589167c312', 0, 'tyutyutyutyutyu📮📮📮📮📮📮📮', 0, 0, 'utyutyutyu', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 9, false, 1640422365022);
INSERT INTO public.post VALUES ('10c86923-393e-483c-860d-ff425ce58e42', 0, 'vfxcvxcvxcvxcvxcvxcvxcv😊😊😊😊😊', 0, 0, 'nrrrrrrrrrrrrrrrrrrrrr', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 3, false, 1640422389612);
INSERT INTO public.post VALUES ('17f8ca93-d0be-4d0a-8968-1082e793b6ae', 0, 'vbnvbnvbnvb 😉😉😉😉😉😉😉😉😉', 0, 0, 'vbnvbnvb', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 4, false, 1640440062008);
INSERT INTO public.post VALUES ('ff8c81a3-d07a-4fbb-ab5e-a9df367978b2', 0, 'xcvxcvxc 🐎🐎🐎🐎🐎🐎', 0, 0, 'xvxcvxcv', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 6, false, 1640513865618);
INSERT INTO public.post VALUES ('5bb9c225-1b8e-47a8-9f8e-0f8d0d8af243', 0, '', 0, 0, 'xcbcvbcvbcv', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 14, false, 1640958160946);
INSERT INTO public.post VALUES ('912eed81-6379-464d-a974-94606bc6aea5', 0, 'cvbcvbcb', 0, 0, 'cvbcvbcvb', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 14, false, 1640958527880);
INSERT INTO public.post VALUES ('31c06452-6802-474b-8204-eed394cf7ad9', 0, '', 0, 0, 'hgjghjghjghj', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 13, false, 1640958913388);
INSERT INTO public.post VALUES ('86c41dc1-4053-4f71-bced-852833331126', 0, 'sadasdasdasd', 0, 0, 'gdfgdf', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 14, false, 1641007246920);
INSERT INTO public.post VALUES ('29d879bc-5720-4913-91ad-a98aab971674', 0, 'zxczxczx', 0, 0, 'zxczxc', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 13, false, 1641111392638);
INSERT INTO public.post VALUES ('33664b22-ad92-4075-b69a-2b6f25a2b5e1', 0, 'ádasdasdasd', 0, 0, 'ádasd', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 9, false, 1641008260658);
INSERT INTO public.post VALUES ('9d7c6d83-5fb6-4daf-84b1-5c910f5696bf', 0, 'fghfghfgh', 0, 0, 'hfghfghf', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 14, false, 1641007303915);
INSERT INTO public.post VALUES ('04446624-b423-42bb-baf3-bac115e27b38', 0, '3132132132132', 0, 0, '331213213232', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 14, false, 1640958715195);
INSERT INTO public.post VALUES ('8ef7deb6-9dd4-4984-8403-b086418266ec', 0, 'ádas', 0, 0, 'ádasxzxzx', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 9, false, 1641112073097);
INSERT INTO public.post VALUES ('e4056ff6-b9af-42b1-84c5-fb53b22eaede', NULL, 'dfgdfgdfg', 0, 0, 'fdgdfg', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 14, false, 1641287314938);


--
-- TOC entry 3441 (class 0 OID 19029)
-- Dependencies: 262
-- Data for Name: postlike; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3439 (class 0 OID 18961)
-- Dependencies: 260
-- Data for Name: posttag; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.posttag VALUES ('ccc', '344654d5-95e2-4f88-afa5-4ee83421669e');
INSERT INTO public.posttag VALUES ('zzzz', '344654d5-95e2-4f88-afa5-4ee83421669e');
INSERT INTO public.posttag VALUES ('vvvv', 'b644f2cf-6948-4a2d-97bd-ccff5a313f00');
INSERT INTO public.posttag VALUES ('ewrwerwe', 'b644f2cf-6948-4a2d-97bd-ccff5a313f00');
INSERT INTO public.posttag VALUES ('czxczxczx', 'b644f2cf-6948-4a2d-97bd-ccff5a313f00');
INSERT INTO public.posttag VALUES ('zzxzcz', 'b644f2cf-6948-4a2d-97bd-ccff5a313f00');
INSERT INTO public.posttag VALUES ('nb', 'ea2d602f-2406-40f2-be21-cb07f316c91c');
INSERT INTO public.posttag VALUES ('mnmnm', '19e46661-e44b-410b-a1f7-44d152ad5af9');
INSERT INTO public.posttag VALUES ('nbnbn', '790098eb-d956-4994-a880-486d1cd6e53f');
INSERT INTO public.posttag VALUES ('nbnb', '790098eb-d956-4994-a880-486d1cd6e53f');
INSERT INTO public.posttag VALUES ('vvv', '2165bbc6-8467-45d8-813c-d61e7d9f3c32');
INSERT INTO public.posttag VALUES ('aaaa', '2165bbc6-8467-45d8-813c-d61e7d9f3c32');
INSERT INTO public.posttag VALUES ('bbbb', '17f8ca93-d0be-4d0a-8968-1082e793b6ae');
INSERT INTO public.posttag VALUES ('cxv', 'ff8c81a3-d07a-4fbb-ab5e-a9df367978b2');
INSERT INTO public.posttag VALUES ('zzz', '86c41dc1-4053-4f71-bced-852833331126');
INSERT INTO public.posttag VALUES ('vvvv', '8ef7deb6-9dd4-4984-8403-b086418266ec');
INSERT INTO public.posttag VALUES ('zzz', 'e4056ff6-b9af-42b1-84c5-fb53b22eaede');


--
-- TOC entry 3431 (class 0 OID 18567)
-- Dependencies: 252
-- Data for Name: socialnetwork; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.socialnetwork VALUES (1, 'GOOGLE', NULL, NULL);
INSERT INTO public.socialnetwork VALUES (2, 'FACEBOOK', NULL, NULL);


--
-- TOC entry 3430 (class 0 OID 17749)
-- Dependencies: 251
-- Data for Name: user_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_sys VALUES ('98f1edad-0410-4fa0-be8c-40133cc0d64f', 'account-public', '2021-08-24 14:44:33', 'account-public', '2021-08-24 14:44:33', 'https://lh3.googleusercontent.com/a/AATXAJwXAwTcL8lHydt_BQLuAKX18VdjxGrW0kuaP9JW=s96-c', true, 'Quản trị viên', '$2a$10$cYsb/fv.GwxxGEc3IKVqOucYYzg31/PDG9gWCGlPWrSQurryHFn0C', 'admin', 'no_email@choydy.com', true, 'Asia/Ho_Chi_Minh');
INSERT INTO public.user_sys VALUES ('1d6f3582-d63b-4823-bb6f-a96b3ce6d5b3', NULL, NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/AATXAJyN2ioajFeDaHilyy3th3hJKa1t8zkQ2FS9qroP=s96-c', true, 'Dy Choy', '$2a$10$kx13euhSsJIQfFwHCwfTCuYznno3qBJxzkqJ0IEXHy.8gcG9TVU6.', 'choydy69@gmail.com', 'choydy69@gmail.com', false, 'Asia/Saigon');


--
-- TOC entry 3438 (class 0 OID 18832)
-- Dependencies: 259
-- Data for Name: userauthority; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.userauthority VALUES ('be8b3e2b-8284-441e-9905-2e316a30b902', 'ADMIN', '98f1edad-0410-4fa0-be8c-40133cc0d64f');
INSERT INTO public.userauthority VALUES ('98f1edad-0410-4fa0-be8c-40133cc0d64f', 'USER', '98f1edad-0410-4fa0-be8c-40133cc0d64f');
INSERT INTO public.userauthority VALUES ('da3a324e-12c2-4b3a-9b8e-473c41c6ca58', 'EDITOR', '98f1edad-0410-4fa0-be8c-40133cc0d64f');
INSERT INTO public.userauthority VALUES ('309bfa17-e3f0-42ac-93ef-641274eccd79', 'USER', '1d6f3582-d63b-4823-bb6f-a96b3ce6d5b3');


--
-- TOC entry 3432 (class 0 OID 18580)
-- Dependencies: 253
-- Data for Name: userdetail; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.userdetail VALUES ('f56b187d-edf6-403e-ab38-6f2efcf6eef0', NULL, NULL, NULL, NULL, NULL, NULL, 'VI', '1d6f3582-d63b-4823-bb6f-a96b3ce6d5b3');


--
-- TOC entry 3433 (class 0 OID 18588)
-- Dependencies: 254
-- Data for Name: usersocialnetwork; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usersocialnetwork VALUES ('499a002d-96b0-4990-93f3-3588f32e0174', 'https://lh3.googleusercontent.com/a/AATXAJyN2ioajFeDaHilyy3th3hJKa1t8zkQ2FS9qroP=s96-c', 'choydy69@gmail.com', NULL, 'r30NYAvKZrXW0w10uc7FPyaIPN62', 1, '1d6f3582-d63b-4823-bb6f-a96b3ce6d5b3');


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 249
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);


--
-- TOC entry 3223 (class 2606 OID 17774)
-- Name: authority authority_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authority
    ADD CONSTRAINT authority_pkey PRIMARY KEY (id);


--
-- TOC entry 3259 (class 2606 OID 18803)
-- Name: catalog catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT catalog_pkey PRIMARY KEY (id);


--
-- TOC entry 3255 (class 2606 OID 18765)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3225 (class 2606 OID 17782)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (iso);


--
-- TOC entry 3227 (class 2606 OID 17788)
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (code);


--
-- TOC entry 3257 (class 2606 OID 18788)
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- TOC entry 3267 (class 2606 OID 18988)
-- Name: oauth2client oauth2client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2client
    ADD CONSTRAINT oauth2client_pkey PRIMARY KEY (id);


--
-- TOC entry 3253 (class 2606 OID 18714)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- TOC entry 3269 (class 2606 OID 19033)
-- Name: postlike postlike_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postlike
    ADD CONSTRAINT postlike_pkey PRIMARY KEY (user_id, post_id);


--
-- TOC entry 3238 (class 2606 OID 18574)
-- Name: socialnetwork socialnetwork_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialnetwork
    ADD CONSTRAINT socialnetwork_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 18599)
-- Name: socialnetwork uk_2s1vq8bhmy1808f219jajrl2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialnetwork
    ADD CONSTRAINT uk_2s1vq8bhmy1808f219jajrl2b UNIQUE (name);


--
-- TOC entry 3229 (class 2606 OID 17864)
-- Name: user_sys uk_5hl4w53pryqi6yvk9xlj9q7qn; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT uk_5hl4w53pryqi6yvk9xlj9q7qn UNIQUE (username);


--
-- TOC entry 3242 (class 2606 OID 18605)
-- Name: userdetail uk_ogldqocqgiidnxc0phek5u6r; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdetail
    ADD CONSTRAINT uk_ogldqocqgiidnxc0phek5u6r UNIQUE (user_id);


--
-- TOC entry 3231 (class 2606 OID 18601)
-- Name: user_sys uk_pjjobtr3fx54k6d3hj8mgsoa5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT uk_pjjobtr3fx54k6d3hj8mgsoa5 UNIQUE (email);


--
-- TOC entry 3233 (class 2606 OID 17876)
-- Name: user_sys ukbyqgxl187y7aer3tki0jd0qr3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT ukbyqgxl187y7aer3tki0jd0qr3 UNIQUE (username, email);


--
-- TOC entry 3261 (class 2606 OID 18838)
-- Name: userauthority ukd2dmkumx3e97vu2shhg9kk2gu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauthority
    ADD CONSTRAINT ukd2dmkumx3e97vu2shhg9kk2gu UNIQUE (user_id, authority_id);


--
-- TOC entry 3265 (class 2606 OID 18967)
-- Name: posttag ukle9i0p4tgtm9530kupkwxif1d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posttag
    ADD CONSTRAINT ukle9i0p4tgtm9530kupkwxif1d UNIQUE (post_id, tag);


--
-- TOC entry 3246 (class 2606 OID 18607)
-- Name: usersocialnetwork uksn7bvt6g2a8i8m65cvmjsfske; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersocialnetwork
    ADD CONSTRAINT uksn7bvt6g2a8i8m65cvmjsfske UNIQUE (user_id, social_network_id);


--
-- TOC entry 3236 (class 2606 OID 17918)
-- Name: user_sys user_sys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT user_sys_pkey PRIMARY KEY (id);


--
-- TOC entry 3263 (class 2606 OID 18836)
-- Name: userauthority userauthority_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauthority
    ADD CONSTRAINT userauthority_pkey PRIMARY KEY (id);


--
-- TOC entry 3244 (class 2606 OID 18587)
-- Name: userdetail userdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdetail
    ADD CONSTRAINT userdetail_pkey PRIMARY KEY (id);


--
-- TOC entry 3248 (class 2606 OID 18595)
-- Name: usersocialnetwork usersocialnetwork_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersocialnetwork
    ADD CONSTRAINT usersocialnetwork_pkey PRIMARY KEY (id);


--
-- TOC entry 3249 (class 1259 OID 18943)
-- Name: idxgj2rd9ewi9h2p4pc09i6upyt1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idxgj2rd9ewi9h2p4pc09i6upyt1 ON public.post USING btree (created);


--
-- TOC entry 3250 (class 1259 OID 18722)
-- Name: idxote8luhmq2ditx56w37mviwny; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idxote8luhmq2ditx56w37mviwny ON public.post USING btree (title, content);


--
-- TOC entry 3251 (class 1259 OID 18721)
-- Name: idxs7ui38nhrh0c7q4nfpgf93bfk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idxs7ui38nhrh0c7q4nfpgf93bfk ON public.post USING btree (user_id);


--
-- TOC entry 3234 (class 1259 OID 17936)
-- Name: user_sys_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_sys_email_idx ON public.user_sys USING btree (email);


--
-- TOC entry 3270 (class 2606 OID 18633)
-- Name: userdetail fk174y51lt1lbl26clh4ymguuk3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdetail
    ADD CONSTRAINT fk174y51lt1lbl26clh4ymguuk3 FOREIGN KEY (country_iso) REFERENCES public.country(iso);


--
-- TOC entry 3281 (class 2606 OID 18839)
-- Name: userauthority fk1minklvli2mn2njbomxvef99g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauthority
    ADD CONSTRAINT fk1minklvli2mn2njbomxvef99g FOREIGN KEY (authority_id) REFERENCES public.authority(id);


--
-- TOC entry 3276 (class 2606 OID 18766)
-- Name: comment fk6kduoq1qgemmbt8ls3x37di8n; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk6kduoq1qgemmbt8ls3x37di8n FOREIGN KEY (parent_id) REFERENCES public.comment(id);


--
-- TOC entry 3271 (class 2606 OID 18638)
-- Name: userdetail fk9kj1yufdk6lpcvs4hc9aki689; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdetail
    ADD CONSTRAINT fk9kj1yufdk6lpcvs4hc9aki689 FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3277 (class 2606 OID 18776)
-- Name: comment fkay3w7wrk7vau26n7ix6crwl1l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fkay3w7wrk7vau26n7ix6crwl1l FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3272 (class 2606 OID 18643)
-- Name: usersocialnetwork fkcjc5u98wa8eymfb2mw57kfp9m; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersocialnetwork
    ADD CONSTRAINT fkcjc5u98wa8eymfb2mw57kfp9m FOREIGN KEY (social_network_id) REFERENCES public.socialnetwork(id);


--
-- TOC entry 3280 (class 2606 OID 19054)
-- Name: catalog fkg02ng5e4xvt6kf5evmexw1k4j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT fkg02ng5e4xvt6kf5evmexw1k4j FOREIGN KEY (parent_id) REFERENCES public.catalog(id);


--
-- TOC entry 3283 (class 2606 OID 18968)
-- Name: posttag fkijuqbnbv01ixs71tbd58xkgkd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posttag
    ADD CONSTRAINT fkijuqbnbv01ixs71tbd58xkgkd FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- TOC entry 3282 (class 2606 OID 18844)
-- Name: userauthority fkjnag5ndsv1g0v1bsrwas0fibt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauthority
    ADD CONSTRAINT fkjnag5ndsv1g0v1bsrwas0fibt FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3274 (class 2606 OID 18817)
-- Name: post fkknuxya8iel3o3odnc1u2c7pp2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT fkknuxya8iel3o3odnc1u2c7pp2 FOREIGN KEY (catalog_id) REFERENCES public.catalog(id);


--
-- TOC entry 3273 (class 2606 OID 18648)
-- Name: usersocialnetwork fko7d0gpfdlq9if52g0fecsfxso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersocialnetwork
    ADD CONSTRAINT fko7d0gpfdlq9if52g0fecsfxso FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3278 (class 2606 OID 18771)
-- Name: comment fkqb0rnht649ifuh6gev5lwvx8x; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fkqb0rnht649ifuh6gev5lwvx8x FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- TOC entry 3284 (class 2606 OID 19034)
-- Name: postlike fkrfesdq1ogr4mt2qxfl241h6ud; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postlike
    ADD CONSTRAINT fkrfesdq1ogr4mt2qxfl241h6ud FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3275 (class 2606 OID 18723)
-- Name: post fkt4kvk5faoe6k9lmq0m7bvqjcg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT fkt4kvk5faoe6k9lmq0m7bvqjcg FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3279 (class 2606 OID 18791)
-- Name: media fktmgj1wjq6o74oq675050lhrb0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT fktmgj1wjq6o74oq675050lhrb0 FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- TOC entry 3285 (class 2606 OID 19039)
-- Name: postlike fkwy2u3sijki3uk1jhyq1wwujw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postlike
    ADD CONSTRAINT fkwy2u3sijki3uk1jhyq1wwujw FOREIGN KEY (post_id) REFERENCES public.post(id);


-- Completed on 2022-01-05 11:18:43

--
-- PostgreSQL database dump complete
--


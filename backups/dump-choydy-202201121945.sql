--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2022-01-12 19:45:38

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 17583)
-- Name: authority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authority (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authority OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 17588)
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
-- TOC entry 212 (class 1259 OID 17593)
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
-- TOC entry 213 (class 1259 OID 17598)
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
-- TOC entry 209 (class 1259 OID 16413)
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
-- TOC entry 214 (class 1259 OID 17603)
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
-- TOC entry 215 (class 1259 OID 17613)
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
-- TOC entry 216 (class 1259 OID 17618)
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
-- TOC entry 217 (class 1259 OID 17623)
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
-- TOC entry 218 (class 1259 OID 17628)
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
-- TOC entry 219 (class 1259 OID 17631)
-- Name: posttag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posttag (
    tag character varying(255) NOT NULL,
    post_id uuid NOT NULL
);


ALTER TABLE public.posttag OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17639)
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
-- TOC entry 222 (class 1259 OID 17806)
-- Name: userauthority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userauthority (
    user_id uuid NOT NULL,
    authority_id character varying(255) NOT NULL
);


ALTER TABLE public.userauthority OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17821)
-- Name: userdetail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userdetail (
    about text,
    address text,
    birthday date,
    gender character varying(255),
    phonenumber character varying(30),
    postalcode character varying(30),
    user_id uuid NOT NULL,
    country_iso character varying(2) NOT NULL
);


ALTER TABLE public.userdetail OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17794)
-- Name: usersocialnetwork; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usersocialnetwork (
    social character varying(150) NOT NULL,
    email character varying(255) NOT NULL,
    phonenumber character varying(255),
    uid character varying(255) NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.usersocialnetwork OWNER TO postgres;

--
-- TOC entry 3411 (class 0 OID 17583)
-- Dependencies: 210
-- Data for Name: authority; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authority VALUES ('ADMIN', 'Quản trị viên');
INSERT INTO public.authority VALUES ('USER', 'Người dùng');
INSERT INTO public.authority VALUES ('EDITOR', 'Biên tập');


--
-- TOC entry 3412 (class 0 OID 17588)
-- Dependencies: 211
-- Data for Name: catalog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.catalog VALUES (10000, 'Video', 1, NULL);
INSERT INTO public.catalog VALUES (10001, 'Hình ảnh', 2, NULL);
INSERT INTO public.catalog VALUES (1, 'Funny', 3, 10000);
INSERT INTO public.catalog VALUES (3, 'Bóng Đá', 4, 10000);
INSERT INTO public.catalog VALUES (5, 'Chọc chó', 5, 10000);
INSERT INTO public.catalog VALUES (4, 'Thú cưng', 6, 10000);
INSERT INTO public.catalog VALUES (6, 'Video Meme', 7, 10000);
INSERT INTO public.catalog VALUES (2, 'Meme Tiến Bịp', 15, 10001);
INSERT INTO public.catalog VALUES (9, 'Meme Huấn Hoa Hồng', 14, 10001);
INSERT INTO public.catalog VALUES (11, 'Meme Gấu Trúc', 11, 10001);
INSERT INTO public.catalog VALUES (13, 'Meme Chó', 12, 10001);
INSERT INTO public.catalog VALUES (14, 'Meme Mèo', 13, 10001);
INSERT INTO public.catalog VALUES (8, 'Meme Hot', 10, 10001);
INSERT INTO public.catalog VALUES (12, 'Meme Gốc', 16, 10001);
INSERT INTO public.catalog VALUES (10, 'Cmt Bá đạo', 9, 10001);
INSERT INTO public.catalog VALUES (7, 'Gaming', 8, 10000);


--
-- TOC entry 3413 (class 0 OID 17593)
-- Dependencies: 212
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3414 (class 0 OID 17598)
-- Dependencies: 213
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
-- TOC entry 3415 (class 0 OID 17603)
-- Dependencies: 214
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
-- TOC entry 3416 (class 0 OID 17613)
-- Dependencies: 215
-- Data for Name: media; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.media VALUES ('b8d61fed-c0f2-45ce-87f6-8f0e3cda7104', '/vid/21/12/postb8d61fed-c0f2-45ce-87f6-8f0e3cda71049627_uday-magar.mp4', 'video/mp4', '8170ad1a-eefa-4a33-b4e3-2fd3f3b8b1ef');
INSERT INTO public.media VALUES ('80d5157f-467c-4bd0-8519-3879d72ef0d2', '/vid/21/12/post80d5157f-467c-4bd0-8519-3879d72ef0d286608410_g-u-bc.mp4', 'video/mp4', '4d340cc0-f391-473c-a2ea-2684c22a036e');
INSERT INTO public.media VALUES ('f5eda7c0-1f48-4ec4-9187-41c8519e1408', '/vid/21/12/postf5eda7c0-1f48-4ec4-9187-41c8519e1408870138019504489.mp4', 'video/mp4', 'c6a869aa-7898-4a97-ac45-84994e160b26');
INSERT INTO public.media VALUES ('922645c3-d4cb-4a80-b480-ec42e051248d', '/vid/21/12/post922645c3-d4cb-4a80-b480-ec42e051248d12827_linh-tinh.mp4', 'video/mp4', '48934986-b56a-443c-92ae-d57900491656');
INSERT INTO public.media VALUES ('bcbe3d0e-d35f-4ca4-8a49-17cb30920729', '/vid/21/12/postbcbe3d0e-d35f-4ca4-8a49-17cb3092072913711705656602_.mp4', 'video/mp4', '0c0b4075-6b00-4160-bdc6-a93131f13b60');
INSERT INTO public.media VALUES ('69922ae5-4053-4078-b948-edd5b7bdfafb', '/vid/21/12/post69922ae5-4053-4078-b948-edd5b7bdfafb9_loveanimal184.mp4', 'video/mp4', '786de890-3812-47ff-ad90-ec4e099c134e');
INSERT INTO public.media VALUES ('9e51d474-cdab-4b47-86d4-510180ad6109', '/vid/21/12/post9e51d474-cdab-4b47-86d4-510180ad610903056897_nmusic.mp4', 'video/mp4', 'c2b3f7fa-b14e-4d52-98b7-b56d0a14fb35');
INSERT INTO public.media VALUES ('55dc1f9a-e595-4e6f-86b5-4305d390a053', '/vid/21/12/post55dc1f9a-e595-4e6f-86b5-4305d390a053801263361-ntt_s.mp4', 'video/mp4', 'f38d5aba-537a-4da0-926c-66aceb42cc37');
INSERT INTO public.media VALUES ('63707816-13f0-4477-a5a5-2b927cc16e10', '/vid/21/12/post63707816-13f0-4477-a5a5-2b927cc16e10936834843_stron.mp4', 'video/mp4', '907d7307-e2a1-4edf-b92c-a4dc12a08538');
INSERT INTO public.media VALUES ('191555cb-d4d5-406b-b68e-e66b9acc9509', '/vid/21/12/post191555cb-d4d5-406b-b68e-e66b9acc9509nguyn-trng-ngha.mp4', 'video/mp4', '00a5809b-e026-4023-93cf-13098e84011c');
INSERT INTO public.media VALUES ('df7b3c22-26b3-4397-bec6-2cfa15ae7c8d', '/vid/21/12/postdf7b3c22-26b3-4397-bec6-2cfa15ae7c8d39313921_tiktok.mp4', 'video/mp4', '9ad1f4cf-8e68-47b2-972e-4c44bc188f8c');
INSERT INTO public.media VALUES ('033fe0de-0866-4239-a220-f61877c4e299', '/vid/21/12/post033fe0de-0866-4239-a220-f61877c4e299choydy-1.mp4', 'video/mp4', '85b309bc-5283-4113-88d9-54945a80f36e');
INSERT INTO public.media VALUES ('55ff231e-9a69-43be-ab0b-783340b2c454', '/img/21/12/post55ff231e-9a69-43be-ab0b-783340b2c454-doi-toi-an-com.jpg', 'image/jpeg', '7fc30f18-0682-4852-8297-96e060252c0c');
INSERT INTO public.media VALUES ('741e6146-09fe-41bb-8407-f9bae07e6d06', '/img/21/12/post741e6146-09fe-41bb-8407-f9bae07e6d06anh-xem-z-u-cai.jpg', 'image/jpeg', '69829e52-ff51-4b5b-bb3d-1b61e4312287');
INSERT INTO public.media VALUES ('0c050ec8-eb00-435f-a84e-927228239454', '/img/21/12/post0c050ec8-eb00-435f-a84e-927228239454i-sao-phai-khoc.jpg', 'image/jpeg', '66505493-b059-460e-8913-611fc014e800');
INSERT INTO public.media VALUES ('80439ac2-2fe8-45f3-b739-4d79652ac6b1', '/vid/21/12/post80439ac2-2fe8-45f3-b739-4d79652ac6b1choydy-2.mp4', 'video/mp4', '4cff0eb4-6bd7-46a8-adb8-cd417a74d461');
INSERT INTO public.media VALUES ('5c3cb797-df4a-4343-b222-35a2cd5219a9', '/vid/21/12/post5c3cb797-df4a-4343-b222-35a2cd5219a9choydy-3.mp4', 'video/mp4', '0f6cd27f-9c0d-41c5-9d6e-00ab5f792d56');
INSERT INTO public.media VALUES ('631d723b-fb6f-42af-ae56-2598abeafbee', '/vid/21/12/post631d723b-fb6f-42af-ae56-2598abeafbeechoydy-5.mp4', 'video/mp4', 'ba18817e-222b-4f64-a0c8-d866a09acb6d');
INSERT INTO public.media VALUES ('3b04cb71-0007-4c2c-8616-605c33bd68a8', '/vid/21/12/post3b04cb71-0007-4c2c-8616-605c33bd68a8choydy-6.mp4', 'video/mp4', '9514e12c-97ea-4382-98b2-8a9c95ce7a30');
INSERT INTO public.media VALUES ('52e165dc-ff6d-4963-aa44-3e06ada9f785', '/vid/21/12/post52e165dc-ff6d-4963-aa44-3e06ada9f785choydy-7.mp4', 'video/mp4', '9bed30cb-b7be-4651-bf06-7733ef8bdec0');
INSERT INTO public.media VALUES ('cc9bdccd-8aee-47f1-a57d-939c1921ee60', '/vid/21/12/postcc9bdccd-8aee-47f1-a57d-939c1921ee60choydy-4.mp4', 'video/mp4', '906efcc1-9c83-4e96-8778-f03713965fa6');
INSERT INTO public.media VALUES ('192928de-4768-4c9e-9907-4b23388ab550', '/vid/21/12/post192928de-4768-4c9e-9907-4b23388ab550choydy-8.mp4', 'video/mp4', 'b7e4e405-1cd6-40ba-9bc6-11ea21197b0d');
INSERT INTO public.media VALUES ('2fd353f2-6e69-44a7-b4d4-6c3cee9a5cdd', '/vid/21/12/post2fd353f2-6e69-44a7-b4d4-6c3cee9a5cddchoydy-9.mp4', 'video/mp4', '523ac955-a355-4716-be33-62df75caa2b5');
INSERT INTO public.media VALUES ('90edb980-4467-4c57-aed1-10bf326adcc0', '/vid/21/12/post90edb980-4467-4c57-aed1-10bf326adcc0choydy-10.mp4', 'video/mp4', 'fc4f30e6-eb1f-4f6d-b001-6136e6be639c');
INSERT INTO public.media VALUES ('c603168a-2ad3-485f-a129-a83c57d610ce', '/vid/21/12/postc603168a-2ad3-485f-a129-a83c57d610cechoydy-11.mp4', 'video/mp4', 'c08a11ea-b4ac-4bb8-820f-183174e0d9f2');
INSERT INTO public.media VALUES ('77ab0acd-6f3d-42c3-9e86-3ff90ad5e933', '/vid/21/12/post77ab0acd-6f3d-42c3-9e86-3ff90ad5e933choydy-12.mp4', 'video/mp4', '725d08cc-a993-4d21-9b48-8133360a7f90');
INSERT INTO public.media VALUES ('a3c91c5f-b454-4ab6-af12-1f3e092d621a', '/vid/21/12/posta3c91c5f-b454-4ab6-af12-1f3e092d621achoydy-13.mp4', 'video/mp4', '7bfaba9a-ed75-4056-ae38-577f84752369');
INSERT INTO public.media VALUES ('c42bc541-4542-4f22-a610-64db1df90af6', '/vid/21/12/postc42bc541-4542-4f22-a610-64db1df90af6choydy-14.mp4', 'video/mp4', '8a0cab0f-c931-414a-aff7-ba6fd05a535b');
INSERT INTO public.media VALUES ('fe3a885e-daac-4dba-995f-362a6bf37bfe', '/vid/21/12/postfe3a885e-daac-4dba-995f-362a6bf37bfechoydy-15.mp4', 'video/mp4', '7e52ba8d-795e-4363-bbe8-8b13d06e67d2');
INSERT INTO public.media VALUES ('e6256e80-84ff-4df2-b5fd-102bb95ca23a', '/vid/21/12/poste6256e80-84ff-4df2-b5fd-102bb95ca23achoydy-16.mp4', 'video/mp4', '6dc85dba-b12c-4ec1-b663-f9219c603683');
INSERT INTO public.media VALUES ('962fb0e6-2b41-4cad-a000-78a8b92a1925', '/vid/21/12/post962fb0e6-2b41-4cad-a000-78a8b92a1925choydy-17.mp4', 'video/mp4', '5e5c87ea-e253-4fd5-9749-04f6f0c21411');
INSERT INTO public.media VALUES ('fbb352b9-70f5-4914-8793-00bab35adcd8', '/vid/21/12/postfbb352b9-70f5-4914-8793-00bab35adcd8vid6.mp4', 'video/mp4', '7b57b08c-2e14-4b12-876d-a569cf7976a0');
INSERT INTO public.media VALUES ('a3c6dd92-acbe-49f4-bf8e-e1afc4296b48', '/img/21/12/posta3c6dd92-acbe-49f4-bf8e-e1afc4296b48oi-con-cai-nit.jpeg', 'image/jpeg', '0e05b0f0-4df8-4a28-8d31-953573d46f2a');
INSERT INTO public.media VALUES ('1265e90f-381a-4fd3-95ba-e5007a4bb514', '/vid/21/12/post1265e90f-381a-4fd3-95ba-e5007a4bb514uLCgEYo (1) (1).mp4', 'video/mp4', '2a261740-de09-4c90-90b9-5c69dc593017');
INSERT INTO public.media VALUES ('1453d5d1-3bd5-4a8e-9d73-63c767609287', '/img/21/12/post1453d5d1-3bd5-4a8e-9d73-63c767609287Capture.PNG', 'image/png', '40556c46-919f-478f-9f03-1c7e3f63f3a4');
INSERT INTO public.media VALUES ('eb0dd907-6848-4760-9397-733f56364304', '/img/21/12/posteb0dd907-6848-4760-9397-733f56364304xcxczxc.JPG', 'image/jpeg', '75691675-074b-4384-bbf3-c0b14870f4b9');
INSERT INTO public.media VALUES ('4d022963-c90a-49dc-950b-c9019ac0a742', '/vid/22/1/post4d022963-c90a-49dc-950b-c9019ac0a742bestgoalsgaming.mp4', 'video/mp4', 'a11f522a-f321-4b5c-a32e-6a561990fb25');
INSERT INTO public.media VALUES ('2a5ff6cd-cc99-42af-9c45-5ee2993e037f', '/vid/22/1/post2a5ff6cd-cc99-42af-9c45-5ee2993e037fif-5-a13b538851.mp4', 'video/mp4', 'a1e1b234-53be-4cf8-9047-712b2b4bf052');
INSERT INTO public.media VALUES ('4fb2effb-18e5-4b5c-a410-552a88963327', '/vid/22/1/post4fb2effb-18e5-4b5c-a410-552a88963327choydy-20.mp4', 'video/mp4', '01b9a56a-ffb0-4054-b8bc-320b7d4f6264');
INSERT INTO public.media VALUES ('7c01b25c-98d5-41f4-b045-abf4d6ed86e9', '/vid/22/1/post7c01b25c-98d5-41f4-b045-abf4d6ed86e9_20_15_IMG_1168.MP4', 'video/mp4', 'a0a878eb-df54-4e8b-8f19-722306a10977');
INSERT INTO public.media VALUES ('f8e1dad8-88de-403f-93a4-44df9bdf4335', '/vid/22/1/postf8e1dad8-88de-403f-93a4-44df9bdf4335_21_58_IMG_1398.MP4', 'video/mp4', '034f1e8e-dd65-447a-824c-6ec8e062ff22');
INSERT INTO public.media VALUES ('d0563d13-7c96-4147-8bd6-2fc97902d17d', '/vid/22/1/postd0563d13-7c96-4147-8bd6-2fc97902d17d_22_02_IMG_1404.MP4', 'video/mp4', '23ba1ad0-761e-4845-92b9-400a5243c77f');
INSERT INTO public.media VALUES ('5c84add7-5406-4ccd-90a5-47603f5348dc', '/vid/22/1/post5c84add7-5406-4ccd-90a5-47603f5348dc6386_siu-c-chui.mp4', 'video/mp4', '010261e4-731e-4f6e-a314-6486cedd8bbf');
INSERT INTO public.media VALUES ('ae1a69f4-597c-430d-bb19-06f86be78961', '/vid/22/1/postae1a69f4-597c-430d-bb19-06f86be78961_21_48_IMG_1403.MP4', 'video/mp4', 'd1c4898d-a25b-4450-b080-43bb34dca92e');
INSERT INTO public.media VALUES ('8c684066-d223-44d7-9a41-582b99d23f7f', '/vid/22/1/post8c684066-d223-44d7-9a41-582b99d23f7f042_coi-la-cuoi.mp4', 'video/mp4', '1f9c17a7-a0bf-4385-b18f-7959edb90cae');
INSERT INTO public.media VALUES ('57b84c06-aba9-4b61-a16a-bb567f1c0ccd', '/vid/22/1/post57b84c06-aba9-4b61-a16a-bb567f1c0ccdem-si-a-rot-roi.mp4', 'video/mp4', '25ca0366-c3e8-482a-b2f5-41a4963c068d');
INSERT INTO public.media VALUES ('b1b07b51-2084-41b8-ad7b-8d2c10d696fe', '/vid/22/1/postb1b07b51-2084-41b8-ad7b-8d2c10d696fechoydy-19.mp4', 'video/mp4', '2840e8e3-4352-4076-8f18-298a2de48ec9');
INSERT INTO public.media VALUES ('bca39e46-a7f4-4789-b7e0-d83007009a27', '/vid/22/1/postbca39e46-a7f4-4789-b7e0-d83007009a2738696449_tiktok.mp4', 'video/mp4', 'b342eff2-8743-4ca8-9c43-8f7e64a8b1bd');
INSERT INTO public.media VALUES ('54be8bdf-b0b8-45b3-ba25-015a612a0e98', '/vid/22/1/post54be8bdf-b0b8-45b3-ba25-015a612a0e9814219522_tiktok.mp4', 'video/mp4', '1b876d25-2c80-489c-8359-216c640b492a');
INSERT INTO public.media VALUES ('93a63e5f-aa31-47e9-ad7a-f63209268f42', '/vid/22/1/post93a63e5f-aa31-47e9-ad7a-f63209268f42_fantastic-girl.mp4', 'video/mp4', 'db24c430-45f9-48fc-8798-12a46f8b03b9');
INSERT INTO public.media VALUES ('f2c58058-c0f8-410d-8d46-9120db4d4bf7', '/vid/22/1/postf2c58058-c0f8-410d-8d46-9120db4d4bf702_bruh-montage.mp4', 'video/mp4', '9ec117cd-6ad3-4cf3-b7d9-f52783ae5f8e');
INSERT INTO public.media VALUES ('8ac69dc3-5d09-435c-b1c4-b0c5b0a46562', '/vid/22/1/post8ac69dc3-5d09-435c-b1c4-b0c5b0a465627_league-hotpot.mp4', 'video/mp4', 'e807e414-a178-4459-8a8e-8f407a645a6d');
INSERT INTO public.media VALUES ('162afd9d-3b20-4a92-9360-2983ea054ff3', '/vid/22/1/post162afd9d-3b20-4a92-9360-2983ea054ff336204801_tiktok.mp4', 'video/mp4', '5aa86fc5-f8b1-491b-b794-ca625e73119b');
INSERT INTO public.media VALUES ('87759158-2aa1-479b-91ff-180dbe6c0e3c', '/vid/22/1/post87759158-2aa1-479b-91ff-180dbe6c0e3c353_y-c-ting-ci.mp4', 'video/mp4', '5b014325-5829-4af6-8163-d3b7d61f1510');
INSERT INTO public.media VALUES ('95578f3d-6586-4685-97a2-0d77a7beb159', '/vid/22/1/post95578f3d-6586-4685-97a2-0d77a7beb1597794_h-moca-(1).mp4', 'video/mp4', 'a12bb9dc-0175-44fe-9f7c-7cc6ecd0c2b6');
INSERT INTO public.media VALUES ('c1012a02-524a-4c45-ba7a-3a79b7b0fe9f', '/vid/22/1/postc1012a02-524a-4c45-ba7a-3a79b7b0fe9firiyaaaaaaa-(1).mp4', 'video/mp4', '9a9a702a-4948-4281-936c-671e3e91e27c');
INSERT INTO public.media VALUES ('0393edf0-4798-4ea9-9449-336f72b10054', '/vid/22/1/post0393edf0-4798-4ea9-9449-336f72b1005461_honglong-(2).mp4', 'video/mp4', '6fb69ebf-aae2-422f-88a6-efc1b9020a70');
INSERT INTO public.media VALUES ('a29c8f78-5823-4b91-b5f9-623a1fa155ee', '/vid/22/1/posta29c8f78-5823-4b91-b5f9-623a1fa155ee_funny-v-tt-(1).mp4', 'video/mp4', 'eb5a9660-472a-4c77-a483-dd546e7f3866');
INSERT INTO public.media VALUES ('da5f1bb8-ab8a-4d51-89cb-3f335c7917b5', '/vid/22/1/postda5f1bb8-ab8a-4d51-89cb-3f335c7917b58_b-mt-phim-(1).mp4', 'video/mp4', '204a7faf-4382-4e64-a17f-a24b12e14cd8');
INSERT INTO public.media VALUES ('e4e74263-3a12-4534-973f-183d191c5f74', '/vid/22/1/poste4e74263-3a12-4534-973f-183d191c5f74_vy-cng-kho-(1).mp4', 'video/mp4', 'baea97c9-4398-4601-9bc3-49ab80a9c35c');
INSERT INTO public.media VALUES ('d6288cfa-316d-4126-940a-7dd4221c7c5a', '/vid/22/1/postd6288cfa-316d-4126-940a-7dd4221c7c5at-minh-thun-(1).mp4', 'video/mp4', '22a8b3fc-2050-4c13-b0a2-f8bb03081334');
INSERT INTO public.media VALUES ('7565c121-afbb-465f-ac72-29b1b93bd93e', '/vid/22/1/post7565c121-afbb-465f-ac72-29b1b93bd93e5873_tiktok-(1).mp4', 'video/mp4', '639167d0-e81a-4925-a5c7-d05f8697a464');
INSERT INTO public.media VALUES ('2a9b8cf5-0d9a-4fca-b898-8b301e6c440a', '/vid/22/1/post2a9b8cf5-0d9a-4fca-b898-8b301e6c440a417_mt-mt-m-(1).mp4', 'video/mp4', '20c784e8-80aa-453e-b27c-4d087b1081b7');
INSERT INTO public.media VALUES ('384e3944-bf8b-4c23-9b60-573c9d26a4f6', '/vid/22/1/post384e3944-bf8b-4c23-9b60-573c9d26a4f6hu-minh-phc-(1).mp4', 'video/mp4', '14295db4-80bd-46c9-9de2-e2f95d6ad176');
INSERT INTO public.media VALUES ('6b58d7bb-a814-4c73-92bf-b5004b6fbbb8', '/vid/22/1/post6b58d7bb-a814-4c73-92bf-b5004b6fbbb8khachatrian-(1).mp4', 'video/mp4', 'bb8305c1-60cb-47ed-b79e-f787182d3851');
INSERT INTO public.media VALUES ('46ce1f67-eba2-4dbf-a0c4-eed4bb7e9718', '/vid/22/1/post46ce1f67-eba2-4dbf-a0c4-eed4bb7e9718ni-adhikari-(1).mp4', 'video/mp4', '83510bfc-4e0a-4454-8de0-6a33bb2fb459');
INSERT INTO public.media VALUES ('576d1054-eed3-43ab-b3fd-32e76060aa07', '/vid/22/1/post576d1054-eed3-43ab-b3fd-32e76060aa0702213_t-bui-(1).mp4', 'video/mp4', 'da1cb426-9ecc-47d3-b9c0-852ef71ccc26');
INSERT INTO public.media VALUES ('c53131a2-93b9-408f-9c11-d4bf4fec7ea7', '/vid/22/1/postc53131a2-93b9-408f-9c11-d4bf4fec7ea7_haiztv-(1)-(1).mp4', 'video/mp4', 'd0444fb9-d3d9-4270-93f7-30ec6d5b8c0c');
INSERT INTO public.media VALUES ('1b52f9b8-bd90-42d3-a0e1-e57faeb49769', '/img/22/1/post1b52f9b8-bd90-42d3-a0e1-e57faeb49769083752869774085.jpg', 'image/jpeg', 'c9c83ae8-78b4-47a4-9fbd-ed96156d282f');
INSERT INTO public.media VALUES ('804cbca9-163b-40b1-9786-9f0fd99ddde9', '/img/22/1/post804cbca9-163b-40b1-9786-9f0fd99ddde920220110_144330.jpg', 'image/jpeg', '0e55bae5-a9c4-4054-acf2-4b83cfc15906');
INSERT INTO public.media VALUES ('2c4a3330-8505-45ae-ab2f-80a0bb0f6956', '/vid/22/1/post2c4a3330-8505-45ae-ab2f-80a0bb0f695679688672539_tun.mp4', 'video/mp4', '685cea84-cea2-413d-98ad-779a2a041e22');
INSERT INTO public.media VALUES ('3ae38bb9-01de-4eab-abb8-4eef76b4ac89', '/vid/22/1/post3ae38bb9-01de-4eab-abb8-4eef76b4ac89ny-page-(1)-(1).mp4', 'video/mp4', '4c1b86f6-4cb2-4116-8029-9550dd25c196');
INSERT INTO public.media VALUES ('5d7f312f-addc-44e8-9b40-350c14638d60', '/vid/22/1/post5d7f312f-addc-44e8-9b40-350c14638d6093_g-potter-(1).mp4', 'video/mp4', 'c5c6f404-12f8-443c-a178-e1da4046366a');
INSERT INTO public.media VALUES ('fa5a3dd6-8cfa-4290-84dd-ca1d86f57a58', '/vid/22/1/postfa5a3dd6-8cfa-4290-84dd-ca1d86f57a5818_ho-panda-(1).mp4', 'video/mp4', '8edbd92c-cfc7-4cf3-bb39-ef05d0fe0c9b');
INSERT INTO public.media VALUES ('232a2fa5-e0c5-4b05-a226-06d2ee12ae29', '/vid/22/1/post232a2fa5-e0c5-4b05-a226-06d2ee12ae29g-giang-111-(1).mp4', 'video/mp4', '1fa2a1d3-86e2-4258-a51d-bd7e01ad1e80');
INSERT INTO public.media VALUES ('9bd9458a-8a58-4192-a4e0-00b717b2ab25', '/img/22/1/post9bd9458a-8a58-4192-a4e0-00b717b2ab25065315323_n-(1).jpg', 'image/jpeg', '2da23411-84f1-43dc-b652-2231b26be3eb');
INSERT INTO public.media VALUES ('9461902d-2592-41e5-93ce-b21df376d7c7', '/vid/22/1/post9461902d-2592-41e5-93ce-b21df376d7c796362310914_nng.mp4', 'video/mp4', 'bb407cc6-a7a1-44aa-8fc7-8cd44fb13083');
INSERT INTO public.media VALUES ('958ab5dd-f979-44e9-9939-55614840568e', '/vid/22/1/post958ab5dd-f979-44e9-9939-55614840568ei-thanh-lch-(1).mp4', 'video/mp4', 'e736bfb6-df5a-4fbc-8e42-4de343598008');
INSERT INTO public.media VALUES ('3d4cc19d-f9b0-4a91-919b-63a3e746079f', '/vid/22/1/post3d4cc19d-f9b0-4a91-919b-63a3e746079f90_no_watermark.mp4', 'video/mp4', 'ddea4298-7dbb-4e3e-971e-b671165d6700');
INSERT INTO public.media VALUES ('66c7fe2a-7e6e-44e7-99f5-e0430590ee94', '/vid/22/1/post66c7fe2a-7e6e-44e7-99f5-e0430590ee94043034_b-mt-(1).mp4', 'video/mp4', '4c7e69ba-1cda-4c00-bfc8-6d8d5cb9e74e');
INSERT INTO public.media VALUES ('0f018619-e492-47d8-92e2-d28df5d0cd1b', '/vid/22/1/post0f018619-e492-47d8-92e2-d28df5d0cd1baystation68-(1).mp4', 'video/mp4', 'eb7642c1-5385-4a72-895a-d7a0d1a8787d');
INSERT INTO public.media VALUES ('3dc3bd4c-eabb-4c96-ae79-dfb5b8f3bece', '/vid/22/1/post3dc3bd4c-eabb-4c96-ae79-dfb5b8f3bece743745_xxxx-(1).mp4', 'video/mp4', 'f5df0000-ae2c-4bd7-9770-f510a396ceb0');
INSERT INTO public.media VALUES ('5785f7dc-682b-46bb-b2c5-70b083b84dd7', '/vid/22/1/post5785f7dc-682b-46bb-b2c5-70b083b84dd7h-hong-linh-(1).mp4', 'video/mp4', 'f80e6772-b255-4ef3-8194-09193017625b');
INSERT INTO public.media VALUES ('f6edaeec-7777-41e9-8d2f-ca6dc1869b67', '/vid/22/1/postf6edaeec-7777-41e9-8d2f-ca6dc1869b67inggoodlife-(1).mp4', 'video/mp4', 'dff0c2e7-8c08-4cea-ba21-647e2627f7ad');
INSERT INTO public.media VALUES ('ed9a375f-3be4-461c-abfd-ec5d5cff332b', '/img/22/1/posted9a375f-3be4-461c-abfd-ec5d5cff332b1487643560_400.jpg', 'image/jpeg', 'b8f0eeb3-59a0-4e31-bca1-de6268bd0d02');


--
-- TOC entry 3417 (class 0 OID 17618)
-- Dependencies: 216
-- Data for Name: oauth2client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.oauth2client VALUES ('f4aeed53675ee', 604800, true, 'choydy.com', NULL, 2592000, '$2a$10$QjF2gJn8VaT5FCtLbp8O6OPTCa5N8R4ZLgPap5ibE/iOmiMC2oH.u');


--
-- TOC entry 3418 (class 0 OID 17623)
-- Dependencies: 217
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post VALUES ('907d7307-e2a1-4edf-b92c-a4dc12a08538', 0, 'Thần đồng Toán vs Thần đồng AV 😑😑😑😑😑😑', 42, 1, 'Thần đồng VN', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 2, false, 1640590825791);
INSERT INTO public.post VALUES ('906efcc1-9c83-4e96-8778-f03713965fa6', 0, '😐', 11, 0, 'Mệt mỏi mấy bà HÀNG XÓM', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640662630646);
INSERT INTO public.post VALUES ('a11f522a-f321-4b5c-a32e-6a561990fb25', NULL, 'Thôi xóa game là vừa 😂😂😂😂😂', 29, 3, 'Fifa 22', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 7, false, 1641436608011);
INSERT INTO public.post VALUES ('9bed30cb-b7be-4651-bf06-7733ef8bdec0', 0, '', 13, 0, 'Hảo quảng cáo =)))', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640661960550);
INSERT INTO public.post VALUES ('9514e12c-97ea-4382-98b2-8a9c95ce7a30', 0, '😆😆😆', 50, 1, 'Ò ó o làng nước ôiii', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 7, false, 1640661618983);
INSERT INTO public.post VALUES ('fc4f30e6-eb1f-4f6d-b001-6136e6be639c', 0, 'Lại là súp pơ ai đồ đây các cháu ạ', 13, 0, 'Cạn lời với quả ghép nhạc', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640663409006);
INSERT INTO public.post VALUES ('69829e52-ff51-4b5b-bb3d-1b61e4312287', 0, 'Thích xem z.u gái', 68, 0, 'Em cười xinh quá, cho anh xem z.ú cái', '89c3ba40-46a4-4885-887c-ab71a6a057f5', 10, false, 1640600631422);
INSERT INTO public.post VALUES ('786de890-3812-47ff-ad90-ec4e099c134e', 0, 'Em lỡ thái độ tý thôi mà 😐😐😐😐😐😐😐😐😐', 21, 1, 'Biết điều đó', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 5, false, 1640589971564);
INSERT INTO public.post VALUES ('ba18817e-222b-4f64-a0c8-d866a09acb6d', 0, '', 23, 0, 'Bruh ', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 7, false, 1640661408878);
INSERT INTO public.post VALUES ('23ba1ad0-761e-4845-92b9-400a5243c77f', NULL, 'Mày đứng im đó', 33, 0, 'Tới công chiện gòi', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 5, false, 1641439638679);
INSERT INTO public.post VALUES ('85b309bc-5283-4113-88d9-54945a80f36e', 0, '', 13, 0, 'thôi thôi mấy ông im moẹ mồm đi', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640598286632);
INSERT INTO public.post VALUES ('9ad1f4cf-8e68-47b2-972e-4c44bc188f8c', 0, 'là có thật nha mọi người 😭😭😭😂😺😸😸', 108, 1, 'Chó ngáp phải ruồi :v', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 10, false, 1640591167795);
INSERT INTO public.post VALUES ('4d340cc0-f391-473c-a2ea-2684c22a036e', 0, 'Ước gì có 1 con 😂😂😂', 17, 0, 'Chó biết nói', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 1, false, 1640588750269);
INSERT INTO public.post VALUES ('8a0cab0f-c931-414a-aff7-ba6fd05a535b', 0, 'còn non lắm', 28, 0, 'Ao chình!!!', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 14, false, 1640679164347);
INSERT INTO public.post VALUES ('66505493-b059-460e-8913-611fc014e800', 0, 'Thở cũng ra bóng', 27, 0, 'Đến việc thở cũng làm ta lao lực', '89c3ba40-46a4-4885-887c-ab71a6a057f5', 11, false, 1640600874338);
INSERT INTO public.post VALUES ('5e5c87ea-e253-4fd5-9749-04f6f0c21411', 0, 'Tới nóc 😕', 15, 0, 'Fly team', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640679560151);
INSERT INTO public.post VALUES ('0f6cd27f-9c0d-41c5-9d6e-00ab5f792d56', 0, '1 cây mà chả lên non, nhiều cây chụm lại thì chết chùm chứ sao 😂', 12, 0, 'Đi vào vết xe đổ', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640660884170);
INSERT INTO public.post VALUES ('f38d5aba-537a-4da0-926c-66aceb42cc37', 0, '😆😆😆😆😆😆😆', 30, 1, 'Khóc mà cười ....', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 6, false, 1640590509421);
INSERT INTO public.post VALUES ('c6a869aa-7898-4a97-ac45-84994e160b26', 0, 'Các Anh Tâm Thần mà đàn hát hay quá....👍', 15, 0, 'Anh này hát hay quá', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 1, false, 1640589024352);
INSERT INTO public.post VALUES ('6dc85dba-b12c-4ec1-b663-f9219c603683', 0, 'Trùm cuối không bao giờ làm ta thất vọng', 13, 0, 'Việt Nam mãi đỉnh', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640679410953);
INSERT INTO public.post VALUES ('0c0b4075-6b00-4160-bdc6-a93131f13b60', 0, '😂😂😂😂😂😂😂😂', 88, 2, 'Thua luôn', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 9, false, 1640589459877);
INSERT INTO public.post VALUES ('523ac955-a355-4716-be33-62df75caa2b5', 0, '', 13, 3, 'Phát minh đi vào lòng đất', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640662921590);
INSERT INTO public.post VALUES ('a0a878eb-df54-4e8b-8f19-722306a10977', NULL, 'Ụa tao tưởng miếng bún mà 😕', 17, 1, 'Cảnh giới cao nhất của ăn nhậu', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641439320699);
INSERT INTO public.post VALUES ('034f1e8e-dd65-447a-824c-6ec8e062ff22', NULL, 'ko đc lơ là khi chiến đấu 😂', 19, 1, 'Bonk ', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641439466081);
INSERT INTO public.post VALUES ('7fc30f18-0682-4852-8297-96e060252c0c', 0, '', 67, 1, 'Mặc kệ đời đi', '89c3ba40-46a4-4885-887c-ab71a6a057f5', 10, false, 1640598495956);
INSERT INTO public.post VALUES ('010261e4-731e-4f6e-a314-6486cedd8bbf', NULL, 'Khi vận đen đã chọn bạn thì bạn có mà chạy bằng trời', 22, 1, 'Mày làm 1 mình đi', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641439939586);
INSERT INTO public.post VALUES ('d1c4898d-a25b-4450-b080-43bb34dca92e', NULL, 'Ui mẹ ơi con chuột', 31, 0, 'Hỏi chấm', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 4, false, 1641440082907);
INSERT INTO public.post VALUES ('75691675-074b-4384-bbf3-c0b14870f4b9', 0, 'Đúng là con gái của ta 😅😅😅😅😅', 35, 15, 'Hảo con gái', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 9, false, 1640689994255);
INSERT INTO public.post VALUES ('7e52ba8d-795e-4363-bbe8-8b13d06e67d2', 0, 'Không một động tác thừa', 14, 0, 'Nhanh gọn', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640679269253);
INSERT INTO public.post VALUES ('0e05b0f0-4df8-4a28-8d31-953573d46f2a', 0, 'Còn mỗi cái nịt', 36, 0, 'Còn mỗi cái nịt', '89c3ba40-46a4-4885-887c-ab71a6a057f5', 2, false, 1640685410986);
INSERT INTO public.post VALUES ('2a261740-de09-4c90-90b9-5c69dc593017', 0, 'Thời thế thay đỗi quá 😏😏😏😏😏', 43, 1, 'Hảo ăn xin', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 8, false, 1640689410374);
INSERT INTO public.post VALUES ('40556c46-919f-478f-9f03-1c7e3f63f3a4', 0, '🙈🙈🙈🙈🙈🙈🙈', 31, 5, 'Thôi không đăng ký học nữa', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 8, false, 1640689664151);
INSERT INTO public.post VALUES ('8170ad1a-eefa-4a33-b4e3-2fd3f3b8b1ef', 0, '🙊🙉🤔', 13, 1, 'Thốn quá :v', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 1, false, 1640588511837);
INSERT INTO public.post VALUES ('7b57b08c-2e14-4b12-876d-a569cf7976a0', 0, 'Trong sáng lên bạn à', 22, 1, 'Như một thói quen', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640679823413);
INSERT INTO public.post VALUES ('7bfaba9a-ed75-4056-ae38-577f84752369', 0, 'Cũng chỉ vì miếng cơm cục cứk thôi mà 😭😭😭', 30, 0, 'Tàn nhẫn quá', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 13, false, 1640678670602);
INSERT INTO public.post VALUES ('725d08cc-a993-4d21-9b48-8133360a7f90', 0, 'Định chuyền mà thôi nghĩ lại tự làm cho lẹ 😅', 53, 7, 'Heung Min Son', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 3, false, 1640665972908);
INSERT INTO public.post VALUES ('01b9a56a-ffb0-4054-b8bc-320b7d4f6264', NULL, 'mày xong rồi, lụm chọt', 32, 3, 'Sao mà đỡ được ', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 7, false, 1641439008849);
INSERT INTO public.post VALUES ('c2b3f7fa-b14e-4d52-98b7-b56d0a14fb35', 0, '😰😰😰😰😰 chưa dám yêu ai', 19, 0, 'Số anh nghèo', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 1, false, 1640590186372);
INSERT INTO public.post VALUES ('c08a11ea-b4ac-4bb8-820f-183174e0d9f2', 0, 'Bản lĩnh thì có đấy nhưng khát nước thì không chịu được :v', 43, 1, 'Ơ kìa :'')', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 3, false, 1640665728245);
INSERT INTO public.post VALUES ('a1e1b234-53be-4cf8-9047-712b2b4bf052', NULL, '😍😍😍😍', 30, 2, 'Pha phối quá đỉnh', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 7, false, 1641437100927);
INSERT INTO public.post VALUES ('00a5809b-e026-4023-93cf-13098e84011c', 0, '"Mưa rừng" Phiên bản nghe xong sang chấn tâm lý luôn 😂🤣🤣', 18, 0, '"Mưa rừng"', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 7, false, 1640591004767);
INSERT INTO public.post VALUES ('eb7642c1-5385-4a72-895a-d7a0d1a8787d', NULL, 'mày ko thoát đc đâu con trai tu bi con tờ niu🤣', 280, 0, 'Chạy đằng trời', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641890817288);
INSERT INTO public.post VALUES ('c5c6f404-12f8-443c-a178-e1da4046366a', NULL, 'Nhà tắm là nơi sản sinh ra những ca sĩ ối dồi ôi nhất =)))', 111, 1, 'Sọt kin chu đờ múuuuuuuuuu', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641867816547);
INSERT INTO public.post VALUES ('4cff0eb4-6bd7-46a8-adb8-cd417a74d461', 0, 'Cuối cùng cũng gặp được người muốn chăm sóc cả đời nhưng lại bị vợ phản đối', 36, 2, 'Thôi anh không yêu nữa đâu :(', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640660598726);
INSERT INTO public.post VALUES ('22a8b3fc-2050-4c13-b0a2-f8bb03081334', NULL, 'Phản dame cực gắt ', 100, 4, 'á đù! khét đấy', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641461802820);
INSERT INTO public.post VALUES ('14295db4-80bd-46c9-9de2-e2f95d6ad176', NULL, 'Lần sau bàn trước với nó 1 tiếng cho đỡ giật mình :v', 147, 0, 'Hảo diễn viên phụ', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 5, false, 1641544680521);
INSERT INTO public.post VALUES ('bb407cc6-a7a1-44aa-8fc7-8cd44fb13083', NULL, 'Thức tỉnh luôn ', 186, 0, 'Bonk!!!', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641870451424);
INSERT INTO public.post VALUES ('6fb69ebf-aae2-422f-88a6-efc1b9020a70', NULL, 'Lâu lâu mới ghi bàn thì ăn mừng sao cho ngầu :v', 92, 3, 'Siêu phẩm', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 3, false, 1641457603615);
INSERT INTO public.post VALUES ('a12bb9dc-0175-44fe-9f7c-7cc6ecd0c2b6', NULL, 'gánh khum nổi nữa rồi :(', 80, 1, 'ôi bạn ơi', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 7, false, 1641457238646);
INSERT INTO public.post VALUES ('83510bfc-4e0a-4454-8de0-6a33bb2fb459', NULL, 'Mạng mẽo chán thật', 258, 0, 'ping 9999', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641544943189);
INSERT INTO public.post VALUES ('d0444fb9-d3d9-4270-93f7-30ec6d5b8c0c', NULL, '😂😂😂', 463, 1, 'Hiểu lầm thôi mà', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 4, false, 1641545457396);
INSERT INTO public.post VALUES ('4c1b86f6-4cb2-4116-8029-9550dd25c196', NULL, 'có ngày đứng tim với thằng sen này mất', 114, 0, 'j` zẫy trùi', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 4, false, 1641866298636);
INSERT INTO public.post VALUES ('b342eff2-8743-4ca8-9c43-8f7e64a8b1bd', NULL, 'Khi bạn đam mê tấu hài nhưng gia đình bắt đi đá bóng ', 34, 0, 'Sân cỏ là sân khấu', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 3, false, 1641455497741);
INSERT INTO public.post VALUES ('e736bfb6-df5a-4fbc-8e42-4de343598008', NULL, '', 261, 0, 'Nhức cái lách thiệt chứ', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641871493381);
INSERT INTO public.post VALUES ('baea97c9-4398-4601-9bc3-49ab80a9c35c', NULL, '😂.cưới sau.đi nét đã 😂', 94, 0, 'Thế là mất một thằng bạn chí cốt', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641458229788);
INSERT INTO public.post VALUES ('b7e4e405-1cd6-40ba-9bc6-11ea21197b0d', 0, 'Alo anh cảnh sát ơi! em đang ngủ trên tầng 2 thì bị xe đụng 😖', 12, 0, 'Khi mày quá đen @@', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1640662708437);
INSERT INTO public.post VALUES ('25ca0366-c3e8-482a-b2f5-41a4963c068d', NULL, 'Gia cát cơ hội 😀😀😀', 39, 1, 'Dương đông kích đồ ăn', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 4, false, 1641454757483);
INSERT INTO public.post VALUES ('2da23411-84f1-43dc-b652-2231b26be3eb', NULL, '😗😗😗😗😗😗', 154, 0, 'Mong là bố sẽ không quên nữa', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 12, false, 1641869201819);
INSERT INTO public.post VALUES ('db24c430-45f9-48fc-8798-12a46f8b03b9', NULL, 'A có nghe thấy tiếng quê chứ ê kéo dài', 37, 1, 'Luật hoa quả', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641455810515);
INSERT INTO public.post VALUES ('2840e8e3-4352-4076-8f18-298a2de48ec9', NULL, 'moẹ :v', 27, 0, 'Gọi tiếng má triều mến đi coan', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641454960400);
INSERT INTO public.post VALUES ('c9c83ae8-78b4-47a4-9fbd-ed96156d282f', NULL, 'quần lót nam giới 😐😐😐😐', 466, 2, 'Sịp Nam 50k', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 8, false, 1641635963485);
INSERT INTO public.post VALUES ('eb5a9660-472a-4c77-a483-dd546e7f3866', NULL, 'nghe mấy bài này riết rồi quên luôn bài gốc', 73, 2, 'Ám ảnh thiệc sự', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641457819050);
INSERT INTO public.post VALUES ('ddea4298-7dbb-4e3e-971e-b671165d6700', NULL, '', 262, 2, 'èo quéo :v', 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', 8, false, 1641872185871);
INSERT INTO public.post VALUES ('1f9c17a7-a0bf-4385-b18f-7959edb90cae', NULL, 'Xem như em chẳng may mà gặp phải thằng chủ này 😂', 49, 1, 'Mất phanh :(', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 4, false, 1641454545322);
INSERT INTO public.post VALUES ('1b876d25-2c80-489c-8359-216c640b492a', NULL, 'Cười mệt 😂', 59, 0, 'X2 giải trí ', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 3, false, 1641455683234);
INSERT INTO public.post VALUES ('5b014325-5829-4af6-8163-d3b7d61f1510', NULL, 'người bị tổn thương lại làm tổn thương chính mình 😂', 48, 1, '1 pha tự hủy', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641457022668);
INSERT INTO public.post VALUES ('685cea84-cea2-413d-98ad-779a2a041e22', NULL, '👌👌👌👌👌👌👌', 276, 2, 'Freefire', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 7, false, 1641803088590);
INSERT INTO public.post VALUES ('f5df0000-ae2c-4bd7-9770-f510a396ceb0', NULL, 'Pha này mà không nhanh trí là ngồi xe lăn như tụi kia thật rồi =)))', 419, 2, 'Đầu nhảy số nhanh thật', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641895588741);
INSERT INTO public.post VALUES ('1fa2a1d3-86e2-4258-a51d-bd7e01ad1e80', NULL, 'tha cho khầy đi 😂', 136, 0, 'Quế ề quê luôn =)))', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641868661895);
INSERT INTO public.post VALUES ('da1cb426-9ecc-47d3-b9c0-852ef71ccc26', NULL, 'Từ từ thôi anh ơi nghe ko kịp', 407, 3, 'Cách nhanh nhất để trở thành ráp pơ ', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641545162279);
INSERT INTO public.post VALUES ('9ec117cd-6ad3-4cf3-b7d9-f52783ae5f8e', NULL, 'leesin: tao mang mồi bén tới đây ae', 51, 1, 'Quả shipper chất lượng thực sự🤢', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 7, false, 1641456131214);
INSERT INTO public.post VALUES ('5aa86fc5-f8b1-491b-b794-ca625e73119b', NULL, 'Uống tới kiếp sau luôn :v', 270, 8, 'Xin cục đá', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641456565428);
INSERT INTO public.post VALUES ('639167d0-e81a-4925-a5c7-d05f8697a464', NULL, 'Tức đến đổi màu luôn', 107, 0, '*** ** cuộc đời', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641521315563);
INSERT INTO public.post VALUES ('e807e414-a178-4459-8a8e-8f407a645a6d', NULL, 'Đang buồn vào làm ván game giải trí, và đây là ván game giải trí đó', 65, 1, 'Khóc đến cạn mana luôn', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 7, false, 1641456382573);
INSERT INTO public.post VALUES ('0e55bae5-a9c4-4054-acf2-4b83cfc15906', NULL, '', 251, 1, 'Buồn thiu', 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', 13, false, 1641800838438);
INSERT INTO public.post VALUES ('9a9a702a-4948-4281-936c-671e3e91e27c', NULL, 'Con gì đây anh em', 53, 0, 'Lại trend mới à', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641457406712);
INSERT INTO public.post VALUES ('20c784e8-80aa-453e-b27c-4d087b1081b7', NULL, 'Ông làm cha tui tới đây là đủ rồi 😂', 128, 1, 'Mé đầu thai nhầm nhà rồi', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641544479645);
INSERT INTO public.post VALUES ('bb8305c1-60cb-47ed-b79e-f787182d3851', NULL, 'Quên chưa làm nút nhả mà đã test nút kẹp @@', 180, 3, 'Thôi hỏng rồi', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641544822863);
INSERT INTO public.post VALUES ('204a7faf-4382-4e64-a17f-a24b12e14cd8', NULL, 'Cái nết mê trai khó bỏ', 81, 0, 'Liêm sỉ gì tầm này nữa', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641458023437);
INSERT INTO public.post VALUES ('48934986-b56a-443c-92ae-d57900491656', 0, 'Bộ muốn làm thịt tui hay sao ? 🎉🎉🎉🎉😭😭😭', 20, 0, 'Bố mày éo muốn hỉu', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 2, false, 1640589260488);
INSERT INTO public.post VALUES ('4c7e69ba-1cda-4c00-bfc8-6d8d5cb9e74e', NULL, 'Nói cho tụi mày biết, dạo này tao không còn được zui tính như ngày xưa đâu nha …😌', 141, 1, 'Cười lên cho con cá nè', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 4, false, 1641888998050);
INSERT INTO public.post VALUES ('8edbd92c-cfc7-4cf3-bb39-ef05d0fe0c9b', NULL, '', 127, 0, 'Trai hư a ko phải diễn, Trai tốt a phải vào vai 😂😂', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641868455600);
INSERT INTO public.post VALUES ('b8f0eeb3-59a0-4e31-bca1-de6268bd0d02', NULL, 'Óc chó 🙏🙏🙏🙏🙏🙏', 171, 0, 'Lạnh lùng đi', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 13, false, 1641971193744);
INSERT INTO public.post VALUES ('f80e6772-b255-4ef3-8194-09193017625b', NULL, 'hết sức lưu ý nha mọi người', 195, 3, 'Góc cảnh tỉnh', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641960553015);
INSERT INTO public.post VALUES ('dff0c2e7-8c08-4cea-ba21-647e2627f7ad', NULL, 'Quá dảk', 190, 0, 'Dừa lắm', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 1, false, 1641969179144);


--
-- TOC entry 3419 (class 0 OID 17628)
-- Dependencies: 218
-- Data for Name: postlike; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.postlike VALUES (1641265487959, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', '40556c46-919f-478f-9f03-1c7e3f63f3a4', 'normal');
INSERT INTO public.postlike VALUES (1641265493900, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', '75691675-074b-4384-bbf3-c0b14870f4b9', 'heart');
INSERT INTO public.postlike VALUES (1641265892164, 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', '2a261740-de09-4c90-90b9-5c69dc593017', 'normal');
INSERT INTO public.postlike VALUES (1641302115126, '98f1edad-0410-4fa0-be8c-40133cc0d64f', 'f38d5aba-537a-4da0-926c-66aceb42cc37', 'love');
INSERT INTO public.postlike VALUES (1641302120437, '98f1edad-0410-4fa0-be8c-40133cc0d64f', '7b57b08c-2e14-4b12-876d-a569cf7976a0', 'haha');
INSERT INTO public.postlike VALUES (1641302124234, '98f1edad-0410-4fa0-be8c-40133cc0d64f', '5e5c87ea-e253-4fd5-9749-04f6f0c21411', 'sad');
INSERT INTO public.postlike VALUES (1641358777209, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', '2a261740-de09-4c90-90b9-5c69dc593017', 'sad');
INSERT INTO public.postlike VALUES (1641380602005, 'e01747f6-ed05-4031-9b6e-84a4a4c00644', '40556c46-919f-478f-9f03-1c7e3f63f3a4', 'ask');
INSERT INTO public.postlike VALUES (1641380604162, 'e01747f6-ed05-4031-9b6e-84a4a4c00644', '75691675-074b-4384-bbf3-c0b14870f4b9', 'heart');
INSERT INTO public.postlike VALUES (1641380611013, 'e01747f6-ed05-4031-9b6e-84a4a4c00644', '2a261740-de09-4c90-90b9-5c69dc593017', 'love');
INSERT INTO public.postlike VALUES (1641390766749, '936c8f18-493b-445b-8c35-cf533dd8f489', '0e05b0f0-4df8-4a28-8d31-953573d46f2a', 'haha');
INSERT INTO public.postlike VALUES (1641390775168, '936c8f18-493b-445b-8c35-cf533dd8f489', '7b57b08c-2e14-4b12-876d-a569cf7976a0', 'normal');
INSERT INTO public.postlike VALUES (1641390777622, '936c8f18-493b-445b-8c35-cf533dd8f489', '5e5c87ea-e253-4fd5-9749-04f6f0c21411', 'heart');
INSERT INTO public.postlike VALUES (1641390782380, '936c8f18-493b-445b-8c35-cf533dd8f489', '7e52ba8d-795e-4363-bbe8-8b13d06e67d2', 'normal');
INSERT INTO public.postlike VALUES (1641390788919, '936c8f18-493b-445b-8c35-cf533dd8f489', '75691675-074b-4384-bbf3-c0b14870f4b9', 'haha');
INSERT INTO public.postlike VALUES (1641470451261, '024bb75d-22f6-4390-9431-d0779a5409b6', '6fb69ebf-aae2-422f-88a6-efc1b9020a70', 'heart');
INSERT INTO public.postlike VALUES (1641470518425, '024bb75d-22f6-4390-9431-d0779a5409b6', '22a8b3fc-2050-4c13-b0a2-f8bb03081334', 'heart');
INSERT INTO public.postlike VALUES (1641470523965, '024bb75d-22f6-4390-9431-d0779a5409b6', 'baea97c9-4398-4601-9bc3-49ab80a9c35c', 'haha');
INSERT INTO public.postlike VALUES (1641470528691, '024bb75d-22f6-4390-9431-d0779a5409b6', '204a7faf-4382-4e64-a17f-a24b12e14cd8', 'heart');
INSERT INTO public.postlike VALUES (1641470536382, '024bb75d-22f6-4390-9431-d0779a5409b6', 'eb5a9660-472a-4c77-a483-dd546e7f3866', 'haha');
INSERT INTO public.postlike VALUES (1641525578050, '98f1edad-0410-4fa0-be8c-40133cc0d64f', '639167d0-e81a-4925-a5c7-d05f8697a464', 'haha');
INSERT INTO public.postlike VALUES (1641742697288, '40331b2a-27bb-4d99-8c78-65e72b46330e', 'c9c83ae8-78b4-47a4-9fbd-ed96156d282f', 'heart');
INSERT INTO public.postlike VALUES (1641742738656, '40331b2a-27bb-4d99-8c78-65e72b46330e', 'd0444fb9-d3d9-4270-93f7-30ec6d5b8c0c', 'haha');
INSERT INTO public.postlike VALUES (1641742748031, '40331b2a-27bb-4d99-8c78-65e72b46330e', 'da1cb426-9ecc-47d3-b9c0-852ef71ccc26', 'haha');
INSERT INTO public.postlike VALUES (1641742758560, '40331b2a-27bb-4d99-8c78-65e72b46330e', '83510bfc-4e0a-4454-8de0-6a33bb2fb459', 'haha');
INSERT INTO public.postlike VALUES (1641742777637, '40331b2a-27bb-4d99-8c78-65e72b46330e', 'bb8305c1-60cb-47ed-b79e-f787182d3851', 'haha');
INSERT INTO public.postlike VALUES (1641742810506, '40331b2a-27bb-4d99-8c78-65e72b46330e', '639167d0-e81a-4925-a5c7-d05f8697a464', 'haha');
INSERT INTO public.postlike VALUES (1641742874416, '40331b2a-27bb-4d99-8c78-65e72b46330e', '204a7faf-4382-4e64-a17f-a24b12e14cd8', 'haha');
INSERT INTO public.postlike VALUES (1641743008665, '40331b2a-27bb-4d99-8c78-65e72b46330e', '5b014325-5829-4af6-8163-d3b7d61f1510', 'haha');
INSERT INTO public.postlike VALUES (1641782502026, 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', 'c9c83ae8-78b4-47a4-9fbd-ed96156d282f', 'normal');
INSERT INTO public.postlike VALUES (1641782504490, 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', 'd0444fb9-d3d9-4270-93f7-30ec6d5b8c0c', 'normal');
INSERT INTO public.postlike VALUES (1641782510452, 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', 'da1cb426-9ecc-47d3-b9c0-852ef71ccc26', 'normal');
INSERT INTO public.postlike VALUES (1641782514745, 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', '83510bfc-4e0a-4454-8de0-6a33bb2fb459', 'normal');
INSERT INTO public.postlike VALUES (1641871416435, 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', '2da23411-84f1-43dc-b652-2231b26be3eb', 'normal');
INSERT INTO public.postlike VALUES (1641871449653, 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', '0e55bae5-a9c4-4054-acf2-4b83cfc15906', 'normal');
INSERT INTO public.postlike VALUES (1641886160045, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', 'e736bfb6-df5a-4fbc-8e42-4de343598008', 'normal');
INSERT INTO public.postlike VALUES (1641886222178, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', 'c5c6f404-12f8-443c-a178-e1da4046366a', 'haha');
INSERT INTO public.postlike VALUES (1641886322497, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', 'da1cb426-9ecc-47d3-b9c0-852ef71ccc26', 'haha');
INSERT INTO public.postlike VALUES (1641886431127, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '14295db4-80bd-46c9-9de2-e2f95d6ad176', 'haha');
INSERT INTO public.postlike VALUES (1641886481721, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '20c784e8-80aa-453e-b27c-4d087b1081b7', 'angry');
INSERT INTO public.postlike VALUES (1641984360351, '024bb75d-22f6-4390-9431-d0779a5409b6', 'dff0c2e7-8c08-4cea-ba21-647e2627f7ad', 'haha');
INSERT INTO public.postlike VALUES (1641984366134, '024bb75d-22f6-4390-9431-d0779a5409b6', 'f80e6772-b255-4ef3-8194-09193017625b', 'haha');
INSERT INTO public.postlike VALUES (1641886553798, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', 'baea97c9-4398-4601-9bc3-49ab80a9c35c', 'haha');
INSERT INTO public.postlike VALUES (1641886556941, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '22a8b3fc-2050-4c13-b0a2-f8bb03081334', 'normal');
INSERT INTO public.postlike VALUES (1641886588306, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '204a7faf-4382-4e64-a17f-a24b12e14cd8', 'ask');
INSERT INTO public.postlike VALUES (1641886918177, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '6fb69ebf-aae2-422f-88a6-efc1b9020a70', 'normal');
INSERT INTO public.postlike VALUES (1641886926754, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '9a9a702a-4948-4281-936c-671e3e91e27c', 'normal');
INSERT INTO public.postlike VALUES (1641886933329, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', 'a12bb9dc-0175-44fe-9f7c-7cc6ecd0c2b6', 'normal');
INSERT INTO public.postlike VALUES (1641886971467, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '5b014325-5829-4af6-8163-d3b7d61f1510', 'haha');
INSERT INTO public.postlike VALUES (1641886979687, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '5aa86fc5-f8b1-491b-b794-ca625e73119b', 'haha');
INSERT INTO public.postlike VALUES (1641887006997, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '2840e8e3-4352-4076-8f18-298a2de48ec9', 'haha');
INSERT INTO public.postlike VALUES (1641887010369, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '25ca0366-c3e8-482a-b2f5-41a4963c068d', 'haha');
INSERT INTO public.postlike VALUES (1641887015435, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', '1f9c17a7-a0bf-4385-b18f-7959edb90cae', 'haha');
INSERT INTO public.postlike VALUES (1641906790542, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', '2da23411-84f1-43dc-b652-2231b26be3eb', 'haha');
INSERT INTO public.postlike VALUES (1641908227167, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 'f5df0000-ae2c-4bd7-9770-f510a396ceb0', 'love');
INSERT INTO public.postlike VALUES (1641909420085, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 'eb7642c1-5385-4a72-895a-d7a0d1a8787d', 'haha');
INSERT INTO public.postlike VALUES (1641909496815, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 'e736bfb6-df5a-4fbc-8e42-4de343598008', 'haha');
INSERT INTO public.postlike VALUES (1641909619609, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 'bb407cc6-a7a1-44aa-8fc7-8cd44fb13083', 'haha');
INSERT INTO public.postlike VALUES (1641914083472, 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', '4c7e69ba-1cda-4c00-bfc8-6d8d5cb9e74e', 'normal');
INSERT INTO public.postlike VALUES (1641962236181, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 'f80e6772-b255-4ef3-8194-09193017625b', 'normal');
INSERT INTO public.postlike VALUES (1641962253638, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', '1fa2a1d3-86e2-4258-a51d-bd7e01ad1e80', 'haha');
INSERT INTO public.postlike VALUES (1641962257369, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', '8edbd92c-cfc7-4cf3-bb39-ef05d0fe0c9b', 'haha');
INSERT INTO public.postlike VALUES (1641962260621, '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', '4c1b86f6-4cb2-4116-8029-9550dd25c196', 'normal');
INSERT INTO public.postlike VALUES (1641984353817, '024bb75d-22f6-4390-9431-d0779a5409b6', 'b8f0eeb3-59a0-4e31-bca1-de6268bd0d02', 'haha');


--
-- TOC entry 3420 (class 0 OID 17631)
-- Dependencies: 219
-- Data for Name: posttag; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.posttag VALUES ('khỉ', '8170ad1a-eefa-4a33-b4e3-2fd3f3b8b1ef');
INSERT INTO public.posttag VALUES ('dog', '4d340cc0-f391-473c-a2ea-2684c22a036e');
INSERT INTO public.posttag VALUES ('nhac', 'c6a869aa-7898-4a97-ac45-84994e160b26');
INSERT INTO public.posttag VALUES ('hay', 'c6a869aa-7898-4a97-ac45-84994e160b26');
INSERT INTO public.posttag VALUES ('music', 'c6a869aa-7898-4a97-ac45-84994e160b26');
INSERT INTO public.posttag VALUES ('mat_day', '48934986-b56a-443c-92ae-d57900491656');
INSERT INTO public.posttag VALUES ('di_ngua', '48934986-b56a-443c-92ae-d57900491656');
INSERT INTO public.posttag VALUES ('karaoke', '0c0b4075-6b00-4160-bdc6-a93131f13b60');
INSERT INTO public.posttag VALUES ('hát', '0c0b4075-6b00-4160-bdc6-a93131f13b60');
INSERT INTO public.posttag VALUES ('dutrend', '786de890-3812-47ff-ad90-ec4e099c134e');
INSERT INTO public.posttag VALUES ('thaido', '786de890-3812-47ff-ad90-ec4e099c134e');
INSERT INTO public.posttag VALUES ('chongoan', '786de890-3812-47ff-ad90-ec4e099c134e');
INSERT INTO public.posttag VALUES ('dog', '786de890-3812-47ff-ad90-ec4e099c134e');
INSERT INTO public.posttag VALUES ('dicho', '786de890-3812-47ff-ad90-ec4e099c134e');
INSERT INTO public.posttag VALUES ('love', 'c2b3f7fa-b14e-4d52-98b7-b56d0a14fb35');
INSERT INTO public.posttag VALUES ('music', 'c2b3f7fa-b14e-4d52-98b7-b56d0a14fb35');
INSERT INTO public.posttag VALUES ('am_nhac', 'c2b3f7fa-b14e-4d52-98b7-b56d0a14fb35');
INSERT INTO public.posttag VALUES ('nhay_hay', 'c2b3f7fa-b14e-4d52-98b7-b56d0a14fb35');
INSERT INTO public.posttag VALUES ('khóc', 'f38d5aba-537a-4da0-926c-66aceb42cc37');
INSERT INTO public.posttag VALUES ('cười', 'f38d5aba-537a-4da0-926c-66aceb42cc37');
INSERT INTO public.posttag VALUES ('embe', 'f38d5aba-537a-4da0-926c-66aceb42cc37');
INSERT INTO public.posttag VALUES ('baby', 'f38d5aba-537a-4da0-926c-66aceb42cc37');
INSERT INTO public.posttag VALUES ('thầnđồng', '907d7307-e2a1-4edf-b92c-a4dc12a08538');
INSERT INTO public.posttag VALUES ('toánhoc', '907d7307-e2a1-4edf-b92c-a4dc12a08538');
INSERT INTO public.posttag VALUES ('english', '907d7307-e2a1-4edf-b92c-a4dc12a08538');
INSERT INTO public.posttag VALUES ('tienganh', '907d7307-e2a1-4edf-b92c-a4dc12a08538');
INSERT INTO public.posttag VALUES ('haixuyenviet', '00a5809b-e026-4023-93cf-13098e84011c');
INSERT INTO public.posttag VALUES ('muarung', '00a5809b-e026-4023-93cf-13098e84011c');
INSERT INTO public.posttag VALUES ('dog', '9ad1f4cf-8e68-47b2-972e-4c44bc188f8c');
INSERT INTO public.posttag VALUES ('ngap', '9ad1f4cf-8e68-47b2-972e-4c44bc188f8c');
INSERT INTO public.posttag VALUES ('#Chó', '66505493-b059-460e-8913-611fc014e800');
INSERT INTO public.posttag VALUES ('#funny', '7b57b08c-2e14-4b12-876d-a569cf7976a0');
INSERT INTO public.posttag VALUES ('an_xin', '2a261740-de09-4c90-90b9-5c69dc593017');
INSERT INTO public.posttag VALUES ('ăn_xin', '2a261740-de09-4c90-90b9-5c69dc593017');
INSERT INTO public.posttag VALUES ('box', '2a261740-de09-4c90-90b9-5c69dc593017');
INSERT INTO public.posttag VALUES ('nhà_hàng', '2a261740-de09-4c90-90b9-5c69dc593017');
INSERT INTO public.posttag VALUES ('CNTT', '40556c46-919f-478f-9f03-1c7e3f63f3a4');
INSERT INTO public.posttag VALUES ('đi_học', '40556c46-919f-478f-9f03-1c7e3f63f3a4');
INSERT INTO public.posttag VALUES ('IT', '40556c46-919f-478f-9f03-1c7e3f63f3a4');
INSERT INTO public.posttag VALUES ('con_gai', '75691675-074b-4384-bbf3-c0b14870f4b9');
INSERT INTO public.posttag VALUES ('bop_chim', '75691675-074b-4384-bbf3-c0b14870f4b9');
INSERT INTO public.posttag VALUES ('phu_huynh', '75691675-074b-4384-bbf3-c0b14870f4b9');
INSERT INTO public.posttag VALUES ('fifa', 'a1e1b234-53be-4cf8-9047-712b2b4bf052');
INSERT INTO public.posttag VALUES ('bóng_đá', 'a1e1b234-53be-4cf8-9047-712b2b4bf052');
INSERT INTO public.posttag VALUES ('phối_hợp', 'a1e1b234-53be-4cf8-9047-712b2b4bf052');
INSERT INTO public.posttag VALUES ('#florentino', '01b9a56a-ffb0-4054-b8bc-320b7d4f6264');
INSERT INTO public.posttag VALUES ('#lienquanmobile', '01b9a56a-ffb0-4054-b8bc-320b7d4f6264');
INSERT INTO public.posttag VALUES ('#saomadoduoc', '01b9a56a-ffb0-4054-b8bc-320b7d4f6264');
INSERT INTO public.posttag VALUES ('#nhau', 'a0a878eb-df54-4e8b-8f19-722306a10977');
INSERT INTO public.posttag VALUES ('#say', 'a0a878eb-df54-4e8b-8f19-722306a10977');
INSERT INTO public.posttag VALUES ('#bonk', '034f1e8e-dd65-447a-824c-6ec8e062ff22');
INSERT INTO public.posttag VALUES ('#chọcchó', '23ba1ad0-761e-4845-92b9-400a5243c77f');
INSERT INTO public.posttag VALUES ('#funny', '010261e4-731e-4f6e-a314-6486cedd8bbf');
INSERT INTO public.posttag VALUES ('meosochuot', 'd1c4898d-a25b-4450-b080-43bb34dca92e');
INSERT INTO public.posttag VALUES ('thucung', '1f9c17a7-a0bf-4385-b18f-7959edb90cae');
INSERT INTO public.posttag VALUES ('thucung', '25ca0366-c3e8-482a-b2f5-41a4963c068d');
INSERT INTO public.posttag VALUES ('funny', '2840e8e3-4352-4076-8f18-298a2de48ec9');
INSERT INTO public.posttag VALUES ('anhduc', '2840e8e3-4352-4076-8f18-298a2de48ec9');
INSERT INTO public.posttag VALUES ('tranthanh', '2840e8e3-4352-4076-8f18-298a2de48ec9');
INSERT INTO public.posttag VALUES ('bongda', 'b342eff2-8743-4ca8-9c43-8f7e64a8b1bd');
INSERT INTO public.posttag VALUES ('tauhai', 'b342eff2-8743-4ca8-9c43-8f7e64a8b1bd');
INSERT INTO public.posttag VALUES ('funny', 'b342eff2-8743-4ca8-9c43-8f7e64a8b1bd');
INSERT INTO public.posttag VALUES ('funny', '1b876d25-2c80-489c-8359-216c640b492a');
INSERT INTO public.posttag VALUES ('bongda', '1b876d25-2c80-489c-8359-216c640b492a');
INSERT INTO public.posttag VALUES ('funny', 'db24c430-45f9-48fc-8798-12a46f8b03b9');
INSERT INTO public.posttag VALUES ('tocchien', '9ec117cd-6ad3-4cf3-b7d9-f52783ae5f8e');
INSERT INTO public.posttag VALUES ('lmht', '9ec117cd-6ad3-4cf3-b7d9-f52783ae5f8e');
INSERT INTO public.posttag VALUES ('lol', 'e807e414-a178-4459-8a8e-8f407a645a6d');
INSERT INTO public.posttag VALUES ('lmht', 'e807e414-a178-4459-8a8e-8f407a645a6d');
INSERT INTO public.posttag VALUES ('funny', '5aa86fc5-f8b1-491b-b794-ca625e73119b');
INSERT INTO public.posttag VALUES ('funny', '5b014325-5829-4af6-8163-d3b7d61f1510');
INSERT INTO public.posttag VALUES ('funny', 'a12bb9dc-0175-44fe-9f7c-7cc6ecd0c2b6');
INSERT INTO public.posttag VALUES ('funny', '9a9a702a-4948-4281-936c-671e3e91e27c');
INSERT INTO public.posttag VALUES ('bongda', '6fb69ebf-aae2-422f-88a6-efc1b9020a70');
INSERT INTO public.posttag VALUES ('mucsic', 'eb5a9660-472a-4c77-a483-dd546e7f3866');
INSERT INTO public.posttag VALUES ('trend2021', 'eb5a9660-472a-4c77-a483-dd546e7f3866');
INSERT INTO public.posttag VALUES ('funny', '204a7faf-4382-4e64-a17f-a24b12e14cd8');
INSERT INTO public.posttag VALUES ('funny', 'baea97c9-4398-4601-9bc3-49ab80a9c35c');
INSERT INTO public.posttag VALUES ('funny', '22a8b3fc-2050-4c13-b0a2-f8bb03081334');
INSERT INTO public.posttag VALUES ('adu', '22a8b3fc-2050-4c13-b0a2-f8bb03081334');
INSERT INTO public.posttag VALUES ('funny', '639167d0-e81a-4925-a5c7-d05f8697a464');
INSERT INTO public.posttag VALUES ('duaxe', '20c784e8-80aa-453e-b27c-4d087b1081b7');
INSERT INTO public.posttag VALUES ('funny', '20c784e8-80aa-453e-b27c-4d087b1081b7');
INSERT INTO public.posttag VALUES ('dog', '14295db4-80bd-46c9-9de2-e2f95d6ad176');
INSERT INTO public.posttag VALUES ('choccho', '14295db4-80bd-46c9-9de2-e2f95d6ad176');
INSERT INTO public.posttag VALUES ('thucung', '14295db4-80bd-46c9-9de2-e2f95d6ad176');
INSERT INTO public.posttag VALUES ('haihuoc', 'bb8305c1-60cb-47ed-b79e-f787182d3851');
INSERT INTO public.posttag VALUES ('funny', 'bb8305c1-60cb-47ed-b79e-f787182d3851');
INSERT INTO public.posttag VALUES ('troll', 'bb8305c1-60cb-47ed-b79e-f787182d3851');
INSERT INTO public.posttag VALUES ('lag', '83510bfc-4e0a-4454-8de0-6a33bb2fb459');
INSERT INTO public.posttag VALUES ('funny', '83510bfc-4e0a-4454-8de0-6a33bb2fb459');
INSERT INTO public.posttag VALUES ('rapperkhoailang', 'da1cb426-9ecc-47d3-b9c0-852ef71ccc26');
INSERT INTO public.posttag VALUES ('khi', 'd0444fb9-d3d9-4270-93f7-30ec6d5b8c0c');
INSERT INTO public.posttag VALUES ('thucung', 'd0444fb9-d3d9-4270-93f7-30ec6d5b8c0c');
INSERT INTO public.posttag VALUES ('sịp', 'c9c83ae8-78b4-47a4-9fbd-ed96156d282f');
INSERT INTO public.posttag VALUES ('nam', 'c9c83ae8-78b4-47a4-9fbd-ed96156d282f');
INSERT INTO public.posttag VALUES ('boy', 'c9c83ae8-78b4-47a4-9fbd-ed96156d282f');
INSERT INTO public.posttag VALUES ('underpants', 'c9c83ae8-78b4-47a4-9fbd-ed96156d282f');
INSERT INTO public.posttag VALUES ('quầnlót', 'c9c83ae8-78b4-47a4-9fbd-ed96156d282f');
INSERT INTO public.posttag VALUES ('namgiới', 'c9c83ae8-78b4-47a4-9fbd-ed96156d282f');
INSERT INTO public.posttag VALUES ('freefire', '685cea84-cea2-413d-98ad-779a2a041e22');
INSERT INTO public.posttag VALUES ('garenafreefire', '685cea84-cea2-413d-98ad-779a2a041e22');
INSERT INTO public.posttag VALUES ('cugoilatuan', '685cea84-cea2-413d-98ad-779a2a041e22');
INSERT INTO public.posttag VALUES ('meo', '4c1b86f6-4cb2-4116-8029-9550dd25c196');
INSERT INTO public.posttag VALUES ('cat', '4c1b86f6-4cb2-4116-8029-9550dd25c196');
INSERT INTO public.posttag VALUES ('funny', '4c1b86f6-4cb2-4116-8029-9550dd25c196');
INSERT INTO public.posttag VALUES ('funny', 'c5c6f404-12f8-443c-a178-e1da4046366a');
INSERT INTO public.posttag VALUES ('hattrongnhatam', 'c5c6f404-12f8-443c-a178-e1da4046366a');
INSERT INTO public.posttag VALUES ('funny', '8edbd92c-cfc7-4cf3-bb39-ef05d0fe0c9b');
INSERT INTO public.posttag VALUES ('khầychua', '1fa2a1d3-86e2-4258-a51d-bd7e01ad1e80');
INSERT INTO public.posttag VALUES ('chrome', '2da23411-84f1-43dc-b652-2231b26be3eb');
INSERT INTO public.posttag VALUES ('bố', '2da23411-84f1-43dc-b652-2231b26be3eb');
INSERT INTO public.posttag VALUES ('quên', '2da23411-84f1-43dc-b652-2231b26be3eb');
INSERT INTO public.posttag VALUES ('internet', '2da23411-84f1-43dc-b652-2231b26be3eb');
INSERT INTO public.posttag VALUES ('funny', 'bb407cc6-a7a1-44aa-8fc7-8cd44fb13083');
INSERT INTO public.posttag VALUES ('funny', 'e736bfb6-df5a-4fbc-8e42-4de343598008');
INSERT INTO public.posttag VALUES ('mèo', '4c7e69ba-1cda-4c00-bfc8-6d8d5cb9e74e');
INSERT INTO public.posttag VALUES ('cat', '4c7e69ba-1cda-4c00-bfc8-6d8d5cb9e74e');
INSERT INTO public.posttag VALUES ('thú_cưng', '4c7e69ba-1cda-4c00-bfc8-6d8d5cb9e74e');
INSERT INTO public.posttag VALUES ('funny', 'eb7642c1-5385-4a72-895a-d7a0d1a8787d');
INSERT INTO public.posttag VALUES ('cười', 'eb7642c1-5385-4a72-895a-d7a0d1a8787d');
INSERT INTO public.posttag VALUES ('funny', 'f5df0000-ae2c-4bd7-9770-f510a396ceb0');
INSERT INTO public.posttag VALUES ('giảitri', 'f5df0000-ae2c-4bd7-9770-f510a396ceb0');
INSERT INTO public.posttag VALUES ('funny', 'f80e6772-b255-4ef3-8194-09193017625b');
INSERT INTO public.posttag VALUES ('sátkhuẩn', 'f80e6772-b255-4ef3-8194-09193017625b');
INSERT INTO public.posttag VALUES ('lol', 'dff0c2e7-8c08-4cea-ba21-647e2627f7ad');
INSERT INTO public.posttag VALUES ('funny', 'dff0c2e7-8c08-4cea-ba21-647e2627f7ad');
INSERT INTO public.posttag VALUES ('troll', 'dff0c2e7-8c08-4cea-ba21-647e2627f7ad');
INSERT INTO public.posttag VALUES ('chó', 'b8f0eeb3-59a0-4e31-bca1-de6268bd0d02');
INSERT INTO public.posttag VALUES ('dog', 'b8f0eeb3-59a0-4e31-bca1-de6268bd0d02');
INSERT INTO public.posttag VALUES ('lạnh', 'b8f0eeb3-59a0-4e31-bca1-de6268bd0d02');
INSERT INTO public.posttag VALUES ('ócchó', 'b8f0eeb3-59a0-4e31-bca1-de6268bd0d02');


--
-- TOC entry 3421 (class 0 OID 17639)
-- Dependencies: 220
-- Data for Name: user_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_sys VALUES ('89c3ba40-46a4-4885-887c-ab71a6a057f5', 'account-public', '2021-08-24 14:44:33', 'account-public', '2021-08-24 14:44:33', '/img/users/6ed264de8f2c45721c3d.jpg', true, 'Gió', '$2a$10$WA8hN3strVVgDfBcPscqfOQGmdZzmOC5dpezwHFkluk0TQ9CL2Sw.', 'quachdinhdugialai', 'quachdinhdugialai@gmail.com', true, 'Asia/Ho_Chi_Minh');
INSERT INTO public.user_sys VALUES ('e01747f6-ed05-4031-9b6e-84a4a4c00644', NULL, NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/AATXAJyN2ioajFeDaHilyy3th3hJKa1t8zkQ2FS9qroP=s96-c', true, 'Dy Choy', '$2a$10$4/7V2iv498xEzNlEtE1tDuUkcoNATaFcaj8Eb3loLwJ6.yFvhyMd6', 'choydy69@gmail.com', 'choydy69@gmail.com', false, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('936c8f18-493b-445b-8c35-cf533dd8f489', NULL, NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a-/AOh14GhXQxiqpeC9RNKEYlEs73luTq5UDjQsyFUZwnWOXA=s96-c', true, 'Đình Tạo Nguyễn', '$2a$10$6ySRS/DlThiOB5YDVEOkNeJnyV83isfHrDVuzYE3QcTaUOlVoyIaC', 'nuthancooltaoqn@gmail.com', 'nuthancooltaoqn@gmail.com', false, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('f780d5cc-4e88-41b0-bb7f-345f239a029b', NULL, NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a-/AOh14GiBqVrHBpzm-szaI6AeRUrt37gsHPGGwE2gACwb=s96-c', true, 'Tao Nguyen', '$2a$10$HaTi3IHXGwNyVC3RqL0GVOAuy1TGlE5VbG/PNtSmJR3b9t0j7fKWC', 'nuthanngabale@gmail.com', 'nuthanngabale@gmail.com', false, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('2f8cec53-8bd4-4b0a-bba0-3a8b8d4a5505', NULL, NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a-/AOh14GjqGDhQGCwSb41GFNNeE31BVn9nRjPaRoKUlRHUAx8=s96-c', true, 'Thanh Hoàng Ma', '$2a$10$yjljIrB/FT0uMrVuIqGkGujySKDSvO.fDu5SWPqthvK.M3UzATtYa', 'mathanhhoang2506@gmail.com', 'mathanhhoang2506@gmail.com', false, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('024bb75d-22f6-4390-9431-d0779a5409b6', NULL, NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/AATXAJyWHWeTgdsCxRNodcJ1J6sV75qfOhO_k3PD8GgS=s96-c', true, 'Sỹ Nguyễn Tiến', '$2a$10$5g/jC.nHiDyE6z0a7mp/G.Y9RlrNCdGPR8959xXyFH.LwDuLUKL3m', 'tiensybinhdinh@gmail.com', 'tiensybinhdinh@gmail.com', false, 'Asia/Bangkok');
INSERT INTO public.user_sys VALUES ('a3ac1529-44ad-491d-a4cb-d269c56d8538', NULL, NULL, NULL, NULL, 'https://graph.facebook.com/4131625933606174/picture', true, 'Tao Dinh', '$2a$10$T7AyvS/TiM6Gye9TO/JCYuaYAAxVNNeGtc9mw64KRO5KbEB6U8pJu', 'taoqnw@yahoo.com', 'taoqnw@yahoo.com', false, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('40331b2a-27bb-4d99-8c78-65e72b46330e', NULL, NULL, NULL, NULL, 'https://graph.facebook.com/2211505828989624/picture', true, 'Tống Xuân Nhiên', '$2a$10$OFTEo8OLvtg0wk2jCGPUL.KhA3jZEsWFLkU.pioukW5f4ZNdEnAa2', 'tong.xuannhien@gmail.com', 'tong.xuannhien@gmail.com', false, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('98f1edad-0410-4fa0-be8c-40133cc0d64f', 'account-public', '2021-08-24 14:44:33', 'account-public', '2021-08-24 14:44:33', '/img/logo/apple-touch-icon-60x60.png', true, 'Quản trị viên', '$2a$10$DYcLwIqu0Ss8Jvi2VgWoRuV909h1g2l7m9kWtEy8jSSRIKpTI36My', 'admin', 'no_email@choydy.com', true, 'Asia/Ho_Chi_Minh');
INSERT INTO public.user_sys VALUES ('9eb56abf-6d9e-4f06-b21c-76e12faead3f', 'account-public', '2021-08-24 14:44:33', 'account-public', '2021-08-24 14:44:33', '/img/users/69b48e6068f1a2affbe0.jpg', true, 'Nóng', '$2a$10$cYbr4fC09Zt8RoU8ilAWr.pzQ/FEeMHuXlU2s321jT45H1EPv5SN.', 'dinhtuankiet167', 'dinhtuankiet167@gmail.com', true, 'Asia/Ho_Chi_Minh');
INSERT INTO public.user_sys VALUES ('f055d2aa-cd20-4da7-a0a4-e50a39a975d0', 'account-public', '2021-08-24 14:44:33', 'account-public', '2021-08-24 14:44:33', '/img/users/0ab53efad56b1f35467a.jpg', true, 'ThienNT', '$2a$10$cYbr4fC09Zt8RoU8ilAWr.pzQ/FEeMHuXlU2s321jT45H1EPv5SN.', 'nguyentuthien1211', 'nguyentuthien1211@gmail.com', true, 'Asia/Ho_Chi_Minh');
INSERT INTO public.user_sys VALUES ('6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 'account-public', '2021-08-24 14:44:33', 'account-public', '2021-08-24 14:44:33', '/img/users/ad2fb2d8652e5519.jpg', true, 'Lê Văn Tèo', '$2a$10$cYbr4fC09Zt8RoU8ilAWr.pzQ/FEeMHuXlU2s321jT45H1EPv5SN.', 'ndtao2020', 'ndtao2020@gmail.com', true, 'Asia/Ho_Chi_Minh');
INSERT INTO public.user_sys VALUES ('efa748e1-d82e-465a-b379-447ac04d0d1a', NULL, NULL, NULL, NULL, 'https://graph.facebook.com/295619062624386/picture', true, 'Phạm Hoàng Lâm', '$2a$10$ioNhiIU61z/61rBoDrLNne6TNXBliQpLtEpNFwVVvI5saUKxC4tv6', 'lam245556667@gmail.com', 'lam245556667@gmail.com', false, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', NULL, NULL, NULL, NULL, 'https://graph.facebook.com/2205547069586271/picture', true, 'Uyên Nguyễn', '$2a$10$dsv5JpWvnGYGgCFcjq5JRO2Bbuc.fVrXjP5kAjNlbgm182xdt5zgm', 'angmaybuon_1997@yahoo.com.vn', 'angmaybuon_1997@yahoo.com.vn', false, 'Asia/Bangkok');
INSERT INTO public.user_sys VALUES ('94f2c5d4-03f6-4c30-9501-0f6d398a48e6', NULL, NULL, NULL, NULL, 'https://graph.facebook.com/2979647375581554/picture', true, 'Châu Phong', '$2a$10$SUV4YnRNPX66lXHU.R9M0e1HIryj46RlJGkC6QBHZti1CJGNj9tda', 'phongchautechnew@gmail.com', 'phongchautechnew@gmail.com', false, 'Asia/Saigon');


--
-- TOC entry 3423 (class 0 OID 17806)
-- Dependencies: 222
-- Data for Name: userauthority; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.userauthority VALUES ('98f1edad-0410-4fa0-be8c-40133cc0d64f', 'ADMIN');
INSERT INTO public.userauthority VALUES ('98f1edad-0410-4fa0-be8c-40133cc0d64f', 'USER');
INSERT INTO public.userauthority VALUES ('98f1edad-0410-4fa0-be8c-40133cc0d64f', 'EDITOR');
INSERT INTO public.userauthority VALUES ('9eb56abf-6d9e-4f06-b21c-76e12faead3f', 'ADMIN');
INSERT INTO public.userauthority VALUES ('f055d2aa-cd20-4da7-a0a4-e50a39a975d0', 'ADMIN');
INSERT INTO public.userauthority VALUES ('6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 'ADMIN');
INSERT INTO public.userauthority VALUES ('e01747f6-ed05-4031-9b6e-84a4a4c00644', 'USER');
INSERT INTO public.userauthority VALUES ('936c8f18-493b-445b-8c35-cf533dd8f489', 'USER');
INSERT INTO public.userauthority VALUES ('f780d5cc-4e88-41b0-bb7f-345f239a029b', 'USER');
INSERT INTO public.userauthority VALUES ('2f8cec53-8bd4-4b0a-bba0-3a8b8d4a5505', 'USER');
INSERT INTO public.userauthority VALUES ('024bb75d-22f6-4390-9431-d0779a5409b6', 'USER');
INSERT INTO public.userauthority VALUES ('a3ac1529-44ad-491d-a4cb-d269c56d8538', 'USER');
INSERT INTO public.userauthority VALUES ('40331b2a-27bb-4d99-8c78-65e72b46330e', 'USER');
INSERT INTO public.userauthority VALUES ('efa748e1-d82e-465a-b379-447ac04d0d1a', 'USER');
INSERT INTO public.userauthority VALUES ('a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', 'USER');
INSERT INTO public.userauthority VALUES ('94f2c5d4-03f6-4c30-9501-0f6d398a48e6', 'USER');


--
-- TOC entry 3424 (class 0 OID 17821)
-- Dependencies: 223
-- Data for Name: userdetail; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.userdetail VALUES ('Admin hệ thống', 'Quy Nhơn, Bình Định', '2005-05-11', 'MALE', '+999999999', '591300', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 'VN');
INSERT INTO public.userdetail VALUES ('Admin hệ thống', 'Quy Nhơn, Bình Định', '2005-05-11', 'MALE', '+999999999', '591300', '9eb56abf-6d9e-4f06-b21c-76e12faead3f', 'VN');
INSERT INTO public.userdetail VALUES ('Admin hệ thống', 'Quy Nhơn, Bình Định', '2005-05-11', 'MALE', '+999999999', '591300', 'f055d2aa-cd20-4da7-a0a4-e50a39a975d0', 'VN');
INSERT INTO public.userdetail VALUES ('Admin hệ thống', 'Quy Nhơn, Bình Định', '2005-05-11', 'MALE', '+999999999', '591300', '89c3ba40-46a4-4885-887c-ab71a6a057f5', 'VN');
INSERT INTO public.userdetail VALUES ('Admin hệ thống', 'Quy Nhơn, Bình Định', '2005-05-11', 'MALE', '+999999999', '591300', '6d9b1b19-4e06-4ede-b70b-ceb1830b2673', 'VN');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, 'e01747f6-ed05-4031-9b6e-84a4a4c00644', 'VI');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, '936c8f18-493b-445b-8c35-cf533dd8f489', 'VI');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, 'f780d5cc-4e88-41b0-bb7f-345f239a029b', 'VI');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, '2f8cec53-8bd4-4b0a-bba0-3a8b8d4a5505', 'VI');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, '024bb75d-22f6-4390-9431-d0779a5409b6', 'VI');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, 'a3ac1529-44ad-491d-a4cb-d269c56d8538', 'VI');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, '40331b2a-27bb-4d99-8c78-65e72b46330e', 'VI');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, 'efa748e1-d82e-465a-b379-447ac04d0d1a', 'VI');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d', 'VI');
INSERT INTO public.userdetail VALUES (NULL, NULL, NULL, NULL, NULL, NULL, '94f2c5d4-03f6-4c30-9501-0f6d398a48e6', 'VI');


--
-- TOC entry 3422 (class 0 OID 17794)
-- Dependencies: 221
-- Data for Name: usersocialnetwork; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usersocialnetwork VALUES ('1', 'choydy69@gmail.com', NULL, 'r30NYAvKZrXW0w10uc7FPyaIPN62', 'e01747f6-ed05-4031-9b6e-84a4a4c00644');
INSERT INTO public.usersocialnetwork VALUES ('1', 'nuthancooltaoqn@gmail.com', NULL, 'ASF30SAG2NVWFLFF7rJuPnsEm7D2', '936c8f18-493b-445b-8c35-cf533dd8f489');
INSERT INTO public.usersocialnetwork VALUES ('1', 'nuthanngabale@gmail.com', NULL, 'uyQPgxEzTWda08Kdk5ppdVrMrjo1', 'f780d5cc-4e88-41b0-bb7f-345f239a029b');
INSERT INTO public.usersocialnetwork VALUES ('1', 'mathanhhoang2506@gmail.com', NULL, 'p5bZsV9b9KRcBLlsywRd2H6QVn32', '2f8cec53-8bd4-4b0a-bba0-3a8b8d4a5505');
INSERT INTO public.usersocialnetwork VALUES ('1', 'tiensybinhdinh@gmail.com', NULL, 'M7d64jfkisaFfSTNfg0CHyQPhjY2', '024bb75d-22f6-4390-9431-d0779a5409b6');
INSERT INTO public.usersocialnetwork VALUES ('2', 'taoqnw@yahoo.com', NULL, 'fcodFOXS8cTvQiqUZyvG7hcxVDM2', 'a3ac1529-44ad-491d-a4cb-d269c56d8538');
INSERT INTO public.usersocialnetwork VALUES ('2', 'tong.xuannhien@gmail.com', NULL, 'N0J8KjEso3eQLGsCD7sGPrRA7Og1', '40331b2a-27bb-4d99-8c78-65e72b46330e');
INSERT INTO public.usersocialnetwork VALUES ('2', 'lam245556667@gmail.com', NULL, 'Ncjig9zxXTdHtNpf5PqizzPQJmx2', 'efa748e1-d82e-465a-b379-447ac04d0d1a');
INSERT INTO public.usersocialnetwork VALUES ('2', 'angmaybuon_1997@yahoo.com.vn', NULL, 'sZfdJCv2RbedTlskV7t6zLwPCCz2', 'a0156e76-ed94-4e5c-86f2-6d1ee62fca6d');
INSERT INTO public.usersocialnetwork VALUES ('2', 'phongchautechnew@gmail.com', NULL, 'bVp9IEiLwrVgF1PzNArAtM35kr53', '94f2c5d4-03f6-4c30-9501-0f6d398a48e6');


--
-- TOC entry 3431 (class 0 OID 0)
-- Dependencies: 209
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);


--
-- TOC entry 3219 (class 2606 OID 17658)
-- Name: authority authority_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authority
    ADD CONSTRAINT authority_pkey PRIMARY KEY (id);


--
-- TOC entry 3221 (class 2606 OID 17660)
-- Name: catalog catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT catalog_pkey PRIMARY KEY (id);


--
-- TOC entry 3223 (class 2606 OID 17662)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3225 (class 2606 OID 17664)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (iso);


--
-- TOC entry 3227 (class 2606 OID 17666)
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (code);


--
-- TOC entry 3229 (class 2606 OID 17670)
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- TOC entry 3231 (class 2606 OID 17672)
-- Name: oauth2client oauth2client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2client
    ADD CONSTRAINT oauth2client_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 17674)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- TOC entry 3238 (class 2606 OID 17676)
-- Name: postlike postlike_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postlike
    ADD CONSTRAINT postlike_pkey PRIMARY KEY (user_id, post_id);


--
-- TOC entry 3242 (class 2606 OID 17682)
-- Name: user_sys uk_5hl4w53pryqi6yvk9xlj9q7qn; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT uk_5hl4w53pryqi6yvk9xlj9q7qn UNIQUE (username);


--
-- TOC entry 3244 (class 2606 OID 17686)
-- Name: user_sys uk_pjjobtr3fx54k6d3hj8mgsoa5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT uk_pjjobtr3fx54k6d3hj8mgsoa5 UNIQUE (email);


--
-- TOC entry 3246 (class 2606 OID 17688)
-- Name: user_sys ukbyqgxl187y7aer3tki0jd0qr3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT ukbyqgxl187y7aer3tki0jd0qr3 UNIQUE (username, email);


--
-- TOC entry 3240 (class 2606 OID 17692)
-- Name: posttag ukle9i0p4tgtm9530kupkwxif1d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posttag
    ADD CONSTRAINT ukle9i0p4tgtm9530kupkwxif1d UNIQUE (post_id, tag);


--
-- TOC entry 3249 (class 2606 OID 17696)
-- Name: user_sys user_sys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT user_sys_pkey PRIMARY KEY (id);


--
-- TOC entry 3253 (class 2606 OID 17810)
-- Name: userauthority userauthority_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauthority
    ADD CONSTRAINT userauthority_pkey PRIMARY KEY (user_id, authority_id);


--
-- TOC entry 3255 (class 2606 OID 17827)
-- Name: userdetail userdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdetail
    ADD CONSTRAINT userdetail_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3251 (class 2606 OID 17800)
-- Name: usersocialnetwork usersocialnetwork_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersocialnetwork
    ADD CONSTRAINT usersocialnetwork_pkey PRIMARY KEY (user_id, social);


--
-- TOC entry 3232 (class 1259 OID 17703)
-- Name: idxgj2rd9ewi9h2p4pc09i6upyt1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idxgj2rd9ewi9h2p4pc09i6upyt1 ON public.post USING btree (created);


--
-- TOC entry 3233 (class 1259 OID 17704)
-- Name: idxote8luhmq2ditx56w37mviwny; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idxote8luhmq2ditx56w37mviwny ON public.post USING btree (title, content);


--
-- TOC entry 3234 (class 1259 OID 17705)
-- Name: idxs7ui38nhrh0c7q4nfpgf93bfk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idxs7ui38nhrh0c7q4nfpgf93bfk ON public.post USING btree (user_id);


--
-- TOC entry 3247 (class 1259 OID 17706)
-- Name: user_sys_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_sys_email_idx ON public.user_sys USING btree (email);


--
-- TOC entry 3269 (class 2606 OID 17828)
-- Name: userdetail fk174y51lt1lbl26clh4ymguuk3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdetail
    ADD CONSTRAINT fk174y51lt1lbl26clh4ymguuk3 FOREIGN KEY (country_iso) REFERENCES public.country(iso);


--
-- TOC entry 3267 (class 2606 OID 17811)
-- Name: userauthority fk1minklvli2mn2njbomxvef99g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauthority
    ADD CONSTRAINT fk1minklvli2mn2njbomxvef99g FOREIGN KEY (authority_id) REFERENCES public.authority(id);


--
-- TOC entry 3257 (class 2606 OID 17717)
-- Name: comment fk6kduoq1qgemmbt8ls3x37di8n; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk6kduoq1qgemmbt8ls3x37di8n FOREIGN KEY (parent_id) REFERENCES public.comment(id);


--
-- TOC entry 3270 (class 2606 OID 17833)
-- Name: userdetail fk9kj1yufdk6lpcvs4hc9aki689; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdetail
    ADD CONSTRAINT fk9kj1yufdk6lpcvs4hc9aki689 FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3258 (class 2606 OID 17727)
-- Name: comment fkay3w7wrk7vau26n7ix6crwl1l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fkay3w7wrk7vau26n7ix6crwl1l FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3256 (class 2606 OID 17789)
-- Name: catalog fkg02ng5e4xvt6kf5evmexw1k4j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT fkg02ng5e4xvt6kf5evmexw1k4j FOREIGN KEY (parent_id) REFERENCES public.catalog(id);


--
-- TOC entry 3265 (class 2606 OID 17742)
-- Name: posttag fkijuqbnbv01ixs71tbd58xkgkd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posttag
    ADD CONSTRAINT fkijuqbnbv01ixs71tbd58xkgkd FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- TOC entry 3268 (class 2606 OID 17816)
-- Name: userauthority fkjnag5ndsv1g0v1bsrwas0fibt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauthority
    ADD CONSTRAINT fkjnag5ndsv1g0v1bsrwas0fibt FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3261 (class 2606 OID 17752)
-- Name: post fkknuxya8iel3o3odnc1u2c7pp2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT fkknuxya8iel3o3odnc1u2c7pp2 FOREIGN KEY (catalog_id) REFERENCES public.catalog(id);


--
-- TOC entry 3266 (class 2606 OID 17801)
-- Name: usersocialnetwork fko7d0gpfdlq9if52g0fecsfxso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersocialnetwork
    ADD CONSTRAINT fko7d0gpfdlq9if52g0fecsfxso FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3259 (class 2606 OID 17762)
-- Name: comment fkqb0rnht649ifuh6gev5lwvx8x; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fkqb0rnht649ifuh6gev5lwvx8x FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- TOC entry 3263 (class 2606 OID 17767)
-- Name: postlike fkrfesdq1ogr4mt2qxfl241h6ud; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postlike
    ADD CONSTRAINT fkrfesdq1ogr4mt2qxfl241h6ud FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3262 (class 2606 OID 17772)
-- Name: post fkt4kvk5faoe6k9lmq0m7bvqjcg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT fkt4kvk5faoe6k9lmq0m7bvqjcg FOREIGN KEY (user_id) REFERENCES public.user_sys(id);


--
-- TOC entry 3260 (class 2606 OID 17777)
-- Name: media fktmgj1wjq6o74oq675050lhrb0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT fktmgj1wjq6o74oq675050lhrb0 FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- TOC entry 3264 (class 2606 OID 17782)
-- Name: postlike fkwy2u3sijki3uk1jhyq1wwujw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postlike
    ADD CONSTRAINT fkwy2u3sijki3uk1jhyq1wwujw FOREIGN KEY (post_id) REFERENCES public.post(id);


-- Completed on 2022-01-12 19:45:44

--
-- PostgreSQL database dump complete
--


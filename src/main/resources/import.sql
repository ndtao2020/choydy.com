CREATE TABLE public.authority (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);

ALTER TABLE public.authority OWNER TO postgres;

CREATE TABLE public.client (
    id bigint NOT NULL,
    created_by character varying(255),
    created_date timestamp without time zone,
    last_modified_by character varying(255),
    last_modified_date timestamp without time zone,
    description character varying(255),
    disable boolean,
    icon character varying(255),
    name character varying(255) NOT NULL,
    path character varying(255) NOT NULL,
    parent_id bigint
);

ALTER TABLE public.client OWNER TO postgres;

CREATE TABLE public.country (
    iso character varying(2) NOT NULL,
    display_name character varying(255) NOT NULL,
    iso3 character varying(3) NOT NULL,
    name character varying(255) NOT NULL,
    num_code integer NOT NULL,
    phone_code integer NOT NULL
);

ALTER TABLE public.country OWNER TO postgres;

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.hibernate_sequence OWNER TO postgres;

CREATE TABLE public.httpendpoint (
    id uuid NOT NULL,
    auth boolean NOT NULL,
    group_description character varying(255) NOT NULL,
    group_name character varying(255) NOT NULL,
    method character varying(150) NOT NULL,
    pattern character varying(255) NOT NULL,
    server_name character varying(255) NOT NULL,
    summary character varying(255)
);

ALTER TABLE public.httpendpoint OWNER TO postgres;

CREATE TABLE public.language (
    code character varying(2) NOT NULL,
    name character varying(255) NOT NULL,
    native_name character varying(255) NOT NULL,
    code3 character varying(3) NOT NULL
);

ALTER TABLE public.language OWNER TO postgres;

CREATE TABLE public.oauth2client (
    id uuid NOT NULL,
    access_token_validity integer NOT NULL,
    additional_information character varying(255),
    approve boolean NOT NULL,
    grant_types character varying(255) NOT NULL,
    redirect character varying(255),
    refresh_token_validity integer NOT NULL,
    resources character varying(255),
    scopes character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    domain character varying(255) NOT NULL
);

ALTER TABLE public.oauth2client OWNER TO postgres;

CREATE TABLE public.social_network (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    client_id character varying(255),
    client_secret character varying(255)
);

ALTER TABLE public.social_network OWNER TO postgres;

CREATE TABLE public.user_authority (
    id uuid NOT NULL,
    authority_id character varying(255) NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.user_authority OWNER TO postgres;

CREATE TABLE public.user_detail (
    id uuid NOT NULL,
    about text,
    birthday date,
    gender character varying(255),
    phone_number character varying(30),
    user_id uuid NOT NULL,
    address text,
    postal_code character varying(30),
    country_iso character varying(2) NOT NULL
);

ALTER TABLE public.user_detail OWNER TO postgres;

CREATE TABLE public.user_social_network (
    id uuid NOT NULL,
    avatar character varying(255),
    email character varying(255) NOT NULL,
    phone_number character varying(255),
    uid character varying(255) NOT NULL,
    social_network_id integer NOT NULL,
    user_id uuid NOT NULL
);

ALTER TABLE public.user_social_network OWNER TO postgres;

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

CREATE TABLE public.vocabulary (
    id uuid NOT NULL,
    created_by character varying(255),
    created_date timestamp without time zone,
    last_modified_by character varying(255),
    last_modified_date timestamp without time zone,
    selected bigint NOT NULL,
    view bigint NOT NULL,
    word character varying(255) NOT NULL,
    language_code character varying(2) NOT NULL,
    verified boolean NOT NULL,
    description text,
    plus character varying(255),
    color character varying(50)
);

ALTER TABLE public.vocabulary OWNER TO postgres;

CREATE TABLE public.word_type (
    id character varying(255) NOT NULL
);

ALTER TABLE public.word_type OWNER TO postgres;

INSERT INTO public.authority VALUES ('ADMIN', 'Quản trị viên');
INSERT INTO public.authority VALUES ('USER', 'Người dùng');
INSERT INTO public.authority VALUES ('EDITOR', 'Biên tập');

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

INSERT INTO public.language VALUES ('mh', 'Marshallese', 'Kajin Majel', 'mah');
INSERT INTO public.language VALUES ('mn', 'Mongolian', 'Монгол хэл', 'mon');
INSERT INTO public.language VALUES ('na', 'Nauru', 'Dorerin Naoero', 'nau');
INSERT INTO public.language VALUES ('nr', 'South Ndebele', 'isiNdebele', 'nbl');
INSERT INTO public.language VALUES ('nn', 'Norwegian Nynorsk', 'Norsk nynorsk', 'nno');
INSERT INTO public.language VALUES ('om', 'Oromo', 'Afaan Oromoo', 'orm');
INSERT INTO public.language VALUES ('oc', 'Occitan', 'occitan, lenga d''òc', 'oci');
INSERT INTO public.language VALUES ('os', 'Ossetian / Ossetic', 'ирон ӕвзаг', 'oss');
INSERT INTO public.language VALUES ('pl', 'Polish', 'język polski, polszczyzna', 'pol');
INSERT INTO public.language VALUES ('qu', 'Quechua', 'Runa Simi, Kichwa', 'que');
INSERT INTO public.language VALUES ('ps', 'Pashto / Pushto', 'پښتو', 'pus');
INSERT INTO public.language VALUES ('rm', 'Romansh', 'Rumantsch Grischun', 'roh');
INSERT INTO public.language VALUES ('rn', 'Rundi', 'Ikirundi', 'run');
INSERT INTO public.language VALUES ('sm', 'Samoan', 'gagana fa''a Samoa', 'smo');
INSERT INTO public.language VALUES ('sg', 'Sango', 'yângâ tî sängö', 'sag');
INSERT INTO public.language VALUES ('sr', 'Serbian', 'српски језик', 'srp');
INSERT INTO public.language VALUES ('sl', 'Slovenian', 'Slovenski jezik, Slovenščina', 'slv');
INSERT INTO public.language VALUES ('tl', 'Tagalog', 'Wikang Tagalog', 'tgl');
INSERT INTO public.language VALUES ('ty', 'Tahitian', 'Reo Tahiti', 'tah');
INSERT INTO public.language VALUES ('tt', 'Tatar', 'татар теле, tatar tele', 'tat');
INSERT INTO public.language VALUES ('bo', 'Tibetan', 'བོད་ཡིག', 'tib');
INSERT INTO public.language VALUES ('fy', 'Western Frisian', 'Frysk', 'fry');
INSERT INTO public.language VALUES ('eo', 'Esperanto', 'Esperanto', 'epo');
INSERT INTO public.language VALUES ('cv', 'Chuvash', 'Чăваш чӗлхи', 'chv');
INSERT INTO public.language VALUES ('aa', 'Afar', 'Afar', 'aar');
INSERT INTO public.language VALUES ('av', 'Avaric', 'авар мацӀ, магӀарул мацӀ', 'ava');
INSERT INTO public.language VALUES ('af', 'Afrikaans', 'Afrikaans', 'afr');
INSERT INTO public.language VALUES ('ts', 'Tsonga', 'Xitsonga', 'tso');
INSERT INTO public.language VALUES ('as', 'Assamese', 'অসমীয়া', 'asm');
INSERT INTO public.language VALUES ('ig', 'Igbo', 'Asụsụ Igbo', 'ibo');
INSERT INTO public.language VALUES ('ae', 'Avestan', 'Avestan', 'ave');
INSERT INTO public.language VALUES ('tn', 'Tswana', 'Setswana', 'tsn');
INSERT INTO public.language VALUES ('ti', 'Tigrinya', 'ትግርኛ', 'tir');
INSERT INTO public.language VALUES ('ta', 'Tamil', 'தமிழ்', 'tam');
INSERT INTO public.language VALUES ('sv', 'Swedish', 'Svenska', 'swe');
INSERT INTO public.language VALUES ('ss', 'Swati', 'SiSwati', 'ssw');
INSERT INTO public.language VALUES ('sc', 'Sardinian', 'Sardu', 'srd');
INSERT INTO public.language VALUES ('st', 'Southern Sotho', 'Sesotho', 'sot');
INSERT INTO public.language VALUES ('sn', 'Shona', 'chiShona', 'sna');
INSERT INTO public.language VALUES ('sd', 'Sindhi', 'सिनधि', 'snd');
INSERT INTO public.language VALUES ('sk', 'Slovak', 'Slovenčina', 'slo');
INSERT INTO public.language VALUES ('si', 'Sinhalese', 'සිංහල', 'sin');
INSERT INTO public.language VALUES ('ru', 'Russian', 'Русский', 'rus');
INSERT INTO public.language VALUES ('fa', 'Persian', 'فارسی', 'per');
INSERT INTO public.language VALUES ('pt', 'Portuguese', 'Português', 'por');
INSERT INTO public.language VALUES ('es', 'Spanish / Castilian', 'Español', 'spa');
INSERT INTO public.language VALUES ('no', 'Norwegian', 'Norsk', 'nor');
INSERT INTO public.language VALUES ('zh', 'Chinese', '中文 (Zhōngwén), 汉语, 漢語', 'chi');
INSERT INTO public.language VALUES ('or', 'Oriya', 'ଓଡ଼ିଆ', 'ori');
INSERT INTO public.language VALUES ('ne', 'Nepali', 'नेपाली', 'nep');
INSERT INTO public.language VALUES ('ng', 'Ndonga', 'Oshiwambo', 'ndo');
INSERT INTO public.language VALUES ('nv', 'Navajo / Navaho', 'Diné bizaad', 'nav');
INSERT INTO public.language VALUES ('mi', 'Maori', 'te reo Māori', 'mao');
INSERT INTO public.language VALUES ('mr', 'Marathi', 'मराठी', 'mar');
INSERT INTO public.language VALUES ('mt', 'Maltese', 'Malti', 'mlt');
INSERT INTO public.language VALUES ('lg', 'Ganda', 'Luganda', 'lug');
INSERT INTO public.language VALUES ('lb', 'Luxembourgish / Letzeburgesch', 'Lëtzebuergesch', 'ltz');
INSERT INTO public.language VALUES ('ln', 'Lingala', 'Lingála', 'lin');
INSERT INTO public.language VALUES ('lv', 'Latvian', 'Latviešu', 'lav');
INSERT INTO public.language VALUES ('li', 'Limburgan / Limburger / Limburgish', 'Limburgs', 'lim');
INSERT INTO public.language VALUES ('mk', 'Macedonian', 'македонски јазик', 'mac');
INSERT INTO public.language VALUES ('la', 'Latin', 'Latina', 'lat');
INSERT INTO public.language VALUES ('kg', 'Kongo', 'KiKongo', 'kon');
INSERT INTO public.language VALUES ('ko', 'Korean', '한국어', 'kor');
INSERT INTO public.language VALUES ('lo', 'Lao', 'ພາສາລາວ', 'lao');
INSERT INTO public.language VALUES ('ky', 'Kirghiz / Kyrgyz', 'Kırgızca / Кыргызча', 'kir');
INSERT INTO public.language VALUES ('ki', 'Kikuyu / Gikuyu', 'Gĩkũyũ', 'kik');
INSERT INTO public.language VALUES ('ks', 'Kashmiri', 'कश्मीरी / كشميري', 'kas');
INSERT INTO public.language VALUES ('kr', 'Kanuri', 'Kanuri', 'kau');
INSERT INTO public.language VALUES ('kv', 'Komi', 'коми кыв', 'kom');
INSERT INTO public.language VALUES ('it', 'Italian', 'Italiano', 'ita');
INSERT INTO public.language VALUES ('kl', 'Kalaallisut / Greenlandic', 'kalaallisut, kalaallit oqaasii', 'kal');
INSERT INTO public.language VALUES ('kk', 'Kazakh', 'қазақ тілі', 'kaz');
INSERT INTO public.language VALUES ('kn', 'Kannada', 'ಕನ್ನಡ', 'kan');
INSERT INTO public.language VALUES ('ie', 'Interlingue / Occidental', 'Interlingue', 'ile');
INSERT INTO public.language VALUES ('iu', 'Inuktitut', 'ᐃᓄᒃᑎᑐᑦ', 'iku');
INSERT INTO public.language VALUES ('ii', 'Sichuan Yi / Nuosu', 'ꆇꉙ / 四川彝语', 'iii');
INSERT INTO public.language VALUES ('ny', 'Chichewa / Chewa / Nyanja', 'ChiCheŵa, chinyanja', 'nya');
INSERT INTO public.language VALUES ('io', 'Ido', 'Ido', 'ido');
INSERT INTO public.language VALUES ('is', 'Icelandic', 'Íslenska', 'ice');
INSERT INTO public.language VALUES ('nl', 'Dutch / Flemish', 'Nederlands, Vlaams', 'dut');
INSERT INTO public.language VALUES ('hu', 'Hungarian', 'Magyar', 'hun');
INSERT INTO public.language VALUES ('he', 'Hebrew', 'עברית', 'heb');
INSERT INTO public.language VALUES ('hz', 'Herero', 'Otsiherero', 'her');
INSERT INTO public.language VALUES ('ho', 'Hiri Motu', 'Hiri Motu', 'hmo');
INSERT INTO public.language VALUES ('ht', 'Haitian / Haitian Creole', 'Krèyol ayisyen', 'hat');
INSERT INTO public.language VALUES ('ha', 'Hausa', 'هَوُسَ', 'hau');
INSERT INTO public.language VALUES ('ka', 'Georgian', 'ქართული', 'geo');
INSERT INTO public.language VALUES ('gd', 'Scottish Gaelic / Gaelic', 'Gàidhlig', 'gla');
INSERT INTO public.language VALUES ('ga', 'Irish', 'Gaeilge', 'gle');
INSERT INTO public.language VALUES ('gl', 'Galician', 'Galego', 'glg');
INSERT INTO public.language VALUES ('gn', 'Guarani', 'Avañe''ẽ', 'grn');
INSERT INTO public.language VALUES ('hi', 'Hindi', 'हिन्दी, हिंदी', 'hin');
INSERT INTO public.language VALUES ('fi', 'Finnish', 'Suomi', 'fin');
INSERT INTO public.language VALUES ('fr', 'French', 'Français', 'fre');
INSERT INTO public.language VALUES ('fo', 'Faroese', 'Føroyskt', 'fao');
INSERT INTO public.language VALUES ('ff', 'Fulah', 'Fulfulde, Pulaar, Pular', 'ful');
INSERT INTO public.language VALUES ('et', 'Estonian', 'Eesti', 'est');
INSERT INTO public.language VALUES ('ee', 'Ewe', 'Eʋegbe', 'ewe');
INSERT INTO public.language VALUES ('cs', 'Czech', 'Česky', 'cze');
INSERT INTO public.language VALUES ('da', 'Danish', 'Dansk', 'dan');
INSERT INTO public.language VALUES ('co', 'Corsican', 'Corsu', 'cos');
INSERT INTO public.language VALUES ('kw', 'Cornish', 'Kernewek', 'cor');
INSERT INTO public.language VALUES ('cr', 'Cree', 'Nehiyaw, 	ᓀᐦᐃᔭᐍᐏᐣ', 'cre');
INSERT INTO public.language VALUES ('ce', 'Chechen', 'Нохчийн мотт', 'che');
INSERT INTO public.language VALUES ('my', 'Burmese', 'မြန်မာစာ', 'bur');
INSERT INTO public.language VALUES ('ba', 'Bashkir', 'Башҡорт', 'bak');
INSERT INTO public.language VALUES ('eu', 'Basque', 'Euskara', 'baq');
INSERT INTO public.language VALUES ('bg', 'Bulgarian', 'Български език', 'bul');
INSERT INTO public.language VALUES ('bi', 'Bislama', 'Bislama', 'bis');
INSERT INTO public.language VALUES ('bs', 'Bosnian', 'Bosanski', 'bos');
INSERT INTO public.language VALUES ('ay', 'Aymara', 'Aymar', 'aym');
INSERT INTO public.language VALUES ('be', 'Belarusian', 'Беларуская мова', 'bel');
INSERT INTO public.language VALUES ('hy', 'Armenian', 'Հայերեն', 'arm');
INSERT INTO public.language VALUES ('ar', 'Arabic', 'العربية', 'ara');
INSERT INTO public.language VALUES ('am', 'Amharic', 'አማርኛ', 'amh');
INSERT INTO public.language VALUES ('sq', 'Albanian', 'Shqip', 'alb');
INSERT INTO public.language VALUES ('vi', 'Vietnamese', 'Tiếng Việt', 'vie');
INSERT INTO public.language VALUES ('en', 'English', 'English', 'eng');
INSERT INTO public.language VALUES ('zu', 'Zulu', 'isiZulu', 'zul');
INSERT INTO public.language VALUES ('nd', 'North Ndebele', 'isiNdebele', 'nde');
INSERT INTO public.language VALUES ('yo', 'Yoruba', 'Yorùbá', 'yor');
INSERT INTO public.language VALUES ('yi', 'Yiddish', 'ייִדיש', 'yid');
INSERT INTO public.language VALUES ('xh', 'Xhosa', 'isiXhosa', 'xho');
INSERT INTO public.language VALUES ('wo', 'Wolof', 'Wollof', 'wol');
INSERT INTO public.language VALUES ('vo', 'Volapük', 'Volapük', 'vol');
INSERT INTO public.language VALUES ('wa', 'Walloon', 'Walon', 'wln');
INSERT INTO public.language VALUES ('ak', 'Akan', 'Akana', 'aka');
INSERT INTO public.language VALUES ('bh', 'Bihari languages', 'भोजपुरी', 'bih');
INSERT INTO public.language VALUES ('ug', 'Uyghur', 'Uyƣurqə / ئۇيغۇرچە', 'uig');
INSERT INTO public.language VALUES ('uk', 'Ukrainian', 'Українська', 'ukr');
INSERT INTO public.language VALUES ('ur', 'Urdu', 'اردو', 'urd');
INSERT INTO public.language VALUES ('uz', 'Uzbek', 'Ўзбек', 'uzb');
INSERT INTO public.language VALUES ('ve', 'Venda', 'Tshivenḓa', 'ven');
INSERT INTO public.language VALUES ('cy', 'Welsh', 'Cymraeg', 'wel');
INSERT INTO public.language VALUES ('tr', 'Turkish', 'Türkçe', 'tur');
INSERT INTO public.language VALUES ('tw', 'Twi', 'Twi', 'twi');
INSERT INTO public.language VALUES ('tk', 'Turkmen', 'Туркмен / تركمن', 'tuk');
INSERT INTO public.language VALUES ('to', 'Tonga (Tonga Islands)', 'Lea Faka-Tonga', 'ton');
INSERT INTO public.language VALUES ('th', 'Thai', 'ไทย / Phasa Thai', 'tha');
INSERT INTO public.language VALUES ('te', 'Telugu', 'తెలుగు', 'tel');
INSERT INTO public.language VALUES ('sw', 'Swahili', 'Kiswahili', 'swa');
INSERT INTO public.language VALUES ('su', 'Sundanese', 'Basa Sunda', 'sun');
INSERT INTO public.language VALUES ('sa', 'Sanskrit', 'संस्कृतम्', 'san');
INSERT INTO public.language VALUES ('pi', 'Pali', 'Pāli / पाऴि', 'pli');
INSERT INTO public.language VALUES ('se', 'Northern Sami', 'Davvisámegiella', 'sme');
INSERT INTO public.language VALUES ('el', 'Greek', 'Ελληνικά', 'gre');
INSERT INTO public.language VALUES ('za', 'Zhuang / Chuang', 'Cuengh / Tôô / 壮语', 'zha');
INSERT INTO public.language VALUES ('ro', 'Romanian / Moldavian / Moldovan', 'Română', 'rum');
INSERT INTO public.language VALUES ('ml', 'Malayalam', 'മലയാളം', 'mal');
INSERT INTO public.language VALUES ('ku', 'Kurdish', 'Kurdî / كوردی', 'kur');
INSERT INTO public.language VALUES ('kj', 'Kuanyama / Kwanyama', 'Kuanyama', 'kua');
INSERT INTO public.language VALUES ('oj', 'Ojibwa', 'ᐊᓂᔑᓈᐯᒧᐎᓐ', 'oji');
INSERT INTO public.language VALUES ('id', 'Indonesian', 'Bahasa Indonesia', 'ind');
INSERT INTO public.language VALUES ('ia', 'Interlingua', 'Interlingua', 'ina');
INSERT INTO public.language VALUES ('de', 'German', 'Deutsch', 'ger');
INSERT INTO public.language VALUES ('gu', 'Gujarati', 'ગુજરાતી', 'guj');
INSERT INTO public.language VALUES ('dz', 'Dzongkha', 'ཇོང་ཁ', 'dzo');
INSERT INTO public.language VALUES ('dv', 'Divehi / Dhivehi / Maldivian', 'ދިވެހިބަސް', 'div');
INSERT INTO public.language VALUES ('ch', 'Chamorro', 'Chamoru', 'cha');
INSERT INTO public.language VALUES ('br', 'Breton', 'Brezhoneg', 'bre');
INSERT INTO public.language VALUES ('bm', 'Bambara', 'Bamanankan', 'bam');
INSERT INTO public.language VALUES ('bn', 'Bengali', 'বাংলা', 'ben');
INSERT INTO public.language VALUES ('az', 'Azerbaijani', 'Azərbaycanca / آذربايجان', 'aze');
INSERT INTO public.language VALUES ('an', 'Aragonese', 'Aragonés', 'arg');
INSERT INTO public.language VALUES ('ab', 'Abkhazian', 'аҧсуа бызшәа, аҧсшәа', 'abk');
INSERT INTO public.language VALUES ('nb', 'Norwegian Bokmål', 'Norsk bokmål', 'nob');
INSERT INTO public.language VALUES ('km', 'Central Khmer', 'ខ្មែរ, ខេមរភាសា, ភាសាខ្មែរ', 'khm');
INSERT INTO public.language VALUES ('ca', 'Catalan / Valencian', 'Català, valencià', 'cat');
INSERT INTO public.language VALUES ('hr', 'Croatian', 'Hrvatski jezik', 'hrv');
INSERT INTO public.language VALUES ('fj', 'Fijian', 'Vosa Vakaviti', 'fij');
INSERT INTO public.language VALUES ('ik', 'Inupiaq', 'Iñupiaq, Iñupiatun', 'ipk');
INSERT INTO public.language VALUES ('ja', 'Japanese', '日本語 (にほんご)', 'jpn');
INSERT INTO public.language VALUES ('jv', 'Javanese', 'ꦧꦱꦗꦮ, Basa Jawa', 'jav');
INSERT INTO public.language VALUES ('rw', 'Kinyarwanda', 'Ikinyarwanda', 'kin');
INSERT INTO public.language VALUES ('lt', 'Lithuanian', 'lietuvių kalba', 'lit');
INSERT INTO public.language VALUES ('lu', 'Luba-Katanga', 'Kiluba', 'lub');
INSERT INTO public.language VALUES ('mg', 'Malagasy', 'fiteny malagasy', 'mlg');
INSERT INTO public.language VALUES ('ms', 'Malay', 'Bahasa Melayu, بهاس ملايو', 'may');
INSERT INTO public.language VALUES ('gv', 'Manx', 'Gaelg, Gailck', 'glv');
INSERT INTO public.language VALUES ('pa', 'Punjabi / Panjabi', 'ਪੰਜਾਬੀ / पंजाबी / پنجابي', 'pan');
INSERT INTO public.language VALUES ('cu', 'Church Slavic / Old Slavonic / Church Slavonic / Old Bulgarian / Old Church Slavonic', 'ѩзыкъ словѣньскъ', 'chu');
INSERT INTO public.language VALUES ('so', 'Somali', 'Soomaaliga, af Soomaali', 'som');
INSERT INTO public.language VALUES ('tg', 'Tajik', 'тоҷикӣ, toçikī, تاجیکی', 'tgk');

INSERT INTO public.social_network VALUES (1, 'GOOGLE', NULL, NULL);
INSERT INTO public.social_network VALUES (2, 'FACEBOOK', NULL, NULL);

INSERT INTO public.user_authority VALUES ('be8b3e2b-8284-441e-9905-2e316a30b902', 'ADMIN', '98f1edad-0410-4fa0-be8c-40133cc0d64f');
INSERT INTO public.user_authority VALUES ('98f1edad-0410-4fa0-be8c-40133cc0d64f', 'USER', '98f1edad-0410-4fa0-be8c-40133cc0d64f');
INSERT INTO public.user_authority VALUES ('da3a324e-12c2-4b3a-9b8e-473c41c6ca58', 'EDITOR', '98f1edad-0410-4fa0-be8c-40133cc0d64f');
INSERT INTO public.user_authority VALUES ('93491647-f0c2-4dae-90cf-cd356d0cc98b', 'USER', '3dd60931-0698-4739-88c7-22dacddd1ba1');
INSERT INTO public.user_authority VALUES ('28aea60d-9c76-479f-a8c3-139c3823dc10', 'USER', '64acaf13-87b2-4f4e-bda2-84efe5681026');
INSERT INTO public.user_authority VALUES ('9bf1f394-86af-4a88-91ff-d34b4d300ad0', 'USER', '00a994a7-0186-496d-82f8-61d26a9ef8d4');
INSERT INTO public.user_authority VALUES ('80f98956-5d81-412b-a664-5a5f8b6999fd', 'USER', '1786c558-fc8d-42fa-86c9-6f97f0f87b0e');

INSERT INTO public.user_detail VALUES ('98f1edad-0410-4fa0-be8c-40133cc0d64f', 'Admin hệ thống', '1995-05-25', 'MALE', '+999999999', '98f1edad-0410-4fa0-be8c-40133cc0d64f', 'Quy Nhơn, Bình Định', '591300', 'VN');
INSERT INTO public.user_detail VALUES ('01d182ed-2a5c-4a3d-b17a-2906dd52c61f', NULL, NULL, NULL, NULL, '3dd60931-0698-4739-88c7-22dacddd1ba1', NULL, NULL, 'VI');
INSERT INTO public.user_detail VALUES ('819dad0c-75a7-4a38-b559-70ce1f0f0397', NULL, NULL, NULL, NULL, '64acaf13-87b2-4f4e-bda2-84efe5681026', NULL, NULL, 'VI');
INSERT INTO public.user_detail VALUES ('c4b90599-039e-4a5f-9698-4af6aa628430', NULL, NULL, NULL, NULL, '00a994a7-0186-496d-82f8-61d26a9ef8d4', NULL, NULL, 'VI');
INSERT INTO public.user_detail VALUES ('68b7cebd-e694-4639-97f0-34f50b144bce', NULL, NULL, NULL, NULL, '1786c558-fc8d-42fa-86c9-6f97f0f87b0e', NULL, NULL, 'VI');

INSERT INTO public.user_social_network VALUES ('ca4295e2-793b-4254-b094-9cd37053bc16', 'https://lh3.googleusercontent.com/a-/AOh14GiXPRLvtwrs9PF3_aWHm4ZIDey7-8CWCvXAzu-E=s96-c', 'ndtao2020@gmail.com', NULL, 'aAPRw31W0BOmZFZDi6njB8EZNtN2', 1, '3dd60931-0698-4739-88c7-22dacddd1ba1');
INSERT INTO public.user_social_network VALUES ('549ed6d8-4790-46cd-adfa-2b924ac823db', 'https://lh3.googleusercontent.com/a-/AOh14GiBqVrHBpzm-szaI6AeRUrt37gsHPGGwE2gACwb=s96-c', 'nuthanngabale@gmail.com', NULL, '0Yp9RIVa4FY7CQi2lqrlrHPzhwi2', 1, '64acaf13-87b2-4f4e-bda2-84efe5681026');
INSERT INTO public.user_social_network VALUES ('a51ad0a3-964d-4cab-b812-c3def65b4c7d', 'https://lh3.googleusercontent.com/a-/AOh14GhXQxiqpeC9RNKEYlEs73luTq5UDjQsyFUZwnWOXA=s96-c', 'nuthancooltaoqn@gmail.com', NULL, 'GT3JgvhyBmViJSezaMUkDy6u00P2', 1, '00a994a7-0186-496d-82f8-61d26a9ef8d4');
INSERT INTO public.user_social_network VALUES ('5f714676-478a-4d2f-9390-5df122fc1502', 'https://lh3.googleusercontent.com/a/AATXAJwXAwTcL8lHydt_BQLuAKX18VdjxGrW0kuaP9JW=s96-c', 'dvcquocgia2019@gmail.com', NULL, 'AocXPCSQswS7lldKgh1KhF33PcE2', 1, '1786c558-fc8d-42fa-86c9-6f97f0f87b0e');

INSERT INTO public.user_sys VALUES ('3dd60931-0698-4739-88c7-22dacddd1ba1', 'system', '2021-09-05 14:01:37.900435', 'system', '2021-09-05 14:01:37.930716', 'https://lh3.googleusercontent.com/a-/AOh14GiXPRLvtwrs9PF3_aWHm4ZIDey7-8CWCvXAzu-E=s96-c', true, 'Teo GN', '$2a$10$cYsb/fv.GwxxGEc3IKVqOucYYzg31/PDG9gWCGlPWrSQurryHFn0C', '95fcb34475ee43878f0716cf3a2dbee7', 'ndtao2020@gmail.com', false, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('1786c558-fc8d-42fa-86c9-6f97f0f87b0e', 'system', '2021-09-06 13:56:56.779786', 'system', '2021-09-06 14:00:47.469698', 'https://lh3.googleusercontent.com/a/AATXAJwXAwTcL8lHydt_BQLuAKX18VdjxGrW0kuaP9JW=s96-c', true, 'Đình Tạo Nguyễn', '$2a$10$cYsb/fv.GwxxGEc3IKVqOucYYzg31/PDG9gWCGlPWrSQurryHFn0C', '6c6ce1ebbe4348358053a811847f77b0', 'dvcquocgia2019@gmail.com', true, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('64acaf13-87b2-4f4e-bda2-84efe5681026', 'system', '2021-09-05 14:21:24.142107', 'system', '2021-09-06 14:32:21.445091', 'https://lh3.googleusercontent.com/a-/AOh14GiBqVrHBpzm-szaI6AeRUrt37gsHPGGwE2gACwb=s96-c', true, 'Tao Nguyen', '$2a$10$cYsb/fv.GwxxGEc3IKVqOucYYzg31/PDG9gWCGlPWrSQurryHFn0C', 'fa42d78d2db148168542488a63e52686', 'nuthanngabale@gmail.com', true, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('00a994a7-0186-496d-82f8-61d26a9ef8d4', 'system', '2021-09-06 13:05:20.706604', 'system', '2021-09-07 00:50:07.727248', 'https://lh3.googleusercontent.com/a-/AOh14GhXQxiqpeC9RNKEYlEs73luTq5UDjQsyFUZwnWOXA=s96-c', true, 'Đình Tạo Nguyễn', '$2a$10$cYsb/fv.GwxxGEc3IKVqOucYYzg31/PDG9gWCGlPWrSQurryHFn0C', '0cafb114e2694698b050b4b130ca4dbe', 'nuthancooltaoqn@gmail.com', true, 'Asia/Saigon');
INSERT INTO public.user_sys VALUES ('98f1edad-0410-4fa0-be8c-40133cc0d64f', 'account-public', '2021-08-24 14:44:33', 'account-public', '2021-08-24 14:44:33', 'https://lh3.googleusercontent.com/a/AATXAJwXAwTcL8lHydt_BQLuAKX18VdjxGrW0kuaP9JW=s96-c', true, 'Nguyễn Đình Tạo', '$2a$10$cYsb/fv.GwxxGEc3IKVqOucYYzg31/PDG9gWCGlPWrSQurryHFn0C', 'taoqn', 'no_email@nhactuvung.com', true, 'Asia/Ho_Chi_Minh');

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);

ALTER TABLE ONLY public.authority
    ADD CONSTRAINT authority_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (iso);
ALTER TABLE ONLY public.httpendpoint
    ADD CONSTRAINT httpendpoint_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (code);
ALTER TABLE ONLY public.oauth2client
    ADD CONSTRAINT oauth2client_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.social_network
    ADD CONSTRAINT social_network_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_social_network
    ADD CONSTRAINT uk1h6b3iioqeqns0ejuegpxsmj8 UNIQUE (user_id, social_network_id);
ALTER TABLE ONLY public.social_network
    ADD CONSTRAINT uk_24rhxyj4ln5m62y587aeihiyc UNIQUE (name);
ALTER TABLE ONLY public.httpendpoint
    ADD CONSTRAINT uk_4fdrv5gsfdnsxrp6ebtpr6j9w UNIQUE (pattern);
ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT uk_5hl4w53pryqi6yvk9xlj9q7qn UNIQUE (username);
ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_6cv9qq72takklp1s5loqv4vxd UNIQUE (path);
ALTER TABLE ONLY public.user_detail
    ADD CONSTRAINT uk_dm7hrxg9mvrb92v1p3o6wg97u UNIQUE (user_id);
ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT ukbyqgxl187y7aer3tki0jd0qr3 UNIQUE (username, email);
ALTER TABLE ONLY public.vocabulary
    ADD CONSTRAINT ukg99y7ggd9rvkds2jn9cj325l2 UNIQUE (word, language_code);
ALTER TABLE ONLY public.user_authority
    ADD CONSTRAINT uko947w16xae78hftq2qqo6xnii UNIQUE (user_id, authority_id);
ALTER TABLE ONLY public.user_authority
    ADD CONSTRAINT user_authority_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_detail
    ADD CONSTRAINT user_detail_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_social_network
    ADD CONSTRAINT user_social_network_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_sys
    ADD CONSTRAINT user_sys_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.vocabulary
    ADD CONSTRAINT vocabulary_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.word_type
    ADD CONSTRAINT word_type_pkey PRIMARY KEY (id);

CREATE INDEX idxio0gt6c5hcmadygqxglcjppjn ON public.vocabulary USING btree (word);
CREATE INDEX idxpanr77uyodjseroh8h8ojya1 ON public.vocabulary USING btree (created_date);
CREATE INDEX idxq5e0nnpknixh1461grlifug41 ON public.vocabulary USING btree (view, selected, verified);
CREATE UNIQUE INDEX user_sys_email_idx ON public.user_sys USING btree (email);

ALTER TABLE ONLY public.vocabulary
    ADD CONSTRAINT fk3kbxto4wu5fbk9yvcxdmxuwea FOREIGN KEY (language_code) REFERENCES public.language(code);
ALTER TABLE ONLY public.client
    ADD CONSTRAINT fka5xorssq88rm7m966xhmn7fjk FOREIGN KEY (parent_id) REFERENCES public.client(id);
ALTER TABLE ONLY public.user_social_network
    ADD CONSTRAINT fkelhp5v4mmmc10xci2n6pu4466 FOREIGN KEY (user_id) REFERENCES public.user_sys(id);
ALTER TABLE ONLY public.user_authority
    ADD CONSTRAINT fkgvxjs381k6f48d5d2yi11uh89 FOREIGN KEY (authority_id) REFERENCES public.authority(id);
ALTER TABLE ONLY public.user_social_network
    ADD CONSTRAINT fkhkkllhhe0ffhrq44yl5p2n62e FOREIGN KEY (social_network_id) REFERENCES public.social_network(id);
ALTER TABLE ONLY public.user_detail
    ADD CONSTRAINT fkjg6wf58bwqhdx9irh3yng86lm FOREIGN KEY (user_id) REFERENCES public.user_sys(id);
ALTER TABLE ONLY public.user_detail
    ADD CONSTRAINT fkl2geb8158qrkmalu266siwghx FOREIGN KEY (country_iso) REFERENCES public.country(iso);
ALTER TABLE ONLY public.user_authority
    ADD CONSTRAINT fkpo68rl9tdsgxhwhfih3ghsuq8 FOREIGN KEY (user_id) REFERENCES public.user_sys(id);

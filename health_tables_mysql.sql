CREATE TABLE kh_article_tag_health ( 
	`value`              integer  NOT NULL ,
	resource_type        smallint  NOT NULL ,
	tag                  varchar(64)   ,
	description          varchar(64)   ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT uni_article_tag_health UNIQUE ( resource_type, tag ) ,
	CONSTRAINT pk_kh_article_tag_health_value PRIMARY KEY ( `value` )
 );


CREATE TABLE kh_articles_feed ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	title                varchar(256)  NOT NULL ,
	lang                 varchar(8)   ,
	resource_type        smallint   ,
	disease_id           bigint   ,
	drug_id              bigint   ,
	article_tag          integer,
	create_type          smallint  NOT NULL ,
	creator_id           bigint   ,
	source_url           varchar(256)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_kh_articles_feed_id PRIMARY KEY ( id )
 );


CREATE TABLE kh_articles_feed_detail ( 
	article_id           bigint  NOT NULL ,
	content              text   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_articles_feed_detail_article_id PRIMARY KEY ( article_id ),
	CONSTRAINT fk_kh_articles_feed_detail FOREIGN KEY ( article_id ) REFERENCES kh_articles_feed( id )  
 );

CREATE TABLE kh_disease ( 
	disease_id           bigint  NOT NULL AUTO_INCREMENT ,
	name_english         varchar(160)   ,
	name_chinese         varchar(160)   ,
	category_id          integer   ,
	source_url           varchar(256)   ,
	spider_job_id        bigint   ,
	check_status         smallint DEFAULT 0  ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	CONSTRAINT pk_kh_disease_disease_id PRIMARY KEY ( disease_id )
 );
CREATE INDEX idx_disease_name_eng ON kh_disease ( name_english );
CREATE INDEX idx_disease_name_chn ON kh_disease ( name_chinese );


CREATE TABLE kh_disease_article ( 
	article_id           bigint  NOT NULL AUTO_INCREMENT ,
	name                 varchar(160)  NOT NULL ,
	disease_id           bigint   ,
	`language`           varchar(8)   ,
	is_primary           smallint DEFAULT 0  ,
	show_type            smallint DEFAULT 0  ,
	article_tag          integer   ,
	source_url           varchar(256)  NOT NULL ,
	site_url             varchar(128)  NOT NULL ,
	source_sitetag       varchar(64)   ,
	source_name          varchar(96)   ,
	spider_job_id        bigint   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	check_status         smallint   ,
	check_time           timestamp NULL  ,
	CONSTRAINT pk_kh_disease_article_id PRIMARY KEY ( article_id ),
	CONSTRAINT fk_kh_disease_article FOREIGN KEY ( disease_id ) REFERENCES kh_disease( disease_id )  
 );
CREATE INDEX idx_disease_article_diseaseid ON kh_disease_article ( disease_id );


CREATE TABLE kh_disease_article_detail ( 
	article_id           bigint  NOT NULL ,
	full_article         text   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_disease_detail_id PRIMARY KEY ( article_id ),
	CONSTRAINT fk_kh_disease_detail FOREIGN KEY ( article_id ) REFERENCES kh_disease_article( article_id )  
 );


CREATE TABLE kh_disease_article_detail_text ( 
	article_id           bigint  NOT NULL ,
	full_article         text   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_disease_detail_id_0 PRIMARY KEY ( article_id ),
	CONSTRAINT fk_kh_disease_detail_text FOREIGN KEY ( article_id ) REFERENCES kh_disease_article( article_id )  
 );


CREATE TABLE kh_disease_category ( 
	id                   integer  NOT NULL AUTO_INCREMENT ,
	name                 varchar(160)  NOT NULL ,
	name_english         varchar(160)   ,
	is_leaf_node         bit DEFAULT 0  ,
	parent_path          varchar(512)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_medical_category_0 PRIMARY KEY ( id )
 );

CREATE TABLE kh_disease_content ( 
	disease_id           bigint  NOT NULL AUTO_INCREMENT ,
	name                 varchar(160)   ,
	`language`           varchar(8)   ,
	symptoms             text   ,
	need_extract         smallint DEFAULT 0  ,
	article_source       varchar(192)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	CONSTRAINT pk_kh_disease_disease_id_0 PRIMARY KEY ( disease_id ),
	CONSTRAINT fk_kh_disease_content FOREIGN KEY ( disease_id ) REFERENCES kh_disease( disease_id )  
 );


CREATE TABLE kh_disease_symptom_items ( 
	disease_id           bigint  NOT NULL ,
	symptom_index        integer  NOT NULL ,
	disease_name         varchar(160)   ,
	`language`           varchar(8)   ,
	symptom              varchar(256)   ,
	relationship         varchar(32)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	-- embedding            text COMMENT 'vector(768)'   ,
	CONSTRAINT pk_kh_disease_symptom PRIMARY KEY ( disease_id, symptom_index ),
	CONSTRAINT fk_kh_disease_symptom_items FOREIGN KEY ( disease_id ) REFERENCES kh_disease( disease_id )  
 );

CREATE TABLE kh_symptoms_collection ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	name                 varchar(256)   ,
	code                 varchar(64)   ,
	descript             varchar(256)   ,
	prop_inpart          varchar(128)   ,
	source_site          varchar(128)   ,
	source_code          varchar(16)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	CONSTRAINT pk_kh_symptoms_collection_id PRIMARY KEY ( id )
 );


CREATE TABLE kh_drug ( 
	drug_id              bigint  NOT NULL AUTO_INCREMENT ,
	name_english         varchar(128)   ,
	name_chinese         varchar(128)   ,
	name_general_temp    varchar(300)   ,
	name_brand_temp      varchar(128)   ,
	is_zhongyao          smallint DEFAULT 0  ,
	category_id          integer   ,
	is_general           smallint   ,
	general_drug_id      bigint   ,
	source_url           varchar(256)   ,
	spider_job_id        bigint   ,
	check_status         smallint DEFAULT 0  ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	id_action_webmd      varchar(16)   ,
	CONSTRAINT pk_kh_drug PRIMARY KEY ( drug_id )
 );
CREATE INDEX idx_drug_name_eng ON kh_drug ( name_english );
CREATE INDEX idx_drug_name_chn ON kh_drug ( name_chinese );



CREATE TABLE kh_drug_article ( 
	article_id           bigint  NOT NULL AUTO_INCREMENT ,
	name                 varchar(128)  NOT NULL ,
	name_general         varchar(300)   ,
	name_brand           varchar(128)   ,
	name_english         varchar(128)   ,
	drug_id              bigint  NOT NULL ,
	`language`           varchar(8)   ,
	is_primary           smallint DEFAULT 0  ,
	show_type            smallint DEFAULT 0  ,
	article_tag          integer DEFAULT 1  ,
	source_url           varchar(256)  NOT NULL ,
	site_url             varchar(128)  NOT NULL ,
	source_sitetag       varchar(64)   ,
	source_name          varchar(96)   ,
	spider_job_id        bigint   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	check_status         smallint DEFAULT 0 NOT NULL ,
	check_time           timestamp NULL  ,
	CONSTRAINT idx_uni_sourceurl_article UNIQUE ( source_url ) ,
	CONSTRAINT pk_kh_drug_article PRIMARY KEY ( article_id ),
	CONSTRAINT fk_kh_drug_article FOREIGN KEY ( drug_id ) REFERENCES kh_drug( drug_id )  
 );
CREATE INDEX idx_drug_article_drugid ON kh_drug_article ( drug_id );


CREATE TABLE kh_drug_article_detail ( 
	article_id           bigint  NOT NULL ,
	full_article         text   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_drug_article_detail PRIMARY KEY ( article_id ),
	CONSTRAINT fk_kh_drug_article_detail FOREIGN KEY ( article_id ) REFERENCES kh_drug_article( article_id )  
 );


CREATE TABLE kh_drug_article_detail_text ( 
	article_id           bigint  NOT NULL ,
	full_article         text   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_drug_article_detail_text PRIMARY KEY ( article_id ),
	CONSTRAINT fk_kh_medical_article_detail_text FOREIGN KEY ( article_id ) REFERENCES kh_drug_article( article_id )  
 );


CREATE TABLE kh_drug_category ( 
	id                   integer  NOT NULL AUTO_INCREMENT ,
	name                 varchar(128)  NOT NULL ,
	name_english         varchar(128)   ,
	is_leaf_node         bit DEFAULT 0  ,
	parent_path          varchar(512)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_drug_category PRIMARY KEY ( id )
 );

CREATE TABLE kh_drug_dose ( 
	drug_id              bigint  NOT NULL ,
	form                 smallint   ,
	unit_type            smallint   ,
	unit_value           integer   ,
	CONSTRAINT pk_kh_drug_dose_drug_id PRIMARY KEY ( drug_id ),
	CONSTRAINT fk_kh_drug_dose_kh_drug FOREIGN KEY ( drug_id ) REFERENCES kh_drug( drug_id )  
 );


CREATE TABLE kh_spider_job ( 
	job_id               bigint  NOT NULL AUTO_INCREMENT ,
	resource_type        smallint   ,
	site_url             varchar(128)  NOT NULL ,
	source_sitetag       varchar(64)   ,
	status_list          smallint DEFAULT 1  ,
	status_detail        smallint DEFAULT 1  ,
	start_time_list      timestamp NULL  ,
	end_time_list        timestamp NULL  ,
	start_time_detail    timestamp NULL  ,
	end_time_detail      timestamp NULL  ,
	total_number_list    bigint   ,
	total_detail_finished bigint   ,
	last_detail_id       bigint   ,
	spider_detail_times  integer   ,
	failed_number        integer   ,
	job_console_log      varchar(1000)   ,
	CONSTRAINT pk_kh_medicine_scra_job_id PRIMARY KEY ( job_id )
 );


CREATE TABLE kh_spider_job_items ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	resource_type        smallint   ,
	name                 varchar(128)  NOT NULL ,
	source_url           varchar(256)  NOT NULL ,
	site_url             varchar(128)   ,
	source_sitetag       varchar(64)   ,
	`language`           varchar(8)   ,
	status               smallint   ,
	spider_time          timestamp NULL  ,
	spider_end_time      timestamp NULL  ,
	hash_article         varchar(128)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	job_id               bigint   ,
	spider_log           varchar(512)   ,
	CONSTRAINT pk_kh_spider_job_items_id PRIMARY KEY ( id ),
	CONSTRAINT fk_kh_spider_items_job_id FOREIGN KEY ( job_id ) REFERENCES kh_spider_job( job_id )  
 );


CREATE TABLE kh_spider_source_site ( 
	site_url             varchar(128)  NOT NULL ,
	resource_type        smallint  NOT NULL ,
	source_sitetag       varchar(64) DEFAULT '' NOT NULL ,
	site_entrance_url    varchar(256)   ,
	source_page_pattern  varchar(256)   ,
	extract_source_rule  varchar(512)   ,
	last_scan_date       timestamp NULL  ,
	CONSTRAINT idx_kh_medicine_scrawl_source_site_0 PRIMARY KEY ( source_sitetag, resource_type, site_url )
 );


CREATE TABLE kh_user ( 
	id                   bigint  NOT NULL AUTO_INCREMENT,
	name                 varchar(128) ,
	email                varchar(256)  NOT NULL,
	gender               smallint   ,
	birth_year           smallint   ,
	locale               varchar(16)   ,
	timezone             varchar(32)   ,
	lang                 varchar(8)   ,
	country              varchar(8)   ,
	password             char(60)   ,
	token_seed           char(6)  NOT NULL,
	verify_status        smallint DEFAULT 0,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	CONSTRAINT pk_kh_user_id PRIMARY KEY ( id ),
	CONSTRAINT uqi_kh_user_email UNIQUE ( email ) 
 );



CREATE TABLE kh_user_email_token ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	user_id              bigint  NOT NULL ,
	email                varchar(256)  NOT NULL,
	token_type           smallint  NOT NULL ,
	token                varchar(64)  NOT NULL ,
	status               smallint DEFAULT 1 NOT NULL ,
	due_time             timestamp  NOT NULL ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp NULL,
	CONSTRAINT uni_kh_user_email_token UNIQUE (token) ,
	CONSTRAINT pk_kh_user_email_token_id PRIMARY KEY (id)
 );
ALTER TABLE kh_user_email_token ADD CONSTRAINT fk_user_email_token_id FOREIGN KEY (user_id) REFERENCES kh_user(id);



CREATE TABLE kh_user_disease ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	user_id              bigint  NOT NULL ,
	disease_id           bigint   ,
	disease_name         varchar(128)   ,
	status               smallint   ,
	start_date           timestamp NULL  ,
	end_date             timestamp NULL  ,
	notes                varchar(256),
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_kh_user_disease_id PRIMARY KEY ( id ),
	CONSTRAINT fk_kh_user_disease_kh_user FOREIGN KEY ( user_id ) REFERENCES kh_user( id )  
 );


CREATE TABLE kh_user_disease_detail ( 
	user_disease_id      bigint  NOT NULL ,
	illness              text   ,
	treatment            text   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_kh_user_disease_detail_user_disease_id PRIMARY KEY ( user_disease_id ),
	CONSTRAINT fk_kh_user_disease_detail FOREIGN KEY ( user_disease_id ) REFERENCES kh_user_disease( id )  
 );


CREATE TABLE kh_user_drug ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	user_id              bigint   ,
	drug_id              bigint   ,
	drug_name            varchar(128)   ,
	status               smallint   ,
	drug_form            smallint   ,
	drug_unit_type       smallint   ,
	drug_unit_value      integer   ,
	start_date           timestamp NULL  ,
	end_date             timestamp NULL  ,
	reminder_start_date  timestamp NULL  ,
	frequency_type       smallint   ,
	days_interval        integer   ,
	days_inweek          varchar(16),
	times_aday           integer   ,
	quantity             numeric(4,2)   ,
	notes                varchar(256)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	CONSTRAINT pk_kh_drug_takeinfo_id PRIMARY KEY ( id ),
	CONSTRAINT fk_kh_user_drug_kh_user FOREIGN KEY ( user_id ) REFERENCES kh_user( id )  
 );


CREATE TABLE kh_user_favorites ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	user_id              bigint  NOT NULL ,
	content_id           bigint  NOT NULL ,
	content_type         smallint DEFAULT 1 NOT NULL ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_kh_user_favorites_id PRIMARY KEY ( id ),
	CONSTRAINT fk_kh_user_favorites_kh_user FOREIGN KEY ( user_id ) REFERENCES kh_user( id )  
 );


CREATE TABLE kh_disease_drug ( 
	disease_id           bigint  NOT NULL ,
	drug_id              bigint  NOT NULL ,
	treate_desc          varchar(4000)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_disease_drug PRIMARY KEY ( disease_id, drug_id ),
	CONSTRAINT fk_kh_disease_drug_2 FOREIGN KEY ( drug_id ) REFERENCES kh_drug( drug_id )  ,
	CONSTRAINT fk_kh_disease_drug FOREIGN KEY ( disease_id ) REFERENCES kh_disease( disease_id )  
 );


CREATE TABLE kh_drug_remind_time ( 
	user_drug_id         bigint  NOT NULL ,
	schedule_time        time  NOT NULL ,
	quantity             numeric(4,2)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	CONSTRAINT pk_kh_drug_remind_time PRIMARY KEY ( user_drug_id, schedule_time ),
	CONSTRAINT fk_kh_drug_remind_time FOREIGN KEY ( user_drug_id ) REFERENCES kh_user_drug( id )  
 );


CREATE TABLE kh_drug_takeinfo ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	user_drug_id         bigint  NOT NULL ,
	user_id              bigint  NOT NULL ,
	schedule_daytime     timestamp  NOT NULL ,
	take_time            timestamp NULL  ,
	quantity             numeric(4,2)   ,
	status               smallint  NOT NULL,
	notes                varchar(256)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_kh_drug_takeinfo_id_0 PRIMARY KEY ( id ),
	CONSTRAINT fk_kh_drug_takeinfo FOREIGN KEY ( user_drug_id ) REFERENCES kh_user_drug( id )  ,
	CONSTRAINT fk_kh_drug_takeinfo_kh_user FOREIGN KEY ( user_id ) REFERENCES kh_user( id )  ,
	CONSTRAINT uqi_kh_drug_takeinfo UNIQUE ( user_drug_id, schedule_daytime ) 
 );


CREATE TABLE kh_user_disease_drug ( 
	user_drug_id         bigint  NOT NULL ,
	user_disease_id      bigint  NOT NULL ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	update_time          timestamp NULL  ,
	CONSTRAINT fk_kh_user_disease_drug_1 FOREIGN KEY ( user_drug_id ) REFERENCES kh_user_drug( id )  ,
	CONSTRAINT fk_kh_user_disease_drug_2 FOREIGN KEY ( user_disease_id ) REFERENCES kh_user_disease( id )  
 );


CREATE TABLE kh_disease_relation ( 
	disease_id_source    bigint  NOT NULL ,
	disease_id_target    bigint  NOT NULL ,
	relation             varchar(64)  NOT NULL ,
	data_source          varchar(128)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL 
 );


CREATE TABLE kh_resource_forum_category ( 
	resource_type        smallint  NOT NULL ,
	resource_id          bigint  NOT NULL ,
	`language`           varchar(8)  NOT NULL ,
	category_id          bigint,
	category_name        varchar(160),
	sync_status          smallint DEFAULT 0 NOT NULL ,
	sync_message         varchar(256),
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_resource_forum_category PRIMARY KEY ( resource_type, resource_id, `language` )
 );

CREATE TABLE kh_forum_user_sync ( 
	user_id              bigint  NOT NULL ,
	user_id_forum        bigint   ,
	sync_action          varchar(8),
	sync_status          smallint DEFAULT 0 NOT NULL ,
	sync_message         varchar(256)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_kh_forum_user_sync_user_id PRIMARY KEY ( user_id )
 );


CREATE TABLE kh_tracking_generate_status ( 
	user_id              bigint  NOT NULL ,
	tracking_day         timestamp  NOT NULL ,
	status               smallint DEFAULT 0 NOT NULL ,
	record_number        integer   ,
	job_id               bigint   ,
	notes                varchar(128)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_tracking_generate_status PRIMARY KEY ( user_id, tracking_day )
 );


CREATE TABLE kh_user_measure_track ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	user_id              bigint  NOT NULL ,
	name                 varchar(128)   ,
	measure_type         smallint  NOT NULL ,
	value1               numeric(6,2)  NOT NULL ,
	value2               numeric(6,2)   ,
	happen_time          timestamp  NOT NULL ,
	notes                varchar(256)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp NULL   ,
	CONSTRAINT pk_kh_user_measure_record_id PRIMARY KEY ( id )
 );
ALTER TABLE kh_user_measure_track ADD CONSTRAINT fk_kh_user_measure_track FOREIGN KEY ( user_id ) REFERENCES kh_user( id );


CREATE TABLE kh_user_capability ( 
	user_id              bigint  NOT NULL ,
	capacity_name        varchar(32)  NOT NULL ,
	enabled              boolean  NOT NULL ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_kh_user_capability PRIMARY KEY ( user_id, capacity_name )
 );

ALTER TABLE kh_user_capability ADD CONSTRAINT fk_kh_user_capability_kh_user FOREIGN KEY ( user_id ) REFERENCES kh_user( id );


CREATE TABLE kh_system_message ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	title                varchar(128)  NOT NULL ,
	is_valid             boolean DEFAULT true NOT NULL ,
	show_type            smallint DEFAULT 1  ,
	mess_body            varchar(512)   ,
	expire_time          timestamp NULL  ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_kh_system_message_id PRIMARY KEY ( id )
 );

CREATE TABLE kh_user_device ( 
	device_id            varchar(24)  NOT NULL ,
	os_name              varchar(16)  NOT NULL ,
	os_version           varchar(16)  NOT NULL ,
	user_id              bigint,
	ip_address			 varchar(16),
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_user_device_device_id PRIMARY KEY ( device_id )
 );


CREATE TABLE kh_user_symptom ( 
	id                     bigint  NOT NULL AUTO_INCREMENT ,
	name                   varchar(128)  NOT NULL ,
	status                 smallint DEFAULT 1 NOT NULL ,
	user_id                bigint  NOT NULL ,
	symptom_id             bigint   ,
	cause_resource_type    smallint  NOT NULL ,
	cause_resource_id      bigint   ,
	start_date             timestamp NULL  ,
	end_date               timestamp NULL  ,
	description            varchar(256)   ,
	create_time            timestamp DEFAULT CURRENT_TIMESTAMP  ,
	update_time            timestamp NULL  ,
	CONSTRAINT pk_kh_user_symptom_id PRIMARY KEY ( id )
 );

ALTER TABLE kh_user_symptom ADD CONSTRAINT fk_user_symptom_userid FOREIGN KEY ( user_id ) REFERENCES kh_user( id );



CREATE TABLE kh_user_symptom_track ( 
	id                   bigint  NOT NULL AUTO_INCREMENT ,
	user_symptom_ids     varchar(128)  NOT NULL ,
	user_id              bigint  NOT NULL ,
	symptoms_name        varchar(768)  NOT NULL ,
	during_time          integer   ,
	degree               integer   ,
	happen_time          timestamp  NOT NULL ,
	notes                varchar(256)   ,
	create_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	update_time          timestamp NULL  ,
	CONSTRAINT pk_kh_user_symptom_record_id PRIMARY KEY ( id )
 );

ALTER TABLE kh_user_symptom_track ADD CONSTRAINT fk_user_symptom_track_userid FOREIGN KEY ( user_id ) REFERENCES kh_user( id );


CREATE TABLE kh_drug_interaction ( 
	drug_id1             bigint  NOT NULL ,
	drug_id2             bigint  NOT NULL ,
	drug_id3             bigint   ,
	severity_level       smallint  NOT NULL,
	mechanism            varchar(1500)   ,
	source_site          varchar(16)   ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP  ,
	CONSTRAINT pk_drug_interaction PRIMARY KEY ( drug_id1, drug_id2 )
 );


CREATE TABLE kh_user_drug_interaction ( 
	user_id              bigint  NOT NULL ,
	user_drug_id1        bigint  NOT NULL ,
	user_drug_id2        bigint  NOT NULL ,
	drug_id1             bigint  NOT NULL ,
	drug_id2             bigint  NOT NULL ,
	drug_name1			 varchar(128) ,
	drug_name2			 varchar(128) ,
	severity_level       smallint  NOT NULL ,
	show_status          smallint DEFAULT 0 NOT NULL ,
	update_time          timestamp  DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_userdrug_interaction PRIMARY KEY ( user_id, user_drug_id1, user_drug_id2 )
 );


CREATE TABLE kh_drug_caution ( 
	drug_id              bigint  NOT NULL ,
	`language`           varchar(8)  NOT NULL ,
	caution_type         smallint DEFAULT 0 NOT NULL ,
	content              varchar(1000)  NOT NULL ,
	update_time          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	CONSTRAINT pk_drug_caution PRIMARY KEY ( drug_id, `language`, caution_type )
 );

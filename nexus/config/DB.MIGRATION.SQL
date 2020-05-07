-- require firebase

-- database changes

CREATE SEQUENCE public.event_bbb_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.event_bbb_id_seq
    OWNER TO northbri_devnexus;

GRANT ALL ON SEQUENCE public.event_bbb_id_seq TO northbri_devnexus;

GRANT SELECT, UPDATE ON SEQUENCE public.event_bbb_id_seq TO northbri_web;

CREATE TABLE public.event_bbb
(
    id integer NOT NULL DEFAULT nextval('event_bbb_id_seq'::regclass),
    event_fk integer NOT NULL,
    bbb_id character varying(100) COLLATE pg_catalog."default",
    bbb_start_dttm timestamp with time zone,
    bbb_end_dttm timestamp with time zone,
    recording_id character varying(100) COLLATE pg_catalog."default",
    recording_url character varying(200) COLLATE pg_catalog."default",
    recording_start_time bigint,
    record_publish_dttm timestamp with time zone,
    record_delete_dttm timestamp with time zone,
    CONSTRAINT event_bbb_pkey PRIMARY KEY (id),
    CONSTRAINT event_bbb_event_fk_fkey FOREIGN KEY (event_fk)
        REFERENCES public.event (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.event_bbb
    OWNER to northbri_devnexus;
	
GRANT INSERT, SELECT, UPDATE ON TABLE public.event_bbb TO northbri_web;

GRANT ALL ON TABLE public.event_bbb TO northbri_devnexus;

-- DEVELOPMENT

INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (697, 1571619841094, 'ac5f66a33ed5e5af8461b550292033e78c09d500-1571619841094', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/ac5f66a33ed5e5af8461b550292033e78c09d500-1571619841094/capture/');

-- PRODUCTION

INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1033, 1585615502878, '71533d013f2896e34a37c6be697c787c7df15aca-1585615502879', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/71533d013f2896e34a37c6be697c787c7df15aca-1585615502879/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (983, 1585004629354, '250617d4b2dc57f2974b24b261c5dac45a3bf462-1585004629354', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/250617d4b2dc57f2974b24b261c5dac45a3bf462-1585004629354/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (946, 1584123502112, 'd4fd11278e292fee317d55cd89c48b2cdeabc48b-1584123502113', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/d4fd11278e292fee317d55cd89c48b2cdeabc48b-1584123502113/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (833, 1571853006240, 'd62d407252c6814375e5b190563ebb6d84b1c47e-1571853006240', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/d62d407252c6814375e5b190563ebb6d84b1c47e-1571853006240/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (839, 1571619841094, 'ac5f66a33ed5e5af8461b550292033e78c09d500-1571619841094', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/ac5f66a33ed5e5af8461b550292033e78c09d500-1571619841094/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (826, 1570463291836, '32ef3e7a1e87676be21d60a90ab4d93effe80363-1570463291837', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/32ef3e7a1e87676be21d60a90ab4d93effe80363-1570463291837/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (787, 1560732254063, '1aac3f9f3fe17c229aacb88fbfbfd49b985b2d45-1560732254064', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/1aac3f9f3fe17c229aacb88fbfbfd49b985b2d45-1560732254064/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (782, 1559226381605, 'a46bc81960be1feda634b240be0c50336cd84ddc-1559226381605', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/a46bc81960be1feda634b240be0c50336cd84ddc-1559226381605/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (782, 1559224328572, 'a46bc81960be1feda634b240be0c50336cd84ddc-1559224328573', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/a46bc81960be1feda634b240be0c50336cd84ddc-1559224328573/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (777, 1558555126081, '97c9e78d5eaf0e901c0fd8988fae6c5a924f9e58-1558555126081', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/97c9e78d5eaf0e901c0fd8988fae6c5a924f9e58-1558555126081/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (779, 1558366555346, '42678fb1ab7a9a9ceaa21d1c0bfccf7779d74fb7-1558366555347', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/42678fb1ab7a9a9ceaa21d1c0bfccf7779d74fb7-1558366555347/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (779, 1558365099665, '42678fb1ab7a9a9ceaa21d1c0bfccf7779d74fb7-1558365099666', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/42678fb1ab7a9a9ceaa21d1c0bfccf7779d74fb7-1558365099666/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (770, 1557855968766, '3eeb57daa302446ec5901fa49c014aace3ee4464-1557855968766', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/3eeb57daa302446ec5901fa49c014aace3ee4464-1557855968766/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (751, 1553709391654, '4c34720bdc62d5688479510e7d29617552a74059-1553709391654', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/4c34720bdc62d5688479510e7d29617552a74059-1553709391654/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (740, 1551059114424, '9a6ae0a41c54ca24a2ff921275c6364c7e9f835b-1551059114425', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/9a6ae0a41c54ca24a2ff921275c6364c7e9f835b-1551059114425/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (699, 1543283549961, '2ebb8a569953202b1929fcf3162b54dba50c425d-1543283549962', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/2ebb8a569953202b1929fcf3162b54dba50c425d-1543283549962/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (693, 1542124258865, '3e718cd91ec06fbcc34a5f956b0c64f31f0393f5-1542124258865', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/3e718cd91ec06fbcc34a5f956b0c64f31f0393f5-1542124258865/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (12, 1541470104335, '515ef69664ee96b46cf0111192a24fb4c6845e0d-1541470104336', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/515ef69664ee96b46cf0111192a24fb4c6845e0d-1541470104336/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (12, 1538768995000, '515ef69664ee96b46cf0111192a24fb4c6845e0d-1538768995442', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/515ef69664ee96b46cf0111192a24fb4c6845e0d-1538768995442/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (641, 1534778559000, '2f421883075cb3e7e4be38759f111c4963d6aec2-1534778559721', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/2f421883075cb3e7e4be38759f111c4963d6aec2-1534778559721/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (608, 1526916943000, 'adde9f30c137a9758b61127aad4347e404c8be43-1526916943152', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/adde9f30c137a9758b61127aad4347e404c8be43-1526916943152/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (559, 1520263676040, '9f7c6fba9717437fe38e8c6b8985c6d5d5e16b5f-1520263676040', 'https://nexus.northbridgetech.org/archive/playback.html?meetingId=9f7c6fba9717437fe38e8c6b8985c6d5d5e16b5f-1520263676040');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (577, 1523887404405, 'c6f47f0a1161f39f29227423027e0187f68a53d5-1523887404405', 'https://nexus.northbridgetech.org/archive/playback.html?meetingId=c6f47f0a1161f39f29227423027e0187f68a53d5-1523887404405');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (529, 1516464680143, '3071e333923c26eeec8d5739ffb7bc6c38a64c97-1516464680143', 'https://nexus.northbridgetech.org/archive/playback.html?meetingId=3071e333923c26eeec8d5739ffb7bc6c38a64c97-1516464680143');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1120, 1587040806344, '031759dfb007eb2b737c87c4ecd72792df6a52be-1587040806344' 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/031759dfb007eb2b737c87c4ecd72792df6a52be-1587040806344/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1125, 1587079171127, '73a75008297d2a667560185407389b69ca01fa75-1587079171127', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/73a75008297d2a667560185407389b69ca01fa75-1587079171127/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1134, 1587149733802, '0c645c3c78507d3b5709f3e6d8181392655b18f9-1587149733802', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/0c645c3c78507d3b5709f3e6d8181392655b18f9-1587149733802/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1133, 1587157214956, '9036ed1cba3b14772d745c5aea37c1802613837a-1587157214956', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/9036ed1cba3b14772d745c5aea37c1802613837a-1587157214956/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1154, 1587583909062, 'bd8c64047a65afba29d7da87a164cd0ab83d0cdc-1587583909063', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/bd8c64047a65afba29d7da87a164cd0ab83d0cdc-1587583909063/capture/'); 
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1158, 1587751276092, 'e1f6a513b5fcdf00cbe21a68069bb70becdb0713-1587751276092', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/e1f6a513b5fcdf00cbe21a68069bb70becdb0713-1587751276092/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1163, 1587930671372, 'fdfff614dfbc5e607a6837b69902ec8967ff64b6-1587930671373', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/fdfff614dfbc5e607a6837b69902ec8967ff64b6-1587930671373/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1173, 1588352622767, '423255807bb6714a9465181dc2b7ca801e9ef0eb-1588352622768', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/423255807bb6714a9465181dc2b7ca801e9ef0eb-1588352622768/capture/');
INSERT INTO public.event_bbb (event_fk, recording_start_time, recording_id, recording_url) values (1186, 1588634194535, '288472768d5ab27f917f36528765a548cbbcea6e-1588634194535', 'https://recordings.rna1.blindsidenetworks.com/northbridgetech/288472768d5ab27f917f36528765a548cbbcea6e-1588634194535/capture/');


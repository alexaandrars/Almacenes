-- Generado por Oracle SQL Developer Data Modeler 24.3.0.240.1210
--   en:        2024-12-06 13:02:30 CET
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE alergia (
    id_alergia                INTEGER NOT NULL,
    nombrealergia             VARCHAR2(255 CHAR),
    tipoalergia_tipoalergiaid INTEGER NOT NULL
);

ALTER TABLE alergia ADD CONSTRAINT alergia_pk PRIMARY KEY ( id_alergia );

CREATE TABLE ano (
    ano SMALLINT NOT NULL
);

ALTER TABLE ano ADD CONSTRAINT ano_pk PRIMARY KEY ( ano );

CREATE TABLE apacheaps (
    apacheapsid            INTEGER NOT NULL,
    intubado               INTEGER NOT NULL,
    ventilado              INTEGER NOT NULL,
    frecuenciarespiratoria FLOAT NOT NULL,
    fio2                   FLOAT NOT NULL,
    pao2                   FLOAT NOT NULL,
    pco2                   FLOAT NOT NULL,
    ph                     FLOAT NOT NULL
);

ALTER TABLE apacheaps ADD CONSTRAINT apacheaps_pk PRIMARY KEY ( apacheapsid );

CREATE TABLE categoriahospital (
    categoriaid INTEGER NOT NULL,
    tamano      VARCHAR2(200 CHAR)
);

ALTER TABLE categoriahospital ADD CONSTRAINT categoriahospital_pk PRIMARY KEY ( categoriaid );

CREATE TABLE cuidadoresp (
    cuidadoid           INTEGER NOT NULL,
    iniciousoventilador INTEGER,
    finusoventilador    INTEGER,
    tipoviaaerea        VARCHAR2(30 CHAR),
    tamanoviaaerea      VARCHAR2(10 CHAR),
    posicionviaaerea    VARCHAR2(32 CHAR)
);

ALTER TABLE cuidadoresp ADD CONSTRAINT cuidadoresp_pk PRIMARY KEY ( cuidadoid );

CREATE TABLE diagadmision (
    diagadid          INTEGER NOT NULL,
    nombrediagnostico VARCHAR2(255 CHAR),
    offsetentradadx   INTEGER
);

ALTER TABLE diagadmision ADD CONSTRAINT diagadmision_pk PRIMARY KEY ( diagadid );

CREATE TABLE diagnostico (
    diagnosticoid          INTEGER NOT NULL,
    descripciondiagnostico VARCHAR2(200 CHAR) NOT NULL,
    codigoicd9             VARCHAR2(100 CHAR) NOT NULL,
    prioridaddiagnostico   VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE diagnostico ADD CONSTRAINT diagnostico_pk PRIMARY KEY ( diagnosticoid );

CREATE TABLE hospital (
    hospitalid                    INTEGER NOT NULL,
    categoriahospital_categoriaid INTEGER NOT NULL,
    region_regionid               INTEGER NOT NULL
);

ALTER TABLE hospital ADD CONSTRAINT hospital_pk PRIMARY KEY ( hospitalid );

CREATE TABLE ingresos_uci (
    duracion_de_la_estancia      VARCHAR2(4000),
    estado_del_alta              VARCHAR2(4000),
    cantidad_de_ingresos         INTEGER,
    uso_de_ventilacion_mecanica  CHAR(1),
    puntaje_de_severidad         VARCHAR2(4000),
    tasa_de_ventilacion_mecanica INTEGER,
    mortalidad                   INTEGER,
    reingresos                   INTEGER,
    paciente_pacienteid          INTEGER NOT NULL,
    hospital_hospitalid          INTEGER NOT NULL,
    ano_ano                      SMALLINT NOT NULL,
    diagadmision_diagadid        INTEGER NOT NULL,
    cuidadoresp_cuidadoid        INTEGER NOT NULL,
    apacheaps_apacheapsid        INTEGER NOT NULL,
    ingresos_uci_id              NUMBER NOT NULL
);

ALTER TABLE ingresos_uci ADD CONSTRAINT ingresos_uci_pk PRIMARY KEY ( ingresos_uci_id );

CREATE TABLE medicacion (
    medicamentoid     INTEGER NOT NULL,
    nombremedicamento VARCHAR2(255 CHAR) NOT NULL,
    dosis             VARCHAR2(400 CHAR) NOT NULL,
    frecuencia        VARCHAR2(255 CHAR) NOT NULL
);

ALTER TABLE medicacion ADD CONSTRAINT medicacion_pk PRIMARY KEY ( medicamentoid );

CREATE TABLE paciente (
    pacienteid        INTEGER NOT NULL,
    pacienteingresoid INTEGER NOT NULL,
    genero            VARCHAR2(25 CHAR) NOT NULL,
    etnicidad         VARCHAR2(50 CHAR) NOT NULL,
    edad              VARCHAR2(10) NOT NULL,
    pesoingreso       NUMBER(10, 2) NOT NULL
);

ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY ( pacienteid );

CREATE TABLE patologia (
    patologiaid     VARCHAR2(100 CHAR) NOT NULL,
    nombrepatologia VARCHAR2(100 CHAR)
);

ALTER TABLE patologia ADD CONSTRAINT patologia_pk PRIMARY KEY ( patologiaid );

CREATE TABLE region (
    regionid INTEGER NOT NULL,
    region   INTEGER NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( regionid );

CREATE TABLE relation_10 (
    medicacion_medicamentoid     INTEGER NOT NULL,
    ingresos_uci_ingresos_uci_id NUMBER NOT NULL
);

ALTER TABLE relation_10 ADD CONSTRAINT relation_10_pk PRIMARY KEY ( medicacion_medicamentoid,
                                                                    ingresos_uci_ingresos_uci_id );

CREATE TABLE relation_13 (
    ingresos_uci_ingresos_uci_id NUMBER NOT NULL,
    alergia_id_alergia           INTEGER NOT NULL
);

ALTER TABLE relation_13 ADD CONSTRAINT relation_13_pk PRIMARY KEY ( ingresos_uci_ingresos_uci_id,
                                                                    alergia_id_alergia );

CREATE TABLE relation_20 (
    ingresos_uci_ingresos_uci_id NUMBER NOT NULL,
    diagnostico_diagnosticoid    INTEGER NOT NULL
);

ALTER TABLE relation_20 ADD CONSTRAINT relation_20_pk PRIMARY KEY ( ingresos_uci_ingresos_uci_id,
                                                                    diagnostico_diagnosticoid );

CREATE TABLE relation_9 (
    patologia_patologiaid        VARCHAR2(100 CHAR) NOT NULL,
    ingresos_uci_ingresos_uci_id NUMBER NOT NULL
);

ALTER TABLE relation_9 ADD CONSTRAINT relation_9_pk PRIMARY KEY ( patologia_patologiaid,
                                                                  ingresos_uci_ingresos_uci_id );

CREATE TABLE tipoalergia (
    tipoalergiaid INTEGER NOT NULL,
    tipoalergia   VARCHAR2(255) NOT NULL
);

ALTER TABLE tipoalergia ADD CONSTRAINT tipoalergia_pk PRIMARY KEY ( tipoalergiaid );

ALTER TABLE alergia
    ADD CONSTRAINT alergia_tipoalergia_fk FOREIGN KEY ( tipoalergia_tipoalergiaid )
        REFERENCES tipoalergia ( tipoalergiaid );

ALTER TABLE hospital
    ADD CONSTRAINT hospital_categoriahospital_fk FOREIGN KEY ( categoriahospital_categoriaid )
        REFERENCES categoriahospital ( categoriaid );

ALTER TABLE hospital
    ADD CONSTRAINT hospital_region_fk FOREIGN KEY ( region_regionid )
        REFERENCES region ( regionid );

ALTER TABLE ingresos_uci
    ADD CONSTRAINT ingresos_uci_ano_fk FOREIGN KEY ( ano_ano )
        REFERENCES ano ( ano );

ALTER TABLE ingresos_uci
    ADD CONSTRAINT ingresos_uci_apacheaps_fk FOREIGN KEY ( apacheaps_apacheapsid )
        REFERENCES apacheaps ( apacheapsid );

ALTER TABLE ingresos_uci
    ADD CONSTRAINT ingresos_uci_cuidadoresp_fk FOREIGN KEY ( cuidadoresp_cuidadoid )
        REFERENCES cuidadoresp ( cuidadoid );

ALTER TABLE ingresos_uci
    ADD CONSTRAINT ingresos_uci_diagadmision_fk FOREIGN KEY ( diagadmision_diagadid )
        REFERENCES diagadmision ( diagadid );

ALTER TABLE ingresos_uci
    ADD CONSTRAINT ingresos_uci_hospital_fk FOREIGN KEY ( hospital_hospitalid )
        REFERENCES hospital ( hospitalid );

ALTER TABLE ingresos_uci
    ADD CONSTRAINT ingresos_uci_paciente_fk FOREIGN KEY ( paciente_pacienteid )
        REFERENCES paciente ( pacienteid );

ALTER TABLE relation_10
    ADD CONSTRAINT relation_10_ingresos_uci_fk FOREIGN KEY ( ingresos_uci_ingresos_uci_id )
        REFERENCES ingresos_uci ( ingresos_uci_id );

ALTER TABLE relation_10
    ADD CONSTRAINT relation_10_medicacion_fk FOREIGN KEY ( medicacion_medicamentoid )
        REFERENCES medicacion ( medicamentoid );

ALTER TABLE relation_13
    ADD CONSTRAINT relation_13_alergia_fk FOREIGN KEY ( alergia_id_alergia )
        REFERENCES alergia ( id_alergia );

ALTER TABLE relation_13
    ADD CONSTRAINT relation_13_ingresos_uci_fk FOREIGN KEY ( ingresos_uci_ingresos_uci_id )
        REFERENCES ingresos_uci ( ingresos_uci_id );

ALTER TABLE relation_20
    ADD CONSTRAINT relation_20_diagnostico_fk FOREIGN KEY ( diagnostico_diagnosticoid )
        REFERENCES diagnostico ( diagnosticoid );

ALTER TABLE relation_20
    ADD CONSTRAINT relation_20_ingresos_uci_fk FOREIGN KEY ( ingresos_uci_ingresos_uci_id )
        REFERENCES ingresos_uci ( ingresos_uci_id );

ALTER TABLE relation_9
    ADD CONSTRAINT relation_9_ingresos_uci_fk FOREIGN KEY ( ingresos_uci_ingresos_uci_id )
        REFERENCES ingresos_uci ( ingresos_uci_id );

ALTER TABLE relation_9
    ADD CONSTRAINT relation_9_patologia_fk FOREIGN KEY ( patologia_patologiaid )
        REFERENCES patologia ( patologiaid );

CREATE SEQUENCE ingresos_uci_ingresos_uci_id START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER ingresos_uci_ingresos_uci_id BEFORE
    INSERT ON ingresos_uci
    FOR EACH ROW
    WHEN ( new.ingresos_uci_id IS NULL )
BEGIN
    :new.ingresos_uci_id := ingresos_uci_ingresos_uci_id.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            18
-- CREATE INDEX                             0
-- ALTER TABLE                             35
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

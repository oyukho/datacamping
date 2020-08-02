CREATE TABLE dim_gen_period (
    gen_period_id   INTEGER NOT NULL,
    beg_gen_period  INTEGER NOT NULL,
    end_gen_period  INTEGER NOT NULL,
    insert_dt       DATE NOT NULL,
    update_dt       DATE
);

ALTER TABLE dim_gen_period ADD CONSTRAINT dim_gen_period_pk PRIMARY KEY ( gen_period_id );



CREATE TABLE dim_products ( 
    product_id     INTEGER NOT NULL,
    product_name   VARCHAR2(40) NOT NULL,
    product_price  FLOAT NOT NULL,
    insert_dt      DATE,
    update_dt      DATE
);

ALTER TABLE dim_products ADD CONSTRAINT products_pk PRIMARY KEY ( product_id );

--DROP TABLE fct_sales_mm;
CREATE TABLE fct_sales_mm (
    fct_id             INTEGER NOT NULL,
    event_id           DATE NOT NULL,
    dim_product_id     INTEGER NOT NULL,
    dim_gen_period_id  INTEGER NOT NULL,
    dim_geo_id         INTEGER NOT NULL,
    quantity_sales     INTEGER NOT NULL,
    insert_dt          DATE NOT NULL,
    update_dt          DATE
);

ALTER TABLE fct_sales_mm 
    ADD CONSTRAINT fct_sales_pk PRIMARY KEY ( fct_id );

ALTER TABLE fct_sales_mm
    ADD CONSTRAINT fct_sales_dim_countries_fkv3 FOREIGN KEY ( dim_geo_id )
        REFERENCES dim_geo_location ( geo_id );

ALTER TABLE fct_sales_mm
    ADD CONSTRAINT fct_sales_dim_gen_period_fk FOREIGN KEY ( dim_gen_period_id )
        REFERENCES dim_gen_period ( gen_period_id );

ALTER TABLE fct_sales_mm
    ADD CONSTRAINT fct_sales_dim_products_fk FOREIGN KEY ( dim_product_id )
        REFERENCES dim_products ( product_id );

ALTER TABLE fct_sales_mm
    ADD CONSTRAINT fct_sales_dim_time_fk FOREIGN KEY ( event_id )
        REFERENCES dim_time ( time_id );


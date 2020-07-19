CREATE TABLE fct_sales (
    fct_id               INTEGER NOT NULL,
    dim_day_id           DATE NOT NULL,
    dim_store_id         INTEGER NOT NULL,
    dim_emp_id           INTEGER NOT NULL,
    dim_promo_id         INTEGER NOT NULL,
    dim_cust_id          INTEGER NOT NULL,
    dim_product_id       INTEGER NOT NULL,
    dim_payment_type_id  INTEGER NOT NULL,
    promo_gen_period_id  INTEGER NOT NULL,
    dim_geo_id_emp       INTEGER NOT NULL,
    dim_geo_id_cust      INTEGER NOT NULL,
    quantity_sold        INTEGER NOT NULL,
    unit_price           FLOAT NOT NULL,
    amount_sold          FLOAT NOT NULL,
    unit_cost            FLOAT NOT NULL,
    CONSTRAINT fct_sales_pk PRIMARY KEY ( fct_id )
)
PARTITION BY RANGE (dim_day_id)
    SUBPARTITION BY HASH(fct_id)
(
    PARTITION quarter_1 VALUES LESS THAN (TO_DATE('01-04-2019', 'dd-mm-yyyy'))
    (
      SUBPARTITION quarter_1_1,
      SUBPARTITION quarter_1_2,
      SUBPARTITION quarter_1_3,
      SUBPARTITION quarter_1_4
    ),
    PARTITION quarter_2 VALUES LESS THAN (TO_DATE('01-07-2019','dd-mm-yyyy'))
    (
      SUBPARTITION quarter_2_1,
      SUBPARTITION quarter_2_2,
      SUBPARTITION quarter_2_3,
      SUBPARTITION quarter_2_4
     ),
     PARTITION quarter_3 VALUES LESS THAN(TO_DATE('01-10-2019','dd-mm-yyyy'))
    (
      SUBPARTITION quarter_3_1,
      SUBPARTITION quarter_3_2,
      SUBPARTITION quarter_3_3,
      SUBPARTITION quarter_3_4
    ),
     PARTITION quarter_4 VALUES LESS THAN (TO_DATE('01-01-2020','dd-mm-yyyy'))
    (
      SUBPARTITION quarter_4_1,
      SUBPARTITION quarter_4_2,
      SUBPARTITION quarter_4_3,
      SUBPARTITION quarter_4_4
    )
);


ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_countries_fk FOREIGN KEY ( dim_geo_id_emp )
        REFERENCES dim_geo_locations ( geo_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_countries_fkv3 FOREIGN KEY ( dim_geo_id_cust )
        REFERENCES dim_geo_locations ( geo_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_customers_fk FOREIGN KEY ( dim_cust_id )
        REFERENCES dim_customers ( cust_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_employees_fk FOREIGN KEY ( dim_emp_id )
        REFERENCES dim_employees ( emp_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_gen_period_fk FOREIGN KEY ( promo_gen_period_id )
        REFERENCES dim_gen_period ( gen_period_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_payment_types_fk FOREIGN KEY ( dim_payment_type_id )
        REFERENCES dim_payment_types ( payment_type_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_products_fk FOREIGN KEY ( dim_product_id )
        REFERENCES dim_products ( product_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_promotions_fk FOREIGN KEY ( dim_promo_id )
        REFERENCES dim_promotions ( promo_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_stores_fk FOREIGN KEY ( dim_store_id )
        REFERENCES dim_stores ( store_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_time_fk FOREIGN KEY ( dim_day_id )
        REFERENCES dim_time ( day_id );
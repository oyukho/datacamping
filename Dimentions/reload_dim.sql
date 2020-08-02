BEGIN
pkg_etl_products_dim.load_dim_products;
pkg_etl_period_dim.load_dim_period;
pkg_etl_fct_sales_mm.load_fct_sales_mm;
END;

CREATE EXTENSION pg_parquet;

CREATE SCHEMA IF NOT EXISTS fct;

CREATE TABLE IF NOT EXISTS fct.sales (
    id BIGSERIAL,
    category TEXT,
    region TEXT,
    quantity INT,
    unit_price NUMERIC(10,2),
    sale_date DATE NOT NULL,
    PRIMARY KEY (id, sale_date)
) PARTITION BY RANGE (sale_date);

CREATE TABLE IF NOT EXISTS fct.sales_default
PARTITION OF fct.sales
DEFAULT;

DO $$
DECLARE
    start_date DATE := CURRENT_DATE - INTERVAL '3 years';
    end_date   DATE := CURRENT_DATE + INTERVAL '30 days';
    d DATE;
BEGIN
    d := start_date;
    WHILE d < end_date LOOP
        EXECUTE format(
            'CREATE TABLE IF NOT EXISTS fct.sales_%s PARTITION OF fct.sales
             FOR VALUES FROM (%L) TO (%L)',
            to_char(d, 'YYYYMMDD'),
            d,
            d + INTERVAL '1 day'
        );
        d := d + INTERVAL '1 day';
    END LOOP;
END $$;

CREATE INDEX IF NOT EXISTS idx_sales_sale_date
ON fct.sales (sale_date);

CREATE INDEX IF NOT EXISTS idx_sales_category
ON fct.sales (category);

CREATE INDEX IF NOT EXISTS idx_sales_region
ON fct.sales (region);

CREATE INDEX IF NOT EXISTS idx_sales_date_category_region
ON fct.sales (sale_date, category, region);

INSERT INTO fct.sales (category, region, quantity, unit_price, sale_date)
SELECT
    (ARRAY['Electronics','Furniture','Clothing','Food'])[1 + floor(random() * 4)],
    (ARRAY['North','South','Southeast','Northeast'])[1 + floor(random() * 4)],
    (random() * 100)::INT,
    round((random() * 1000)::numeric, 2),
    CURRENT_DATE - (random() * 1000)::INT
FROM generate_series(1, 1000000);


CREATE SCHEMA IF NOT EXISTS fct;

CREATE TABLE IF NOT EXISTS fct.vendas (
    id BIGSERIAL PRIMARY KEY,
    categoria TEXT,
    regiao TEXT,
    quantidade INT,
    preco_unitario NUMERIC(10,2),
    data_venda DATE
);

INSERT INTO fct.vendas (categoria, regiao, quantidade, preco_unitario, data_venda)
SELECT
    (ARRAY['Eletronicos','Moveis','Roupas','Alimentos'])[1 + floor(random() * 4)],
    (ARRAY['Norte','Sul','Sudeste','Nordeste'])[1 + floor(random() * 4)],
    (random() * 100)::INT,
    round((random() * 1000)::numeric, 2),
    CURRENT_DATE - (random() * 1000)::INT
FROM generate_series(1, 1000000);

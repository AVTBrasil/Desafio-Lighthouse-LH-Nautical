-- O período de análise deve considerar todas as datas entre a menor e a data atual da venda presentes no arquivo. 

SELECT 
    dimensao_datas.dia_da_semana,
    AVG(COALESCE(vendas_diarias.total_pedido, 0)) AS media_vendas
FROM (
    SELECT 
        data,
        CASE EXTRACT(DOW FROM data)
            WHEN 0 THEN 'Domingo'
            WHEN 1 THEN 'Segunda-feira'
            WHEN 2 THEN 'Terça-feira'
            WHEN 3 THEN 'Quarta-feira'
            WHEN 4 THEN 'Quinta-feira'
            WHEN 5 THEN 'Sexta-feira'
            WHEN 6 THEN 'Sábado'
        END AS dia_da_semana
    FROM (
        SELECT generate_series(
            (SELECT MIN(created_at)::date FROM orders),
            (SELECT MAX(created_at)::date FROM orders),
            '1 day'::interval
        )::date AS data
    ) AS gerador_datas
) AS dimensao_datas

LEFT JOIN (
    SELECT
        created_at::date AS data_venda,
        SUM(total) AS total_pedido
    FROM orders
    WHERE channel = 'pos'
    GROUP BY created_at::date
) AS vendas_diarias
    ON dimensao_datas.data = vendas_diarias.data_venda

GROUP BY dimensao_datas.dia_da_semana
ORDER BY media_vendas ASC;

--Por que é necessário utilizar uma tabela de datas (calendário) em vez de agrupar diretamente a tabela de vendas? 

-- Porque a tabela de vendas não possui registro de dias que não vendem por exemplo o domingo. Assim, com a dimensão das datas
-- Cada dia é considerado, por isso que no LEFT JOIN com as vendas e tranformamos os dias sem registros em 0 usando COALESCE
- 
--O que aconteceria com a média de vendas se um dia da semana tivesse muitos dias sem nenhuma venda registrada?
-- Se alguns dias sem vendas não fossem incluidos a média seria artificialmente maior
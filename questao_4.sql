-- Análise de clientes

-- Faturamento Total: Soma da coluna total por cliente.
SELECT  customer_id, SUM(TOTAL) AS Faturamento_total 
	FROM orders 
	GROUP BY customer_id

--Frequência: Contagem total de transações (IDs de venda) por cliente.
SELECT  customer_id, COUNT(*) AS total_de_transacoes 
	FROM orders 
	GROUP BY customer_id


-- Ticket Médio: Faturamento Total / Frequência.

SELECT  customer_id, SUM(TOTAL)/COUNT(*) AS ticket_medio 
	FROM orders 
	GROUP BY customer_id


-- Diversidade de Categorias: Quantidade de categorias distintas (category_id) que o cliente comprou.
SELECT DISTINCT orders.customer_id, products.category_id
    FROM orders 
	    INNER JOIN order_items ON orders.id = order_items.order_id
	    INNER JOIN product_variants ON order_items.product_variant_id = product_variants.id
	    INNER JOIN products ON product_variants.product_id = products.id




--Filtro de Elite: Apenas clientes que compraram produtos de 13 ou mais categorias distintas devem ser considerados no ranking.
--Desempate: Em caso de empate no Ticket Médio, utilize o customer_id em ordem crescente.
SELECT DISTINCT orders.customer_id, COUNT (DISTINCT products.category_id ) AS diversidade_de_categorias
		FROM orders 
			INNER JOIN order_items ON orders.id = order_items.order_id
			INNER JOIN product_variants ON order_items.product_variant_id = product_variants.id
			INNER JOIN products ON product_variants.product_id = products.id
			GROUP BY orders.customer_id
		HAVING COUNT(DISTINCT products.category_id) >= 13

--Filtre os 10 clientes com o maior Ticket Médio que atendam ao critério de diversidade (13 ou + categorias)
SELECT 
    orders.customer_id,
    SUM(orders.total) / COUNT(*) AS ticket_medio,
    COUNT(DISTINCT products.category_id) AS diversidade_categorias
FROM orders
	INNER JOIN order_items ON orders.id = order_items.order_id
	INNER JOIN product_variants ON order_items.product_variant_id = product_variants.id
	INNER JOIN products ON product_variants.product_id = products.id
GROUP BY orders.customer_id
HAVING COUNT(DISTINCT products.category_id) >= 13
ORDER BY ticket_medio DESC, orders.customer_id ASC
LIMIT 10;

--Para este grupo específico de 10 clientes,
-- identifique qual categoria de produto concentra a maior quantidade total de itens comprados (sum(quantity)). 

WITH top_10_clientes AS (
    SELECT 
        orders.customer_id,
        SUM(orders.total) / COUNT(*) AS ticket_medio,
        COUNT(DISTINCT products.category_id) AS diversidade_categorias
    FROM orders
        INNER JOIN order_items ON orders.id = order_items.order_id
        INNER JOIN product_variants ON order_items.product_variant_id = product_variants.id
        INNER JOIN products ON product_variants.product_id = products.id
    GROUP BY orders.customer_id
    HAVING COUNT(DISTINCT products.category_id) >= 13
    ORDER BY ticket_medio DESC, orders.customer_id ASC
    LIMIT 10
)
SELECT 
    products.category_id,
    SUM(order_items.quantity) AS quantidade_total
FROM orders
    INNER JOIN top_10_clientes ON orders.customer_id = top_10_clientes.customer_id
    INNER JOIN order_items ON orders.id = order_items.order_id
    INNER JOIN product_variants ON order_items.product_variant_id = product_variants.id
    INNER JOIN products ON product_variants.product_id = products.id
GROUP BY products.category_id
ORDER BY quantidade_total DESC
LIMIT 1;

-- Como você chegou nas categorias mais vendidas? (mapeamento da cadeia de chaves)
'Co'

-- Qual lógica utilizou para filtrar os clientes com diversidade mínima?
-- Como garantiu que a contagem de itens refletisse apenas os Top 10?
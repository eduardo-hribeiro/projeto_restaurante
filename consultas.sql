USE projeto_restaurante;

/* =====================================================
   CONSULTAS BÁSICAS E FILTROS SIMPLES
   ===================================================== */

-- Produtos com preço acima de 30
SELECT nome, categoria
FROM produtos
WHERE preco > 30
ORDER BY nome ASC;

-- Clientes nascidos antes de 1985
SELECT nome, telefone, data_nascimento
FROM clientes
WHERE YEAR(data_nascimento) < 1985
ORDER BY data_nascimento DESC;

-- Clientes com nome iniciando em 'C'
SELECT *
FROM clientes
WHERE nome LIKE 'C%';

-- Produtos com preço entre 20 e 30
SELECT *
FROM produtos
WHERE preco BETWEEN 20 AND 30;

/* =====================================================
   CONSULTAS COM LIKE / NULL / CASE
   ===================================================== */

-- Produtos que contêm 'carne' nos ingredientes
SELECT p.id_produto, p.nome, i.ingredientes
FROM produtos p
JOIN info_produtos i ON p.id_produto = i.id_produto
WHERE i.ingredientes LIKE '%carne%';

-- Info_produtos com ingredientes carne ou frango
SELECT *
FROM info_produtos
WHERE ingredientes LIKE '%Carne%'
   OR ingredientes LIKE '%Frango%';

-- Pedidos com status nulo e não nulo
SELECT * FROM pedidos WHERE status IS NULL;
SELECT * FROM pedidos WHERE status IS NOT NULL;

-- Substituir status nulo por 'Cancelado'
SELECT id_pedido,
       IFNULL(status, 'Cancelado') AS status_atualizado
FROM pedidos;

-- Classificação de salários (CASE)
SELECT nome, salario,
       CASE
           WHEN salario > 3000 THEN 'Acima da média'
           ELSE 'Abaixo da média'
       END AS media_salario
FROM funcionarios;

/* =====================================================
   CONSULTAS COM ORDENAÇÃO, LIMIT E OFFSET
   ===================================================== */

-- Produtos ordenados por categoria e nome
SELECT nome, categoria
FROM produtos
ORDER BY categoria ASC, nome ASC;

-- Os 5 produtos mais caros
SELECT nome, preco
FROM produtos
ORDER BY preco DESC
LIMIT 5;

-- Dois pratos principais com OFFSET (exemplo)
SELECT nome, categoria
FROM produtos
WHERE categoria = 'Prato Principal'
LIMIT 2 OFFSET 6;

/* =====================================================
   CONSULTAS COM AGREGAÇÃO (COUNT, AVG, MIN, MAX)
   ===================================================== */

-- Quantidade total de pedidos
SELECT COUNT(*) AS total_pedidos
FROM pedidos;

-- Quantidade de clientes únicos que realizaram pedidos
SELECT COUNT(DISTINCT id_cliente) AS clientes_unicos
FROM pedidos;

-- Média de preço dos produtos
SELECT ROUND(AVG(preco), 2) AS media_preco
FROM produtos;

-- Média de preço dos produtos por categoria
SELECT categoria, ROUND(AVG(preco), 2) AS media_preco
FROM produtos
GROUP BY categoria;

-- Preço máximo e mínimo (geral)
SELECT MAX(preco) AS preco_maximo,
       MIN(preco) AS preco_minimo
FROM produtos;

-- Preço máximo e mínimo por categoria
SELECT categoria, MAX(preco) AS preco_maximo
FROM produtos
GROUP BY categoria;

SELECT categoria, MIN(preco) AS preco_minimo
FROM produtos
GROUP BY categoria;

/* =====================================================
   CTE E RANKING
   ===================================================== */

-- Ranking dos 5 produtos mais caros usando CTE
WITH ranking_produtos AS (
    SELECT nome, preco,
           ROW_NUMBER() OVER (ORDER BY preco DESC) AS ranking_preco
    FROM produtos
)
SELECT *
FROM ranking_produtos
WHERE ranking_preco <= 5;

/* =====================================================
   CONSULTAS COM JOIN (RELACIONAMENTOS)
   ===================================================== */

-- Pedidos de um funcionário específico com status pendente
SELECT *
FROM pedidos
WHERE id_funcionario = 4
  AND status = 'Pendente';

-- Pedidos que não estão concluídos
SELECT *
FROM pedidos
WHERE status <> 'Concluído';

-- Pedidos que possuem produtos específicos
SELECT p.id_pedido, ip.id_produto, pr.nome
FROM pedidos p
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produtos pr ON ip.id_produto = pr.id_produto
WHERE ip.id_produto IN (1, 3, 5, 7, 8);

-- Listar itens de cada pedido
SELECT p.id_pedido, c.nome AS cliente, pr.nome AS produto, ip.quantidade, ip.preco_unitario
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produtos pr ON ip.id_produto = pr.id_produto
ORDER BY p.id_pedido;

-- Produtos + info_produtos (LEFT JOIN)
SELECT pr.id_produto, pr.nome, pr.descricao, ip.ingredientes
FROM produtos pr
LEFT JOIN info_produtos ip ON pr.id_produto = ip.id_produto;

-- Pedidos + clientes + funcionários + produtos
SELECT p.id_pedido, p.data_pedido, c.nome AS cliente, c.email, f.nome AS funcionario, pr.nome AS produto, ip.quantidade, ip.preco_unitario
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
LEFT JOIN funcionarios f ON p.id_funcionario = f.id_funcionario
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produtos pr ON ip.id_produto = pr.id_produto;

/* =====================================================
   CONSULTAS ANALÍTICAS (NEGÓCIO)
   ===================================================== */

-- Clientes com pedidos pendentes
SELECT c.nome, c.id_cliente
FROM clientes c
JOIN pedidos p ON p.id_cliente = c.id_cliente
WHERE p.status = 'Pendente'
GROUP BY c.id_cliente, c.nome
ORDER BY MAX(p.id_pedido) DESC;

-- Clientes sem pedidos
SELECT c.nome
FROM clientes c
LEFT JOIN pedidos p ON p.id_cliente = c.id_cliente
WHERE p.id_pedido IS NULL;

-- Total de pedidos por cliente
SELECT c.nome, COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome;

-- Total financeiro de cada pedido
SELECT p.id_pedido, c.id_cliente, c.nome AS cliente, 
	   COALESCE(SUM(ip.quantidade * ip.preco_unitario), 0) AS total_pedido
FROM pedidos p
LEFT JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
LEFT JOIN clientes c ON p.id_cliente = c.id_cliente
GROUP BY p.id_pedido;
USE projeto_restaurante;
-- LISTAR TODOS OS PRODUTOS COM PREÇO ACIMA DE 30
SELECT nome, categoria 
FROM produtos 
WHERE preco > 30 
ORDER BY nome ASC;


-- CLIENTES NASCIDOS ANTES DE 1985
SELECT nome, telefone, data_nascimento 
FROM clientes 
WHERE year(data_nascimento) < 1985 
ORDER BY data_nascimento DESC;


-- PRODUTOS QUE CONTÉM "CARNE" NOS INGREDIENTES
SELECT p.id_produto, p.nome, i.ingredientes
FROM produtos p
JOIN info_produtos i ON p.id_produto = i.id_produto
WHERE i.ingredientes LIKE '%carne%';


-- PRODUTOS ORDENADOS POR CATEGORIA E NOME
SELECT nome, categoria 
FROM produtos 
ORDER BY categoria ASC, nome ASC;


-- OS 5 PRODUTOS MAIS CAROS
SELECT nome, preco 
FROM produtos 
ORDER BY preco DESC
LIMIT 5;


-- 2 PRATOS PRINCIPAIS EM PROMOÇÃO (EXEMPLO COM OFFSET)
SELECT nome, categoria 
FROM produtos 
WHERE categoria = 'Prato Principal'
LIMIT 2 OFFSET 6;


-- PEDIDOS DO FUNCIONÁRIO 4 COM STATUS PENDENTE
SELECT *
FROM pedidos
WHERE id_funcionario = 4 AND status = 'Pendente';


-- PEDIDOS QUE NÃO ESTÃO CONCLUÍDOS
SELECT *
FROM pedidos
WHERE status <> 'Concluído';


-- PEDIDOS QUE POSSUEM PRODUTOS ESPECÍFICOS
SELECT p.id_pedido, ip.id_produto, produtos.nome
FROM pedidos p
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produtos ON ip.id_produto = produtos.id_produto
WHERE ip.id_produto IN (1, 3, 5, 7, 8);


-- CLIENTES COM NOME INICIANDO EM "C"
SELECT * FROM clientes
WHERE nome LIKE 'C%';


-- INFO PRODUTOS COM INGREDIENTES CARNE OU FRANGO
SELECT *
FROM info_produtos
WHERE ingredientes LIKE '%Carne%' OR ingredientes LIKE '%Frango%';


-- PRODUTOS COM PREÇO ENTRE 20 E 30
SELECT *
FROM produtos
WHERE preco BETWEEN 20 AND 30;


-- SELECIONAR PEDIDOS COM STATUS NULO E NÃO NULO
SELECT * FROM pedidos WHERE status IS NULL;
SELECT * FROM pedidos WHERE status IS NOT NULL;


-- SUBSTITUIR STATUS NULO POR 'CANCELADO'
SELECT id_pedido, status,
IFNULL(status, 'Cancelado') AS status_atualizado
FROM pedidos;


-- MÉDIA DE SALÁRIOS: ACIMA OU ABAIXO DA MÉDIA
SELECT nome, id_cargo, salario,
	CASE 
     WHEN salario > 3000 THEN 'Acima da média'
	 ELSE 'Abaixo da média' 
	END AS media_salario
FROM funcionarios;


-- QUANTIDADE DE PEDIDOS
SELECT COUNT(*) FROM pedidos;


-- QUANTIDADE DE CLIENTES ÚNICOS QUE REALIZARAM PEDIDOS
SELECT COUNT(DISTINCT id_cliente) FROM pedidos;


-- MÉDIA DE PREÇO DOS PRODUTOS
SELECT ROUND(AVG(preco),2) FROM produtos; -- Média Total


-- MÉDIA DE PREÇO DOS PRODUTOS POR CATEGORIA
SELECT categoria, ROUND(AVG(preco),2) AS media_preco FROM produtos GROUP BY categoria; 


-- MÍNIMO E MÁXIMO DO PREÇO DOS PRODUTOS
SELECT MAX(preco) AS preco_maximo_geral, MIN(preco) AS preco_minimo_geral FROM produtos; -- Máximo e mínimo globais dos preços de todos os produtos 

SELECT categoria, MAX(preco) AS preco_maximo FROM produtos GROUP BY categoria; -- Preço Máximo por Categoria
SELECT categoria, MIN(preco) AS preco_minimo FROM produtos GROUP BY categoria; -- Preço Mínimo por Categoria


-- OS 5 PRODUTOS MAIS CAROS
-- Criação de uma CTE
WITH ranking_produtos AS (
	SELECT 
		nome,
        preco,
        ROW_NUMBER() OVER (ORDER BY preco DESC) AS ranking_preco
	FROM produtos
)

SELECT * FROM ranking_produtos WHERE ranking_preco <=5;


-- QUANTIDADE DE PRODUTOS POR FORNECEDOR
SELECT id_produto, fornecedor, COUNT(*) AS produto_fornecedor FROM info_produtos GROUP BY id_produto, fornecedor;


-- FORNECEDORES COM MAIS DE 1 PRODUTO CADASTRADO
SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(fornecedor, ' e ', n.n), ' e ', -1)) AS fornecedor_individual,
       COUNT(*) AS total_produtos
FROM info_produtos
JOIN (
    SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3
) n
ON n.n <= 1 + LENGTH(fornecedor) - LENGTH(REPLACE(fornecedor, ' e ', ''))
GROUP BY fornecedor_individual
HAVING COUNT(*) > 1;


-- CLIENTES QUE REALIZARAM APENAS 1 PEDIDO
SELECT id_cliente, COUNT(*) AS total_pedidos FROM pedidos GROUP BY id_cliente HAVING COUNT(*) = 1;


-- LISTAR ITENS DE CADA PEDIDO (JOIN COMPLETO) 
SELECT p.id_pedido, c.nome AS cliente, pr.nome AS produto,
	   ip.quantidade, ip.preco_unitario
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produtos pr ON ip.id_produto = pr.id_produto
ORDER BY p.id_pedido;


-- TOTALIZAR O VALOR DE UM PEDIDO
SELECT p.id_pedido,
	SUM(ip.quantidade * ip.preco_unitario) AS total_pedido
FROM pedidos p
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
GROUP BY p.id_pedido;


-- ATUALIZAR O VALOR TOTAL DO PEDIDO
UPDATE pedidos p
JOIN (
	SELECT id_pedido, SUM(quantidade * preco_unitario) AS total
	FROM itens_pedido
	GROUP BY id_pedido
) AS t ON p.id_pedido = t.id_pedido
SET p.valor_total = t.total;


-- SELECIONAR PRODUTOS: id, nome e descrição e INFO_PRODUTOS: ingredientes
SELECT pr.id_produto, pr.nome, pr.descricao, ip.ingredientes
FROM produtos AS pr
LEFT JOIN info_produtos AS ip ON pr.id_produto = ip.id_produto;


-- SELECIONAR PEDIDOS: id, quantidade e data, CLIENTES: nome e email, FUNCIONARIOS: nome e PRODUTOS: nome, preco
SELECT p.id_pedido, p.data_pedido, c.nome AS cliente, c.email AS email_cliente, f.nome AS funcionario,
       pr.nome AS produto, ip.quantidade, ip.preco_unitario
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
LEFT JOIN funcionarios AS f ON p.id_funcionario = f.id_funcionario
JOIN itens_pedido AS ip ON p.id_pedido = ip.id_pedido
JOIN produtos AS pr ON ip.id_produto = pr.id_produto;


-- CLIENTES COM PEDIDOS "PENDENTE"
SELECT c.nome, c.id_cliente
FROM clientes c
JOIN pedidos AS p ON p.id_cliente = c.id_cliente
WHERE p.status = 'Pendente'
GROUP BY c.id_cliente, c.nome
ORDER BY MAX(p.id_pedido) DESC;


-- CLIENTES SEM PEDIDOS
SELECT c.nome, p.id_pedido
FROM clientes c
LEFT JOIN pedidos AS p ON p.id_cliente = c.id_cliente
WHERE p.id_pedido IS NULL;


-- TOTAL DE PEDIDOS DE CADA CLIENTE
SELECT nome, 
	(SELECT COUNT(*) FROM pedidos WHERE pedidos.id_cliente = clientes.id_cliente) AS total_pedidos
FROM clientes;


-- PREÇO TOTAL DE CADA PEDIDO
SELECT p.id_pedido, c.id_cliente, c.nome AS cliente,
       COALESCE(SUM(ip.quantidade * ip.preco_unitario), 0) AS total_pedido
FROM pedidos p
LEFT JOIN itens_pedido AS ip ON p.id_pedido = ip.id_pedido
LEFT JOIN clientes AS c ON p.id_cliente = c.id_cliente
GROUP BY p.id_pedido;
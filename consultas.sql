USE projeto_restaurante;
-- LISTAR TODOS OS PRODUTOS COM PREÇO ACIMA DE 30
select * from produtos;

SELECT nome, categoria 
FROM produtos 
WHERE preco > 30 
ORDER BY nome ASC;


-- CLIENTES NASCIDOS ANTES DE 1985
select * from clientes;

SELECT nome, telefone, data_nascimento 
FROM clientes 
WHERE year(data_nascimento) < 1985 
ORDER BY data_nascimento DESC;


-- PRODUTOS QUE CONTÉM "CARNE" NOS INGREDIENTES
select * from info_produtos;

SELECT p.id_produto, p.nome, i.ingredientes
FROM produtos p
JOIN info_produtos i ON p.id_produto = i.id_produto
WHERE i.ingredientes LIKE '%carne%';


-- PRODUTOS ORDENADOS POR CATEGORIA E NOME
select * from produtos;

SELECT nome, categoria 
FROM produtos 
ORDER BY categoria ASC, nome ASC;


-- OS 5 PRODUTOS MAIS CAROS
select * from produtos;

SELECT nome, preco 
FROM produtos 
ORDER BY preco DESC
LIMIT 5;


-- 2 PRATOS PRINCIPAIS EM PROMOÇÃO (EXEMPLO COM OFFSET)
select * from produtos;

SELECT nome, categoria 
FROM produtos 
WHERE categoria = 'Prato Principal'
LIMIT 2 OFFSET 6;


-- PEDIDOS DO FUNCIONÁRIO 4 COM STATUS PENDENTE
select * from pedidos;

SELECT *
FROM pedidos
WHERE id_funcionario = 4 AND status = 'Pendente';


-- PEDIDOS QUE NÃO ESTÃO CONCLUÍDOS
select * from pedidos;

SELECT *
FROM pedidos
WHERE status <> 'Concluído';


-- PEDIDOS QUE POSSUEM PRODUTOS ESPECÍFICOS
select * from produtos;

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


-- ATUALIZAR O VALOR TOTAL DO PEDIDO (OPCIONAL)
UPDATE pedidos p
JOIN (
	SELECT id_pedido, SUM(quantidade * preco_unitario) AS total
	FROM itens_pedido
	GROUP BY id_pedido
) AS t ON p.id_pedido = t.id_pedido
SET p.valor_total = t.total;
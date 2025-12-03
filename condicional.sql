-- PEDIDOS DO ID_FUNCIONARIO = 4 E STATUS = PENDENTE
select * from pedidos;

select * from pedidos WHERE id_funcionario = 4 AND status = "Pendente";


-- PEDIDOS COM STATUS <> "CONCLUÍDO"
select * from pedidos;

select * FROM pedidos WHERE status <> "Concluído";


-- PEDIDOS QUE APRESENTAM O ID_PRODUTO (1, 3, 5, 7 OU 8)
select * from pedidos;

select * from pedidos WHERE id_produto IN (1, 3, 5, 7, 8);


-- NOMES DOS CLIENTES QUE COMEÇAM COM "C"
select * from clientes;

select * from clientes WHERE nome LIKE "C%";


-- INFO PRODUTOS QUE CONTENHAM CARNE OU FRANGO NOS INGREDIENTES
select * from info_produtos;

select * from info_produtos WHERE ingredientes LIKE '%Carne%' OR ingredientes LIKE '%Frango%';


-- PRODUTOS COM PREÇO DE 20 A 30
select * from produtos;

select * from produtos WHERE preco BETWEEN 20 AND 30;


-- ATUALIZAR ID PEDIDO 6 PARA VAZIO
select * from pedidos;

UPDATE pedidos
SET status = NULL 
WHERE id_pedido = 6;


-- SELEÇÃO DOS PEDIDOS COM STATUS NULOS E NÃO NULOS
select * from pedidos;

select * from pedidos WHERE status IS NULL;

select * from pedidos WHERE status IS NOT NULL;


-- STATUS NULOS = CANCELADO
select * from pedidos;

select id_pedido, status, IFNULL(status, 'Cancelado') AS status_atualizado FROM pedidos;


-- MÉDIA DOS SALÁRIOS
select * from funcionarios;

select nome, cargo, salario,
  CASE 
	WHEN salario > 3000 THEN 'Acima da média'
    ELSE 'Abaixo da média'
  END AS media_salario
FROM funcionarios;
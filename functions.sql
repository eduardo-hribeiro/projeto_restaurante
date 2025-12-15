USE projeto_restaurante; 

-- CRIAÇÃO DE FUNÇÃO QUE RETORNA OS INGREDIENTES DOS INFO_PRODUTOS
DELIMITER //
CREATE FUNCTION BuscaIngredientesProduto(idInfoProduto INT) -- Na função não precisa escrever IN ou OUT
RETURNS VARCHAR(200)
READS SQL DATA
BEGIN
   DECLARE produtosIngredientes VARCHAR(200);
   SELECT ingredientes INTO produtosIngredientes FROM info_produtos WHERE id_produto = idInfoProduto;
   RETURN produtosIngredientes;
END //
DELIMITER ;   

SELECT BuscaIngredientesProduto(10);


-- CRIAÇÃO DE FUNÇÃO QUE INFORMA SE O PEDIDO É ACIMA, ABAIXO OU IGUAL A MÉDIA DE TODOS OS PEDIDOS
DELIMITER //
CREATE FUNCTION mediaPedido(pedidoID INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
   DECLARE total_pedido DECIMAL(10,2);
   DECLARE media_geral DECIMAL(10,2);
   DECLARE resultado VARCHAR(100);

    -- Total do pedido informado
   SELECT SUM(ip.quantidade * pr.preco) INTO total_pedido
   FROM itens_pedido AS ip
   JOIN produtos AS pr ON ip.id_produto = pr.id_produto
   WHERE ip.id_pedido = pedidoID;

    -- Média do total de todos os pedidos
    SELECT AVG(total_por_pedido) INTO media_geral
    FROM (
        SELECT SUM(ip.quantidade * pr.preco) AS total_por_pedido
        FROM itens_pedido ip
        JOIN produtos pr ON ip.id_produto = pr.id_produto
        GROUP BY ip.id_pedido
    ) AS totais;

    SET resultado =
        CASE
            WHEN total_pedido > media_geral THEN 'Total do pedido acima da média'
            WHEN total_pedido < media_geral THEN 'Total do pedido abaixo da média'
            ELSE 'Total do pedido igual à média'
        END;

    RETURN resultado;
END //
DELIMITER ;

SELECT mediaPedido(5);
SELECT mediaPedido(6);
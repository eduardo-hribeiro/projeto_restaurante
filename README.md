# 🍽️ BD_restaurante

## 🚀 Descrição  
Este projeto é um sistema de banco de dados relacional para gestão de um restaurante. Ele contempla modelagem com tabelas normalizadas, registro de funcionários, clientes, produtos, pedidos e itens dos pedidos. O objetivo é aplicar boas práticas de modelagem de dados e estruturação em SQL, de modo a garantir integridade, flexibilidade e clareza no esquema.

---

## 📁 Estrutura do Projeto

```
BD_restaurante/
│
├── definicao.sql — Script principal: criação das tabelas normalizadas e estrutura completa.
├── inserts.sql — Inserções iniciais (funcionários, clientes, produtos, info_produtos, pedidos, itens_pedido).
├── consultas.sql — Exemplos de consultas SELECT, filtros, ordenações, buscas por critérios, JOINs, funções de agregadoras e uso de CTEs.
├── updates.sql — Exemplos de comandos UPDATE / DELETE para manipulação de dados.
├── views.sql - Exemplos de criações de visualizações para simplificar consultas de dados.
├── functions.sql - Consultas com o objetivo de retornar um valor específico.
└── README.md — Documentação deste projeto.

Os arquivos foram separados para melhor organização, visualização e manutenção do banco.

```

---

## 🗄️ Modelo de Dados & Tabelas  

O banco possui as seguintes tabelas principais, com relacionamentos adequados:

| Tabela             | Função / Conteúdo |
|--------------------|------------------|
| **cargos**         | Lista cargos de funcionários com `id_cargo`, `nome_cargo` e `nível`. |
| **funcionários**   | Dados dos funcionários: nome, CPF, cargo (FK para cargos), salário, data de admissão etc. |
| **clientes**       | Dados dos clientes do restaurante. |
| **produtos**       | Produtos ou pratos oferecidos pelo restaurante (nome, descrição, preço, categoria). |
| **info_produtos**  | Informações adicionais sobre produtos: ingredientes, fornecedor etc. |
| **pedidos**        | Registros de pedidos feitos por clientes — sem detalhe de item, apenas pedido geral. Usa `ENUM` para `status`. |
| **itens_pedido**   | Tabela de junção entre pedidos e produtos, relacionando cada pedido aos seus produtos/itens, com `quantidade` e `preco_unitario`. |

Esse modelo normalizado permite representar pedidos com múltiplos produtos de forma correta, sem redundâncias e com histórico consistente.

---

## ✅ Boas Práticas e Normalização  

- Uso de **chaves primárias (PK)** e **chaves estrangeiras (FK)** para garantir integridade referencial.  
- Substituição de campos de texto livre (ex: cargo como `VARCHAR`) por FK para `cargos`, garantindo padronização.  
- Separação entre pedido e itens do pedido — evitando repetição e permitindo 1 pedido ⇒ N itens.  
- Uso de `ENUM` para o status do pedido, limitando os valores possíveis.  
- Estrutura preparada para fácil manutenção, extensão e evolução.

---

## 🛠️ Tecnologias / Ambiente  

- Banco: **MySQL 8.x**  
- Ferramenta sugerida: **MySQL Workbench** ou outro cliente SQL compatível  
- Scripts em SQL puro (sem dependências externas)  

---

## 🎯 Como Usar  

- Clone este repositório:  
   ```bash
   git clone https://github.com/eduardo-hribeiro/BD_restaurante.git
   
- Abra o arquivo definicao.sql no MySQL Workbench e execute-o para criar o banco e as tabelas.

- Em seguida, execute inserts.sql para popular o banco com dados iniciais.

- Use consultas.sql para testar consultas — filtros, buscas, ordenações, joins etc.

- Teste updates.sql para verificar operações de atualização ou remoção de dados.

---

## 🔍 Exemplos de Algumas Consultas Executadas

- Selecionar todos os produtos com preço acima de determinado valor.

- Buscar clientes que nasceram antes de uma certa data.

- Encontrar pedidos de um cliente ou funcionários específicos.

- Listar os itens de cada pedido com quantidade e preço unitário.

- Calcular o valor total de um pedido somando os itens.

---

## 📌 Exemplo de Algumas Consultas Importantes

### Status nulos sendo exibidos como “Cancelado”
```sql
SELECT id_pedido, status, IFNULL(status, 'Cancelado') AS status_atualizado
FROM pedidos;
```

### Análise salarial
```sql
SELECT nome, cargo, salario,
  CASE 
    WHEN salario > 3000 THEN 'Acima da média'
    ELSE 'Abaixo da média'
  END AS media_salario
FROM funcionarios;
```

### Listar itens de cada pedido
```sql
SELECT p.id_pedido, c.nome AS cliente, pr.nome AS produto,
       ip.quantidade, ip.preco_unitario
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produtos pr ON ip.id_produto = pr.id_produto;
```

---

## 🧠 Destaque: Uso de CTE (Common Table Expressions)
O projeto inclui consultas utilizando CTEs, que melhoram:
- Legibilidade
- Organização
- Reutilização de lógica
- Clareza nas operações que exigem múltiplas etapas
- Exemplo aplicado no projeto:

Exemplo aplicado no projeto:
``` sql
WITH ranking_produtos AS (
    SELECT 
        nome,
        preco,
        ROW_NUMBER() OVER (ORDER BY preco DESC) AS ranking_preco
    FROM produtos
)
SELECT * 
FROM ranking_produtos
WHERE ranking_preco <= 5;
```

---

## 🧑‍💻 Autor

**Eduardo Ribeiro**  
Projeto desenvolvido para estudos de SQL e modelagem de banco de dados.

---

## 📄 Licença

Este projeto é de uso educacional.
Você pode reutilizar o conteúdo para estudos, desde que mantenha os créditos ao autor.

---

🗓️ Última atualização

Última atualização: Dezembro de 2025

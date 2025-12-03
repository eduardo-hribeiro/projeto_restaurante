# 🍽️ Banco de Dados – Restaurante
Projeto desenvolvido para prática de criação, manipulação e consulta de dados utilizando **MySQL**.
O objetivo é simular o funcionamento de um sistema de restaurante, contendo funcionários, clientes, produtos, pedidos e informações detalhadas de cada produto.

---

## 📁 Estrutura do Projeto

```
📦 restaurante
 ├── definicao.sql       # Script completo com criação das tabelas
 ├── manipulacao.sql     # Script completo com inserção, atualização e remoção de dados
 ├── consulta.sql        # Script completo com consultas por ordens e limites, além de criação de backup
 ├── condicional.sql     # Script completo com consultas através de estruturas condicionais
 └── README.md           # Documentação do projeto
```

---

## 🛠️ Tecnologias Utilizadas

- **MySQL**
- **MySQL Workbench**
- Comandos SQL: `CREATE`, `INSERT`, `SELECT`, `UPDATE`, `DELETE`, `JOIN`, `LIKE`, `BETWEEN`, `CASE`, `IFNULL`, `ORDER BY`, `LIMIT`, `IN`.

---

## 🗂️ Estrutura das Tabelas

O banco contém as seguintes tabelas:

- **funcionarios** — Dados dos funcionários do restaurante  
- **clientes** — Registro de clientes  
- **produtos** — Produtos vendidos  
- **info_produtos** — Informações extras como ingredientes e fornecedor  
- **pedidos** — Histórico de pedidos  
- **backup_pedidos** — Cópia da tabela de pedidos

As tabelas possuem **chaves primárias**, **chaves estrangeiras** e restrições como `UNIQUE` e `NOT NULL`.

---

## 🧪 Funcionalidades do Script (condicional.sql)

### ✔ Criação do Banco e Tabelas
O script:

- Cria o banco de dados `restaurante`
- Cria todas as tabelas com chaves e relacionamentos
- Adiciona comentários e restrições

### ✔ Inserção de Dados
Inclui:

- 10 funcionários  
- 30 clientes  
- 20 produtos  
- 20 registros de info_produtos  
- 50+ pedidos 

### ✔ Atualizações Realizadas
- Alteração de cargo e salário de funcionários  
- Atualização automática de pedidos anteriores a uma data para “Concluído”  
- Atualização de status para `NULL`

### ✔ Remoção
- Exclusão de funcionário por ID

### ✔ Backup
- Criação da tabela `backup_pedidos` com base nos registros atuais

---

## 🔍 Consultas Executadas

Essas foram as consultas solicitadas:

### 🧾 Seleções básicas
- Pedidos do funcionário `id_funcionario = 4` com status **Pendente**
- Pedidos com status diferente de **Concluído**
- Pedidos com `id_produto` em (1, 3, 5, 7, 8)
- Clientes cujo nome começa com “C”

### 🍗 Pesquisas por texto
- Produtos contendo **Carne** ou **Frango**
- Ingredientes contendo a palavra “carne”

### 💰 Consultas financeiras
- Produtos com preço entre **20 e 30**
- Os **5 produtos mais caros**
- Dois pratos principais em promoção (usando `LIMIT` e `OFFSET`)

### 🚫 Status nulos
- Pedidos com status `NULL`
- Exibição de status usando:
  ```sql
  IFNULL(status, 'Cancelado')
  ```

### 📊 Análise salarial
- Classificação de funcionários como:
  - **Acima da média**
  - **Abaixo da média**
  usando `CASE WHEN`.

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

---

## 🚀 Como Executar

1. Abra o **MySQL Workbench**
2. Importe os arquivos 
3. Execute o script completo ou as seções desejadas
4. Verifique os dados nas tabelas geradas

---

## 🧑‍💻 Autor

**Eduardo Ribeiro**  
Projeto desenvolvido para estudos de SQL e modelagem de banco de dados.

---

## 📄 Licença

Este projeto é de uso educacional e livre para estudos.

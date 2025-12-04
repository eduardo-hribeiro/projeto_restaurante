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
├── consultas.sql — Exemplos de consultas SELECT, filtros, ordenações e buscas por critérios.
├── updates.sql — Exemplos de comandos UPDATE / DELETE para manipulação de dados.
└── README.md — Documentação deste projeto.
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

---

## 🧩 Potenciais Melhorias / Extensões Futuras

- Adicionar tabela de status_pedido para status mais flexíveis (caso mude do ENUM).

- Registrar histórico de preços dos produtos para manter histórico real de pedidos antigos.

- Adicionar controle de estoque / quantidade disponível de produtos.

- Criar views para relatórios: pedidos por data, por cliente, por produto, faturamento total, etc.

- Criar scripts de backup / restauração.

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

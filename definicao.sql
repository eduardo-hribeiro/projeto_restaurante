create database restaurante; /* Banco de dados */
use restaurante;


-- TABELA FUNCIONÁRIOS
drop table if exists funcionarios;

create table funcionarios(
	id_funcionario int auto_increment primary key comment'ID único para os funcionários',
    nome varchar(255) not null, /* Não pode ser vazio */
    cpf varchar(14) not null, /* Não pode ser vazio */
    data_nascimento date,
    endereco varchar(255),
    telefone varchar(15) unique, /* Precisa ser único */
    email varchar(100) unique, 
    cargo varchar(100),
    salario decimal(10, 2),
    data_admissao date
);
desc funcionarios;


-- TABELA CLIENTES
drop table if exists clientes;

create table clientes(
	id_cliente int auto_increment primary key comment'ID único para cada cliente',
    nome varchar(255) not null, /* Não pode ser vazio */
    cpf varchar(14) not null, 
    data_nascimento date,
    endereco varchar(255),
    telefone varchar(15) unique, /* Precisa ser único */
    email varchar(100) unique, 
    data_cadastro date
);
desc clientes;


-- TABELA PRODUTOS
drop table if exists produtos;

create table produtos(
	id_produto int auto_increment primary key comment'ID único para cada pedido',
    nome varchar(255) not null, /* Não pode ser vazio */
    descricao text not null, /* Descrição detalhada produto (ingredientes, etc) */
    preco decimal(10, 2) not null,
    categoria varchar(100) /* Entrada, bebida, prato principal, etc */
);
desc produtos;


-- TABELA PEDIDOS
drop table if exists pedidos;

create table pedidos(
	id_pedido int auto_increment primary key comment'ID único para cada pedido',
    id_cliente int not null,
    id_funcionario int not null,
    id_produto int not null,
    quantidade int, /* Quantidade do produto pedido */ 
    preco decimal(10, 2) not null,
    data_pedido date,
    status varchar(50), /* Concluído, pendente, cancelado */
    
    foreign key (id_cliente) references clientes (id_cliente), /* Cliente que realizou o pedido */
    foreign key (id_funcionario) references funcionarios (id_funcionario), /* Funcionário que atendeu o pedido */
    foreign key (id_produto) references produtos (id_produto) /* Produto pedido */
);
desc pedidos;


-- TABELA INFO_PRODUTOS
drop table if exists info_produtos;

create table info_produtos(
	id_info int auto_increment primary key comment'ID único para cada info',
    id_produto int not null,
    ingredientes text not null, /* Lista de ingredientes do produto */
    fornecedor varchar(255) not null, /* Nome do fornecedor do produto */
    
    foreign key (id_produto) references produtos (id_produto) /* Referência ao produto */
);
desc info_produtos;
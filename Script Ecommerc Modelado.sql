create database ecommerceModelado;

use ecommerceModelado;

-- Cliando a base clientes - Generalização de PJ e PF

create table Clientes(
		idClientes int primary key auto_increment,
        Nome varchar(150) not null,
        Rua varchar(100),
        Bairro varchar(50),
        UF char(2),
        Telefone int,
        Tipo_cliente enum('PF','PJ')
        );

alter table clientes auto_increment=1;

-- cliando a tabela Pessoa Física

Create table PFisica(
		idPFisica int,
		CPF char(11) not null,	
        Sexo enum('M','F'),
        Dt_Nascimento date,        
        constraint unique_CPF_PFisica unique(CPF),
        constraint FK_PFisica_Cliente foreign key(idPFisica) references clientes(idClientes)
        on delete cascade
        on update cascade
);

-- Criando a tabela Pessoa Juridica

Create table PJuridica(
		idPJuridica int,
        RSocial varchar(150) not null,
		CNPJ char(14) not null,
        IE char(9) not null,
        constraint unique_CNPJ_RSocial unique(RSocial),
        constraint unique_CNPJ_Pjuridica unique(CNPJ),
        constraint unique_IE_Pjuridica unique(IE),
        constraint FK_PJuridica_cliente foreign key(idPJuridica) references clientes(idClientes)
		on delete cascade
        on update cascade
);

  
 -- Criando a tabela Pedidos - Recebendo a FK de Clientes
 
 create table Pedido(
		idPedido int primary key auto_increment,
        idPedCliente int,
        PStatus enum('Em processamento', 'Aprovado', 'Recusado'),
        Descricao varchar(200),
        constraint fk_Pedido_Cliente foreign key (idPedCliente) references Clientes(idClientes)
 );

-- Criando a tabela produto

create table Produtos(
		idProdutos int primary key auto_increment,
        Categoria enum('Eletronicos', 'Infantil','Cosmeticos','livraria','Moveis') default ('Outros'),
        PValor float
);

-- Criando tabela Entrega - Recebendo a FK de Pedido

create table Entrega(
		idEntrega int primary key  auto_increment,
        idEntPedido int,
        CodRastreio char(3),
        PrevEntrega date,
        StatusEntrega enum('A caminho','Entregue','Recusada'),
        Frete float,
        constraint fk_Entrega_Pedido foreign key (idEntPedido) references Pedido(idPedido)
);

-- Criando a tabela Vendedor

create table Vendedor(
		idVendedor int primary key auto_increment,
        CNPJ char(16) not null,
        RSocial varchar(100) not null, 
		IE char(9) not null, 
        Rua varchar(100),
        Bairro varchar(50),
        UF char(2),
        Telefone int,
        constraint unique_CNPJ_Terceiros unique(CNPJ),
        constraint unique_RSocial_Terceiros unique(RSocial),
        constraint unique_IE_Terceiros unique(IE)
);

-- Criando a tabela Fornecedor

create table Fornecedor(
		idFornecedor int primary key auto_increment,
        CNPJ char(16) not null,
        RSocial varchar(100) not null, 
		IE char(9) not null, 
        Rua varchar(100),
        Bairro varchar(50),
        UF char(2),
        Telefone int,
        constraint unique_CNPJ_Fornecedor unique(CNPJ),
        constraint unique_RSocial_Fornecedor unique(RSocial),
        constraint unique_IE_Fornecedor unique(IE)
);

-- Criando a tabela estoque

create table Estoque(
		idEstoque int primary key auto_increment,
        Rua varchar(100),
        Bairro varchar(50),
        UF char(2),
        Telefone int
);

-- Criando tabela Fomras de  Pagamentos

create table FPagamento(
		idFPagamento int auto_increment primary key,
		TipoPag Enum('Cartão de Credito','Boleto','Pix')
        );

-- Criando tabela de Relacionamento Formas de Pagamento do Pedidos

Create table Rel_FormPag_Pedidos(
        idRelFormPagPed int,
        idRelPedidoPag int,
        primary key (idRelFormPagPed,idRelPedidoPag),
        constraint FK_Rel_FormPag_Pedidos_FormPag foreign key (idRelFormPagPed) references FPagamento(idFPagamento),
        constraint FK_Rel_FormPag_Pedidos_Pedido foreign key (idRelPedidoPag) references Pedido(idPedido)
);

-- Criando tabela de Relacionamento Produto no Pedidos

create table Rel_Prod_Pedidos(
		idRelPrdPed int,
        idRelPedidoPrd int,
        QntProd int default 0,
        primary key(idRelPrdPed,idRelPedidoPrd),
        constraint FK_Rel_Prod_Pedidos_Prd foreign key (idRelPrdPed) references Produtos(idProdutos),
        constraint FK_Rel_Prod_Pedidos_Pedido foreign key (idRelPedidoPrd) references Pedido(idPedido)
);

-- Criando tabela de Relacionamento Produtos por Vendedor

create table Rel_Prd_Vend(
		idRelVendPrd int,
        idRelProdVend int,
        QntProd int default 0,
        primary key(idRelVendPrd,idRelProdVend),
        constraint FK_Rel_Prd_Vend_Vend foreign key (idRelVendPrd) references Vendedor(idVendedor),
        constraint FK_Rel_Prd_Vend_Prod foreign key (idRelProdVend) references Produtos(idProdutos)
        );
 

-- Criando tabela de Relacionamento de Produtos por Estoque

create table Rel_Prd_Est(
		idRelEstPrd int,
        idRelProdEst int,
        QntProd int default 0,
        primary key(idRelEstPrd,idRelProdEst),
        constraint FK_Rel_Prd_Est_Est foreign key (idRelEstPrd) references Estoque(idEstoque),
        constraint FK_Rel_Prd_Est_Prod foreign key (idRelProdEst) references Produtos(idProdutos)
        );
 
-- Criando tabela de Relacionamento de Produtos por Fornecedor

create table Rel_Prd_Forn(
		idRelFornPrd int,
        idRelProdForn int,
        QntProd int default 0,
        primary key(idRelFornPrd,idRelProdForn),
        constraint FK_Rel_Prd_Forn_Forn foreign key (idRelFornPrd) references Fornecedor(idFornecedor),
        constraint FK_Rel_Prd_Forn_Prod foreign key (idRelProdForn) references Produtos(idProdutos)
        );
        

show databases;

use information_schema;
show tables;
desc table_constraints;
select * from referential_constraints where constraint_schema = 'ecommerceModelado';

-- Inserindo dados na tabela Cliente

use ecommerceModelado;


insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('1', 'InnovateTech Solutions', 'Belvin', 'Box', 'RJ', '1464764074', 'PJ');
insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('2', 'Cassius da Silva', 'Ricarde', 'laranjeiras', 'RJ', '1021415545', 'PF');
insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('3', 'Flower Innovations', 'Eastment', 'Caminhas', 'SL', '2354682', 'PJ');
insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('4', 'Vera Tavares', 'Langlands', 'Real', 'US', '94194748', 'PF');
insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('5', 'Archi Industries', 'Leathers', 'Campo Grande', 'GL', '1652999196', 'PJ');
insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('6', 'Ygor Junior', 'Bettinson', 'Realengo', 'US', '870163240', 'PF');
insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('7', 'NexusGlobe', 'Wiltsher', 'Bangu', 'PG', '462302551', 'PJ');
insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('8', 'Justin Belmount', 'McGinn', 'Bangu', 'CA', '135514210', 'PF');
insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('9', 'VisionaryTech', 'Baldetti', 'Campo Grande', 'PG', '333246688', 'PJ');
insert into Clientes (idClientes, Nome, Rua, Bairro, UF, Telefone, Tipo_cliente) values ('10', 'Heloisa Gomes', 'Mulvy', 'Barra', 'PG', '785712195', 'PF');

select * from clientes;

-- Inserindo dados na tabela PFisica
        
insert into PFisica (idPFisica, CPF, Sexo, Dt_Nascimento) values ('2', '22546359873', 'M', '1956-02-27');
insert into PFisica (idPFisica, CPF, Sexo, Dt_Nascimento) values ('6', '13045876925', 'M', '1974-04-14');
insert into PFisica (idPFisica, CPF, Sexo, Dt_Nascimento) values ('8', '56987425314', 'M', '1990-12-04');
insert into PFisica (idPFisica, CPF, Sexo, Dt_Nascimento) values ('10', '25648759336', 'F', '1989-05-22');
insert into PFisica (idPFisica, CPF, Sexo, Dt_Nascimento) values ('4', '89754635218', 'F','1986-01-19');

select * from PFisica;

select cpf from PFisica where sexo='M';


-- Inserindo dados na tabela PJuridica
        
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('1', 'InnovateTech Solutions', '12365987563214', '965823564');
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('3', 'Flower Innovations', '96358216549635', '985648523');
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('5', 'Archi Industries', '58963582654782', '859635214');
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('7', 'NexusGlobe', '96356894215687', '589774581');
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('9', 'VisionaryTech', '98526547251369', '879852654');

select * from Pjuridica;

-- inserindo dados na tabela Pedidos

  
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('1', '2', 'Em Processamento', 'Maquina de Lavar');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('2','2', 'Em Processamento', 'Geladeira');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('3', '6', 'Recusado', 'Vestido');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('4', '8', 'Aprovado', 'Livro');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('5', '8', 'Aprovado', 'Fogão');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('6', '10', 'Aprovado', 'Boneca');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('7', '7', 'Aprovado', 'Jogo de Toalhas');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('8', '9', 'Em Processamento', 'Calça e Blusa');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('9', '9','Em Processamento', 'Tijolo');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('10', '9', 'Em Processamento', 'livro');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('11', '1', 'Recusado', 'Perfurme');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('12', '3', 'Aprovado', 'Sofá');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('13', '4', 'Aprovado', 'Televisão');
 insert into Pedido (idPedido, idPedCliente, PStatus, Descricao) values ('14', '4', 'Recusado', 'Brincos');
 
 
 select * from Pedido;
 
 select idPedido, PStatus from Pedido
		where PStatus='Recusado';
        
select count(*) as QtdPed from Pedido where idPedCliente =4;

select PStatus as StatusPedido, count(*) as QtdPed from Pedido group by PStatus;


-- Inserindo dados na tabela Produtos

alter table Produtos add NomeProduto varchar(50); 
alter table Produtos modify Categoria enum('Eletronicos', 'Infantil','Cosmeticos','livraria','Moveis','Vestimenta','Material de construção','Mesa&banho') default ('Outros');


insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (1,'Eletronicos',2500,'Maquina de lavar');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (2,'Infantil',100,'Boneca');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (3,'Cosmeticos',200,'Perfurme');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (4,'Eletronicos',4000,'Televisão');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (5,'Livraria',70.50,'Livro');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (6,'Material de construção',899,'Tijolo');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (7,'Moveis',1599.99,'Sofá');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (8,'Cosmeticos',19.99,'Brincos');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (9,'Eletronicos',999.99,'Fogão');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (10,'Mesa&banho',99.99,'Jogo de Toalhas');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (11,'Vestimenta',200,'Calça');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (12,'Vestimenta',59.90,'Blusa');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (13,'Eletronicos',2750.99,'Geladeira');
insert into Produtos(idProdutos, Categoria, PValor,NomeProduto) values (14,'Vestimenta',120.90,'Vestido');

select*from Produtos;

-- Inserindo dados na tabela Entega

insert into Entrega(idEntrega, idEntPedido, CodRastreio,PrevEntrega,StatusEntrega,Frete) values (1,4,145,'2023-05-12','Entregue',12.50);
insert into Entrega(idEntrega, idEntPedido, CodRastreio,PrevEntrega,StatusEntrega,Frete) values (2,8,574,'2023-08-31','A caminho',10.00);
insert into Entrega(idEntrega, idEntPedido, CodRastreio,PrevEntrega,StatusEntrega,Frete) values (3,8,581,'2023-08-16','A caminho',17.60);
insert into Entrega(idEntrega, idEntPedido, CodRastreio,PrevEntrega,StatusEntrega,Frete) values (4,10,253,'2023-03-05','Entregue',34.8);
insert into Entrega(idEntrega, idEntPedido, CodRastreio,PrevEntrega,StatusEntrega,Frete) values (5,7,355,'2023-09-13','Recusada',8.90);
insert into Entrega(idEntrega, idEntPedido, CodRastreio,PrevEntrega,StatusEntrega,Frete) values (6,3,558,'2023-01-10','Entregue',22.50);
insert into Entrega(idEntrega, idEntPedido, CodRastreio,PrevEntrega,StatusEntrega,Frete) values (7,4,478,'2023-04-17','Recusada',17.50);

select*from Pedido where PStatus='Aprovado';

select*from Entrega;

select count(*) as Qtd, StatusEntrega from Entrega group by StatusEntrega;

-- Inserindo dados na tablea Vendedor

insert into Vendedor(idVendedor,CNPJ,RSocial,IE,Rua,Bairro,UF,Telefone) values(1,'1569857456235698','Butique Flower','569856745','Abigail','Campo Grande','RJ','698559874');
insert into Vendedor(idVendedor,CNPJ,RSocial,IE,Rua,Bairro,UF,Telefone) values(2,'8965874263514256','TechTool','674598756','Vila Nova','Realengo','RS','987458742');
insert into Vendedor(idVendedor,CNPJ,RSocial,IE,Rua,Bairro,UF,Telefone) values(3,'5698874956635214','Casa Nova','567459987','Pedrinhas','Bangu','BH','989968574');
insert into Vendedor(idVendedor,CNPJ,RSocial,IE,Rua,Bairro,UF,Telefone) values(4,'7456235698857423','Happy Kid','878546923','Lodo','Sta.Cruz','SP','758793214');

select*from Vendedor;

-- Inserindo dados na tabela Fornecedor

insert into Fornecedor(idFornecedor,CNPJ,RSocial,IE,Rua,Bairro,UF,Telefone) values(1,'6988574232365987','Oliveiras Dist.','879564552','Casinhas','Belford Roxo','RJ','985746231');
insert into Fornecedor(idFornecedor,CNPJ,RSocial,IE,Rua,Bairro,UF,Telefone) values(2,'9756659854258746','Santos Dist.','998564875','Passaros','Sta.Cruz','SP','987653264');
insert into Fornecedor(idFornecedor,CNPJ,RSocial,IE,Rua,Bairro,UF,Telefone) values(3,'7845962156849756','Lady LTDA','887895462','Brejo','Marechal','BH','968523012');
insert into Fornecedor(idFornecedor,CNPJ,RSocial,IE,Rua,Bairro,UF,Telefone) values(4,'9568758213654878','Blue LTDA','968524165','Capitolio','Bangu','SP','987630254');
insert into Fornecedor(idFornecedor,CNPJ,RSocial,IE,Rua,Bairro,UF,Telefone) values(5,'7456235698857423','Happy Kid','878546923','Lodo','Sta.Cruz','SP','758793214');

select * from Fornecedor;


-- Inserindo dados na tabela Estoque

Insert into Estoque(idEstoque,Rua,Bairro,UF,Telefone) values(1,'Viveira','Sta. Cruz','SP','89756458');
Insert into Estoque(idEstoque,Rua,Bairro,UF,Telefone) values(2,'Green','Campo Grande','RJ','78945618');
Insert into Estoque(idEstoque,Rua,Bairro,UF,Telefone) values(3,'Viveira','Bangu','BH','88580068');

select * from Estoque;

--  Inserindo daos na tabela FPagamento

select count(*) as PedAprovados from pedido where PStatus='Aprovado'; -- inserir 7 formas de pagamentos

insert into FPagamento(idFPagamento,TipoPag) values (1,'Cartão de credito');
insert into FPagamento(idFPagamento,TipoPag) values (2,'Boleto');
insert into FPagamento(idFPagamento,TipoPag) values (3,'Boleto');
insert into FPagamento(idFPagamento,TipoPag) values (4,'Pix');
insert into FPagamento(idFPagamento,TipoPag) values (5,'Cartão de credito');
insert into FPagamento(idFPagamento,TipoPag) values (6,'Pix');
insert into FPagamento(idFPagamento,TipoPag) values (7,'Cartão de credito');

select * from FPagamento;

select TipoPag, count(*) as QtdPag from FPagamento group by TipoPag; -- Quantidade de por tipos de pagamento

-- Inserindod ados na Relação Forma de pagamento x Pedido

select * from FPagamento;
select * from pedido where PStatus='Aprovado';
select * from Produtos;

Insert into Rel_FormPag_Pedidos(idRelFormPagPed,idRelPedidoPag) values(1,1); -- televisão
Insert into Rel_FormPag_Pedidos(idRelFormPagPed,idRelPedidoPag) values(2,4); -- livro
Insert into Rel_FormPag_Pedidos(idRelFormPagPed,idRelPedidoPag) values(3,5); -- fogão
Insert into Rel_FormPag_Pedidos(idRelFormPagPed,idRelPedidoPag) values(4,6); -- Boneca
Insert into Rel_FormPag_Pedidos(idRelFormPagPed,idRelPedidoPag) values(5,7); -- Jogo de toalha
Insert into Rel_FormPag_Pedidos(idRelFormPagPed,idRelPedidoPag) values(6,12); -- Sofá
Insert into Rel_FormPag_Pedidos(idRelFormPagPed,idRelPedidoPag) values(7,13); -- Televisão

select * from Rel_FormPag_Pedidos;


-- Inserindo dados na Relação Produtos x Pedido

select * from pedido; -- verificar os produtos x pedidos
select * from Produtos;

insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(4,1,1); -- televisão
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(13,2,1); -- geladeira
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(14,3,3); -- vestido
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(5,4,5); -- livro
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(9,5,1); -- fogão
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(2,6,3); -- boneca
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(10,7,10); -- toalhas
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(11,8,2); -- calça
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(12,8,2); -- blusa
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(6,9,1000); -- tijolo
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(5,10,2); -- livro
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(3,11,4); -- perfurme
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(7,12,1); -- sofa
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(4,13,2); -- televisão
insert into Rel_Prod_Pedidos(idRelPrdPed,idRelPedidoPrd,QntProd) values(8,14,6); -- brincos

select * from Rel_Prod_Pedidos;

-- Inserindo dados na Relação Produtos por Vendedor

select * from produtos; -- 14 prod.(1,3,5,7,10)
select * from vendedor;

insert into Rel_Prd_Vend(idRelVendPrd,idRelProdVend,QntProd) values(1,1,10);
insert into Rel_Prd_Vend(idRelVendPrd,idRelProdVend,QntProd) values(2,3,0);
insert into Rel_Prd_Vend(idRelVendPrd,idRelProdVend,QntProd) values(3,5,50);
insert into Rel_Prd_Vend(idRelVendPrd,idRelProdVend,QntProd) values(4,7,5);
insert into Rel_Prd_Vend(idRelVendPrd,idRelProdVend,QntProd) values(4,10,6);

select * from Rel_Prd_Vend;


-- Inserindo dados na Relação Produtos por Estoque

 select * from produtos; -- 14 prod.(1,3,5,7,10) / (2,4,8,11,14)
 select * from estoque; -- 3 estoques
 
insert into Rel_Prd_Est(idRelEstPrd,idRelProdEst,QntProd) values(1,2,3);
insert into Rel_Prd_Est(idRelEstPrd,idRelProdEst,QntProd) values(2,4,80);
insert into Rel_Prd_Est(idRelEstPrd,idRelProdEst,QntProd) values(3,8,0);
insert into Rel_Prd_Est(idRelEstPrd,idRelProdEst,QntProd) values(2,11,50);
insert into Rel_Prd_Est(idRelEstPrd,idRelProdEst,QntProd) values(1,14,0);


select * from Rel_Prd_Est;
 
-- Inserindo dados na Relação Produtos por Fornecedor

 select * from produtos; -- 14 prod.(1,3,5,7,10) / (2,4,8,11,14) / (6,9,12,13) / sem estoque (Ped 3 - prd 14,ped 11 prod 3 ,ped 14 prod 8) - pedidos recusados
 select * from fornecedor; -- 4 fornecedores
 select * from Rel_Prod_Pedidos;

insert into Rel_Prd_Forn(idRelFornPrd,idRelProdForn,QntProd) values(1,6,10000);
insert into Rel_Prd_Forn(idRelFornPrd,idRelProdForn,QntProd) values(2,9,10);
insert into Rel_Prd_Forn(idRelFornPrd,idRelProdForn,QntProd) values(3,12,15);
insert into Rel_Prd_Forn(idRelFornPrd,idRelProdForn,QntProd) values(4,13,4);

show tables; -- 15 tabelas

-- Quantos pedidos foram feitos por cada cliente?

select * from clientes;
select * from pedido;

select idClientes, Nome, count(*) as Qtd from clientes c, Pedido p 
		where idClientes = idPedCLiente
        group by idClientes;
        
        
-- Algum vendedor também é fornecedor?

select * from vendedor;
select * from fornecedor;

select v.RSocial, IdVendedor, IdFornecedor 
		from Vendedor as v 
        Inner Join Fornecedor as f
        on v.CNPJ = f.CNPJ;

-- Relação de produtos x fornecedores;

Select * from Produtos;
Select * from Fornecedor;
select * from Rel_Prd_Forn;

select p.idProdutos, p.NomeProduto, r.idRelFornPrd as Fornecedor, RSocial as NomeForn, QntProd
		from Produtos as p
		inner join Rel_Prd_Forn as r
        on p.idProdutos = r.idRelProdForn
        inner join Fornecedor as f
        on f.idFornecedor=idRelFornPrd;


-- Relação de produtos x estoques;

Select * from Produtos;
select * from estoque;
select * from Rel_Prd_Est;

select p.idProdutos, p.NomeProduto, r.idRelEstPrd as Estoque, RSocial as NomeForn, QntProd
		from Produtos as p
		inner join Rel_Prd_Est as r
        on p.idProdutos = r.idRelProdEst
        inner join Fornecedor as f
        on f.idFornecedor=idRelEstPrd;
        
-- Lerembrando: 
show tables;
select * from Pedido;
select * from FPagamento;
Select * from entrega;
select * from rel_formpag_pedidos;
Select * from Produtos;
select * from rel_prod_pedidos;

-- Relacionar o Produtos x pedido, valor total dos pedidos Aprovados 

select r.idRelPedidoPrd as Pedido, p.PStatus, r.QntProd, pd.Pvalor, round((QntProd*Pvalor),2) as total
	from rel_prod_pedidos as r
		inner join Pedido as p
        on r.idRelPedidoPrd = p.idPedido
        inner join produtos as pd
        on pd.idProdutos = r.idRelPrdPed        
        where p.PStatus = 'Aprovado';

-- Agrupar por cliente o total solicitado nos pedidos filtrando por tipo

select * from Pedido;
select * from clientes;
select * from rel_prod_pedidos;

select p.idPedCliente as Cliente, c.Nome, c.Tipo_Cliente, sum(QntProd) as QtdTotal
		from Pedido p
        inner join rel_prod_pedidos r
        on idRelPedidoPrd = idPedido
        inner join clientes c
        on idPedCliente = idclientes
        group by idpedCliente
        having Tipo_cliente = 'PJ';
        
select p.idPedCliente as Cliente, c.Nome, c.Tipo_Cliente, sum(QntProd) as QtdTotal
		from Pedido p
        inner join rel_prod_pedidos r
        on idRelPedidoPrd = idPedido
        inner join clientes c
        on idPedCliente = idclientes
        group by idpedCliente
        having Tipo_cliente = 'PF'; 

-- Verificando quantidade por tipo de cliente PJ x PF

select c.Tipo_Cliente, sum(QntProd) as QtdTotal
		from Pedido p
        inner join rel_prod_pedidos r
        on idRelPedidoPrd = idPedido
        inner join clientes c
        on idPedCliente = idclientes
        group by Tipo_cliente; 

-- Total de Quant e Valor por Tipo de cliente

Select * from Produtos;
select * from rel_prod_pedidos;

   select c.Tipo_Cliente, sum(QntProd) as QtdTotal, round(Sum(PValor),2) as TValor
		from Pedido p
        inner join rel_prod_pedidos r
        on idRelPedidoPrd = idPedido
        inner join clientes c
        on idPedCliente = idclientes
        inner join Produtos pd
        on idRelPrdPed = pd.idProdutos
        group by Tipo_cliente; 
        
        
-- Recuperando o total dos pedidos aprovados + Frete,  Status das entregas, Qtd dos Protudos 

select * from entrega;
Select * from pedido;
select * from rel_prod_pedidos;
Select * from Produtos; 


select r.idRelPedidoPrd as Pedido, p.PStatus, r.QntProd, pd.Pvalor as VProd, round((QntProd*Pvalor),2) as Total, e.Frete, e.StatusEntrega, round((QntProd*Pvalor)+Frete,2) as PedTotal
	from rel_prod_pedidos as r
		inner join Pedido as p
        on r.idRelPedidoPrd = p.idPedido
        inner join produtos as pd
        on pd.idProdutos = r.idRelPrdPed
        inner join entrega as e
        on identPedido = p.idPedido
        where p.PStatus = 'Aprovado';
	


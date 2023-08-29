create database Oficina;

use oficina;

-- Cliando a base clientes - PJ e PF

create table Clientes(
		idClientes int primary key auto_increment,
        PNome varchar(150) not null,
        Rua varchar(100),
        Bairro varchar(50),
        UF char(2),
        Telefone int,
        Tipo_cliente enum('PF','PJ')
        );

alter table clientes auto_increment=1;

-- cliando a tabela Pessoa Física

Create table PFisica(
		idPFisica int primary key,
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
		idPJuridica int primary key,
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

-- Criando a tabela de veiculos

create table Veiculos(
		idVeiculos int primary key auto_increment,
        idCliVeiculo int,
        Doc_CRV char(11) not null,
        Placa char(7),
        TipoVeiculo Enum('Carro','Moto','Caminhão'),
        constraint unique_Placa unique(Placa),
		constraint unique_Doc_CRV unique(Doc_CRV),
        constraint FK_idCliVeiculo foreign key(idCliVeiculo) references clientes(idClientes)
);

alter table Veiculos auto_increment=1;

-- Criando Tabela de Motos

create table Moto(
		idVeic_Moto int primary key,
        Cor varchar(20),
        Modelo varchar(20),
        constraint FK_VeicMoto foreign key(idVeic_Moto) references veiculos(idVeiculos)        
);

-- Criando Tabela de Carros

create table Carro(
		idVeic_Carro int primary key,
        Cor varchar(20),
        Modelo varchar(20),
        constraint FK_VeicCarro foreign key(idVeic_Carro) references veiculos(idVeiculos)        
);
 
-- Criando Tabela de Caminhão

create table Caminhao(
		idVeic_Caminhao int primary key,
        Cor varchar(20),
        Modelo varchar(20),
        constraint FK_VeicCaminhao foreign key(idVeic_Caminhao) references veiculos(idVeiculos)        
);

-- Criando tabela Avaliação - Equipe Mecaninca

create table Equipe(
		idEquipe int primary key auto_increment,
        idEq_Veiculo int,
        Tipo_Equipe enum('Azul','Verde','Vermelha','Amarela'),
        constraint FK_idEq_Veiculo foreign key(idEq_Veiculo) references veiculos(idVeiculos)
);

alter table Equipe auto_increment=1;

-- Criando tabela ordem de serviço

create table OrdServico(
		idOrdServico int primary key auto_increment,
        IdOrdVeiculo Int,
        IdEqMecanica int,        
        CodOrdem int, 
        Dt_Emissão date,
        Prev_Entrega date,
        Tipo_servico enum('Revisão','Conserto'),
        OrdStatus enum('Em Andamento','Concluido'),
        constraint FK_OS_IdOrdVeiculo foreign key(IdOrdVeiculo) references veiculos(idVeiculos),
        constraint FK_OS_IdEqMecanica foreign key(IdEqMecanica) references Equipe(idEquipe)
        );

alter table OrdServico auto_increment=1;

-- Criando a tabela Peças

create table PecasMec(
		idPecas int primary key auto_increment,
        PDescricao varchar(100),
        PQtd int
);

alter table PecasMec auto_increment=1;

-- Criando tabela Mão de Obra

create table MObra(
		idMObra int primary key auto_increment,
        MODescricao varchar(100)
);

alter table MObra auto_increment=1;

-- Criando tabela de relacionamento entre Peças e Ordem de serviço

create table Rel_Pç_OS(
		idRelPecaOS int,
        idRelOServPc int,
        Valor float,
        primary key(idRelPecaOS,idRelOServPc),
        constraint FK_RelPecaOS_Pecas foreign key(idRelPecaOS) references pecasMec(idPecas),
        constraint FK_RelOServpc_OS foreign key(idRelOServPc) references OrdServico(idOrdServico)
);

-- Criando tabela de relacionamento entre Mão de Obra e Ordem de serviço

create table Rel_MO_OS(
		idRelMObr_OS int,
        idRelOServMO int,
        Valor float,
        primary key(idRelMObr_OS,idRelOServMO),
        constraint FK_idRelMObr_OS_MO foreign key(idRelMObr_OS) references MObra(idMObra),
        constraint FK_idRelOServMO_OS foreign key(idRelOServMO) references OrdServico(idOrdServico)
);                    


-- Inserindo dados na tabela Cliente

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

select count(*) as Qtd from PFisica where sexo='F';


-- Inserindo dados na tabela PJuridica
        
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('1', 'InnovateTech Solutions', '12365987563214', '965823564');
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('3', 'Flower Innovations', '96358216549635', '985648523');
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('5', 'Archi Industries', '58963582654782', '859635214');
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('7', 'NexusGlobe', '96356894215687', '589774581');
insert into PJuridica (idPJuridica, RSocial, CNPJ, IE) values ('9', 'VisionaryTech', '98526547251369', '879852654');

select * from Pjuridica;

-- Inserindo dados na tabela Veiculos

insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('2','89574623781','PLR8574','Carro');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('1','2563698571','POB8635','Caminhão');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('3','98571203214','PIT5835','Moto');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('4','47571203214','OTT5885','Moto');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('5','47888523214','RST6685','Caminhão');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('6','87596526514','ESN8500','Carro');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('7','51455555777','WQP5002','Moto');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('8','88574228712','GBK8542','Carro');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('9','85745852599','YTR3342','Caminhão');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('10','8875933527','MBL0326','Moto');
insert into Veiculos(idCliVeiculo,Doc_CRV,Placa,TipoVeiculo) values('10','8875555527','MBL0886','Carro');

select * from Veiculos;

-- Inserindo dados na tabela moto

insert into Moto(idVeic_Moto,Cor,Modelo) values('3','Vermelha','scooter');
insert into Moto(idVeic_Moto,Cor,Modelo) values('4','Preta','street');
insert into Moto(idVeic_Moto,Cor,Modelo) values('7','Azul','street');
insert into Moto(idVeic_Moto,Cor,Modelo) values('10','Preta','scooter');

-- Inserindo dados na tabela Carros
 
insert into Carro(idVeic_Carro,Cor,Modelo) values('2','Cinza','SUV');
insert into Carro(idVeic_Carro,Cor,Modelo) values('6','Branco','Sedans');
insert into Carro(idVeic_Carro,Cor,Modelo) values('8','Verde','Picapes');
insert into Carro(idVeic_Carro,Cor,Modelo) values('10','Laranja','SUV');

-- Inserindo dados na tabela Caminhão
       
insert into Caminhao(idVeic_Caminhao,Cor,Modelo) values('1','Cinza','VUC');
insert into Caminhao(idVeic_Caminhao,Cor,Modelo) values('5','Azul','VUC');
insert into Caminhao(idVeic_Caminhao,Cor,Modelo) values('9','Vermelho','TOCO');


-- Inserindo dados na tabela Avaliação - Equipe Mecaninca

insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(1,'Amarela');
insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(2,'Azul');
insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(3,'Vermelha');
insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(4,'Verde');
insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(5,'Verde');
insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(6,'Amarela');
insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(7,'Azul');
insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(8,'Vermelha');
insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(9,'Azul');
insert into Equipe(idEq_Veiculo,Tipo_Equipe) values(10,'Amarela');

select * from Equipe;


-- Inserindo dados na tabela ordem de serviço

insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(1,5,564,'2023-08-01','2023-08-11','Conserto','Concluido');
insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(2,10,566,'2023-08-04','2023-08-14','Revisão','Concluido');
insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(3,9,700,'2023-08-16','2023-08-26','Revisão','Em Andamento');
insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(4,4,745,'2023-08-23','2023-08-31','Conserto','Em Andamento');
insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(5,3,454,'2023-08-20','2023-08-29','Conserto','Em Andamento');
insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(6,2,852,'2023-08-07','2023-08-17','Revisão','Concluido');
insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(7,7,963,'2023-08-11','2023-08-21','Concerto','Concluido');
insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(8,6,956,'2023-08-07','2023-08-20','Revisão','Concluido');
insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(9,1,785,'2023-08-24','2023-09-03','Revisão','Em andamento');
insert into OrdServico(IdOrdVeiculo,IdEqMecanica,CodOrdem,Dt_Emissão,Prev_Entrega,Tipo_servico,OrdStatus) values(10,8,942,'2023-08-22','2023-08-31','Conserto','Em andamento');

select*from OrdServico;


-- Inserindo dados na tabela Peças

insert into PecasMec(PDescricao,PQtd) values('Supesnsão',2);
insert into PecasMec(PDescricao,PQtd) values('Peneus de Carro',4);
insert into PecasMec(PDescricao,PQtd) values('Peneus de moto',2);
insert into PecasMec(PDescricao,PQtd) values('Pneus de camminhão',4);
insert into PecasMec(PDescricao,PQtd) values('Pastilha de freio',4);
insert into PecasMec(PDescricao,PQtd) values('Bteria',1);
insert into PecasMec(PDescricao,PQtd) values('Filtro de ar',1);
insert into PecasMec(PDescricao,PQtd) values('Oleo',1);
insert into PecasMec(PDescricao,PQtd) values('Pistão',1);

select * from PecasMec;

-- Inserindo dados na tabela Mão de Obra

insert into MObra(MODescricao) values('Troca de Oleo');
insert into MObra(MODescricao) values('Troca de Pneus');
insert into MObra(MODescricao) values('Troca da Suspensão');
insert into MObra(MODescricao) values('Troca do Filtro de ar');
insert into MObra(MODescricao) values('Troca da bateria');
insert into MObra(MODescricao) values('Troca das Pastilhas de freio');
insert into MObra(MODescricao) values('Troca do Pistão');

select * from MObra;

-- Inserindo dados na tabela de Relacionamento Peças x Ordem de serviço

select * from OrdServico;
select * from veiculos;

select o.idOrdServico, v.Tipoveiculo, o.Tipo_servico 
		from Veiculos as v
        inner join OrdServico as o
        on o.idOrdVeiculo = v.idveiculos;
        
select*from Rel_Pç_OS;
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(1,1,99.9);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(5,1,149.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(4,2,449);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(6,2,599.89);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(8,3,49.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(3,4,69.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(8,4,49.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(1,4,88.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(9,5,659.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(10,5,999.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(7,6,50);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(5,7,79.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(4,8,449);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(3,9,69.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(9,9,69.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(8,9,69.99);
insert into Rel_Pç_OS(idRelPecaOS,idRelOServPc,Valor) values(6,9,69.99);

-- Criando tabela de relacionamento entre Mão de Obra e Ordem de serviço

select * from MObra;

select o.idOrdServico, v.Tipoveiculo, o.Tipo_servico, p.Pdescricao
		from Veiculos as v
        inner join OrdServico as o
        on o.idOrdVeiculo = v.idveiculos
        inner join Rel_Pç_OS r
        on o.idOrdServico = r.idRelOServPc
		inner join PecasMec p
        on p.idPecas = r.idRelPecaOS;
             

insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(3,1,69.99); -- Suspenção
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(6,1,89.99); -- Pastilha de Ferio
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(2,2,159.99); -- Pneu de Caminhão
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(5,2,99.99); -- Bateria 
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(1,3,49.99); -- Oleo Moto
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(3,4,69.99); -- Suspensão
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(2,4,39.99); -- Pneu de moto
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(1,4,49.99); -- Oleo
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(7,5,45.99); -- Pistão
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(5,5,99.99); -- Bateria
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(4,6,39.99); -- FIltro de ar
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(6,7,89.99); -- Pastilha de freio
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(2,8,159.99); -- Pneu de caminhão
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(2,9,39.99); -- Pneu de moto
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(5,9,99.99); -- Bateria
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(1,9,49.99); -- oleo
insert into Rel_MO_OS(idRelMObr_OS,idRelOServMO,Valor) values(7,9,45.99); -- Pistão

select * from Rel_MO_OS;


-- Iniciando as Queries

show tables;

select * from Veiculos;
select * from clientes;

-- Quantidade de veiculos por tipo

select count(*) as Qtd, TipoVeiculo 
		from Veiculos
        group by TipoVeiculo;
        
-- modelos e cores das motos

select * from moto;
select * from Veiculos;
select * from clientes;
        
select idCliVeiculo,Placa, TipoVeiculo,cor,modelo,Nome,Telefone,Tipo_cliente
		from veiculos v
        inner join moto m
        on idVeiculos=idVeic_Moto
        inner join clientes
        on idCliVeiculo=idclientes;
        
select idCliVeiculo,Placa, TipoVeiculo,cor,modelo
		from veiculos v
        inner join carro c
        on idVeiculos=idVeic_carro;
        
-- Recuperando o Tipo do Veiculo, Placa que a equipe realizando o conserto/manutenção 

select * from equipe;
select * from veiculos;
select Tipo_equipe from  Equipe where tipo_equipe='Azul';

select TipoVeiculo, Placa, Tipo_equipe
		from equipe e
        inner join veiculos
        on idEq_Veiculo=idVeiculos;

-- quantos veiculos cada equipe esta realizando o conserto/manutenção 

select Tipo_equipe, count(*) as Qtd
		from equipe
        group by Tipo_equipe;

-- Somente euqipe azul

select Tipo_equipe, count(*) as Qtd
		from equipe
        group by Tipo_equipe
        having tipo_equipe='azul';


-- Ordem de serviço : recuperando o nome do cliente, placa do carro, tipo do veiculo, Tipo do serviço, Status da Ordem e Equipe que realizou o serviço
	
show tables;
select * from ordservico;
select * from mobra;
select * from veiculos;
select * from clientes;


select idOrdServico,nome, placa,TipoVeiculo,Tipo_cliente,Tipo_servico,OrdStatus,Tipo_equipe
		from ordservico
        inner join veiculos v
        on idOrdVeiculo=idveiculos
        inner join clientes c
        on idClientes=idCliVeiculo
        inner join equipe e
        on idEqMecanica=idEquipe;
        
show tables;
select * from ordservico;
select * from mobra;
select * from rel_mo_os;
select * from rel_pç_os;
select * from pecasmec;

-- total de peças por ordem de serviço

select idRelOServpc, round(SUM(valor),2) as total from rel_pç_os group by idRelOServpc;

-- Valor total de mão de obra por ordem de serviço

select idRelOServMO, round(SUM(valor),2) as total, idOrdVeiculo, TipoVeiculo
	from rel_mo_os 
	inner join ordservico
    on idOrdServico=idRelOServMO
    inner join veiculos
    on idOrdVeiculo=idveiculos
	group by idRelOServMO;

-- Quantas ordens temos e seus status

select OrdStatus, count(*) as Qtd
		from ordservico
        group by OrdStatus;

-- tipos de Manutenção - conserto ou revisão

select Tipo_servico, count(*) as Qtd
		from ordservico
        group by Tipo_servico;

-- Valor total de peças por ordem de serviço

select idRelOServPc as OServico, round(SUM(valor),2) as total, idOrdVeiculo, TipoVeiculo
	from rel_pç_os 
	inner join ordservico
    on idOrdServico=idRelOServPc
    inner join veiculos
    on idOrdVeiculo=idveiculos
	group by idRelOServPc;
    
-- total de valores de peças por Tipo de veiculo

    select TipoVeiculo, round(SUM(valor),2) as total
	from rel_pç_os 
	inner join ordservico
    on idOrdServico=idRelOServPc
    inner join veiculos
    on idOrdVeiculo=idveiculos
	group by TipoVeiculo
    order by total;

select idRelOServMO, round(SUM(valor),2) as total from rel_mo_os group by idRelOServMO;
select pc.idRelOServpc, round(SUM(pc.valor),2) as totalpc from rel_pç_os as pc group by idRelOServpc;
    

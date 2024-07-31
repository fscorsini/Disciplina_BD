create database cineonline;
use cineonline;
show tables;
CREATE TABLE cinema
		( 
			cinema_codigo int NOT NULL, 
			cinema_nome varchar(40) NOT NULL,
			cinema_sala varchar(2) NOT NULL, 
			cinema_capacidade int NOT NULL, 
			cinema_cidade varchar(50) NOT NULL,
		            PRIMARY KEY(cinema_codigo)
		);

CREATE TABLE filmes
(
	fil_codigo int NOT NULL,
	fil_titulo varchar(50) NOT NULL,
	fil_genero varchar(30) NOT NULL, 
	fil_censura char(8) NOT NULL DEFAULT 'Livre', 
	PRIMARY KEY(fil_codigo)
);

CREATE TABLE sessao
(
	ses_codigo int NOT NULL, 
	ses_codfilme int NOT NULL, 
	ses_codcinema int NOT NULL, 
	ses_datahora datetime NOT NULL, 
	ses_preco numeric(9,2) NOT NULL, 
	PRIMARY KEY (ses_codigo), 
	FOREIGN KEY (ses_codfilme) 
	REFERENCES filmes (fil_codigo), 
	FOREIGN KEY (ses_codcinema) 
	REFERENCES cinema (cinema_codigo)
) ;
show tables;
desc cinema;
show create table cinema;

insert into cinema values
(1,"Cine1","1",100,"Alfenas"),
(2,"Cine2","1",100,"Machado"),
(3,"Cine3","1",100,"Varginha");
select * from cinema;

desc filmes;
insert into filmes values
(1, "Filme 1", "Ação","14"),
(2, "Filme 2", "Comedia","12"),
(3, "Filme 3", "Drama","16")
;
select * from filmes;

desc sessao;
insert into sessao values
(1,1,1,"2023-12-01",35.50),
(2,2,2,"2023-11-01",40.50),
(3,3,3,"2023-10-01",50.54)
;
select * from sessao;

-- PRECISA CRIAR AS TABELAS CLIENTES E COMPRAS PARA CONTINUAR
SELECT cli_nome, fil_titulo
	FROM clientes CROSS JOIN filmes;
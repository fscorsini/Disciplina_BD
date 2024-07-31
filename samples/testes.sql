show databases;
drop database banco;
show databases;
use sakila;
show tables;
select * from actor;
show procedure status where db = 'sakila';
show triggers;
show tables;
show create table actor;
describe actor;
show columns from actor;
show columns from city;
show columns from payment;
show create database sakila;
show databases;
use world;
show tables;
select * from country;
describe country;
describe payment;
select * from country;
-- name, região e expectaviva de vida
select count(*) from country;
select Name, Region, LifeExpectancy from country where LifeExpectancy > 70 ORDER BY LifeExpectaNcy DESC;
select Name, Region, LifeExpectancy 
from country 
where LifeExpectancy is not null 
order by LifeExpectancy ASC;
select * from country where Name = "Brazil";
select * from country;
show create table country;

-- FAZER uma consulta que mostre a média de expectativa de vida em cada região em ordem DESC

select Region, avg(LifeExpectancy) as Media
from country where LifeExpectancy is not null
group by Region
order by Media DESC;


Use sakila;
















-- FAZER uma consulta que mostre a média de expectativa de vida em cada 
-- região em ordem DESC

use world;
show tables;
show create table country;
select * from country;

SELECT Name, Region, 
LifeExpectancy FROM country
WHERE LifeExpectancy IS NOT NULL 
ORDER BY LifeExpectancy ASC;

select Region, round(avg(LifeExpectancy),2) 
as MediaExpectativa
from Country
where LifeExpectancy is not null
group by Region 
order by MediaExpectativa Desc;


select distinct(Region) from Country;
select city.Name, Country.Name from city, country
where Country.Code = City.CountryCode
order by Country.Name ASC;

select C.Name, CO.Name from city as C, country as CO
where CO.Code = C.CountryCode
order by CO.Name ASC;

use sakila;
show tables;

select amount, amount * 0.9 as Desconto 
from payment;

select max(amount) from payment;
select min(amount) from payment 
where amount > 0;
select avg(amount) from payment
where amount >= 5.99;
select * from address;
-- Todos os registros do distrito do Texas
select * from address where
district = "Texas" 
or district = "Alberta"
or district = "California"
or district = "Attika";
select * from address where
district in ("Texas", "Alberta", 
"California","Attika");
select * from address where
district like "T____";
select * from address where
district like "Ca%";

use world;
select * from country 
order by LifeExpectancy DESC 
limit 100,100;



use mysql;
show tables;
show databases;
select * from
user;
create user fabio@172.29.0.1
identified by '4321';
drop user fabio@172.20.240.1;

select database();

select * from payment;
select * from payment where amount > 5.99;
select avg(amount) from payment;
select * from payment 
where amount > (select avg(amount) from payment);

select * from payment where customer_id = 1;
select count(*) from payment where customer_id = 1;
-- ERRADA

select * from customer
where customer_id in (
	select customer_id
    from payment 
    where amount = (
		select max(amount) from payment
	)
);
select *
from customer 
where customer_id in (
	select customer_id
    from payment
    where amount = (
		select max(amount) 
        from payment
    )
);

select customer_id, amount
    from payment
    where amount = (
		select max(amount) 
        from payment
    );







SELECT country_id, city, city_id
from city
where city_id < 20
order by country_id DESC;

select * from city limit 2;


use sakila;
show tables;
select * from payment;
select * from customer;

select avg(amount) from payment;

select customer_id, amount from payment where amount > (
	select avg(amount) from payment
);

select C.first_name, C.last_name, P.amount 
from customer as C, payment as P 
where C.customer_id = P.customer_id and P.amount > (
	select avg(amount) from payment
) order by amount desc;

select concat(C.first_name, " " , C.last_name) as Nome, P.amount 
from customer as C, payment as P 
where C.customer_id = P.customer_id and P.amount > (
	select avg(amount) from payment
) order by P.amount desc;

select concat(C.first_name, " " ,C.last_name) as Nome, P.amount as Valor
from customer as C, payment as P 
where C.customer_id = P.customer_id and P.amount > (
	select avg(amount) from payment
) order by Valor Desc;



select * from store;
select * from staff;
select * from payment;

show tables;


select sum(amount) from payment group by staff_id;


SELECT language.name,
       film.title,
       film.rental_rate
FROM film, language
JOIN category ON film.category_id = category.category_id
ORDER BY (
    SELECT SUM(rental_rate)
    FROM rental
    WHERE rental.film_id = film.film_id
) DESC;

select * from film;
select * from language;
select * from category;

SELECT year(film.release_year),
       film.title,
       AVG(film.rating) AS average_rating
FROM film
GROUP BY year(film.release_year)
ORDER BY average_rating DESC;

select release_year, title from film
where rental_duration > (
	select avg(rental_duration) from film
) order by rental_duration desc;

select * from language;

select F.release_year, F.title, L.name, F.rental_duration  from film as F, language as L
where rental_duration > (
	select avg(rental_duration) from film
) and L.language_id = F.language_id order by F.rental_duration desc;


SELECT customer.first_name,
       customer.last_name
FROM customer
WHERE NOT EXISTS (
    SELECT *
    FROM store
    WHERE NOT EXISTS (
        SELECT *
        FROM rental
        WHERE rental.customer_id = customer.customer));
        
select * from rental;
select R.rental_date, C.first_name from rental as R, customer as C group by C.first_name;
        
show tables;
Select * from actor;
select * from film;
select * from film_actor;

select * from film_actor where film_id in (
	select film_id from film where length > (
		select avg(length) from film)
);

select actor.first_name, film.title from film_actor, actor, film 
where actor.actor_id = film_actor.actor_id and film.film_id = film_actor.film_id 
and film_actor.film_id in (
	select film_id from film where length > (
		select avg(length) from film)
) order by film.length desc;


show tables;
select * from category;
select * from film where rating in (
	select rating, count(*) as conta from film group by rating order by conta desc
)order by rental_rate desc;

select rating, count(*) as conta from film group by rating order by conta desc;


use sakila;
show tables; 
select * from category;
select * from film;

select * from film;

Select release_year, title from film
where rental_duration = (
	select max(rental_duration) from film
) order by rental_duration desc;



use sakila;
























show tables;
select * from film where rental_duration > (
	select avg(rental_duration) from film
);

-- Média do tempo de aluguel (rental_duration)


-- tempo maximo de aluguel
select max(rental_duration) from film;

select * from film 
where rental_duration < (
	select avg(rental_duration) from film
);

-- média do tempo de aluguel
-- consulta com campo linguagem, nome filme 

show tables;
select * from language;
select * from film;

select avg(rental_duration) from film;
describe language;

select F.title, L.name 
from film as F, language as L
where F.language_id = L.language_id and rental_duration > (
	select avg(rental_duration) from film
);  

select customer_id, amount from payment
where amount >(
	select avg(amount) from payment
) order by amount desc;

select C.first_name, C.last_name, P.amount 
from payment as P, customer as C
where C.customer_id = P.customer_id and
P.amount >(
	select avg(amount) from payment
) order by P.amount desc;


-- média dos lenght dos filmes (film coluna lenght)
-- Quais filmes tiveram o tempo de duração maior que a média anterior
-- Quais atores participaram dos filmes

show tables;
select * from film_actor where film_id in (
	select film_id from film where length >(
		select avg(length) from film
	)
);
use sakila;
-- Número de atores que participaram de filmes onde a duração é maior que a média de duração dos filmes da base.
select count(distinct(actor_id)) from film_actor where film_id in (
	select film_id from film where length >(
		select avg(length) from film
	)
);

show tables;
select * 
from customer
join payment on customer.customer_id = payment.payment_id;

select 
	customer.customer_id,
    customer.first_name,
    customer.last_name,
    payment.rental_id,
    payment.amount
from customer
join payment on customer.customer_id = payment.customer_id;
select * from payment;
select * from customer;
select * from address;


select 
	cus.customer_id,
    cus.first_name,
    cus.last_name,
    adr.address,
    pay.rental_id,
    pay.amount
from customer as cus
join payment as pay 
	on cus.customer_id = pay.customer_id
join address as adr
	on cus.address_id = adr.address_id;
    

create table payment_backup as
select * from payment;

select * from payment_backup;

truncate table payment_backup;
drop table payment_backup;

select 
	max(amount) as Maior,
    min(amount) as Menor,
    avg(amount) as Media,
    sum(amount) as total,
    count(amount) as vendas
from payment
where staff_id = 1;

select 
	customer_id,
    sum(amount) as total
from payment
group by customer_id
order by total desc;


select 
	pay.customer_id,
    concat(cus.first_name, " " , cus.last_name) as 'Nome Completo',
    sum(pay.amount) as total
from payment as pay
join customer as cus using(customer_id)
group by cus.customer_id
order by total desc;

-- Pegue os clientes que mais fizeram compras e com o maior valor. Ordene primeiramente pelo número de compras e depois pelo valor.
select 
	pay.customer_id,
    concat(cus.first_name, " " , cus.last_name) as 'Nome Completo',
    sum(pay.amount) as total,
    count(amount) as compras
from payment as pay
join customer as cus using(customer_id)
group by cus.customer_id
having total >= 150 and compras >= 35
order by compras desc, total desc;

use sakila;
select actor.first_name,actor.last_name, film.title from film_actor, actor, film 
where actor.actor_id = film_actor.actor_id and film.film_id = film_actor.film_id 
and film_actor.film_id in (
	select film_id from film where length > (
		select avg(length) from film)
) order by film.length desc;




show tables;
select * from actor;
select * from film where rental_duration = 3 and rental_rate = 2.99;
select rental_rate from film group by rental_rate;
select rental_duration from film group by rental_duration;
select max(rental_rate) from film;
select * from film where rental_rate = (
	select max(rental_rate) from film
);

use world;
show tables;
select * from country;
select * from city;

-- Quais são as cidades do pais com menor expectativa de vida
select * from city
where CountryCode = (
	select code from country 
    where LifeExpectancy is not null
    order by LifeExpectancy asc
    limit 1
);

USE WORLD;
-- Quais são as cidades do pais com maior expectativa de vida
select * from city
where CountryCode = (
	select code from country 
    where LifeExpectancy is not null
    order by LifeExpectancy desc
    limit 1
);


select * from countrylanguage where Language like "Port%";
select * from countrylanguage order by Percentage desc;
select CountryCode from (
	select CountryCode, count(CountryCode) as contar from countryLanguage 
	group by CountryCode
	having contar = 12
	order by contar desc
	limit 1
) as Tabela;

select CountryCode from countrylanguage group by CountryCode;

-- Identifique o continente onde se encontra o país com o maior número de linguas faladas internamente. Apresente o nome do país e o continente.
Select Name, Continent from country 
where Code = (
	select CountryCode from (
		select CountryCode, count(CountryCode) as contar from countryLanguage 
		group by CountryCode
		having contar = 12
		order by contar desc
		limit 1
	) as Tabela
);

Select Name, Continent from country 
where Code = (
	select CountryCode from (
		select CountryCode, count(CountryCode) as quant from countryLanguage 
		group by CountryCode
		order by quant desc, CountryCode asc
		limit 1
	) as Tabela
);

select CountryCode, count(CountryCode) as quant from countryLanguage 
		group by CountryCode
		order by quant desc, CountryCode asc
		limit 10;
-- Qual o país com a maior população? Apresente o Nome do país, o Continente e o Code.
select Name, Continent, Code, Population 
from country where population = (
	select max(population) from country
);

-- Quais países que a população seja maior que a média de população dos países do mundo. Apresente o Nome, o Continente e a População.
select Name, Continent, Code, Population 
from country where population > (
	select avg(population) from country
);

use world;


-- ATIVIDADE SEMANA 6

-- Comando para exibir todas as bases de dados.
show databases;

-- Comando para selecionar a base de dados sakila.
use sakila;

-- Comando para exibir todas as tabelas de uma base selecionada.
show tables;

-- SQL para exibir todos os registros da tabela actor.
select * from actor;

-- SQL para exibir os endereços (tabela address) onde os distritos começam com a letra T e mais 4 letras
select * from address where district like "T____";

-- SQL para exibir os endereços (tabela address) onde os distritos começam com as letras Ca.
select * from address where district like "Ca%";

-- SQL para exibir filmes onde a duração do aluguel seja menor que a média da duração de aluguel de filmes da base.
select * from film where rental_duration < (
	select avg(rental_duration) from film
);

-- SQL para exibir o número de atores que participaram de filmes cujo tempo de duração (length)
-- seja maior que a média de tempo de duração dos filmes da base.
select count(distinct(actor.actor_id)) from film_actor, actor, film 
where actor.actor_id = film_actor.actor_id and film.film_id = film_actor.film_id 
and film_actor.film_id in (
	select film_id from film where length > (
		select avg(length) from film)
);

select count(distinct(actor_id)) from film_actor where film_id in (
	select film_id from film where length >(
		select avg(length) from film
	)
);

-- Comando para selecionar a base de dados world.
use world;

-- SQL utilizada para exibir o nome, a região e a expectativa de vida dos países cuja expectativa de vida é maior que 70. 
-- Apresente os 20 primeiros países com maior expectativa de vida.
select Name, Region, LifeExpectancy 
from country 
where LifeExpectancy > 70 
limit 20;

-- SQL utilizada para exibir todos os dados do Brasil na tabela country.
select * from country where Name = "Brazil";

-- SQL utilizada para consultar a média de expectativa de vida em cada região em ordem da maior para a menor. 
-- Utilize a tabela country e agrupe por Region. 
select Region, avg(lifeExpectancy) as ExpectativaVida 
from country 
group by Region 
order by ExpectativaVida Desc;

-- SQL para exibir as Regiões em que são categorizadas os países.
select count(Region) from country group by Region;

-- FIM ATIVIDADE SEMANA 6


-- SEMANA 7 

use world;
select * from countrylanguage;

-- Contar numero de idiomas falados em um país
select countrycode, count(countrycode) as contar
from countryLanguage
group by countryCode;

-- Países onde se fala mais de 10 idiomas
select countrycode, count(countrycode) as contar
from countryLanguage
group by countryCode
having contar > 10;

select * from country;
-- Países onde se fala mais de 10 idiomas. Apresentando nome do pais
select C.Name, CL.countrycode, count(CL.countrycode) as Idiomas
from country as C
join countryLanguage as CL 
	on C.code = CL.countrycode
group by countrycode
having Idiomas > 10;

use world;
-- Monstra todas as combinações possíveis entre duas tabelas
select * from country cross join countrylanguage;
select * from country;
select * from countryLanguage;



-- VIEWS - SEMANA 7
use agencia3si2023;
show tables;
select * from conta;

select * from cliente order by nome;

create view v_clientesOrdemCrescente as
	select * 
    from cliente
    order by nome;
show TABLES;
select * from v_clientesordemcrescente;
show create view v_clientesordemcrescente;





show databases;
use agencia3si2024;
show tables;
select * from cliente;

CREATE VIEW vw_clientesOrdenados AS
	SELECT nome, cpf
	FROM cliente
	ORDER BY nome;

SHOW TABLES;
SELECT * FROM vw_clientesordenados;
SHOW CREATE VIEW vw_clientesordenados;




show tables;
CREATE VIEW vw_totalbanco AS
	SELECT sum(saldo) AS "Dinheiro do Banco" 
    FROM conta;
SELECT * FROM vw_totalbanco;
show tables;

show tables;
select * from contavinculada;

select 
	cli.nome,con.idconta,con.tipo,con.saldo
    from cliente as cli, conta as con, 
    contavinculada as cvi
	where
		cli.idcliente = cvi.cliente_idcliente
        and con.idconta =cvi.conta_idconta;

select 
	cli.nome,con.idconta,con.tipo,con.saldo
    from cliente as cli
    join contavinculada as cvi
		on cli.idcliente = cvi.cliente_idcliente
	join conta as con
		on con.idconta =cvi.conta_idconta;
	









use agencia3si2024;
show create table cliente;

select * from cliente;

create table cliente2 (
	select * from cliente
);
-- delete from cliente2;
select * from cliente2;
-- drop table cliente2;

select table_schema, table_name, engine
from information_schema.tables
where table_name = 'cliente2';

ALTER TABLE cliente2 engine=InnoDB;
select * from cliente2;

START TRANSACTION;
	DELETE FROM cliente2;
    INSERT INTO cliente2 (nome,cpf,rg,dataNascimento,telefone)
    VALUES ('Fabio','123',NULL,'1921-05-12',NULL);
    SELECT * FROM cliente2;
-- ROLLBACK;
COMMIT;


SELECT * FROM cliente2;










-- SEMANA 09 - TRANSAÇÕES
USE agencia3si2023;
show tables;
show create table cliente;
select table_schema, table_name, engine 
from information_schema.tables
where table_name = 'cliente2';

alter table cliente2 engine=MyISAM;
alter table cliente2 engine=InnoDB;

select @@autocommit;
set @@autocommit = OFF;
select 
select * from cliente

SELECT * FROM cliente2;
create table cliente4 (
	select * from cliente
);
select * from cliente4;
rollback;

show tables;


START TRANSACTION;
	DELETE FROM cliente2;
    INSERT INTO cliente2 (nome, cpf, rg, dataNascimento, telefone)
		VALUES ('Fálvio Almeida','456.456.456-56',NULL,'1985-03-28',NULL);
	SELECT * FROM cliente2;
ROLLBACK;


START TRANSACTION;
	DELETE FROM cliente2;
    INSERT INTO cliente2 (nome, cpf, rg, dataNascimento, telefone)
		VALUES ('Fálvio Almeida','456.456.456-56',NULL,'1985-03-28',NULL);
	SELECT * FROM cliente2;
COMMIT;
























select * from cliente2;




















use agencia3si2024;
select * from conta;
start transaction;
	update conta set saldo = saldo * 1.10
		where tipo = "Poupança";
	select * from conta;
rollback;
-- commit;
select * from conta;












SELECT * FROM cliente;
START TRANSACTION;
	INSERT INTO cliente VALUES (NULL,"NOME1","444","444","1975-05-12","(35)3295-4444");
	INSERT INTO cliente VALUES(NULL,"NOME2","999","999","1980-01-10","(35)3295-9999");
	INSERT INTO cliente VALUES(NULL,"NOME3","777","777","1990-10-02","(35)3295-7777");
-- COMMIT;
Rollback;
SELECT * FROM cliente;






SELECT * FROM cliente4;
start transaction;
	UPDATE cliente4 SET nome = UPPER(nome) WHERE telefone IS NOT NULL;
	SELECT * FROM cliente4;
-- COMMIT;
ROLLBACK;

START TRANSACTION;
	UPDATE cliente4 SET nome = UPPER(nome) WHERE telefone IS NOT NULL;
	SELECT * FROM cliente4;
-- COMMIT;
ROLLBACK;

SELECT * FROM cliente4;



show procedure status;


-- FIM SEMANA 09



-- SEMANA 10 

-- AVALIAÇÃO
drop database agenda_eletronica;
-- Criar o banco de dados
CREATE DATABASE agenda_eletronica;

-- Usar o banco de dados agenda_eletronica
USE agenda_eletronica;

-- Criar tabela 'Usuarios'
CREATE TABLE Usuarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    nivel_acesso ENUM('admin', 'usuario') NOT NULL DEFAULT 'usuario'
);

-- Criar tabela 'Contatos'
CREATE TABLE Contatos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(255),
    email VARCHAR(255),
    data_nascimento DATE,
    observacao TEXT,
    id_usuario INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

-- Criar tabela 'Compromissos'
CREATE TABLE Compromissos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    id_contato INT UNSIGNED NOT NULL,
    descricao TEXT NOT NULL,
    id_usuario INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_contato) REFERENCES Contatos(id),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

-- Atividade 1 - Crie SQL's de inserção para cada tabela do banco na ordem correta conforme os relacionamentos. Cadastre 3 usuarios, 4 contatos e 3 compromissos.
-- Atividade 2 - Crie uma SQL para atualizar o e-mail de um dos usuarios
-- Atividade 3 - Altere a tabela compromisso e insira um campo para registrar o local do compromisso.
-- Atividade 4 - Crie um SQL para inserir o seguinte usuario no sistema: Pedrinho, pedrinho@gmail.com, senha 456 com o nível de acesso de administrador.
-- Atividade 5 - Crie uma view que apresente todos os compromissos do ano de 2024 apresentando a data, o motivo do compromisso, o nome de quem estará no compromisso, o telefone e o e-mail dele.
-- Atividade 6 - Crie uma SQL para cadastrar um compromisso chamado "Festa de aniversário - Nome do contato" para todos os contatos de sua agenda

-- Inserir cadastros básicos (opcional)
INSERT INTO Usuarios (nome, email, senha, nivel_acesso)
VALUES
    ('admin', 'admin@email.com', '123', 'admin'),
    ('usuario1', 'usuario1@email.com', '123', 'usuario');

INSERT INTO Contatos (nome, endereco, telefone, email, data_nascimento, observacao, id_usuario)
VALUES
    ('João Silva', 'Rua da Paz, 123', '(55) 1234-5678', 'joao@email.com', '1980-01-01', 'Cliente desde 2010.', 1),
    ('Maria Oliveira', 'Avenida Paulista, 987', '(55) 9876-5432', 'joao@email.com', '1990-02-02', 'Fornecedora de serviços.', 1);

INSERT INTO Compromissos (data_hora, id_contato, descricao, id_usuario)
VALUES
    ('2024-04-24 10:00:00', 1, 'Reunião para discutir projeto X.', 1),
    ('2024-04-25 14:00:00', 2, 'Entrega de materiais para evento Y.', 1);

CREATE TABLE Funcinoario (
    id INT NOT NULL PRIMARY KEY,
    nome varchar(200),
    cargo varchar(100),
    salario float(10)
);
INSERT INTO Funcinoario (id, nome, cargo, salario) VALUES (1,'João Silva', 'Gerente', 5000.00);
drop table Funcinoario;

sELECT c.id, c.data_hora, contatos.nome AS nome_contato, c.descricao
FROM Compromissos c
INNER JOIN Contatos contatos ON c.id_contato = contatos.id
WHERE c.id_usuario = 1 AND YEARWEEK(c.data_hora) = YEARWEEK(CURDATE());




-- Resolução da Avaliação Prática

-- Criando banco
CREATE DATABASE agenda_eletronica2;

USE agenda_eletronica2;

CREATE TABLE Usuarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    nivel_acesso ENUM('admin', 'usuario') NOT NULL DEFAULT 'usuario'
);

CREATE TABLE Contatos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(255),
    email VARCHAR(255),
    data_nascimento DATE,
    observacao TEXT,
    id_usuario INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE Compromissos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    id_contato INT UNSIGNED NOT NULL,
    descricao TEXT NOT NULL,
    id_usuario INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_contato) REFERENCES Contatos(id),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);


/* Atividade 1
Crie SQL's de inserção para cada tabela do banco na ordem correta conforme os relacionamentos. 
Cadastre 3 usuários, 4 contatos e 3 compromissos. 
Apresente os comandos utilizados para inserir os registros e um print do resultado gerado.
*/

INSERT INTO Usuarios (nome, email, senha, nivel_acesso) VALUES
    ('Administrador', 'admin@email.com', '123', 'admin'),
    ('Usuário Comum', 'usuario@email.com', '123', 'usuario'),
    ('Usuário Comum 2', 'usuario2@email.com', '123', 'usuario');

SELECT * FROM usuarios;

INSERT INTO Contatos (nome, endereco, telefone, email, data_nascimento, observacao, id_usuario) VALUES
	('João Silva', 'Rua da Paz, 123', '(55) 1234-5678', 'joaosilva@email.com', '1980-01-01', 'Cliente desde 2010.', 1),
    ('Carlos Souza', 'Rua Brasil, 32', '(55) 3412-5490', 'carlossouza@email.com', '1980-01-01', 'Cliente desde 2020.', 1),
    ('Maria Oliveira', 'Avenida Paulista, 987', '(55) 9876-5432', 'mariaoliveira@email.com', '1990-02-02', 'Fornecedora de serviços.', 1);

SELECT * FROM Contatos;

INSERT INTO Compromissos (data_hora, id_contato, descricao, id_usuario) VALUES
    ('2024-04-25 10:00:00', 1, 'Reunião para discutir projeto X.', 1),
    ('2024-05-22 08:00:00', 2, 'Reunião para discutir projeto W.', 1),
    ('2024-04-26 14:00:00', 3, 'Entrega de materiais para evento Y.', 1);

SELECT * FROM Compromissos;

/* Atividade 2
Crie uma SQL para atualizar o e-mail de um dos usuários. 
Escolha o usuário que desejar. 
Apresente a SQL utilizada para executar a tarefa e um print do resultado gerado.
*/
UPDATE Usuarios SET email = 'user2@gmail.com' WHERE nome = 'Usuário Comum';
SELECT * FROM Usuarios;

/* Atividade 3
Crie uma SQL para executar a alteração da tabela compromisso de modo a inserir um 
campo para registrar o local do compromisso. Você tem liberdade para escolher o 
nome do campo e as características do mesmo. Apresente a SQL utilizada e um print do resultado gerado.
*/
ALTER TABLE Compromissos ADD local VARCHAR(255) NOT NULL;
SELECT * FROM Compromissos;

/* Atividade 4
Crie um SQL para inserir o seguinte usuário no sistema: Pedrinho, pedrinho@gmail.com, 
senha 456 com o nível de acesso de administrador. 
Apresente a SQL utilizada para inserir o usuário em solicitado e um print do resultado gerado.
*/
INSERT INTO Usuarios (nome, email, senha, nivel_acesso) VALUES ('Pedrinho', 'pedrinho@gmail.com', '456', 'admin');
SELECT * FROM Usuarios;

/* Atividade 5
Crie uma view que apresente todos os compromissos do ano de 2024 apresentando a data, o motivo do compromisso, 
o local, o nome de quem estará no compromisso, o telefone e o e-mail dele. 
Apresente o comando SQL utilizado para criação da view e um print do resultado gerado.
*/
CREATE VIEW Compromissos_2024 AS
	SELECT
		c.data_hora AS "Data e Hora",
		c.descricao AS "Motivo do Compromisso",
		c.local AS "Local",
		contatos.nome AS "Nome do Contato",
		contatos.telefone AS "Telefone",
		contatos.email AS "Email"
	FROM Compromissos c
	INNER JOIN Contatos AS contatos ON c.id_contato = contatos.id
	WHERE YEAR(c.data_hora) = 2024;
    
drop view compromissos_2024;

CREATE VIEW Compromissos_2024 AS
	SELECT
		c.data_hora AS "Data e Hora",
		c.descricao AS "Motivo do Compromisso",
		c.local AS "Local",
		contatos.nome AS "Nome do Contato",
		contatos.telefone AS "Telefone",
		contatos.email AS "Email"
	FROM Compromissos c
	INNER JOIN Contatos ON c.id_contato = Contatos.id
	WHERE YEAR(c.data_hora) = 2024;

CREATE VIEW Compromissos_2024 AS
	SELECT
		c.data_hora AS "Data e Hora",
		c.descricao AS "Motivo do Compromisso",
		c.local AS "Local",
		contatos.nome AS "Nome do Contato",
		contatos.telefone AS "Telefone",
		contatos.email AS "Email"
	FROM Compromissos c
	INNER JOIN Contatos AS contatos ON c.id_contato = contatos.id
	WHERE c.data_hora like '2024%';

SELECT * FROM Compromissos_2024;

/* Atividade 6
Crie uma SQL para cadastrar um compromisso chamado "Festa de aniversário - Nome do contato" 
para todos os contatos de sua agenda. Você pode escolher inserir todos de uma vez ou criar uma SQL para cada inserção. 
Apresente o(s) comando(s) SQL utilizado(s) e um print do resultado gerado.
*/
INSERT INTO Compromissos (data_hora, id_contato, descricao, id_usuario, local)
VALUES
    ('2024-01-01 19:00:00', 1, 'Festa de aniversários - João Silva', 1, 'Casa João'),
    ('2024-10-01 19:00:00', 2, 'Festa de aniversários - Carlos Souza', 1, 'Casa Carlos'),
    ('2024-02-02 19:00:00', 3, 'Festa de aniversários - Maria Oliveira', 1, 'Casa Maria');

SELECT * FROM Compromissos;
/* Atividade 8
Nosso banco permite que mais de um usuário gerencie seus compromissos. Então poderíamos logar com um usuário, 
cadastrar os contatos deste usuário e inserir os compromissos desejados. Para este exercício, insira um 
compromisso na semana corrente com um contato de um Usuario específico no banco de dados. Agora, crie uma SQL 
utilizando subconsultas que retorne os compromissos agendados na semana corrente para um usuário em questão. 
Apresente o SQL utilizado para resolver esta demanda. Lembre-se que é obrigatório o uso de subconsultas.
Funções SQL úteis:
yearweek() - semana do ano;
curdate() - data corrente;
*/

SELECT C.id AS 'Código', C.data_hora AS 'Data Compromisso', contatos.nome AS 'Nome Contato', C.descricao AS 'Descrição'
FROM Compromissos C
INNER JOIN Contatos AS contatos ON C.id_contato = contatos.id
WHERE C.id_usuario = (
    SELECT id FROM Usuarios WHERE id = 1
) AND YEARWEEK(C.data_hora) = YEARWEEK(CURDATE());





-- SEMANA 10 - Triggers
create database teste_Trigger;

use teste_trigger;
drop table produto;
create table Produto (
id_produto int AUTO_INCREMENT Primary Key,
nome_produto varchar(45) not null,
preco_produto decimal(10,2) not null,
preco_desconto decimal(10,2) not null
);

select * from Produto;

create trigger tr_desconto before insert
on Produto
for each row
set new.preco_desconto = (new.preco_produto * 0.90);

show triggers;

select * from Produto;

insert into Produto (nome_produto, preco_produto) values ('Monitor', 700.00);
















CREATE DATABASE exemplo_trigger;
DROP DATABASE exemplo_trigger;
USE teste_trigger;
CREATE TABLE Produto (
id_produto INT AUTO_INCREMENT PRIMARY KEY,
nome_produto VARCHAR(45) NOT NULL,
preco_normal DECIMAL(10,2) NOT NULL,
preco_desconto DECIMAL(10,2) NOT NULL
);
SELECT * FROM Produto;
UPDATE Produto SET preco_normal = 20 WHERE Produto.id_produto = 10;
UPDATE from Produto SET preco_normal = 20.00 WHERE id_produto = 4;
UPDATE produto(set preco_normal = 20.00 WHERE id_produto=10;)
UPDATE Produto SET preco = 20.00 WHERE id = 10;
UPDATE produto SET preco = 20.00 WHERE id = 1;
update produto set id = 10 where id = 1;
UPDATE Produto SET preco = 20 WHERE id = 10;
UPDATE Produto SET id = 10, preco = 20.00;
UPDATE preco FROM Produtos WHERE id = 10;
select * from produto;
UPDATE produtos SET id = preco 20;
DELETE FROM produto WHERE id = 10;
drop Produto where id = 11;


CREATE TRIGGER tr_desconto BEFORE INSERT
ON Produto
FOR EACH ROW
SET NEW.preco_desconto = (NEW.preco * 0.90);

SELECT * FROM Produto;
SHOW TRIGGERS;
DROP trigger tr_desconto;
INSERT INTO Produto 
(nome_produto, preco)
VALUES
('Mouse de luizinha', 70.00),
('Mouse normal', 20.00),
('Pen drive 64 GB', 30.00);

SELECT * FROM Produto;



DROP DATABASE agenda_eletronica3;
CREATE DATABASE agenda_eletronica3;

USE agenda_eletronica3;

CREATE TABLE Usuarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    nivel_acesso ENUM('admin', 'usuario') NOT NULL DEFAULT 'usuario'
);

CREATE TABLE Contatos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(255),
    email VARCHAR(255),
    data_nascimento DATE,
    observacao TEXT,
    id_usuario INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE Compromissos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    id_contato INT UNSIGNED NOT NULL,
    descricao TEXT NOT NULL,
    id_usuario INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_contato) REFERENCES Contatos(id),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);
select auto_increment from information_schema.tables where table_name = "Usuarios" and table_schema = 'agenda_eletronica3';
select * from information_schema.tables;
select * from usuarios;
select * from contatos;
select * from compromissos;

show databases;
use teste_trigger;
show tables;
select * from log;
describe log;

DELIMITER //
CREATE TRIGGER tr_logar_produtos3
AFTER INSERT on Produto
FOR EACH ROW
BEGIN
	INSERT INTO log (nome, preco, preco_desconto, data)
    VALUES (NEW.nome_produto,NEW.preco, NEW.preco_desconto,NOW());
END//


DELIMITER ;

describe produto;
INSERT INTO Produto (nome_produto, preco) VALUES ("SSD 250", 500);
select * from log;
drop trigger tr_logar_produtos3;



drop database agencia3si2024;
use agencia3si2024;
show tables;
select * from contavinculada;
select * from cliente;
describe cliente;

/* Atividade 1
Toda vez que atualizarmos o CPF de um cliente, se for diferente do que estava, a conta
deve mudar sua data de abertura
*/
#Definindo o delimitador
delimiter //
CREATE TRIGGER tr_atualiza_data_conta_por_cpf
BEFORE UPDATE ON cliente
FOR EACH ROW 
BEGIN
	if (NEW.cpf != OLD.cpf) then
		UPDATE contavinculada SET dataAbertura = NOW()
			WHERE OLD.idCLIENTE = CLIENTE_idCLIENTE;
	END IF;
END//
delimiter ;

select * from contavinculada;
select * from cliente;
update cliente set cpf = '187.187.187.81' where idCLIENTE = 1;


/*
Toda vez que a senha de uma conta do tipo POUPANÇA for alterada, acrescentar dez centavos no saldo.
*/
DELIMITER //
CREATE TRIGGER tr_atualiza_saldo_poupanca_senha
BEFORE UPDATE ON conta
FOR EACH ROW
BEGIN
	IF (NEW.senha != OLD.senha) THEN
		IF (NEW.tipo = 'Poupança') THEN
			SET NEW.saldo = OLD.saldo + 0.10;
		END IF;
	END IF;
END//;
DELIMITER ;
SHOW TRIGGERS;

SELECT * FROM conta;
update conta set senha = "123321" where idConta = 2;


DELIMITER //
CREATE TRIGGER tr_insere_poupanca_cliente
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
	INSERT INTO conta VALUES (null, "Poupança", 0.01,"abc");
	SELECT idCONTA INTO @idNovaConta FROM conta 
ORDER BY idCONTA DESC LIMIT 1;
	INSERT INTO contavinculada VALUES(NEW.idCLIENTE, @idNovaConta, NOW());
END//
DELIMITER ;

SHOW TRIGGERS;
DROP TRIGGER tr_insere_poupanca_cliente;

SELECT * from cliente;
desc cliente;
select * from contavinculada;
select * from conta;
insert into cliente (nome,cpf,rg,dataNascimento,telefone) values ("Jose","132.111.122-56","MG","1980-06-06","3532953");
SELECT idCONTA INTO @idNovaConta FROM conta ORDER BY idCONTA DESC LIMIT 1;
select @idNovaConta;
select * from conta;

use agencia3si2024;
create table auditoria (
id_auditoria int auto_increment primary key,
acao varchar(400),
tabela varchar(50),
data_hora datetime,
usuario varchar(50)
);
show tables;
desc auditoria;
show triggers;
drop trigger tr_log_auditoria;
/*
Criar uma Trigger que registre no LOG de AUDITORIA a exclusão de uma conta vinculada.
*/
delimiter $
create trigger tr_log_auditoria after delete
on contavinculada
for each row
begin
	insert into auditoria values (NULL, "Exclusão de Registro", "contavinculada",now(), user());
end$
delimiter ;
select * from contavinculada;
delete from contavinculada where cliente_idcliente = 32;
select * from auditoria;

/*
Exclua a Trigger anterior e modifique-a para que ela informe, na mensagem de auditoria, a conta e o nome do cliente excluido.
*/
DROP trigger tr_log_auditoria;
DELIMITER $
CREATE TRIGGER tr_log_auditoria AFTER DELETE
ON contavinculada
FOR EACH ROW
BEGIN
	SELECT nome INTO @nomecliente FROM cliente where idCLIENTE = OLD.CLIENTE_idCLIENTE;
    SET @mensagem = CONCAT("Foi excluida a conta ",OLD.CONTA_idCONTA," do cliente ",@nomecliente);
    INSERT INTO auditoria VALUES (NULL,@mensagem,"contavinculada",NOW(),USER());
END$
DELIMITER $


/*
Crie um Trigger que registre no LOG de AUDITORIA a alteração do CPF de um cliente.
*/

DELIMITER $
CREATE TRIGGER tr_atualiza_cpf AFTER UPDATE
ON cliente
FOR EACH ROW
BEGIN
	SET @mensagem = CONCAT("O CPF do usuario ", NEW.nome, " foi alterado de ", OLD.cpf, " para ", NEW.CPF);
    INSERT INTO auditoria VALUES (NULL, @mensagem, "cliente", NOW(),USER());
END$
DELIMITER ;
select * from cliente;
UPDATE cliente set cpf = "111.111.111-22" where idCLIENTE = 11;
select * from auditoria;
select * from conta;


/*
Crie um trigger que registre no LOG de AUDITORIA a inserção de uma conta com seus 
respectivos dados principais (id, tipo e saldo).
*/
DELIMITER $
CREATE TRIGGER tr_log_criarconta AFTER INSERT
ON conta
FOR EACH ROW
BEGIN
	SET @mensage = CONCAT("Foi criada uma conta com os seguintes dados: Conta: ",NEW.idCONTA, " - Tipo:", NEW.tipo, " - Saldo:", NEW.saldo);
    INSERT INTO auditoria VALUES (NULL, @mensage,"conta",NOW(),USER());
END$
DELIMITER ;

SELECT * FROM conta;
INSERT INTO conta VALUES (NULL, "Salário",1500.00,321);
select * from auditoria;

































show databases;
drop database agencia3si2024;
use agencia3si2024;
show tables;
select * from cliente;
select * from conta;
select * from contavinculada;

/*
Criar um Trigger que atualize a data de abertura da 
conta caso ocorra uma atualização do CPF do cliente.
*/
DELIMITER $
CREATE TRIGGER tr_atualiza_cpf BEFORE UPDATE ON cliente
FOR EACH ROW
BEGIN
	IF (NEW.cpf != OLD.cpf) THEN
		UPDATE contavinculada SET dataAbertura = NOW()
        WHERE OLD.idCliente = CLIENTE_idCLIENTE;
	END IF;
END$
DELIMITER ;

SHOW TRIGGERS;
SELECT * FROM contavinculada;
select * from cliente;
update cliente set cpf="123.123.123-32" where idCLIENTE = 2;


/*
Criar um Trigger que, toda vez que a senha 
de uma conta do tipo POUPANÇA for alterada, 
acrescentar dez centavos no saldo.
*/

DELIMITER $
CREATE TRIGGER tr_atualiza_saldo_poupanca BEFORE UPDATE ON conta
FOR EACH ROW
BEGIN
	IF (NEW.senha != OLD.senha) THEN
		IF (NEW.tipo = "Poupança") THEN
			SET NEW.saldo = OLD.saldo + 0.10;
        END IF;
    END IF;
END$
DELIMITER ;

select * from conta;
update conta set senha = "A123" where idCONTA = 3;


use agencia3si2024B;
show triggers;
select * from conta;
select max(idconta) into @id from conta;
select @id;
select * from contavinculada;
select * from cliente;
/*
Trigger para cadastrar uma conta do tipo poupança quando inserir um cliente
*/
DELIMITER $
CREATE TRIGGER tr_criar_conta_novo_cliente
AFTER INSERT ON Cliente
FOR EACH ROW
BEGIN
	INSERT INTO conta VALUES (NULL, "Poupança",0.01,"ABC");
    SELECT max(idconta) into @idnovaconta from conta;
    INSERT INTO contavinculada VALUES (NEW.idCLIENTE, @idnovaconta, NOW());
END$
DELIMITER ;

SELECT * FROM cliente ORDER BY IDCLIENTE DESC;
DELETE FROM CLIENTE WHERE IDCLIENTE = 29;
insert into cliente (nome,cpf,rg,dataNascimento,telefone) values ("Jose","132.111.122-56","MG","1980-06-06","3532953");
SELECT * FROM CONTA;
SELECT * FROM CONTAVINCULADA;
drop trigger tr_criar_conta_novo_cliente;


/*
TRIGGER para que antes de apagar uma conta apague todos vínculos a ela. 
*/
select * from conta;
select * from contavinculada;
delimiter $
create trigger tr_limpar_vinculos_cliente
before delete on conta
for each row
begin
	select CLIENTE_idCLIENTE into @idclientedeletado from contavinculada where CONTA_idCONTA = OLD.idCONTA;
	delete from contavinculada where CONTA_idCONTA = OLD.idCONTA;
    delete from cliente where idCLIENTE = @idclientedeletado;
end$

delimiter ;

DROP TRIGGER tr_limpar_vinculos_cliente;
select * from conta;
select * from contavinculada;
select * from cliente order by idcliente desc;
/* idconta = 7
cliente_idcliente = 30
conta_idConta = 7
idCliente = 30
*/

delete from conta where idconta = 7;
SELECT @idclientedeletado;

/*
Trigger para que, antes de inserir um cliente 
formate o RG dele para maiúscula
*/
SELECT * FROM CLIENTE;

delimiter $
create trigger tr_up_rg before insert on Cliente
for each row
begin
	set NEW.rg = upper(NEW.rg);
end$
delimiter ;
insert into cliente (nome,cpf,rg,dataNascimento,telefone) values ("Jose","132.111.122-56","mm","1980-06-06","3532953");
select * from cliente order by idcliente desc;


/*
Criar uma tabela de auditoria
*/
create table auditoria (
id_auditoria int auto_increment primary key not null,
acao varchar(400),
tabela varchar(50),
data_hora datetime,
usuario varchar(50)
);
select * from auditoria;
desc auditoria;
select * from contavinculada;

/*
Trigger que registre no log de auditoria a exclusão de uma conta vinculada
*/
delimiter $
create trigger tr_log_contavinculada after delete on contavinculada
for each row
begin
	insert into auditoria values (NULL, "Conta Vinculada apagada","contavinculada", NOW(), USER());
end$
delimiter ;

select * from contavinculada;
delete from contavinculada where cliente_idcliente = 32;
select * from auditoria;

/*
Exclua o trigger anterior e o modifique para que
seja informado, na mensagem de auditoria, a conta e o nome
do cliente excluido
*/
drop trigger tr_log_contavinculada;
delimiter $
create trigger tr_log_contavinculada after delete on contavinculada
for each row
begin
	set @mensagem = concat("A conta com id ", OLD.CONTA_idCONTA, " do cliente com id ", OLD.CLIENTE_idCLIENTE, " foi excluida");
    insert into auditoria values (NULL, @mensagem, "contavinculada", NOW(), USER());
end$
delimiter ;

delete from contavinculada where cliente_idcliente = 31;
select * from auditoria;








select * from cliente;
select nome into @nomeCliente from cliente
where cpf = "123.123.123-32";
select @nomeCliente;





use agencia3si2024;
show tables;
select * from conta;
select * from contavinculada;
select * from cliente;

/*
Crie um Trigger para que, 
antes de apagar uma conta, 
apague os vínculos a ela.
*/

/*Conta que pertence a um cliente
Contavinculada relaciona as duas tabelas.*/
select * from contavinculada;
select * from conta where idconta=1;

delimiter $
create trigger tr_limpa_dados_cliente
before delete on conta
for each row
begin
	select CLIENTE_idCLIENTE into @idcliente from contavinculada
    where conta_idCONTA = OLD.idconta;
    delete from contavinculada where conta_idCONTA = OLD.idCONTA;
    delete from cliente where idCLIENTE = @idcliente;
end$
delimiter ;
drop trigger tr_limpa_dados_cliente;
select * from contavinculada;
select * from cliente where idcliente = 2;
/*
idconta 3
idcliente 2
*/
delete from conta where idconta = 3;





/*
Crie um Trigger para que, 
Antes de inserir um cliente, 
formate o RG para letras maiúsculas.
*/






/*
Criando tabela auditoria
*/
create table auditoria (
id_auditoria int primary key auto_increment not null,
acao varchar(400),
tabela varchar(50),
data_hora datetime,
usuario varchar(50)
);

select * from auditoria;
delimiter $
create trigger tr_registrar_delete_conta 
after delete on contavinculada
for each row
begin
	set @mensagem = concat ("A conta de id ",old.conta_idconta,
    " pertencente ao cliente ", old.CLIENTE_idcliente, " foi excluida!");
	insert into auditoria values (NULL, @mensagem,
    "contavinculada", NOW(),USER());    
end$
delimiter ;





delimiter $
create trigger tr_logar_cpf after update on cliente
for each row
begin
	set @mensagem = concat ("O cliente ",OLD.nome, " teve seu CPF
    alterado de <", OLD.cpf, "> para <",NEW.cpf);
    insert into auditoria values (NULL, @mensagem, "cliente", now(), 
    user());
end$
delimiter ;
select * from auditoria;

select * from cliente;
update cliente set cpf = "111.111.111-11" where idcliente = 3;



select * from contavinculada;
select * from conta;
#conta 4 e cliente 4
delete from contavinculada where cliente_idcliente = 4;
select * from auditoria;



/*
STORED PROCEDURE
Exemplo 1 - Hello World 
*/
use agencia3si2024B;
show triggers;
delimiter #
create procedure Hello()
begin
	select "o famoso hello World";
end#
delimiter ;

call hello();

desc cliente;
/* 
Exemplo 2 - Inserir Cliente
*/
delimiter #
create procedure InserirCliente (
	IN p_nome varchar(150),
    IN p_cpf varchar(45),
    IN p_nascimento date
)
begin
	insert into cliente (nome, cpf, dataNascimento) 
    values (p_nome,p_cpf,p_nascimento);
end#
delimiter ;

drop procedure InserirCliente;
show procedure status where db='agencia3si2024b';
show create procedure InserirCliente;
show create procedure Hello;

call InserirCliente("Souza","212.212.121-45","1990-05-10");

select * from conta;
select * from cliente order by idCliente desc;
select * from contavinculada;

delimiter #
create procedure proc_lista_contas_cliente ()
begin
	select cliente.nome, cliente.cpf, cliente.telefone, conta.idconta, conta.tipo, conta.saldo 
	from cliente, conta, contavinculada
	where contavinculada.conta_idconta = conta.idconta
	and contavinculada.cliente_idcliente = cliente.idcliente;
end#
delimiter ;
call proc_lista_contas_cliente();

show triggers;
select * from contavinculada;
call proc_lista_contas_cliente();



















/*STORE PROCEDURES */

DELIMITER #
CREATE PROCEDURE OLA()
BEGIN
	SELECT "OLÁ PESSOAL";
END#
DELIMITER ;

CALL OLA();


DELIMITER #
CREATE PROCEDURE SP_LISTA_CONTAS()
BEGIN
	SELECT * FROM CONTA;
END#
DELIMITER ;
CALL SP_LISTA_CONTAS();


DELIMITER #
CREATE PROCEDURE SP_INSERIR_CLIENTE(
	P_NOME VARCHAR(150),
    IN P_CPF VARCHAR(45),
    P_NASCIMENTO DATE
)
BEGIN
	INSERT INTO CLIENTE (NOME, CPF,DATANASCIMENTO) VALUES (P_NOME,P_CPF,P_NASCIMENTO);
END#
DELIMITER ;

SELECT * FROM CLIENTE ORDER BY IDCLIENTE DESC;
select * from contavinculada;


CALL SP_INSERIR_CLIENTE("Mariana Silveira","111.111.222-02","1991-04-03");
select * from lciente;






















use agencia3si2024;
show triggers;

DELIMITER #
CREATE PROCEDURE SP_HELLO()
BEGIN
	SELECT "O famoso hello world!!!!";
END#
DELIMITER ;

CALL SP_HELLO();
SHOW procedure status where DB = 'agencia3si2024';
show create procedure SP_hello;


select * from cliente;
select * from contavinculada;
select * from conta;

delimiter #
create procedure sp_lista_contas_clientes ()
begin
	select cliente.nome, cliente.cpf, conta.tipo,conta.saldo
	from cliente, conta,contavinculada
	where cliente.idCLIENTE = contavinculada.CLIENTE_idCLIENTE
	and conta.idCONTA = contavinculada.CONTA_idCONTA;
end#
delimiter ;

call sp_lista_contas_clientes();





DESC CLIENTE;

DELIMITER #
create procedure SP_INSERIR_CLIENTE(
	IN P_NOME VARCHAR(150),
    P_CPF varchar(45),
    IN P_nascimento date
)
BEGIN
	INSERT INTO CLIENTE (nome, cpf, datanascimento) values
    (P_nome, P_CPF, P_NASCIMENTO);
END#
DELIMITER ;

SELECT * FROM CLIENTE ORDER BY IDCLIENTE DESC;
CALL SP_INSERIR_CLIENTE("Maria silveira","111.222.444-09",
"1991-05-08");




use lanchonete3si_2024;
show tables;
show triggers;
show procedure status where DB = 'lanchonete3si_2024';



######################################

-- Copiando estrutura para procedure lanchonete3si_2023.proc_alteraEmailCliente
DROP PROCEDURE IF EXISTS `proc_alteraEmailCliente`;
/*
Criar uma Stored Procedure que permita, passando o codigo do cliente o e-mail, 
atualizar o e-mail de um cliente na tabela cliente
*/
DELIMITER //
CREATE PROCEDURE `proc_alteraEmailCliente`(in codClienteAlterado int,
in novoEmail varchar(200))
BEGIN
update cliente set email = novoEmail 
where codCliente = codClienteAlterado;
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_alteraMarca
DROP PROCEDURE IF EXISTS `proc_alteraMarca`;

/*
Criar uma Stored Procedure que permita, passando o código e um nome novo, 
atualizar o nome da marca na tabela marca
*/
DELIMITER //
CREATE PROCEDURE `proc_alteraMarca`(IN nomeAlterado varchar(100),
IN codigo INT)
BEGIN
	update marca set nome = nomeAlterado where codMarca = codigo;
    /*Se tiver mais de um campo a ser alterado, basta ir separando com vírgula nos parâmetros 
    e na lista de campos após o comando SET*/
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_apagaMarca
DROP PROCEDURE IF EXISTS `proc_apagaMarca`;
/*
Criar uma Stored Procedure que permita, passando o código de uma marca, 
apagar uma marca na tabela marca
*/
DELIMITER //
CREATE PROCEDURE `proc_apagaMarca`(IN codigoParaExcluir int)
BEGIN
	delete from marca where codMarca = codigoParaExcluir;
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_insereCategoria
DROP PROCEDURE IF EXISTS `proc_insereCategoria`;

/*
Criar uma Stored Procedure que permita, passando um nome novo, 
inserir uma nova categoria na tabela categoria
*/
DELIMITER //
CREATE PROCEDURE `proc_insereCategoria`(IN novoNome varchar(100))
BEGIN
	insert into categoria(nome) values(novoNome);
    
    /*Se tiver mais de um campo a ser preenchido, basta ir separando com vírgula nos parâmetros 
    e na inserção*/
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_insereCliente
DROP PROCEDURE IF EXISTS `proc_insereCliente`;

/*
Criar uma Stored Procedure que permita, passando o nome do cliente e a data de nascimento, 
inserir um novo cliente na tabela cliente
*/
DELIMITER //
CREATE PROCEDURE `proc_insereCliente`(in nomeCli varchar(200), in dataNascimentoCli date)
BEGIN
insert into cliente(codCliente, nome, dataNascimento)
values (null, nomeCli, dataNascimentoCli);
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_insereMarca
DROP PROCEDURE IF EXISTS `proc_insereMarca`;
DELIMITER //
CREATE PROCEDURE `proc_insereMarca`(IN nomeNovo varchar(100))
BEGIN
	insert into marca(nome) values(nomeNovo);
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_alteraMargemLucro
DROP PROCEDURE IF EXISTS `proc_alteraMargemLucro`;
/*
Criar uma Stored Procedure que permita, passando o código e uma nova margem de lucro, 
atualizar a margem de lucro de um produto na tabela produto. Caso o código não corresponda
a um produto, retornar a mensagem de “Produto não encontrado”.
*/
DELIMITER //
CREATE PROCEDURE `proc_alteraMargemLucro`(
	IN `codAlterado` INT,
	IN `novaMargemLucro` DECIMAL(5,2)
)
BEGIN
	SELECT COUNT(*) INTO @contador FROM produto 
	WHERE codProduto = codAlterado;
	if (@contador = 0)
		then SELECT "Produto não encontrado" AS erro;
		else
				if (novaMargemLucro > 0)
					then UPDATE produto SET margemLucro = novaMargemLucro
					WHERE codProduto = codAlterado;
				END if;
	END if;
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_apagaMarca
DROP PROCEDURE IF EXISTS `proc_apagaMarca`;
DELIMITER //
CREATE PROCEDURE `proc_apagaMarca`(IN codigoParaExcluir int)
BEGIN
	delete from marca where codMarca = codigoParaExcluir;
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_hello
DROP PROCEDURE IF EXISTS `proc_hello`;
DELIMITER //
CREATE PROCEDURE `proc_hello`()
BEGIN
	SELECT "Hello World..." AS mensagem;
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_insereCategoria
DROP PROCEDURE IF EXISTS `proc_insereCategoria`;
DELIMITER //
CREATE PROCEDURE `proc_insereCategoria`(IN novoNome varchar(100))
BEGIN
	insert into categoria(nome) values(novoNome);
    
    /*Se tiver mais de um campo a ser preenchido, basta ir separando com vírgula nos parâmetros 
    e na inserção*/
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_insereCliente
DROP PROCEDURE IF EXISTS `proc_insereCliente`;

/*
Criar uma Stored Procedure que permita, passando o nome do cliente e data de nascimento, 
inserir um novo cliente.
*/

DELIMITER //
CREATE PROCEDURE `proc_insereCliente`(in nomeCli varchar(200), in dataNascimentoCli date)
BEGIN
insert into cliente(codCliente, nome, dataNascimento)
values (null, nomeCli, dataNascimentoCli);
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_insereMarca
DROP PROCEDURE IF EXISTS `proc_insereMarca`;

/*
Criar uma Stored Procedure que permita, passando um nome, 
inserir uma nova marca.
*/

DELIMITER //
CREATE PROCEDURE `proc_insereMarca`(IN nomeNovo varchar(100))
BEGIN
	insert into marca(nome) values(nomeNovo);
END//
DELIMITER ;

-- Copiando estrutura para procedure lanchonete3si_2023.proc_insereProduto
DROP PROCEDURE IF EXISTS `proc_insereProduto`;

/*
Criar uma Stored Procedure que permita, passando os campos obrigatórios, 
inserir um novo produto.
*/

DELIMITER //
CREATE PROCEDURE `proc_insereProduto`(
	IN `nomeInserir` VARCHAR(200),
	IN `precoCustoInserir` DECIMAL(10,2),
	IN `precoVendaInserir` DECIMAL(10,2),
	IN `categoriaInserir` INT,
	IN `marcaInserir` INT
)
BEGIN
INSERT INTO produto(nome, precoCusto, precoVenda,
categoria_codCategoria, marca_codMarca) VALUES(nomeInserir,
precoCustoInserir, precoVendaInserir, categoriaInserir,
marcaInserir);

END//
DELIMITER ;
###################################















/*
1. Criar uma Stored Procedure que, passando o código do cliente o e-mail, atualize o e-mail de um cliente na tabela cliente.
*/
show databases;
use lanchonete3si_2024;
desc cliente;
delimiter #
create procedure sp_atualiza_email_por_codigo (
	in p_codigo int,
    in p_email varchar(200)
)
begin
	update cliente set email = p_email 
    where codCliente = p_codigo;
end#
delimiter ;

select * from cliente;
call sp_atualiza_email_por_codigo(3,"email@email.com");


/*
2. Criar uma Stored Procedure que, passando um nome novo, insira uma nova marca na tabela marca.
*/
desc marca;
delimiter #
create procedure sp_insere_marca (
	p_nome varchar(100)
)
begin
	insert into marca values (null, p_nome);
end#
delimiter ;

call sp_insere_marca("Opa");
select * from marca;


/*
3. Criar uma Stored Procedure que, passando o código e um nome novo, atualize o nome da marca na tabela marca.
*/

delimiter #
create procedure sp_atualiza_marca(
	in p_codigo int,
    in p_nome varchar(100)
)
begin
	update marca set nome = p_nome
    where codMarca = p_codigo;
end#
delimiter ;

call sp_atualiza_marca(7,"OPPA");
select * from marca;


/*
4. Criar uma Stored Procedure que, passando o código de uma marca, apague uma marca na tabela marca.
*/
delimiter #
create procedure sp_apaga_marca (
	in p_codigo int
)
begin
	delete from marca where codMarca = p_codigo;
end#
delimiter ;

call sp_apaga_marca(7);
select * from marca;

desc categoria;
/*
5.Criar uma Stored Procedure que, passando um nome novo, insira uma nova categoria na tabela categoria.
*/
delimiter #
create procedure sp_insere_categoria (
	in p_nome varchar(100)
)
begin
	insert into categoria values (null, p_nome);
end#
delimiter ;

call sp_insere_categoria("New");
select * from categoria;


/*
6.Criar uma Stored Procedure que, passando o nome do cliente e a data de nascimento, insira um novo cliente na tabela cliente.
*/
desc cliente;
delimiter #
create procedure sp_insere_cliente (
	in p_nome varchar(200),
    in p_nasc date
)
begin
	insert into cliente (nome,datanascimento) values (p_nome,p_nasc);
end#
delimiter ;

select * from cliente;

call sp_insere_cliente ("Fabio","1980-10-05");


/*
7.Criar uma Stored Procedure que, passando o código e uma nova margem de lucro, 
atualize a margem de lucro de um produto na tabela produto. 
Caso o código não corresponda a um produto, retornar a mensagem de “Produto não encontrado”.
*/

desc produto;
delimiter #
create procedure sp_atualiza_margem (
	in p_codigo int,
    in p_margem decimal(5,2)
)
begin
	select count(codProduto) into @quantidade from produto where codProduto = p_codigo;
    if @quantidade > 0 then
		update produto set margemLucro = p_margem where codProduto = p_codigo;
	else
		select "Produto não encontrado";
	end if;
end#
delimiter ;

call sp_atualiza_margem(1, 99);
select * from produto;


/*
8.Criar uma Stored Procedure que, passando
 os campos obrigatórios, insira um novo produto na tabela produto.
*/
desc produto;
delimiter #
create procedure sp_insere_produtos (
	p_nome varchar(200),
    p_precoCusto decimal(10,2),
    p_precoVenda decimal (10,2),
    p_quantEstoque decimal (10,2),
    p_categoria int,
    p_marca int
)
begin
	insert into produto (nome,precoCusto,precovenda, quantidadeEstoque,categoria_codCategoria,marca_codMarca) 
    values (p_nome, p_precoCusto, p_precoVenda, p_quantEstoque, p_categoria, p_marca);
end#
delimiter ;

call sp_insere_produtos("AA",7,77,7,1,1);
select * from produto;
/*
9.Criar uma Stored Procedure que, passando parte do nome 
do cliente, seja possível consultar os clientes que possuem 
esta informação em qualquer parte do seu nome.
*/

delimiter #
create procedure sp_consulta_clientes_nome (
	p_nome_parcial varchar(20)
    )
begin
	select * from cliente where nome like concat("%",p_nome_parcial,"%");
end#
delimiter ;
select * from cliente where nome like "%tel%";


use agencia3si2024b;
/*
Criar uma Stored Procedure que, passando o código do cliente retorne o saldo 
disponível em sua conta ou, caso tenha mais de uma conta, o saldo total.
*/
show tables;
desc conta;
delimiter #
create procedure consulta_saldo (
	codigo int,
    out saldo float
)
begin
	select conta.saldo into saldo from conta, contavinculada
    where contavinculada.cliente_idcliente = codigo 
    and contavinculada.conta_idconta = conta.idconta;
end#
delimiter ;

drop procedure consulta_saldo;
call consulta_saldo(1,@saldo);

select @saldo;


/*
Criar uma Stored Procedure que, passando um tipo de conta ('Salário','Corrente','Poupança'), 
me apresente quanto dinheiro eu tenho armazenado neste tipo de conta.
*/
desc conta;
delimiter #
create procedure consulta_saldo_tipo (
	tipo_conta varchar(40),
    out saldotipo float
)
begin
	select sum(saldo) into saldotipo from conta where tipo = tipo_conta;
end#
delimiter ;

drop procedure consulta_saldo_tipo;
call consulta_saldo_tipo("Poupança", @sa);

select @sa;




select sum(saldo) into @saldotipo from conta where tipo = "Poupança";
select @saldotipo;

select sum(saldo) from conta where tipo = "Poupança";


/*
Criar uma Stored Procedure que, passando o nome, o cpf e a data de nascimento, 
o sistema verifique se ele é maior de 18 anos. Caso seja, insira o cliente, 
senão, exiba a mensagem “Cliente menor de idade”.
*/
desc cliente;
delimiter #
create procedure insere_maior_18 (
	p_nome varchar(150),
    p_cpf varchar(45),
    p_datanascimento date
)
begin
	SET @birthdate = STR_TO_DATE(p_datanascimento, '%Y-%m-%d');
	SET @current_date = NOW();
	SET @idade = TIMESTAMPDIFF(YEAR, @birthdate, @current_date);
    if @idade > 18 then
		insert into cliente (nome, cpf, datanascimento) values (p_nome, p_cpf, p_datanascimento);
	else
		select "usuário menor de idade";
	end if;
end#
delimiter ;
drop procedure insere_maior_18;

call insere_maior_18("Flavio","321","2005-05-06");
select * from cliente;


/*

*/
desc conta;

delimiter #
create procedure consulta_saldo_tipo2 (
	tipo_conta varchar(40),
    out saldotipo float
)
begin
	if tipo_conta not in ("Poupança", "Corrente","Salário") then
		Select "Tipo de conta Incorreta";
	else
		select sum(saldo) into saldotipo from conta where tipo = tipo_conta;
	end if;
end#
delimiter ;
drop procedure consulta_saldo_tipo2;
call consulta_saldo_tipo2("poupança", @saldocontas);
select format(@saldocontas, 2);
select @saldocontas;

#select sum(saldo) from conta where tipo = "Poupança";


use agencia3si2024;












show procedure status where db='agencia3si2024';

delimiter #
create procedure sp_consultar_saldo_cliente (
	in p_codigo_cliente int,out p_saldo float
)
begin
	select sum(c.saldo) into p_saldo
	from conta as c, contavinculada as cv
	where cv.cliente_idcliente = p_codigo_cliente
	and cv.conta_idconta = c.idconta;
end#
delimiter ;
call sp_consultar_saldo_cliente (33,@retorno);
select @retorno;


/*
Criar uma Stored Procedure que, 
passando um tipo de conta ('Salário','Corrente',
'Poupança'), me apresente quanto dinheiro 
eu tenho armazenado neste tipo de conta.
*/

delimiter #
create procedure sp_consulta_saldo_tipo (
	p_tipo varchar(40),
    out p_saldotipo float
    )
begin
	select sum(conta.saldo) into p_saldotipo from
    conta where tipo = p_tipo;
end#
delimiter ;

desc conta;

call sp_consulta_saldo_tipo("salário",@meusaldo);
select @meusaldo;



/*
Criar uma Stored Procedure que, passando um valor de uma cobrança e um tipo de conta, 
faça o débito deste valor em todas as contas deste tipo no banco. caso seja passado 
o tipo como “TODAS”, a SP faça o débito em todas as contas da agência.
*/

delimiter #
create procedure debito_conta_tipo(
	p_valor_debito double,
    p_tipo_conta varchar(20)
)
begin
		if p_tipo_conta not in ("Poupança", "Salário","Corrente", "Todas") then
			select "Tipo de conta incorreto";
		elseif p_tipo_conta = "Todas" then
			update conta set conta.saldo = (conta.saldo - p_valor_debito) where
            conta.tipo != "";
            select "Debito executado em todas os tipos de contas";
		else
			update conta set conta.saldo = (conta.saldo - p_valor_debito) where
            conta.tipo = p_tipo_conta;
            select concat ("Debito executado nas contas do tipo ", p_tipo_conta);
		end if;
end#
delimiter ;

select * from conta;
call debito_conta_tipo(5, "Todas");


delimiter #
create procedure debito_com_while (
	p_valor double,
    p_tipo_conta varchar(20)
)
begin
	while ;
end#
delimiter ;

-- Código relacionado as questões sobre SQL para livro Sistemas de Banco de Dados - Elmasri e Navathe - 6ª Edicao



-- create tabela - Criando tabelas 
create table funcionario(
  pnome varchar(30),
  minicial varchar(30),
  unome varchar(30),
  cpf varchar(11),
  datanasc date,
  endereco varchar(100),
  sexo char,
  salario decimal(10,2),
  cpf_supervisor varchar(11),
  dnr integer,
  primary key(cpf)
);

create table departamento(
  dnome varchar(30),
  dnumero integer,
  cpf_gerente varchar(11),
  data_inicio_gerente date,
  primary key(dnumero)
);

create table dependente(
  fcpf varchar(11),
  nome_dependente varchar(50),
  sexo char,
  datanasc date,
  parentesco varchar(50),
  primary key(fcpf, nome_dependente)
);

create table projeto(
  projnome varchar(50),
  projnumero integer,
  projlocal varchar(50),
  dnum integer,
  primary key(projnumero)
);

create table trabalha_em(
  fcpf varchar(11),
  pnr integer,
  horas decimal(5,1),
  primary key(fcpf, pnr)
);

create table localizacao_dep(
  dnumero integer,
  dlocal varchar(50),
  primary key(dnumero, dlocal)
);

-- -------------------------------------------------------------
-- alter
alter table 
  funcionario add constraint dep_func_fk foreign key(dnr) references departamento(dnumero);

\d funcionario

-- insert Tabelas departamento
INSERT INTO departamento 
VALUES ('Pesquisa', 5, null, null);

INSERT INTO departamento(dnome,dnumero) 
VALUES ('Adminstracao', 4);

INSERT INTO departamento(dnumero, dnome) 
VALUES (1, 'Matriz');

update departamento set cpf_gerente='33344555587' WHERE dnumero=5;
update departamento set data_inicio_gerente='1988-05-25' WHERE dnumero=5;
update departamento set data_inicio_gerente='1988-05-25' WHERE dnumero=5;
update departamento set cpf_gerente='98765432168', data_inicio_gerente='1995-01-01' WHERE dnumero=4;
update departamento set cpf_gerente='88866555576', data_inicio_gerente='1981-06-19' WHERE dnumero=1;

-- insert Tabelas funcionario
INSERT INTO funcionario 
VALUES ('Jorge', 'E','Brito', 88866555576,'10-11-1937', 'Rua do Horto, 35, São Paulo, SP','M',55.000, null, 1);

INSERT INTO funcionario 
VALUES ('Jennifer', 'S','Souza', 98765432168,'1941-06-20', 'Av. Arthur de Lima, 54, Santo André, SP','F',43.000, 88866555576, 4);

INSERT INTO funcionario 
VALUES ('Fernando', 'T','Wong', 33344555587, '08-12-1955', 'Rua da Lapa, 34, São Paulo, SP','M',40.000, 88866555576, 5);

INSERT INTO funcionario 
VALUES ('João', 'B','Silva', 12345678966, '09-01-1965', 'Rua das Flores, 751, São Paulo, SP','M',30.000, 33344555587, 5);

-- insert Tabelas projeto
INSERT INTO projeto 
VALUES('ProdutoX',1,'Santo André',5);

INSERT INTO projeto 
VALUES('ProdutoY',2,'Itu',5);

INSERT INTO projeto 
VALUES('ProdutoZ',3,'São Paulo',5);

INSERT INTO projeto 
VALUES('Informatização',10,'Mauá',4);

INSERT INTO projeto 
VALUES('Reorganização',20,'São Paulo',1);

INSERT INTO projeto 
VALUES('Novos Benafícios',30,'Mauá',4);

-- insert Tabelas dependente
INSERT INTO dependente 
VALUES(33344555587,'Alicia','F','1986-04-05','Filha');

INSERT INTO dependente 
VALUES(33344555587,'Tiago','M','1983-10-25','Filho');

INSERT INTO dependente 
VALUES(33344555587,'Janaina','F','1958-05-03','Esposa');

INSERT INTO dependente 
VALUES(98765432168,'Antonio','M','1942-02-28','Esposo');

INSERT INTO dependente 
VALUES(12345678966,'Michael','M','1988-01-04','Filho');

INSERT INTO dependente 
VALUES(12345678966,'Alícia','F','1988-12-30','Filha');

INSERT INTO dependente 
VALUES(12345678966,'Elizabeth','M','1967-05-05','Esposa');

-- insert Tabelas localizacao_dep
INSERT INTO localizacao_dep 
VALUES(1,'São Paulo');

INSERT INTO localizacao_dep 
VALUES(4,'Mauá');

INSERT INTO localizacao_dep 
VALUES(5,'Santo André');

INSERT INTO localizacao_dep 
VALUES(5,'Itu');

INSERT INTO localizacao_dep 
VALUES(5,'São Paulo');

-- insert Tabelas trabalha_em
INSERT INTO trabalha_em 
VALUES('12345678966',1,32.5);

INSERT INTO trabalha_em 
VALUES('12345678966',2,7.5);

INSERT INTO trabalha_em 
VALUES('66688444476',3,40.0);

INSERT INTO trabalha_em 
VALUES('45345345376',1,20.0);

INSERT INTO trabalha_em 
VALUES('45345345376',2,20.0);

INSERT INTO trabalha_em 
VALUES('33344555587',2,10.0);

INSERT INTO trabalha_em 
VALUES('33344555587',3,10.0);

INSERT INTO trabalha_em 
VALUES('33344555587',10,10.0);

INSERT INTO trabalha_em 
VALUES('33344555587',20,10.0);

-- Select em relação as tabelas
SELECT * FROM funcionario;
SELECT * FROM departamento;
SELECT * FROM projeto;
SELECT * FROM dependente;
SELECT * FROM localizacao_dep;
SELECT * FROM trabalha_em;

-- Filtro
SELECT pnome, unome, endereco  FROM funcionario, departamento WHERE dnome='Pesquisa' and dnumero=dnr;

-- Filtrando por varrias chaves
SELECT projnumero, dnum, unome, endereco, datanasc  FROM projeto, departamento, funcionario WHERE dnum=dnumero and cpf_gerente=cpf and projlocal='São Paulo';

-- Aliases (s = inicial e f = final - Em nosso exemplo ele relaciona quem é supervisor em relação a quem supervisiona)
SELECT f.pnome, f.unome, s.pnome, s.unome FROM funcionario AS f,funcionario AS s WHERE f.cpf_supervisor=s.CPF;

SELECT pnome, unome, endereco FROM funcionario f,departamento d WHERE d.dnome='Pesquisa' and d.dnumero = f.dnr;

-- Select sem Where - Gerar todas as tuplas das tabelas em uma relação catesiana

Select cpf FROM funcionario;

Select cpf, dnome from funcionario, departamento;

-- Usando * no Select tras todos os dados da tabela caso use um where retorna apenas do Filtrando
SELECT * FROM funcionario, departamento where dnome='Pesquisa' and dnr=dnumero;

-- Order by

SELECT dnome AS dep_nome, unome, pnome, projnome FROM departamento, funcionario, trabalha_em, projeto WHERE dnumero=dnr and cpf=fcpf and pnr=projnumero ORDER BY dnome, unome, pnome;
-- pode colocar numero no orde by 1 = dnome, 2 = unome, 3 = pnome pq esta na sequencia
SELECT dnome AS dep_nome, unome, pnome, projnome FROM departamento, funcionario, trabalha_em, projeto WHERE dnumero=dnr and cpf=fcpf and pnr=projnumero ORDER BY 1,2,3;
-- Ordenação dos resultados: por default será ascentesn (ASC) caso queira indicar descendente utilize DESC 
SELECT dnome AS dep_nome, unome, pnome, projnome FROM departamento, funcionario, trabalha_em, projeto WHERE dnumero=dnr and cpf=fcpf and pnr=projnumero ORDER BY dnome ASC, unome ASC, pnome DESC;





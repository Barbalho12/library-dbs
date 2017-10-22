-- CREATE DATABASE 
CREATE DATABASE biblioteca
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = 100;

-- DROP TABLES (TESTS)

DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Credencial;
DROP TABLE IF EXISTS Endereco;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Editora;
DROP TABLE IF EXISTS Livro;
DROP TABLE IF EXISTS Exemplar;

-- CREATE TABLES 

-- Entidades de Usuário
CREATE TABLE IF NOT EXISTS Endereco(
    idEndereco SERIAL,
    pais VARCHAR(20),
    uf VARCHAR(2),
    cep NUMERIC(8),
    bairro VARCHAR(40),
    rua VARCHAR(80),
    numero INTEGER,
    complemento TEXT,
    PRIMARY KEY( idEndereco )
);

CREATE TABLE IF NOT EXISTS Credencial(
	idCredencial SERIAL,
    username VARCHAR(40),
    senha NUMERIC(11),
    token_user TEXT,
    idCliente INTEGER,
    PRIMARY KEY( idCredencial )
);

CREATE TABLE IF NOT EXISTS Cliente(
	idCliente SERIAL,
    nome VARCHAR(40),
    cpf NUMERIC(11),
    telefone NUMERIC(13),
    email VARCHAR(40),
    idEndereco INTEGER,
    idCredencial INTEGER,
    PRIMARY KEY( idCliente ),
    FOREIGN KEY (idEndereco) REFERENCES Endereco (idEndereco),
    FOREIGN KEY (idCredencial) REFERENCES Credencial (idCredencial)
);

CREATE TABLE IF NOT EXISTS Funcionario(
	idFuncionario SERIAL,
    nome VARCHAR(40),
    cpf NUMERIC(11),
    idCredencial INTEGER,
    PRIMARY KEY( idFuncionario ),
    FOREIGN KEY (idCredencial) REFERENCES Credencial (idCredencial)
);

-- Entidades de Livro
CREATE TABLE IF NOT EXISTS Autor(
	idAutor SERIAL,
    nome VARCHAR(40),
    PRIMARY KEY( idAutor )
);

CREATE TABLE IF NOT EXISTS Editora(
	idEditora SERIAL,
    nome VARCHAR(40),
    telefone NUMERIC(13),
    email VARCHAR(40),
    PRIMARY KEY( idEditora )
);

CREATE TABLE IF NOT EXISTS Livro(
	idLivro SERIAL,
    titulo VARCHAR(80),
    isbn VARCHAR(40),
    edicao INT,
    data_publicacao DATE,
    categoria TEXT,
    descricao TEXT,
    idAutor INTEGER,
    idEditora INTEGER,
    PRIMARY KEY( idLivro ),
    FOREIGN KEY (idAutor) REFERENCES Autor (idAutor),
    FOREIGN KEY (idEditora) REFERENCES Editora (idEditora)
);

-- Entidades de Exemplar
CREATE TABLE IF NOT EXISTS Biblioteca(
	idBiblioteca SERIAL,
    nome VARCHAR(80),
    descricao_endereco TEXT,
    PRIMARY KEY( idBiblioteca )
);

CREATE TABLE IF NOT EXISTS Localizacao(
	idLocalizacao SERIAL,
    andar INTEGER,
    sala VARCHAR(10),
    estante VARCHAR(10),
    idBiblioteca INTEGER,
    PRIMARY KEY( idLocalizacao ),
    FOREIGN KEY (idBiblioteca) REFERENCES Biblioteca (idBiblioteca)
);

CREATE TABLE IF NOT EXISTS Exemplar(
	idExemplar SERIAL,
    preco FLOAT,
    codigo_barras VARCHAR(40),
    data_compra DATE,
    estado_fisico VARCHAR(20),
    idLivro INTEGER,
    idLocalizacao INTEGER,
    PRIMARY KEY( idExemplar ),
    FOREIGN KEY (idLivro) REFERENCES Livro (idLivro),
    FOREIGN KEY (idLocalizacao) REFERENCES Localizacao (idLocalizacao)
);







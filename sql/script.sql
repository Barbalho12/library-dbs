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

-- CREATE TABLES 
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







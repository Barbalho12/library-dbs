-- CREATE TABLES

-- Entidades de Usuário
CREATE TABLE IF NOT EXISTS Endereco(
    idEndereco SERIAL,
    pais VARCHAR(20),
    uf VARCHAR(2),
    cidade VARCHAR(30),
    cep NUMERIC(8),
    bairro VARCHAR(40),
    rua VARCHAR(80),
    PRIMARY KEY( idEndereco )
);

CREATE TABLE IF NOT EXISTS Credencial(
    idCredencial SERIAL,
    username VARCHAR(40),
    senha VARCHAR(18),
    token_user TEXT,
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
    FOREIGN KEY (idEndereco) REFERENCES Endereco (idEndereco) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (idCredencial) REFERENCES Credencial (idCredencial) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS Funcionario(
    idFuncionario SERIAL,
    nome VARCHAR(40),
    cpf NUMERIC(11),
    idCredencial INTEGER,
    PRIMARY KEY( idFuncionario ),
    FOREIGN KEY (idCredencial) REFERENCES Credencial (idCredencial) ON UPDATE NO ACTION ON DELETE NO ACTION
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
    ano_publicacao INT,
    linguagem TEXT,
    descricao TEXT,
    idAutor INTEGER,
    idEditora INTEGER,
    PRIMARY KEY( idLivro ),
    FOREIGN KEY (idAutor) REFERENCES Autor (idAutor) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (idEditora) REFERENCES Editora (idEditora) ON UPDATE NO ACTION ON DELETE NO ACTION
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
    sala VARCHAR(15),
    estante VARCHAR(15),
    idBiblioteca INTEGER,
    PRIMARY KEY( idLocalizacao ),
    FOREIGN KEY (idBiblioteca) REFERENCES Biblioteca (idBiblioteca) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS Exemplar(
    idExemplar SERIAL,
    preco FLOAT,
    codigo_barras VARCHAR(40),
    data_compra DATE,
    estado_fisico VARCHAR(20) CHECK (estado_fisico = 'DANIFICADO' or estado_fisico = 'BOM'),
    idLivro INTEGER,
    idLocalizacao INTEGER,
    PRIMARY KEY( idExemplar ),
    FOREIGN KEY (idLivro) REFERENCES Livro (idLivro) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (idLocalizacao) REFERENCES Localizacao (idLocalizacao) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS Devolucao(
    idDevolucao SERIAL,
    idExemplar INTEGER,
    idCliente INTEGER,
    idFuncionario INTEGER,
    data_devolucao date,
    PRIMARY KEY( idDevolucao ),
    FOREIGN KEY (idExemplar) REFERENCES Exemplar (idExemplar) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (idFuncionario) REFERENCES Funcionario (idFuncionario) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS Emprestimo(
    idEmprestimo SERIAL,
    idExemplar INTEGER,
    idCliente INTEGER,
    idFuncionario INTEGER,
    data_emprestimo date,
    data_prev_entrega date,
    status_emprestimo VARCHAR(15) CHECK (status_emprestimo = 'FINALIZADO' or status_emprestimo = 'ATRASADO' or status_emprestimo = 'ATIVO' or status_emprestimo = 'RENOVADO'),
    PRIMARY KEY( idEmprestimo ),
    FOREIGN KEY (idExemplar) REFERENCES Exemplar (idExemplar)  ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)     ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (idFuncionario) REFERENCES Funcionario (idFuncionario)
);

-- CREATE TABLE IF NOT EXISTS Renovacao(
--     idRenovacao SERIAL,
--     idEmprestimo INTEGER,
--     idCliente INTEGER,
--     data_renovacao date,
--     PRIMARY KEY( idRenovacao ),
--     FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
--     FOREIGN KEY (idEmprestimo) REFERENCES Emprestimo (idEmprestimo)
-- );

CREATE TABLE IF NOT EXISTS Reserva(
    idReserva SERIAL,
    idLivro INTEGER,
    idCliente INTEGER,
    data_reserva date,
    status_reserva VARCHAR(15) CHECK (status_reserva = 'ATIVA' or status_reserva = 'FINALIZADA'),
    PRIMARY KEY( idReserva ),
    FOREIGN KEY (idLivro) REFERENCES Livro (idLivro) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS Multa(
    idMulta SERIAL,
    idCliente INTEGER,
    categoria VARCHAR(15),
    status_conclusao VARCHAR(15) CHECK (status_conclusao = 'NAO_INICIADA' or status_conclusao = 'PENDENTE' or status_conclusao = 'FINALIZADA'),
    idEmprestimo INTEGER,
    PRIMARY KEY( idMulta ),
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (idEmprestimo) REFERENCES Emprestimo (idEmprestimo) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS Requisicao(
    idRequisicao SERIAL,
    idCliente INTEGER,
    livro VARCHAR(100),
    PRIMARY KEY( idRequisicao ),
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE NO ACTION ON DELETE NO ACTION
);



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
    status VARCHAR(20) CHECK (status = 'DISPONIVEL' or status = 'INDISPONIVEL'),
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


-- Retorna relação de livros com seus autores e número de exemplares disponíveis
CREATE VIEW situacao_livros AS
    SELECT liv.titulo "Titulo do livro", aut.nome "Autor" , 
    (  
        SELECT COUNT(exe.idExemplar) 
        FROM Exemplar exe
        WHERE exe.idLivro = liv.idLivro and 
              exe.status = 'DISPONIVEL'
    )  "Quantidade disponível"

    FROM Livro liv, Autor aut
    WHERE aut.idAutor = liv.idAutor;


-- Retorna Clientes com emprestimos ativos e previsão de entrega próxima do final (Cliente, email, dias restantes)
CREATE VIEW alerta_clientes AS
    SELECT cli.nome "Cliente", cli.email "Email", emp.data_prev_entrega - CURRENT_DATE "Dias Restantes"
    FROM Cliente cli, Emprestimo emp
    WHERE emp.idCliente = cli.idCliente and 
          emp.status_emprestimo = 'ATIVO' and
          emp.data_prev_entrega - CURRENT_DATE <= 2;


-- Retorna Exemplares que não estão disponiveis
CREATE VIEW exemplar_indisponivel AS
    SELECT exe.idExemplar
    FROM Exemplar exe
    WHERE exe.status = 'INDISPONIVEL';


-- Retorna Emprestimos não finalizados
CREATE VIEW emprestimo_debito AS
    SELECT emp.idExemplar
    FROM Emprestimo emp
    WHERE emp.status_emprestimo != 'FINALIZADO';



------------------------------------------

-- Função que atualiza a data de entrega e o status do emprestimo
CREATE OR REPLACE FUNCTION make_emprestimo_ativo() RETURNS TRIGGER AS
$BODY$
BEGIN

    IF NEW.status_emprestimo IS NULL THEN
        UPDATE Emprestimo
        set status_emprestimo = 'ATIVO'
        WHERE idEmprestimo = NEW.idEmprestimo;
    END IF;

    IF NEW.data_prev_entrega IS NULL THEN
        UPDATE Emprestimo
        set data_prev_entrega = NEW.data_emprestimo + 15
        WHERE idEmprestimo = NEW.idEmprestimo;
    END IF;

    RETURN NEW;
END;
$BODY$
language plpgsql;

-- Gatilho acionado quando um emprestimo é inserido
CREATE TRIGGER trig_make_emprestimo_ativo
     AFTER INSERT ON Emprestimo
     FOR EACH ROW
     EXECUTE PROCEDURE make_emprestimo_ativo();

------------------------------------------



------------------------------------------

-- Função que atualiza status de exemplar e emprestimo quando ocorre uma devolução
CREATE OR REPLACE FUNCTION make_devolucao() RETURNS TRIGGER AS
$BODY$
DECLARE 
    var_r record;
BEGIN
    FOR var_r IN(SELECT * FROM exemplar_indisponivel)  LOOP
        UPDATE Exemplar
        set status = 'DISPONIVEL'
        WHERE idExemplar = var_r.idExemplar;
    END LOOP;

    FOR var_r IN(SELECT * FROM emprestimo_debito)  LOOP
        UPDATE Emprestimo
        set status_emprestimo = 'FINALIZADO'
        WHERE idExemplar = var_r.idExemplar;
    END LOOP;

    RETURN NEW;
END;
$BODY$
language plpgsql;

-- Gatilho acionado quando um emprestimo é inserido
CREATE TRIGGER trig_make_devolucao
     AFTER INSERT ON Devolucao
     FOR EACH ROW
     EXECUTE PROCEDURE make_devolucao();

------------------------------------------



-- Procedure to Renovar emprestimo
CREATE OR REPLACE FUNCTION renovar_emprestimo(id_emprestimo INTEGER) 
RETURNS void AS $$
DECLARE 
    var_r record;
BEGIN
    -- record = (SELECT data_prev_entrega FROM Emprestimo emp WHERE emp.idEmprestimo = id_emprestimo ORDER BY data_prev_entrega DESC LIMIT 1);
    -- FOR var_r IN(SELECT * FROM Emprestimo emp WHERE emp.idEmprestimo = id_emprestimo)  LOOP

        IF (SELECT data_prev_entrega FROM Emprestimo emp WHERE emp.idEmprestimo = id_emprestimo ORDER BY data_prev_entrega DESC LIMIT 1) < CURRENT_DATE THEN
            RAISE EXCEPTION 'Não é possível renovar emprestimo, pois a situação do material está em atraso!';
        END IF;

        IF (SELECT status_emprestimo FROM Emprestimo emp WHERE emp.idEmprestimo = id_emprestimo ORDER BY data_prev_entrega DESC LIMIT 1) != 'ATIVO' THEN
            RAISE EXCEPTION 'Só é possível renovar emprestimos ativos!';
        END IF;

        IF (SELECT data_prev_entrega FROM Emprestimo emp WHERE emp.idEmprestimo = id_emprestimo ORDER BY data_prev_entrega DESC LIMIT 1) >= CURRENT_DATE THEN
            UPDATE Emprestimo
            set status_emprestimo = 'RENOVADO'
            WHERE idEmprestimo = id_emprestimo;

            UPDATE Emprestimo
            set data_prev_entrega = (SELECT data_prev_entrega FROM Emprestimo emp WHERE emp.idEmprestimo = id_emprestimo ORDER BY data_prev_entrega DESC LIMIT 1) + 15
            WHERE idEmprestimo = id_emprestimo;

        END IF;
        
    -- END LOOP;
END;
$$ LANGUAGE plpgsql;



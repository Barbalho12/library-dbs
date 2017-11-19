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
    FOREIGN KEY (idEndereco) REFERENCES Endereco (idEndereco) ON UPDATE NO ACTION ON DELETE SET NULL,
    FOREIGN KEY (idCredencial) REFERENCES Credencial (idCredencial) ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Funcionario(
    idFuncionario SERIAL,
    nome VARCHAR(40),
    cpf NUMERIC(11),
    idCredencial INTEGER,
    PRIMARY KEY( idFuncionario ),
    FOREIGN KEY (idCredencial) REFERENCES Credencial (idCredencial) ON UPDATE NO ACTION ON DELETE SET NULL
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
    idEditora INTEGER,
    PRIMARY KEY( idLivro ),
    FOREIGN KEY (idEditora) REFERENCES Editora (idEditora) ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Autor_Livro(
    idLivro INTEGER,
    idAutor INTEGER,
    PRIMARY KEY( idLivro,  idAutor),
    FOREIGN KEY (idAutor) REFERENCES Autor (idAutor) ON UPDATE NO ACTION ON DELETE CASCADE,
    FOREIGN KEY (idLivro) REFERENCES Livro (idLivro) ON UPDATE NO ACTION ON DELETE CASCADE
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
    FOREIGN KEY (idBiblioteca) REFERENCES Biblioteca (idBiblioteca) ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Exemplar(
    idExemplar SERIAL,
    preco FLOAT,
    codigo_barras VARCHAR(40),
    data_compra DATE,
    estado_fisico VARCHAR(20) CHECK (estado_fisico = 'DANIFICADO' or estado_fisico = 'CONSERVADO'),
    idLivro INTEGER,
    idLocalizacao INTEGER,
    status VARCHAR(20) CHECK (status = 'DISPONIVEL' or status = 'INDISPONIVEL'),
    PRIMARY KEY( idExemplar ),
    FOREIGN KEY (idLivro) REFERENCES Livro (idLivro) ON UPDATE NO ACTION ON DELETE SET NULL,
    FOREIGN KEY (idLocalizacao) REFERENCES Localizacao (idLocalizacao) ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Devolucao(
    idDevolucao SERIAL,
    idExemplar INTEGER,
    idCliente INTEGER,
    idFuncionario INTEGER,
    data_devolucao date,
    PRIMARY KEY( idDevolucao ),
    FOREIGN KEY (idExemplar) REFERENCES Exemplar (idExemplar) ON UPDATE NO ACTION ON DELETE SET NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE NO ACTION ON DELETE SET NULL,
    FOREIGN KEY (idFuncionario) REFERENCES Funcionario (idFuncionario) ON UPDATE NO ACTION ON DELETE SET NULL
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
    FOREIGN KEY (idExemplar) REFERENCES Exemplar (idExemplar)  ON UPDATE NO ACTION ON DELETE SET NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)     ON UPDATE NO ACTION ON DELETE SET NULL,
    FOREIGN KEY (idFuncionario) REFERENCES Funcionario (idFuncionario)
);

CREATE TABLE IF NOT EXISTS Reserva(
    idReserva SERIAL,
    idLivro INTEGER,
    idCliente INTEGER,
    data_reserva date,
    status_reserva VARCHAR(15) CHECK (status_reserva = 'ATIVA' or status_reserva = 'FINALIZADA'),
    PRIMARY KEY( idReserva ),
    FOREIGN KEY (idLivro) REFERENCES Livro (idLivro) ON UPDATE NO ACTION ON DELETE SET NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Multa(
    idMulta SERIAL,
    idCliente INTEGER,
    categoria VARCHAR(15),
    status_conclusao VARCHAR(15) CHECK (status_conclusao = 'PENDENTE' or status_conclusao = 'FINALIZADA'),
    idEmprestimo INTEGER,
    date_conclusao DATE,
    PRIMARY KEY( idMulta ),
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE NO ACTION ON DELETE SET NULL,
    FOREIGN KEY (idEmprestimo) REFERENCES Emprestimo (idEmprestimo) ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Requisicao(
    idRequisicao SERIAL,
    idCliente INTEGER,
    livro VARCHAR(100),
    PRIMARY KEY( idRequisicao ),
    FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE NO ACTION ON DELETE SET NULL
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

    FROM Livro liv, Autor aut, Autor_Livro al
    WHERE aut.idAutor = al.idAutor and liv.idLivro = al.idLivro;


-- Retorna Clientes com emprestimos ativos e previsão de entrega próxima do final 
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


-- Retorna Emprestimos não finalizados
CREATE VIEW livro_com_autor AS
    SELECT liv.titulo, STRING_AGG(aut.nome, ', ') AS Autores
    FROM Livro liv, Autor aut, Autor_Livro al
    WHERE liv.idLivro = al.idLivro and
          aut.idAutor = al.idAutor
    GROUP BY 1;


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
     BEFORE INSERT ON Emprestimo
     FOR EACH ROW
     EXECUTE PROCEDURE make_emprestimo_ativo();

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

        IF NEW.data_devolucao > var_r.data_prev_entrega THEN
            INSERT INTO  Multa (idCliente, categoria, status_conclusao, idEmprestimo, date_conclusao)
            VALUES(NEW.idCliente, 'ATRASO', 'PENDENTE', var_r.idExemplar, NEW.data_devolucao+((NEW.data_devolucao-var_r.data_prev_entrega) * 3));
        END IF;
    END LOOP;

    RETURN NEW;
END;
$BODY$
language plpgsql;

-- Gatilho acionado quando um emprestimo é inserido
CREATE TRIGGER trig_make_devolucao
     BEFORE INSERT ON Devolucao
     FOR EACH ROW
     EXECUTE PROCEDURE make_devolucao();

------------------------------------------


-- Função que VERIFICA se é possível fazer emprestimo
CREATE OR REPLACE FUNCTION make_emprestimo_restrict() RETURNS TRIGGER AS
$BODY$
DECLARE 
    var_r record;
BEGIN
    IF (SELECT COUNT(*) FROM Emprestimo emp WHERE emp.idCliente = NEW.idCliente AND emp.status_emprestimo != 'FINALIZADO') > 3 THEN
        RAISE EXCEPTION 'Limite de emprestimos Excedido!';
    END IF;

    IF (SELECT COUNT(*) FROM Emprestimo emp WHERE emp.idCliente = NEW.idCliente AND emp.status_emprestimo = 'ATRASADO') != 0 THEN
        RAISE EXCEPTION 'Não é possível realizar emprestimo com emprestimos atrasados!';
    END IF;

    IF (SELECT COUNT(*) FROM Multa m WHERE m.idCliente = NEW.idCliente AND m.status_conclusao = 'PENDENTE') != 0 THEN
        RAISE EXCEPTION 'Não é possível realizar emprestimo pois o usuário está cumprindo multa!';
    END IF;

    RETURN NEW;
END;
$BODY$
language plpgsql;

-- Gatilho acionado quando um emprestimo é inserido
CREATE TRIGGER trig_make_emprestimo_restrict
     AFTER INSERT ON Emprestimo
     FOR EACH ROW
     EXECUTE PROCEDURE make_emprestimo_restrict();

------------------------------------------



-- Procedure to Renovar emprestimo
CREATE OR REPLACE FUNCTION renovar_emprestimo(id_emprestimo INTEGER) 
RETURNS void AS $$
DECLARE 
    var_r record;
BEGIN
    IF (SELECT data_prev_entrega FROM Emprestimo emp 
        WHERE emp.idEmprestimo = id_emprestimo 
        ORDER BY data_prev_entrega DESC LIMIT 1) < CURRENT_DATE THEN
        
        RAISE EXCEPTION 'Não é possível renovar emprestimo, 
        pois a situação do material está em atraso!';
    END IF;

    IF (SELECT status_emprestimo FROM Emprestimo emp 
        WHERE emp.idEmprestimo = id_emprestimo 
        ORDER BY data_prev_entrega DESC LIMIT 1) != 'ATIVO' THEN
        
        RAISE EXCEPTION 'Só é possível renovar emprestimos ativos!';
    END IF;

    IF (SELECT data_prev_entrega FROM Emprestimo emp 
        WHERE emp.idEmprestimo = id_emprestimo 
        ORDER BY data_prev_entrega DESC LIMIT 1) >= CURRENT_DATE THEN
        UPDATE Emprestimo
        set status_emprestimo = 'RENOVADO'
        WHERE idEmprestimo = id_emprestimo;

        UPDATE Emprestimo
        set data_prev_entrega = (SELECT data_prev_entrega 
                                 FROM Emprestimo emp 
                                 WHERE emp.idEmprestimo = id_emprestimo 
                                 ORDER BY data_prev_entrega DESC LIMIT 1) + 15
        WHERE idEmprestimo = id_emprestimo;
    END IF;
END;
$$ LANGUAGE plpgsql;




-- Procedure atualiza multas
CREATE OR REPLACE FUNCTION update_multa() 
RETURNS void AS $$
DECLARE 
    var_r record;
BEGIN
    FOR var_r IN(SELECT * FROM Multa m WHERE m.date_conclusao >= CURRENT_DATE)  LOOP
        UPDATE Multa
        SET status_conclusao = 'FINALIZADA'
        WHERE idMulta = var_r.idMulta;
    END LOOP;
END;
$$ LANGUAGE plpgsql;




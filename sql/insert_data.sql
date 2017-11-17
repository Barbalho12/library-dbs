-- Insert data

INSERT INTO Endereco (pais, uf, cep, bairro, rua, numero, complemento)
    VALUES  ('Brasil',  'RN',   59131480,   'Pajuçara',     'Rua Campo Novo',           1640,   ''),
            ('Brasil',  'RN',   59056450,   'Lagoa Nova',   'Av. Nascimento de Castro', 22,     '203B');

INSERT INTO Credencial (username, senha, token_user)
    VALUES  ('barbalho12',  'barbalho12',   'barbalho12_token'),
            ('raulmacintosh',  'raulmacintosh',   'raulmacintosh_token'),
            ('breno73',  'breno73',   'breno73_token');

INSERT INTO Cliente (nome, cpf, telefone, email, idEndereco, idCredencial)
    VALUES  ('Felipe Barbalho', 11111111111, 5584911111111, 'barbalho12@ufrn.edu.br', 1, 1),
            ('Raul Silveira',   22222222222, 5584922222222, 'raul-macintosh@ufrn.edu.br', 2, 2);

INSERT INTO Funcionario (nome, cpf, idCredencial)
    VALUES  ('Breno Viana',  33333333333, 3);

INSERT INTO Autor (nome)
    VALUES  ('José de Alencar'),
            ('Augusto Cury'),
            ('Monteiro Lobato'),
            ('Agatha Christie');

INSERT INTO Editora (nome)
    VALUES  ('Rocco'),
            ('Sextante'),
            ('Melhoramentos');

INSERT INTO Livro (titulo, isbn, edicao, ano_publicacao, linguagem, descricao, idAutor, idEditora)
    VALUES  ('O Homem Mais Inteligente da História', '978-85-4310-435-5', 1, 2016, 'Português', '', 2, 2),
            ('Iracema', '', 1, 1865, 'Português', '', 1, 3);

INSERT INTO Biblioteca (nome, descricao_endereco)
    VALUES  ('Biblioteca Central Zila Mamede', 'Próxima ao centro de convivência'),
            ('Biblioteca Setorial do CCHLA', 'Próxima a BCZM');

INSERT INTO Localizacao (andar, sala, estante, idBiblioteca)
    VALUES  (1, 'P', '3A', 1),
            (2, 'P', '5C', 1);

INSERT INTO Exemplar (preco, codigo_barras, data_compra, estado_fisico, idLivro, idLocalizacao)
    VALUES  (40.0, '11111111', '10/05/2015', 'BOM', 1, 2),
            (40.0, '11111112', '10/05/2015', 'BOM', 1, 2),
            (20.0, '22222222', '10/05/2003', 'DANIFICADO', 2, 1);



-- CREATE TABLE IF NOT EXISTS Devolucao(
--     idDevolucao SERIAL,
--     idOperacao INTEGER,
--     idExemplar INTEGER,
--     idCliente INTEGER,
--     idFuncionario INTEGER,
--     data_devolucao date,
--     PRIMARY KEY( idDevolucao ),
--     FOREIGN KEY (idExemplar) REFERENCES Exemplar (idExemplar),
--     FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
--     FOREIGN KEY (idFuncionario) REFERENCES Funcionario (idFuncionario)
-- );

-- CREATE TABLE IF NOT EXISTS Emprestimo(
--     idEmprestimo SERIAL,
--     idOperacao INTEGER,
--     idExemplar INTEGER,
--     idCliente INTEGER,
--     idFuncionario INTEGER,
--     data_emprestimo date,
--     data_prev_entrega date,
--     status_emprestimo VARCHAR(10),
--     PRIMARY KEY( idEmprestimo ),
--     FOREIGN KEY (idExemplar) REFERENCES Exemplar (idExemplar),
--     FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
--     FOREIGN KEY (idFuncionario) REFERENCES Funcionario (idFuncionario)
-- );

-- CREATE TABLE IF NOT EXISTS Renovacao(
--     idRenovacao SERIAL,
--     idEmprestimo INTEGER,
--     idCliente INTEGER,
--     data_renovacao date,
--     PRIMARY KEY( idRenovacao ),
--     FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
--     FOREIGN KEY (idEmprestimo) REFERENCES Emprestimo (idEmprestimo)
-- );

-- CREATE TABLE IF NOT EXISTS Reserva(
--     idReserva SERIAL,
--     idExemplar INTEGER,
--     idCliente INTEGER,
--     data_reserva date,
--     status_reserva VARCHAR(10),
--     PRIMARY KEY( idReserva ),
--     FOREIGN KEY (idExemplar) REFERENCES Exemplar (idExemplar),
--     FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
-- );

-- CREATE TABLE IF NOT EXISTS Multa(
--     idMulta SERIAL,
--     idCliente INTEGER,
--     categoria VARCHAR(10),
--     status_conclusao VARCHAR(10),
--     idEmprestimo INTEGER,
--     PRIMARY KEY( idMulta ),
--     FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
--     FOREIGN KEY (idEmprestimo) REFERENCES Emprestimo (idEmprestimo)
-- );

-- CREATE TABLE IF NOT EXISTS Requisicao(
--     idRequisicao SERIAL,
--     idCliente INTEGER,
--     livro VARCHAR(40),
--     PRIMARY KEY( idRequisicao ),
--     FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
-- );

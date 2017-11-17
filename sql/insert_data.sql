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

INSERT INTO Emprestimo (idExemplar, idCliente, idFuncionario, data_emprestimo, data_prev_entrega, status_emprestimo)
    VALUES  (1, 1, 1, '05/07/2017', '20/07/2017', 'FINALIZADO'),
            (1, 1, 1, '15/08/2017', '30/08/2017', 'ATRASADO'),
            (2, 2, 1, '10/11/2017', '25/11/2017', 'EMPRESTADO'),
            (3, 2, 1, '01/10/2017', '30/11/2017', 'RENOVADO');

INSERT INTO Devolucao (idExemplar, idCliente, idFuncionario, data_devolucao)
    VALUES  (1, 1, 1, '20/07/2017');

INSERT INTO Renovacao (idEmprestimo, idCliente, data_renovacao)
    VALUES  (4, 2, '15/11/2017');

INSERT INTO Reserva (idLivro, idCliente, data_reserva, status_reserva)
    VALUES  (2, 2, '08/11/2017', 'FINALIZADA'),
            (2, 1, '16/11/2017', 'ATIVA');

INSERT INTO Multa (idCliente, categoria, status_conclusao, idEmprestimo)
    VALUES  (1, 'ATRASO', 'NAO_INICIADA', 2);

INSERT INTO Requisicao (idCliente, livro)
    VALUES  (1, 'Mitologia Nórdica - Neil Gaiman');



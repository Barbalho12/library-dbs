-- Insert data

INSERT INTO Endereco (pais, uf, cidade, cep, bairro, rua)
    VALUES  ('Brasil', 'RN',      'Natal', 59131480,        'Pajuçara',           'Rua Campo Novo'),
            ('Brasil', 'RN',      'Natal', 59056450,      'Lagoa Nova', 'Av. Nascimento de Castro'),
            ('Brasil', 'RN', 'Parnamirim', 59151610, 'Nova Parnamirim',         'Av. Ayrton Senna'),
            ('Brasil', 'RN',      'Natal', 59091120,     'Ponta Negra',         'Av. Ayrton Senna'),
            ('Brasil', 'RN',      'Natal', 59088100,        'Neopólis',         'Av. Ayrton Senna');

INSERT INTO Credencial (username, senha, token_user)
    VALUES  (   'barbalho12',    'barbalho12',    'barbalho12_token'),
            ('raulmacintosh', 'raulmacintosh', 'raulmacintosh_token'),
            (      'caminho',       'caminho',       'caminho_token'),
            (     'pekopeko',      'pekopeko',      'pekopeko_token'),
            (      'profedu',       'profedu',       'profedu_token'),
            (      'profamo',       'profamo',       'profamo_token'),
            (      'breno73',       'breno73',       'breno73_token'),
            (      'felipe1',       'felipe1',       'felipe1_token'),
            (       'debora',        'debora',        'debora_token');

INSERT INTO Cliente (nome, cpf, telefone, email, idEndereco, idCredencial)
    VALUES  ('Felipe Barbalho', 11111111111, 5584911111111,     'barbalho12@ufrn.edu.br', 1, 1),
            (  'Raul Silveira', 22222222222, 5584922222222, 'raul-macintosh@ufrn.edu.br', 2, 2),
            (  'Patrícia Cruz', 33333333333, 5584933333333,        'caminho@ufrn.edu.br', 3, 3),
            ( 'Patrícia Silva', 44444444444, 5584944444444,       'pekopeko@ufrn.edu.br', 4, 4),
            (  'Eduardo Pinto', 55555555555, 5584955555555,        'profedu@ufrn.edu.br', 2, 5),
            ( 'Monica Bezerra', 66666666666, 5584966666666,        'profamo@ufrn.edu.br', 1, 6);

INSERT INTO Funcionario (nome, cpf, idCredencial)
    VALUES  ( 'Breno Viana', 77777777777, 7),
            ('Felipe Rocha', 88888888888, 8),
            ('Débora Rocha', 99999999999, 9);

INSERT INTO Autor (nome)
    VALUES  ('José de Alencar'),
            ('Augusto Cury'),
            ('Monteiro Lobato'),
            ('Agatha Christie'),
            ('Jim Kurose'),
            ('Keith Ross');

INSERT INTO Editora (nome, telefone, email)
    VALUES  ('Rocco',         11111,         'rocco@sac.com'),
            ('Sextante',      22222,      'sextante@sac.com'),
            ('Melhoramentos', 33333, 'melhoramentos@sac.com'),
            ('Ática',         44444,         'atica@sac.com'),
            ('Saraiva',       55555,       'saraiva@sac.com'),
            ('Pearson',       12455,       'Pearson@sac.com');

INSERT INTO Livro (titulo, isbn, edicao, ano_publicacao, linguagem, descricao, idEditora)
    VALUES  ('O Homem Mais Inteligente da História', '978-85-4310-435-5', 1, 2016, 'Português', '', 2),
            (                             'Iracema',                  '', 1, 1865, 'Português', '', 3),
            ('Redes de Computadores e a Internet', '978-85-8143-677-7', 6, 2013, 'Portugês', 'Uma Abordagem Top-Down', 6);

INSERT INTO Autor_Livro (idLivro, idAutor)
    VALUES  (2 , 1),
            (1 , 2),
            (3 , 5),
            (3 , 6);


INSERT INTO Biblioteca (nome, descricao_endereco)
    VALUES  ('Biblioteca Central Zila Mamede', 'Próxima ao centro de convivência'),
            (  'Biblioteca Setorial do CCHLA',                   'Próxima a BCZM');

INSERT INTO Localizacao (andar, sala, estante, idBiblioteca)
    VALUES  (1, 'P', '3A', 1),
            (1, 'P', '5C', 1),
            (2, 'P', '5C', 1),
            (2, 'P', '5C', 1),
            (1, 'P', '5C', 2),
            (1, 'P', '5C', 2),
            (2, 'P', '5C', 2),
            (2, 'P', '5C', 2);

INSERT INTO Exemplar (preco, codigo_barras, data_compra, estado_fisico, idLivro, idLocalizacao, status)
    VALUES  (40.0, '11111111', '10/05/2015', 'DANIFICADO', 1, 2, 'DISPONIVEL'),
            (40.0, '11111111', '10/05/2015', 'CONSERVADO', 1, 2, 'DISPONIVEL'),
            (40.0, '11111111', '11/02/2016', 'CONSERVADO', 1, 2, 'DISPONIVEL'),
            (40.0, '11111111', '11/02/2016', 'DANIFICADO', 1, 2, 'DISPONIVEL'),
            (40.0, '11111111', '26/09/2017', 'CONSERVADO', 1, 2, 'DISPONIVEL'),
            (40.0, '11111111', '26/09/2017', 'CONSERVADO', 1, 2, 'DISPONIVEL'),
            (20.0, '11111112', '10/05/2003', 'DANIFICADO', 2, 1, 'DISPONIVEL'),
            (20.0, '11111112', '10/05/2003', 'DANIFICADO', 2, 1, 'DISPONIVEL'),
            (20.0, '11111112', '10/05/2003', 'DANIFICADO', 2, 1, 'DISPONIVEL'),
            (20.0, '11111112', '10/05/2003', 'CONSERVADO', 2, 1, 'DISPONIVEL');

INSERT INTO Emprestimo (idExemplar, idCliente, idFuncionario, data_emprestimo, data_prev_entrega, status_emprestimo)
    VALUES  (1, 1, 1, '05/07/2017', '20/07/2017', 'FINALIZADO'),
            (1, 6, 1, '15/08/2017', '30/08/2017',   'FINALIZADO'),
            (2, 2, 1, '10/11/2017', '20/11/2017', 'FINALIZADO'),
            (3, 2, 1, '01/10/2017', '30/11/2017',   'FINALIZADO');

INSERT INTO Devolucao (idExemplar, idCliente, idFuncionario, data_devolucao)
    VALUES  (1, 1, 1, '20/07/2017');

INSERT INTO Reserva (idLivro, idCliente, data_reserva, status_reserva)
    VALUES  (2, 2, '08/11/2017', 'FINALIZADA'),
            (2, 1, '16/11/2017',      'ATIVA');

-- INSERT INTO Multa (idCliente, categoria, status_conclusao, idEmprestimo)
--     VALUES  (4, 'ATRASO', 'PENDENTE', 1);

INSERT INTO Requisicao (idCliente, livro)
    VALUES  (1,                        'Mitologia Nórdica - Neil Gaiman'),
            (2,        'Harry Potter e a Pedra Filosofal - J.K. Rowling'),
            (3,         'Harry Potter e a Câmara Secreta - J.K. Rowling'),
            (4, 'Harry Potter e o Prisioneiro de Azkaban - J.K. Rowling'),
            (5,         'Harry Potter e o Cálice de Fogo - J.K. Rowling'),
            (6,         'Harry Potter e a Ordem da Fenix - J.K. Rowling'),
            (6,       'Harry Potter e o Príncipe Mestiço - J.K. Rowling'),
            (6,    'Harry Potter e as Relíquias da Morte - J.K. Rowling');




-- Transação: Realização de emprestimo 1
BEGIN WORK;
    -- Cria um emprestimo informando (Exemplar, Cliente, Funcionário que realizou e a data de realização)
    INSERT INTO Emprestimo (idExemplar, idCliente, idFuncionario, data_emprestimo)
        VALUES (3, 2, 1, '01/11/2017');

    -- Atualiza o status do exemplar como INDISPONIVEL
    UPDATE Exemplar 
    SET status = 'INDISPONIVEL' 
    WHERE idExemplar = 3;


    UPDATE Reserva 
    SET status_reserva = 'FINALIZADA' 
    WHERE idCliente = 2 AND
          status_reserva = 'ATIVA' AND
          idLivro IN (SELECT idLivro FROM Exemplar WHERE idExemplar = 3);
COMMIT WORK;


-- Transação: Realização de emprestimo 2
BEGIN WORK;
    -- Cria um emprestimo informando (Exemplar, Cliente, Funcionário que realizou e a data de realização)
    INSERT INTO Emprestimo (idExemplar, idCliente, idFuncionario, data_emprestimo)
        VALUES (10, 1, 1, '19/11/2017');

    -- Atualiza o status do exemplar como INDISPONIVEL
    UPDATE Exemplar 
    SET status = 'INDISPONIVEL' 
    WHERE idExemplar = 10;


    UPDATE Reserva 
    SET status_reserva = 'FINALIZADA' 
    WHERE idCliente = 1 AND
          status_reserva = 'ATIVA' AND
          idLivro IN (SELECT idLivro FROM Exemplar WHERE idExemplar = 10);
COMMIT WORK;

-- -- Function para emprestimo
-- select new_emprestimo(10, 1, 1, '19/11/2017');


-- Alterar estados de Livros antigos para danificado
Update Exemplar 
set estado_fisico = 'DANIFICADO'
where data_compra < '01/01/2005'::DATE;


-- Deleta Requisições em que existem os livros requeridos
DELETE from Requisicao r
WHERE r.livro IN (SELECT l.titulo FROM Livro l);


-- Deleta Localizações em que não há exemplares
DELETE from Localizacao l
WHERE idLocalizacao NOT IN (SELECT e.idLocalizacao FROM Exemplar e);


-- Deleta Endereços onde ninguem mora
DELETE from Endereco e
WHERE idEndereco NOT IN (SELECT c.idEndereco FROM Cliente c);


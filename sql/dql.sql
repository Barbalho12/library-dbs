-- Consultas
SELECT * FROM Endereco;

SELECT * FROM Credencial;

SELECT nome, email  FROM Cliente;

SELECT nome FROM Funcionario;

SELECT nome FROM Editora;

SELECT nome FROM Autor;

SELECT titulo, ano_publicacao FROM Livro;

-- SELECT * FROM Autor_Livro;

SELECT nome, descricao_endereco  FROM Biblioteca;

SELECT e.idExemplar, l.titulo, e.status FROM Exemplar e, Livro l WHERE e.idLivro = l.idLivro;

SELECT e.idExemplar, l.titulo, emp.data_emprestimo FROM Emprestimo emp, Exemplar e, Livro l WHERE e.idLivro = l.idLivro AND e.idExemplar = emp.idExemplar;

SELECT * FROM Reserva;

SELECT cli.nome, m.status_conclusao FROM Multa m, Cliente cli WHERE m.idCliente = cli.idCliente;

SELECT cli.nome, r.livro FROM Requisicao r, Cliente cli WHERE r.idCliente = cli.idCliente;

SELECT liv.titulo, aut.nome FROM Autor aut 
    JOIN Autor_Livro al on al.idAutor = aut.idAutor
	JOIN Livro liv on liv.idLivro = al.idLivro;


SELECT exe.idExemplar, cli.nome, emp.data_emprestimo, liv.titulo FROM Cliente cli 
    RIGHT OUTER JOIN Emprestimo emp on cli.idCliente = emp.idCliente
	RIGHT OUTER JOIN exemplar exe on emp.idExemplar = exe.idExemplar
	RIGHT OUTER JOIN Livro liv on liv.idLivro = exe.idLivro;

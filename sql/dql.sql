-- Consultas
SELECT * FROM Endereco;

SELECT * FROM Credencial;

SELECT * FROM Cliente;

SELECT * FROM Funcionario;

SELECT * FROM Editora;

SELECT * FROM Autor;

SELECT * FROM Livro;

SELECT * FROM Autor_Livro;

SELECT * FROM Biblioteca;

SELECT * FROM Exemplar;

SELECT * FROM Devolucao;

SELECT * FROM Emprestimo;

SELECT * FROM Reserva;

SELECT * FROM Multa;

SELECT * FROM Requisicao;


SELECT liv.titulo, aut.nome FROM Autor aut 
    JOIN Autor_Livro al on al.idAutor = aut.idAutor
	JOIN Livro liv on liv.idLivro = al.idLivro;


SELECT exe.idExemplar, cli.nome, emp.data_emprestimo, liv.titulo FROM Cliente cli 
    RIGHT OUTER JOIN Emprestimo emp on cli.idCliente = emp.idCliente
	RIGHT OUTER JOIN exemplar exe on emp.idExemplar = exe.idExemplar
	RIGHT OUTER JOIN Livro liv on liv.idLivro = exe.idLivro;

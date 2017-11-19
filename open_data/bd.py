import psycopg2
import pprint
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT 
from psycopg2.extras import RealDictCursor
import json


dbname_default = 'postgres'
host_default ='localhost'
user_default ='postgres'
password_default ='postgres'

dbname_biblioteca = 'biblioteca'

file_creation_db = '../sql/ddl_create_database.sql'
file_create_tables = '../sql/ddl.sql'
file_insert_data = '../sql/dml.sql'


def readFileJson(file):
	file = open(file, 'r')
	data_file = file.read()
	file.close()
	data = json.loads(data_file)
	return data


## DELETA A BASE DADOS
def delete_database():
	try:
		con = psycopg2.connect(dbname='postgres', user='postgres', host='localhost', password='postgres')
		cursor = con.cursor()
		con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
		cursor.execute( "drop database biblioteca" )
	except:
		pass

delete_database()
# exit()

#Ler um arquivo e retorna uma string
def readSQLFile(file):
	file = open(file, 'r')
	data_file = file.read()
	file.close()
	return data_file

#Conecta ao banco e cria a base de dados da biblioteca
def connect_db():
	create_db = readSQLFile(file_creation_db)
	con = psycopg2.connect(dbname=dbname_default,
	      user=user_default, host=host_default,
	      password=password_default)
	try:

		con = psycopg2.connect(dbname=dbname_biblioteca,
		      user=user_default, host=host_default,
		      password=password_default)
		print "Create database biblioteca"

	except Exception as e:
		cursor = get_cursor(con)
		cursor.execute( create_db )
		con = psycopg2.connect( dbname=dbname_biblioteca, user=user_default, host=host_default, password=password_default)
		print "Create database biblioteca"
		pass
	return con


def get_cursor(con):
	# cursor = con.cursor()
	cursor = con.cursor(cursor_factory=RealDictCursor)
	con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
	return cursor



def execute(sql, cursor):
	cursor.execute( sql )
	records = cursor.fetchall()

def consulta(sql, cursor):
	
	cursor.execute( sql )
	records = cursor.fetchall()

	try:
		colunas = ""
		for coluna in records[0]:
			colunas += coluna+' | '

		print colunas
		for tupla in records:
			values = ""
			for coluna in tupla:
				values += str(tupla[coluna])+' | '
			print values
	except:
		pass

	return records



create_tables = readSQLFile(file_create_tables)
insert_data = readSQLFile(file_insert_data)

con = connect_db()
cursor = get_cursor(con)

cursor.execute( create_tables )
print "Create Tables"

# ----------

cursor.execute( insert_data )
print "Insert Data"

# ----------

print "----------- Consultando clientes -----------"
consulta("SELECT * FROM Cliente", cursor)

# ----------

print "----------- Consultando view situacao_livros -----------"
consulta("SELECT * FROM situacao_livros", cursor)

# ----------

print "----------- Consultando view situacao_livros -----------"
consulta("SELECT * FROM alerta_clientes", cursor)


print "----------- Consultando Emprestimo -----------"
consulta("SELECT * FROM emprestimo ORDER BY idEmprestimo", cursor)

print "----------- view Reserva -----------"
consulta("SELECT * FROM Reserva", cursor)


print "----------- Procedure Renovar Emprestimo -----------"
try:
	execute("SELECT renovar_emprestimo(6) ", cursor)
	consulta("SELECT * FROM emprestimo ORDER BY idEmprestimo", cursor)
except Exception as e:
        print("Failed "+str(e))
        pass

print "----------- Procedure Renovar Emprestimo -----------"
try:
	execute("SELECT renovar_emprestimo(4) ", cursor)
	consulta("SELECT * FROM emprestimo ORDER BY idEmprestimo", cursor)
except Exception as e:
        print("Failed "+str(e))
        pass

print "----------- view Renovar Emprestimo Atrasado -----------"
try:
	execute("SELECT renovar_emprestimo(5)", cursor)
	consulta("SELECT * FROM emprestimo ORDER BY idEmprestimo", cursor)
except Exception as e:
        print("Failed "+str(e))
        pass


print "----------- view Emprestimo -----------"
consulta("SELECT * FROM emprestimo ORDER BY idEmprestimo", cursor)


print "----------- Atualizando Multas -----------"
execute("SELECT update_multa()", cursor)

print "----------- Consultando licros com Multiplos autores -----------"
consulta("SELECT * FROM livro_com_autor", cursor)




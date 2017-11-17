import psycopg2
import pprint
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT 

dbname_default = 'postgres'
host_default ='localhost'
user_default ='postgres'
password_default ='postgres'

dbname_biblioteca = 'biblioteca'

file_creation_db = '../sql/create_db.sql'
file_create_tables = '../sql/create_tables.sql'
file_insert_data = '../sql/insert_data.sql'


## DELETA A BASE DADOS
def delete_database():
	con = psycopg2.connect(dbname='postgres', user='postgres', host='localhost', password='postgres')
	cursor = con.cursor()
	con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
	cursor.execute( "drop database biblioteca" )

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
	cursor = con.cursor()
	con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
	return cursor

create_tables = readSQLFile(file_create_tables)
insert_data = readSQLFile(file_insert_data)

con = connect_db()
cursor = get_cursor(con)

cursor.execute( create_tables )
print "Create Tables"

cursor.execute( insert_data )
print "Insert Data"

cursor.execute( "select * from Cliente" )

records = cursor.fetchall()

pprint.pprint(records)

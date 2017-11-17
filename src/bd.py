#/usr/bin/python2.4
#
#
# 
import psycopg2
import pprint
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT # <-- ADD THIS LINE


# con = psycopg2.connect(dbname='postgres', user='postgres', host='localhost', password='postgres')
# cursor = con.cursor()
# con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
# cursor.execute( "drop database biblioteca" )

#Ler um arquivo e retorna uma string
def readSQLFile(file):
	file = open(file, 'r')
	data_file = file.read()
	file.close()
	return data_file

def connect_db():
	create_db = readSQLFile("../sql/create_db.sql")
	con = psycopg2.connect(dbname='postgres',
	      user='postgres', host='localhost',
	      password='postgres')
	try:

		con = psycopg2.connect(dbname='biblioteca',
		      user='postgres', host='localhost',
		      password='postgres')
		print "Create database biblioteca"

	except Exception as e:
		cursor = get_cursor(con)
		cursor.execute( create_db )
		con = psycopg2.connect( dbname='biblioteca', user='postgres', host='localhost', password='postgres')
		print "Create database biblioteca"
		pass
	return con


def get_cursor(con):
	cursor = con.cursor()
	con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
	return cursor



create_tables = readSQLFile("../sql/create_tables.sql")
insert_data = readSQLFile("../sql/insert_data.sql")

con = connect_db()
cursor = get_cursor(con)

cursor.execute( create_tables )
print "Create Tables"

cursor.execute( insert_data )
print "Insert Data"

cursor.execute( "select * from Cliente" )

records = cursor.fetchall()

pprint.pprint(records)

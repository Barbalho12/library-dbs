import json
import time
import os
from pprint import pprint

def readFileJson(file):
	file = open(file, 'r')
	data_file = file.read()
	file.close()
	data = json.loads(data_file)
	return data

#Get token
os.system("curl -X POST \"http://apitestes.info.ufrn.br/authz-server/oauth/token?client_id=sesi-id&client_secret=segredo&grant_type=client_credentials\" > cred.txt")

data = readFileJson('cred.txt')
access_token = data["access_token"]

os.system("rm cred.txt")
# print access_token

# Consult libraries
os.system("curl -X GET \"https://apitestes.info.ufrn.br/biblioteca/v0.1/bibliotecas\" -H \"Authorization: Bearer "+access_token+"\" -H \"x-api-key: mIWP49N4BfuLbVrToQerm3dWKNjUQzqYcXi8q1ND\" > biblioteca.txt")

data = readFileJson('biblioteca.txt')

# print "--------------"

# pprint(data)
print "--------------"
print(data[0]["descricao"])
print(data[0]["id-biblioteca"])



print "--------------"
# Consult libraries
os.system("curl -X GET \"https://apitestes.info.ufrn.br/biblioteca/v0.1/exemplares\" -H \"Authorization: Bearer "+access_token+"\" -H \"x-api-key: mIWP49N4BfuLbVrToQerm3dWKNjUQzqYcXi8q1ND\" > exemplares.txt")
data = readFileJson('exemplares.txt')
print "--------------"
for exemplar in data:
	print exemplar["titulo"]
	print exemplar["autor"]
	print "--------------"


os.system("curl -X GET \"https://apitestes.info.ufrn.br/biblioteca/v0.1/acervos\" -H \"Authorization: Bearer "+access_token+"\" -H \"x-api-key: mIWP49N4BfuLbVrToQerm3dWKNjUQzqYcXi8q1ND\" > acervos.txt")
data = readFileJson('acervos.txt')
print "--------------"
for acervo in data:
	print acervo["titulo"]
	print acervo["autor"]

	for topico in acervo["assunto"]:
		print "\t"+topico
	print "--------------"


# os.system("curl -X GET \"https://apitestes.info.ufrn.br/biblioteca/v0.1/sitacoes-materiais\" -H \"Authorization: Bearer "+access_token+"\" -H \"x-api-key: mIWP49N4BfuLbVrToQerm3dWKNjUQzqYcXi8q1ND\" > sitacoes-materiais.txt")


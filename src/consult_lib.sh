
#Install curl
sudo apt install curl

#Get token
curl -X POST "http://apitestes.info.ufrn.br/authz-server/oauth/token?client_id=sesi-id&client_secret=segredo&grant_type=client_credentials" 

# Consult libraries
curl -X GET "https://apitestes.info.ufrn.br/biblioteca/v0.1/bibliotecas" -H "Authorization: Bearer d2281c72-01ae-4925-99b9-80df84cb3ab7" -H "x-api-key: mIWP49N4BfuLbVrToQerm3dWKNjUQzqYcXi8q1ND" > biblioteca.txt


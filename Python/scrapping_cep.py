import requests
import json

cep = [
    '81540082',
    ]

list_obj = []

for indice, cep in enumerate(cep):
    req = requests.get(f'http://viacep.com.br/ws/{cep}/json/')
    if req.status_code == 200:
      json = req.json()
      list_obj.append(json['bairro'])
      print(f'Requisição bem sucedida. {indice+1}')
    else:
      print(f'Erro {indice+1} {req.status_code}')

print(list_obj)

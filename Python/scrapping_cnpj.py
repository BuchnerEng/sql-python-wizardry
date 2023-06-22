import requests
import json

dados = ['']

data_abertura = {}

for indice, dado in enumerate(dados):
    headers = {'Authorization': 'Bearer TOKENAQUI'}
    req = requests.get(f'https://receitaws.com.br/v1/cnpj/{dado}/days/30', headers=headers)
    if req.status_code == 200:
      print(f'Requisição bem sucedida. {indice+1}')
      json = req.json()
      data_abertura[dado] = json['abertura']
    else:
      print(f'Erro {indice+1} {req.status_code}')

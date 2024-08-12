import requests
import json
import re 
import os

# Dicionário para armazenar a polaridade das palavras
POL = {}

# Função para baixar o arquivo do URL especificado
def download_sentilex(url, local_filename):
    try:
        response = requests.get(url)
        response.raise_for_status()  # Verifica se a requisição foi bem-sucedida
        with open(local_filename, "wb") as f:
            f.write(response.content)
    except requests.exceptions.RequestException as e:
        print(f"Erro ao baixar o arquivo: {e}")

# Função para processar o arquivo Sentilex
def sentilex(url="https://raw.githubusercontent.com/lilianoftheveil/polaridade_sentilex/main/sentilex.txt"):
    local_filename = "sentilex.txt"
    
    # Faz o download do arquivo se ele não existir localmente
    if not os.path.exists(local_filename):
        download_sentilex(url, local_filename)
    
    # Abre e processa o arquivo para extrair a polaridade das palavras
    with open(local_filename, "r", encoding="utf-8") as f:
        for linha in f:
            linha = re.sub(r"ANOT=.*", "", linha)
            lista = re.split(r";", linha)
            if len(lista) == 5:
                pallemapos, flex, assina, pol, junk = lista
                pal = re.split(r",", pallemapos)[0]
                pol = int(re.sub(r"POL:N[01]=", "", pol))
                POL[pal] = pol
            elif len(lista) == 6:
                pallemapos, flex, assina, pol1, pol2, junk = lista
                pal = re.split(r",", pallemapos)[0]
                pol1 = int(re.sub(r"POL:N[01]=", "", pol1))
                pol2 = int(re.sub(r"POL:N[01]=", "", pol2))
                POL[pal] = (pol1 + pol2) / 2
            else:
                print("Erro ao processar linha:", lista)
                continue

# Chama a função para carregar o dicionário de polaridade
sentilex()

def sentimento(a):         #total
    lp = re.findall(r"\w+", a)   
    ptotal = 0  # total
    totalp = 0  # positivo
    totaln = 0  # negativo
    totalo = 0  # neutro

    total_pol = 0

    for p in lp:    #total
        if p in POL:
            ptotal = ptotal + POL[p]
            total_pol = total_pol + 1

    for p in lp:    # positivo
        if p in POL:
            if POL[p] == 1 or POL[p] == 0.5:
                totalp = totalp + 1

    for p in lp:    # negativo
        if p in POL:
            if POL[p] == -1 or POL[p] == -0.5:
                totaln = totaln + 1

    for p in lp:    # neutro
        if p in POL:
            if POL[p] == 0 or POL[p] == 0.0:
                totalo = totalo + 1

    if ptotal < 0:
        ptotal = "Negativo"
    elif ptotal == 0 or ptotal == 0.0:
        ptotal = "Neutro"
    elif ptotal > 0:
        ptotal = "Positivo"


    if totalp == 0 and totaln == 0:     # se positivo e negativo = 0
        totalo = 100
    elif totalo == 0 and totaln == 0:   # se neutro e negativo = 0
        totalp = 100
    elif totalo == 0 and totalp ==0:    # se neutro e positivo = 0
        totaln = 100
    else:
        totalp = int(round(totalp / total_pol, 2)* 100)
        totalo = int(round(totalo / total_pol, 2)* 100)
        totaln = int(round(totaln / total_pol, 2)* 100)


    # Cria o resultado como um dicionário JSON
    resultado_json = {
       "geral": ptotal,
        "positivo": totalp,
        "neutro": totalo,
        "negativo": totaln
    }

    return json.dumps(resultado_json)


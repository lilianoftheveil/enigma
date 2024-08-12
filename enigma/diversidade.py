import string
import json

def diversidade_lexical(texto):
    if texto.endswith('.txt'):
        with open(texto, 'r', encoding='utf-8') as file:
            texto = file.read()
    
    texto = texto.lower().translate(str.maketrans("", "", string.punctuation))
    
    palavras = texto.split()
    
    num_tokens = len(palavras)
    num_tipos = len(set(palavras))
    
    diversidade_lexical = round(num_tipos / num_tokens if num_tokens > 0 else 0, 4)
    
    resultado_json = {
        'numero_palavras': num_tokens,
        'numero_unicas': num_tipos,
        'diversidade_lexical': diversidade_lexical
    }
    
    return json.dumps(resultado_json, ensure_ascii=False, indent=4)
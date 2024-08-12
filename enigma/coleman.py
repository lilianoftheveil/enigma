import json

def calcular_coleman_liau(texto):
  w = 1
  for a in texto:
      if a == " ":
        w = w + 1
  s = 0                                                   
  for b in texto:
    if b == "." or b == "!" or b == "?" or b == "...":
        s = s + 1
  l = 0                                                  
  for c in texto:        
    if c.isalpha():
        l = l + 1
  
  # Cálculo de médias por 100 palavras
  cl = (l / w) * 100
  cs = (s / w) * 100
  
  # Cálculo da fórmula de Coleman-Liau
  calcu = round((0.0588 * cl) - (0.296 * cs) - 15.8)
  
  # Determinação do nível escolar
  if calcu < 1:
      resultado_grade = "Pre-escolar"
  elif 1 <= calcu <= 16:
      resultado_grade = calcu
  else:
      resultado_grade = "16+"
    
  resultado_json = {"grade": resultado_grade,  "numero_letras": l, "numero_palavras": w, "numero_sentencas": s}
    
  return json.dumps(resultado_json)
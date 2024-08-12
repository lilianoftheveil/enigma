import nltk
nltk.download('mac_morpho')
nltk.download('punkt')
import json
from nltk.corpus import mac_morpho
from nltk.tokenize import word_tokenize
from collections import Counter

tagged_sents = mac_morpho.tagged_sents()

train_data = tagged_sents[:int(0.9 * len(tagged_sents))] 
test_data = tagged_sents[int(0.9 * len(tagged_sents)):]  

default_tagger = nltk.DefaultTagger('N')  
unigram_tagger = nltk.UnigramTagger(train_data, backoff=default_tagger)
bigram_tagger = nltk.BigramTagger(train_data, backoff=unigram_tagger)

pontuacoes = ["<blank>", ".", ",", ":", ";", "...", "?", "!", "—", "--", '"', "(", ")", "'", "/", "*", "_", "%", "$", "&", "=", "+", "<", ">", "~", "…", "'"]

def processar_subs(texto):
    if texto.endswith('.txt'):
        with open(texto, 'r', encoding='utf-8') as file:
            texto = file.read()
            
    texto = texto.lower()
    
    words = word_tokenize(texto, language='portuguese')
    tagged_words = bigram_tagger.tag(words)
    
    substantivos = []
    for word, tag in tagged_words:
        if word not in pontuacoes:
            if tag == 'N' or tag.startswith('N-'):
                substantivos.append(word)
    
    contagem_substantivos = Counter(substantivos).most_common(20)
    
    resultado_json = {
        'substantivos': {substantivo: contagem for substantivo, contagem in contagem_substantivos}
    }
    
    return json.dumps(resultado_json, ensure_ascii=False, indent=4)

texto = """A cidade de São Paulo, a maior metrópole do Brasil, é conhecida por sua diversidade cultural, arquitetônica e gastronômica. Com seus prédios altos e modernos, São Paulo se destaca como um dos principais centros financeiros da América Latina. Além disso, a cidade oferece uma vida noturna vibrante, com bares, restaurantes e baladas para todos os gostos.

O clima na cidade é bastante variado, com verões quentes e invernos relativamente frios. Durante o verão, as temperaturas podem ultrapassar os 30 graus, enquanto no inverno, especialmente nas madrugadas, os termômetros podem registrar temperaturas próximas dos 10 graus. Apesar das variações climáticas, São Paulo continua sendo um destino popular para turistas do mundo inteiro.

A gastronomia paulistana é um dos grandes atrativos da cidade. Com uma vasta oferta de restaurantes, São Paulo é o lugar ideal para experimentar desde a tradicional comida brasileira até a alta culinária internacional. Os mercados municipais, como o famoso Mercado Municipal de São Paulo, oferecem uma variedade de frutas, verduras e iguarias, sendo um verdadeiro paraíso para os amantes da boa comida.

Além da gastronomia, a arte e a cultura são aspectos importantes da vida paulistana. Museus, teatros e galerias de arte espalhados por toda a cidade oferecem aos visitantes uma rica experiência cultural. O Museu de Arte de São Paulo (MASP), com sua arquitetura icônica e acervo impressionante, é um dos pontos turísticos mais visitados da cidade.

No entanto, como toda grande metrópole, São Paulo enfrenta desafios. O trânsito caótico, a poluição do ar e as questões relacionadas à segurança são problemas que afetam o dia a dia dos paulistanos. Mesmo assim, a cidade continua a atrair pessoas em busca de oportunidades, seja para trabalho, estudo ou lazer.

São Paulo é uma cidade de contrastes, onde o antigo e o novo coexistem harmoniosamente. Desde os bairros históricos até os modernos arranha-céus, a cidade oferece uma mistura única de tradição e inovação. É esse dinamismo que faz de São Paulo uma cidade vibrante, cheia de vida e possibilidades."""
resultado = processar_subs(texto)
print(resultado)

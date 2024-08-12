import string
import json

stopwords_pt = ["o", "a", "os", "as", "um", "uma", "uns", "umas", # artigos
                

    'a', 'ante', 'após', 'até', 'com', 'contra', 'de', 'desde', 'em', 'entre', # preposições
    'para', 'por', 'perante', 'sem', 'sob', 'sobre', 'trás', 'afora', 'como',
    'conforme', 'consoante', 'durante', 'exceto', 'feito', 'fora', 'mediante',
    'menos', 'salvo', 'segundo', 'senão', 'tirante', 'visto', 'do', 'da', 'no',
    'na', 'o', 'dum', 'um', 'duma', 'uma', 'dele', 'ele', 'dela', 'ela', 'deste',
    'este', 'dessa', 'essa', 'daquilo', 'aquilo', 'dali', 'ali', 'num', 'numa',
    'nele', 'nela', 'neste', 'nessa', 'naquilo', 'à', 'às', 'ao', 'aos', 'àquele',
    'àquilo', 'a fim de', 'a respeito de', 'abaixo de', 'acerca de', 'acima de',
    'antes de', 'ao lado de', 'apesar de', 'atrás de', 'atráves de', 'de acordo com',
    'de cima de', 'debaixo de', 'dentro de', 'diante de', 'em frente de',
    'em lugar de', 'em vez de',

    
    'eu', 'tu', 'ele', 'ela', 'nós', 'vós', 'eles', 'elas', 'me', 'te', 'o', 'a', 'lhe', # pronomes
    'se', 'nos', 'vos', 'os', 'as', 'lhes', 'mim', 'comigo', 'ti', 'contigo', 'si', 'consigo',
    'conosco', 'convosco', 'você', 'v.', 'senhor', 'Sr.', 'senhora', 'Sr.ª', 'senhorita',
    'Srta.', 'Vossa Alteza', 'V. A.', 'Vossa Eminência', 'V. Em.ª', 'Vossa Excelência',
    'V. Ex.ª', 'Vossa Magnificência', 'V. Mag.ª', 'Vossa Majestade', 'V. M.',
    'Vossa Majestade Imperial', 'V. M. I.', 'Vossa Mercê', 'V.M.cê', 'Vossa Onipotência',
    'Vossa Paternidade', 'V.P', 'Vossa Reverendíssima', 'V. Rev.mª', 'Vossa Santidade',
    'V. S.', 'Vossa Senhoria', 'V. S.ª', 'meu', 'minha', 'meus', 'minhas', 'teu', 'tua',
    'teus', 'tuas', 'seu', 'sua', 'seus', 'suas', 'nosso', 'nossa', 'nossos', 'nossas', 'vosso',
    'vossa', 'vossos', 'vossas', 'isto', 'isso', 'aquilo', 'este', 'esta', 'estes', 'estas',
    'esse', 'essa', 'esses', 'essas', 'aquele', 'aquela', 'aqueles', 'aquelas', 'mesmo', 'mesma',
    'mesmos', 'mesmas', 'próprio', 'própria', 'próprios', 'próprias tal', 'tais semelhante',
    'semelhantes', 'que', 'quem', 'qual', 'quais', 'quanto', 'quanta', 'quantos', 'quantas',
    'onde', 'o qual', 'a qual', 'os quais', 'as quais cujo', 'cuja', 'cujos', 'cujas quanto',
    'tudo', 'nada', 'algo', 'cada', 'alguém', 'ninguém', 'outrem', 'algum', 'alguns', 'alguma',
    'algumas nenhum', 'nenhuns', 'nenhuma', 'nenhumas todo', 'todos', 'toda', 'todas outro',
    'outros', 'outra', 'outras muito', 'muitos', 'muita', 'muitas pouco', 'poucos', 'pouca',
    'poucas certo', 'certos', 'certa', 'certas vário', 'vários', 'vária', 'várias tanto', 'tantos',
    'tanta', 'tantas quanto', 'qualquer', 'quaisquer bastante', 'bastantes',
    

    'e', 'ou', 'mas', 'nem', 'logo', 'como', 'que', 'se', 'pois', 'porque', 'portanto', 'também', # conjunções
    'bem como', 'não só', 'mas também', 'porém', 'contudo', 'todavia', 'entretanto', 'no entanto',
    'não obstante', 'já', 'ora', 'quer', 'seja', 'assim', 'por isso', 'por consequência',
    'por conseguinte', 'porquanto', 'isto é', 'visto que', 'uma vez que', 'já que', 'pois que',
    'tanto que', 'tão que', 'tal que', 'tamanho que', 'de forma que', 'de modo que', 'de sorte que',
    'de tal forma que', 'a fim de que', 'para que', 'quando', 'enquanto', 'agora que', 'logo que',
    'desde que', 'assim que', 'apenas', 'caso', 'desde', 'salvo se', 'exceto se', 'contando que',
    'embora', 'conquanto', 'ainda que', 'mesmo que', 'se bem que', 'posto que', 'assim como', 'tal',
    'qual', 'tanto como', 'conforme', 'consoante', 'segundo', 'à proporção que', 'à medida que',
    'ao passo que', 'quanto mais', 'mais', 'dado que', 'sem que', 'até que', 'antes que', 
    'por mais que', 'contanto que', 'ainda assim', 'apesar disso', 'mesmo assim', 'senão',
    'como também', 'mas ainda', 'não somente', 'antes do verbo', 'ou seja', 'na verdade', 'a saber',
    'então', 'consequentemente', 'desse modo', 'dessarte', 'destarte', 'talvez',
    
    "aqui","ali","lá","cá","acolá","agora","já","sempre","nunca","antes","depois","logo","então", # advérbios de função
    "hoje","ontem","amanhã","ainda","tarde","cedo","demais","também","mais","menos","sim","não","talvez"]


def sofisticacao_lexical(texto):
    if texto.endswith('.txt'):
        with open(texto, 'r', encoding='utf-8') as file:
            texto = file.read()
    
    texto = texto.lower().translate(str.maketrans("", "", string.punctuation))

    palavras = texto.split()

    num_tokens = len(palavras)

    num_tipos = [palavra for palavra in palavras if palavra in stopwords_pt]

    num_tip = len(set(num_tipos))

    num_conteudo = [palavra for palavra in palavras if palavra not in stopwords_pt]

    num_cont = len(set(num_conteudo))

    sofisticacao_lexical = round((num_cont + num_tip) / num_tokens if num_tokens > 0 else 0, 4)

    resultado_json = {
        'numero_palavras': num_tokens,
        'numero_funcionais': num_tip,
        'numero_semantico_unico': num_cont,
        'sofisticacao_lexical': sofisticacao_lexical
    }

    return json.dumps(resultado_json, ensure_ascii=False, indent=4)
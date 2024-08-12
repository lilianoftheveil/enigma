if (!require("shiny"))              install.packages("shiny")
if (!require("shinydashboard"))     install.packages("shinydashboard")
if (!require("reticulate"))         install.packages("reticulate")
if (!require("ggplot2"))            install.packages("ggplot2")
if (!require("dplyr"))              install.packages("dplyr")
if (!require("hrbrthemes"))         install.packages("hrbrthemes")
if (!require("jsonlite"))           install.packages("jsonlite")

virtualenv_create("myenv")
use_virtualenv("myenv", required = TRUE)
py_install(c("requests"), envname = "myenv")
py_install(c("nltk"), envname = "myenv")
py_run_string("import nltk")
py_run_string("nltk.download('punkt_tab')")

options(shiny.connect.timeout = 300)

py_run_file("sentimento.py")
py_run_file("substantivos.py")
py_run_file("adjetivos.py")
py_run_file("pronomes.py")
py_run_file("verbos.py")
py_run_file("adverbios.py")
py_run_file("coleman.py")
py_run_file("diversidade.py")
py_run_file("densidade.py")
py_run_file("sofisticacao.py")


ui <- dashboardPage(skin = 'blue', 
                    dashboardHeader(title = "Enigma", titleWidth = 300),
                    dashboardSidebar(width = 300,
                                     sidebarMenu(
                                       id = "tabs",
                                       menuItem(tabName = "home",
                                                tags$span("Sobre o App")),
                                       menuItem(tabName = "sentimento",
                                                tags$span("Análise de Sentimento")),
                                       menuItem(tabName = "gramatica",
                                                tags$span("Classes de Palavras"),
                                                menuSubItem("Substantivos",
                                                            tabName = "subMenu1"),
                                                menuSubItem("Adjetivos",
                                                            tabName = "subMenu2"),
                                                menuSubItem("Pronomes",
                                                            tabName = "subMenu3"),
                                                menuSubItem("Verbos",
                                                            tabName = "subMenu4"),
                                                menuSubItem("Advérbios",
                                                            tabName = "subMenu5")),
                                       menuItem(tabName = "coleman",
                                                tags$span("Coleman-Liau Index")),
                                       menuItem(tabName = "legibilidade",
                                                tags$span("Índices Lexicais e Sintáticos"), 
                                                menuSubItem("Diversidade lexical",
                                                            tabName = "subMenu6"),
                                                menuSubItem("Densidade lexical",
                                                            tabName = "subMenu7"),
                                                menuSubItem("Sofisticação lexical",
                                                            tabName = "subMenu8")),
                                       tags$div(
                                         style = "position: absolute; 
                                         bottom: 0; 
                                         width: 100%; 
                                         padding: 10px; 
                                         color: #B2BEC4;
                                         background: #242D31;
                                         font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                         font-weight: regular;
                                         font-size: 14px;",
                                         p('Desenvolvido por: Lilian Carvalho de Oliveira'),
                                         p("Contato: lilianoftheveil@gmail.com"),
                                         tags$a(href = "http://lattes.cnpq.br/2170886883377451", target="_blank", "Currículo Lattes"))
                                     )),
                    dashboardBody(
                      tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Roboto Slab", "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-weight: bold;
        font-size: 24px;
      }
      
      .sidebar  span {
        font-family: "Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-weight: regular;
        font-size: 16px;
      }
      
      .custom-box {
        background-color: #fff;
        #border: 1px solid #ccc;
        margin-bottom: 20px;
      }
    
      .title-home {
        font-family: "Roboto Slab", "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-weight: regular;
        font-size: 20px;
        color: #528BB8;
        padding-top: 20px;
        padding-left: 20px;
        padding-bottom: 10px;
      }
      
      .text-home {
        font-family: "Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-weight: regular;
        font-size: 16px;
        color: #4A4040;
        padding-bottom: 10px;
        padding-left: 20px;
        padding-right: 20px;
      }
      
      .choice {
        font-family: "Roboto Slab", "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-weight: bold;
        font-size: 16px;
        color: #0E2F73;
        padding-top: 20px;
      }
      
       .sidebar .treeview-menu > .active > a {
        background-color: #48769A;
        color: #1F0E65;
        font-weight: bold;
       }
       
       .title-tab {
        font-family: "Roboto Slab", "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-weight: regular;
        font-size: 20px;
        color: #4a7da5;
        padding-left: 10px;
       }
      
      .text-home a {
        font-family: "Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-weight: regular;
        font-size: 16px;
        color: #4A4040;
        padding-left: 10px;
        padding-right: 10px;
        text-decoration: none; 
      }
      
      .text-home a:hover {
        color: #0E2F73;
      }
      
      .resultado {
        background-color: "#ffff";
      }
      
      '))),
                      tabItems(
                        tabItem(tabName = "home",
                                fluidRow(tags$div(class = "custom-box",
                                                  box( width = 8, solidHeader = TRUE, 
                                                       br(), 
                                                       tags$div(class = "title-home", "Como utilizar"), 
                                                       br(), 
                                                       tags$div(class = "text-home", style="text-align: justify",
                                                                tags$p(tags$b("Análise de Sentimento:"), "A análise de sentimento identifica e classifica as emoções 
                                                                expressas em um texto, determinando se a tonalidade geral do texto é positiva, negativa ou neutra.")),
                                                       tags$div(class = "text-home", style="text-align: justify",
                                                                tags$p(tags$b("Classe de Palavras:"), "Esta função permite que você selecione substantivos, adjetivos,
                                                                pronomes, verbos ou advérbios organizados por ordem e quantidade de ocorrências de um texto.")),
                                                       tags$div(class = "text-home", style="text-align: justify",
                                                                tags$p(tags$b("Coleman-Liau Index:"), "Esta função calcula o Índice de Coleman-Liau do seu texto, 
                                                                fornecendo uma estimativa do nível de leitura necessário. Isto é Ideal para avaliar a complexidade e a acessibilidade do conteúdo."),
                                                                tags$p("- 5 ou  < 5: Muito fácil de ler"),
                                                                tags$p("- 6: Fácil de ler"),
                                                                tags$p("- 7: Relativamente fácil de ler"),
                                                                tags$p("- 7-10: Médio"),
                                                                tags$p("- 11-12: Relativamente difícil de ler"),
                                                                tags$p("- 13-16: Difícil de ler"),
                                                                tags$p("- 16 +: Extremamente difícil de ler")), 
                                                       tags$div(class = "text-home", style="text-align: justify",
                                                                tags$p(tags$b("Índices Lexicais e Semânticos:"), "A densidade lexical de um texto, que varia entre 0 a 1, fornece uma medida da 
                                                                diversidade e complexidade do vocabulário utilizado. Ideal para entender a riqueza lexical e a variedade de palavras no seu conteúdo. 
                                                                      A diversidade lexical de um texto, que varia entre 0 a 1, infere a variedade de palavras usadas. Ela fornece insights sobre a riqueza vocabular e a originalidade do conteúdo."))),
                                                  box(width = 4, solidHeader = TRUE, tags$div(class = "title-home", 
                                                                                              tags$span("Funcionalidades", style = "font-size: 20px;"),
                                                                                              selectInput("dashboard_variavel1", 
                                                                                                          tags$div(class = "choice", "Escolha uma opção:"),
                                                                                                          choices = c("Análise de Sentimento", "Classes de Palavras","Coleman-Liau Index","Índices Lexicais e Sintáticos"),
                                                                                                          selectize = FALSE),
                                                                                              uiOutput("variavel_options"),
                                                  ),
                                                  actionButton("dashboard_switchTabs", "Analisar", 
                                                               style="background-color: #0E2F73;
                                                           color: #ffff;
                                                           border-radius: 10px;
                                                           font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                           font-weight: bold;
                                                           font-size: 16px;
                                                           margin-left: 20px;"))),
                                )),
                        tabItem(tabName = "sentimento",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_sentimento", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_sentimento", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_sentimento", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_sentimento"),
                                               downloadButton("downloadJson_sentimento", "Baixar JSON"),
                                               br(), 
                                               plotOutput("sentPlot"))
                                  )
                                )
                        ),
                        tabItem(tabName = "subMenu1",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_substantivo", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_substantivo", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_substantivo", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_substantivo"),
                                               downloadButton("downloadJson_substantivo", "Baixar JSON"))
                                  )
                                )
                        ),
                        tabItem(tabName = "subMenu2",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_adjetivo", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_adjetivo", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_adjetivo", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_adjetivo"),
                                               downloadButton("downloadJson_adjetivo", "Baixar JSON"))
                                  )
                                )
                        ),
                        tabItem(tabName = "subMenu3",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_pronome", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_pronome", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_pronome", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_pronome"),
                                               downloadButton("downloadJson_pronome", "Baixar JSON"))
                                  )
                                )
                        ),
                        tabItem(tabName = "subMenu4",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_verbo", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_verbo", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_verbo", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_verbo"),
                                               downloadButton("downloadJson_verbo", "Baixar JSON"))
                                  )
                                )
                        ),
                        tabItem(tabName = "subMenu5",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_adverbio", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_adverbio", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_adverbio", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_adverbio"),
                                               downloadButton("downloadJson_adverbio", "Baixar JSON"))
                                  )
                                )
                        ),
                        tabItem(tabName = "coleman",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_coleman", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_coleman", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_coleman", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_coleman"),
                                               downloadButton("downloadJson_coleman", "Baixar JSON"))
                                  )
                                )
                        ),
                        tabItem(tabName = "subMenu6",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_diversidade", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_diversidade", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_diversidade", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_diversidade"),
                                               downloadButton("downloadJson_diversidade", "Baixar JSON"))
                                  )
                                )
                        ),
                        tabItem(tabName = "subMenu7",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_densidade", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_densidade", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_densidade", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_densidade"),
                                               downloadButton("downloadJson_densidade", "Baixar JSON"))
                                  )
                                )
                        ),
                        tabItem(tabName = "subMenu8",
                                fluidRow(
                                  div(
                                    class = "text-center", width = 8,
                                    actionButton("redirect_home", "Voltar para Home", 
                                                 style="background-color: #0E2F73;
                                color: #fff;
                                border-radius: 10px;
                                font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                font-weight: bold;
                                font-size: 16px;
                                margin-bottom: 20px;"),
                                  ),
                                ),
                                fluidRow(
                                  box(width = 6, solidHeader = TRUE, 
                                      tags$div(class = "text-home", 
                                               tags$p("O arquivo deve ser um txt e ter o formato UTF-8."),
                                               tags$p("Caso carregue um arquivo txt, aguarde o aviso 'Upload complete' antes de clicar em Processar.")), 
                                      fileInput("file_sofisticacao", "Carregue um arquivo de texto:", buttonLabel = "Arquivo", accept = ".txt"),
                                      textAreaInput("texto_sofisticacao", "Ou digite algo:", "", width = "500px", height = "300px"),
                                      actionButton("processar_sofisticacao", "Processar", 
                                                   style="background-color: #0e7352;
                                                             color: #ffff;
                                                             border-radius: 10px;
                                                             font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';
                                                             font-weight: bold;
                                                             font-size: 16px;
                                                             margin-top: 20px;"
                                      )
                                  ),
                                  box(width = 6, solidHeader = TRUE,
                                      tags$div(class = "title-home", "Resultado"),
                                      tags$div(class = "title-home",
                                               verbatimTextOutput("resultado_sofisticacao"),
                                               downloadButton("downloadJson_sofisticacao", "Baixar JSON"))
                                  )
                                )
                        )
                      )
                    )
)

server <- function(input, output, session) {
  
  output$variavel_options <- renderUI({
    if(input$dashboard_variavel1 == "Análise de Sentimento") {
      selectInput("dashboard_variavel2",
                  tags$div(class = "choice", "Escolha o que será analisado:"),
                  choices = c("Sentimento"),
                  selectize = FALSE)
    } else if(input$dashboard_variavel1 == "Classes de Palavras") {
      selectInput("dashboard_variavel2", 
                  tags$div(class = "choice", "Escolha o que será analisado:"),
                  choices = c("Substantivos", "Adjetivos", "Pronomes", "Verbos", "Advérbios"),
                  selectize = FALSE)
    } else if(input$dashboard_variavel1 == "Coleman-Liau Index") {
        selectInput("dashboard_variavel2",
                    tags$div(class = "choice", "Escolha o que será analisado:"),
                    choices = c("Coleman index"),
                    selectize = FALSE)
    } else if(input$dashboard_variavel1 == "Índices Lexicais e Sintáticos") {
      selectInput("dashboard_variavel2", 
                  tags$div(class = "choice", "Escolha o que será analisado:"),
                  choices = c("Diversidade lexical", "Densidade lexical", "Sofisticação lexical"),
                  selectize = FALSE)
    }
  })
  
  observeEvent(input$dashboard_switchTabs, {
    selected_tab <- switch(input$dashboard_variavel1,
                           "Análise de Sentimento" = switch(input$dashboard_variavel2,
                                                            "Sentimento" = "sentimento"
                           ),
                           "Classes de Palavras" = switch(input$dashboard_variavel2,
                                                          "Substantivos" = "subMenu1",
                                                          "Adjetivos" = "subMenu2",
                                                          "Pronomes" = "subMenu3",
                                                          "Verbos" = "subMenu4",
                                                          "Advérbios" = "subMenu5"
                           ),
                           "Coleman-Liau Index" = switch(input$dashboard_variavel2,
                                                         "Coleman index" = "coleman"
                           ),
                           "Índices Lexicais e Sintáticos" = switch(input$dashboard_variavel2,
                                                                    "Diversidade lexical" = "subMenu6",
                                                                    "Densidade lexical" = "subMenu7",
                                                                    "Sofisticação lexical" = "subMenu8"
                           )
    )
    updateTabsetPanel(session, "tabs", selected = selected_tab)
    
  })
  
  observeEvent(input$redirect_home, {
    updateTabsetPanel(session, "tabs", selected = "home")
    
  })
  
  observeEvent(input$processar_sentimento, {
    texto <- NULL
    
    if (!is.null(input$file_sentimento$datapath)) {
      linhas <- readLines(input$file_sentimento$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")  # Mantém as quebras de linha
    } else if (nzchar(input$texto_sentimento)) {
      texto <- input$texto_sentimento
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      resultado_json <- py$sentimento(texto)  # Chama a função sentimento do Python
      resultado <- jsonlite::fromJSON(resultado_json)# Chamada à função sentimento em Python
      
      output$resultado_sentimento <- renderPrint({
        cat(paste("Sentimento geral:", resultado$geral, "\n"))
        cat(paste("Positivo:", resultado$positivo, "%\n"))
        cat(paste("Neutro:", resultado$neutro, "%\n"))
        cat(paste("Negativo:", resultado$negativo, "%\n"))
      })
      
      output$downloadJson_sentimento <- downloadHandler(
        filename = function() {
          paste("resultado_sentimento", ".json", sep = "")
        },
        content = function(file) {
          # Converter o objeto resultado_json para JSON e escrever no arquivo
          json <- jsonlite::toJSON(resultado_json)
          writeLines(json, file)
        }
      )
      
      # Renderiza o gráfico de barras
      output$sentPlot <- renderPlot({
        # Converter o resultado em um data frame para usar no ggplot
        dados_sentimento <- data.frame(
          Sentimento = factor(c("Positivo", "Neutro", "Negativo"), levels = c("Positivo", "Neutro", "Negativo")),
          Porcentagem = c(resultado$positivo, resultado$neutro, resultado$negativo)
        )
        
        # Criar o gráfico de barras
        ggplot(dados_sentimento, aes(x = Sentimento, y = Porcentagem)) +
          geom_bar(fill = "#0E2F73", width = 0.8, stat = "identity") + 
          geom_text(aes(label = paste0(round(Porcentagem, 1), "%")), 
                    position = position_dodge(width = 0.9), 
                    vjust = -0.5, size = 4.5) + 
          ggtitle("Análise de Sentimento") +
          xlab("Sentimento") +
          ylab("Porcentagem (%)") +
          theme_minimal() +
          theme(
            legend.title = element_text(size = 12), 
            axis.text.x = element_text(size = 12),
            axis.text.y = element_text(size = 12),
            axis.title.x = element_text(size = 12),
            axis.title.y = element_text(size = 12)
          )
      })
      
    } else {
      output$resultado_sentimento <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
      
      output$sentPlot <- renderPlot(NULL)  # Caso nenhum texto seja inserido, renderiza um gráfico nulo
    }
  })
  
  processar_texto_substantivo <- function(texto) {
    cat("Processando texto...\n")
    cat("Texto:\n", texto, "\n")
    
    resultado_json <- tryCatch({
      py$processar_subs(texto)
    }, error = function(e) {
      cat("Erro ao processar o texto com Python: ", e$message, "\n")
      return(NULL)
    })
    
    if (is.null(resultado_json)) {
      return()
    }
    
    resultado <- jsonlite::fromJSON(resultado_json)
    print(resultado)  # Verifique o resultado
    
    output$resultado_substantivo <- renderPrint({
      cat("Substantivos:\n")
      for (substantivo in names(resultado$substantivos)) {
        cat(substantivo, ":", resultado$substantivos[[substantivo]], "\n")
      }
    })
    
    output$downloadJson_substantivo <- downloadHandler(
      filename = function() {
        paste("resultado_substantivo", ".json", sep = "")
      },
      content = function(file) {
        writeLines(resultado_json, file)
      }
    )
  }
  
  observeEvent(input$processar_substantivo, {
    texto <- NULL
    
    if (!is.null(input$file_substantivo)) {
      cat("Arquivo carregado: ", input$file_substantivo$datapath, "\n")
      linhas <- readLines(input$file_substantivo$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")
    } else if (nzchar(input$texto_substantivo)) {
      texto <- input$texto_substantivo
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      processar_texto_substantivo(texto)
    } else {
      output$resultado_substantivo <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
    }
  })
  
  processar_texto_adjetivo <- function(texto) {
    cat("Processando texto...\n")
    cat("Texto:\n", texto, "\n")
    
    resultado_json <- tryCatch({
      py$processar_adj(texto)
    }, error = function(e) {
      cat("Erro ao processar o texto com Python: ", e$message, "\n")
      return(NULL)
    })
    
    if (is.null(resultado_json)) {
      return()
    }
    
    resultado <- jsonlite::fromJSON(resultado_json)
    print(resultado)  # Verifique o resultado
    
    output$resultado_adjetivo <- renderPrint({
      cat("Adjetivos:\n")
      for (adjetivo in names(resultado$adjetivos)) {
        cat(adjetivo, ":", resultado$adjetivos[[adjetivo]], "\n")
      }
    })
    
    output$downloadJson_adjetivo <- downloadHandler(
      filename = function() {
        paste("resultado_adjetivo", ".json", sep = "")
      },
      content = function(file) {
        writeLines(resultado_json, file)
      }
    )
  }
  
  observeEvent(input$processar_adjetivo, {
    texto <- NULL
    
    if (!is.null(input$file_adjetivo)) {
      cat("Arquivo carregado: ", input$file_adjetivo$datapath, "\n")
      linhas <- readLines(input$file_adjetivo$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")
    } else if (nzchar(input$texto_adjetivo)) {
      texto <- input$texto_adjetivo
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      processar_texto_adjetivo(texto)
    } else {
      output$resultado_adjetivo <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
    }
  })
  
  processar_texto_pronome <- function(texto) {
    cat("Processando texto...\n")
    cat("Texto:\n", texto, "\n")
    
    resultado_json <- tryCatch({
      py$processar_pron(texto)
    }, error = function(e) {
      cat("Erro ao processar o texto com Python: ", e$message, "\n")
      return(NULL)
    })
    
    if (is.null(resultado_json)) {
      return()
    }
    
    resultado <- jsonlite::fromJSON(resultado_json)
    print(resultado)  # Verifique o resultado
    
    output$resultado_pronome <- renderPrint({
      cat("Pronomes:\n")
      for (pronome in names(resultado$pronomes)) {
        cat(pronome, ":", resultado$pronomes[[pronome]], "\n")
      }
    })
    
    output$downloadJson_pronome <- downloadHandler(
      filename = function() {
        paste("resultado_pronome", ".json", sep = "")
      },
      content = function(file) {
        writeLines(resultado_json, file)
      }
    )
  }
  
  observeEvent(input$processar_pronome, {
    texto <- NULL
    
    if (!is.null(input$file_pronome)) {
      cat("Arquivo carregado: ", input$file_pronome$datapath, "\n")
      linhas <- readLines(input$file_pronome$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")
    } else if (nzchar(input$texto_pronome)) {
      texto <- input$texto_pronome
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      processar_texto_pronome(texto)
    } else {
      output$resultado_pronome <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
    }
  })
  
  processar_texto_verbo <- function(texto) {
    cat("Processando texto...\n")
    cat("Texto:\n", texto, "\n")
    
    resultado_json <- tryCatch({
      py$processar_verb(texto)
    }, error = function(e) {
      cat("Erro ao processar o texto com Python: ", e$message, "\n")
      return(NULL)
    })
    
    if (is.null(resultado_json)) {
      return()
    }
    
    resultado <- jsonlite::fromJSON(resultado_json)
    print(resultado)  # Verifique o resultado
    
    output$resultado_verbo <- renderPrint({
      cat("Verbos:\n")
      for (verbo in names(resultado$verbos)) {
        cat(verbo, ":", resultado$verbos[[verbo]], "\n")
      }
    })
    
    output$downloadJson_verbo <- downloadHandler(
      filename = function() {
        paste("resultado_verbo", ".json", sep = "")
      },
      content = function(file) {
        writeLines(resultado_json, file)
      }
    )
  }
  
  observeEvent(input$processar_verbo, {
    texto <- NULL
    
    if (!is.null(input$file_verbo)) {
      cat("Arquivo carregado: ", input$file_verbo$datapath, "\n")
      linhas <- readLines(input$file_verbo$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")
    } else if (nzchar(input$texto_verbo)) {
      texto <- input$texto_verbo
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      processar_texto_verbo(texto)
    } else {
      output$resultado_verbo <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
    }
  })
  
  processar_texto_adverbio <- function(texto) {
    cat("Processando texto...\n")
    cat("Texto:\n", texto, "\n")
    
    resultado_json <- tryCatch({
      py$processar_adv(texto)
    }, error = function(e) {
      cat("Erro ao processar o texto com Python: ", e$message, "\n")
      return(NULL)
    })
    
    if (is.null(resultado_json)) {
      return()
    }
    
    resultado <- jsonlite::fromJSON(resultado_json)
    print(resultado)  # Verifique o resultado
    
    output$resultado_adverbio <- renderPrint({
      cat("Advérbios:\n")
      for (adverbio in names(resultado$adverbios)) {
        cat(adverbio, ":", resultado$adverbios[[adverbio]], "\n")
      }
    })
    
    output$downloadJson_adverbio <- downloadHandler(
      filename = function() {
        paste("resultado_adverbio", ".json", sep = "")
      },
      content = function(file) {
        writeLines(resultado_json, file)
      }
    )
  }
  
  observeEvent(input$processar_adverbio, {
    texto <- NULL
    
    if (!is.null(input$file_adverbio)) {
      cat("Arquivo carregado: ", input$file_adverbio$datapath, "\n")
      linhas <- readLines(input$file_adverbio$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")
    } else if (nzchar(input$texto_adverbio)) {
      texto <- input$texto_adverbio
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      processar_texto_adverbio(texto)
    } else {
      output$resultado_adverbio <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
    }
  })
  
  processar_texto_coleman <- function(texto) {
    resultado_json <- py$calcular_coleman_liau(texto)
    resultado <- jsonlite::fromJSON(resultado_json)
    
    output$resultado_coleman <- renderPrint({
      cat(paste("Índice de legibilidade:", resultado$grade, "\n"))
      cat(paste("Número de letras:", resultado$numero_letras, "\n"))
      cat(paste("Número de palavras:", resultado$numero_palavras, "\n"))
      cat(paste("Número de sentenças:", resultado$numero_sentencas, "\n"))
    })
    
    output$downloadJson_coleman <- downloadHandler(
      filename = function() {
        paste("resultado_coleman", ".json", sep = "")
      },
      content = function(file) {
        writeLines(resultado_json, file)
      }
    )}
  
  observeEvent(input$processar_coleman, {
    texto <- NULL
    
    if (!is.null(input$file_coleman)) {
      linhas <- readLines(input$file_coleman$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")  # Mantém as quebras de linha
    } else if (nzchar(input$texto_coleman)) {
      texto <- input$texto_coleman
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      processar_texto_coleman(texto)
    } else {
      output$resultado_coleman <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
    }
  })
  
  processar_texto_diversidade <- function(texto) {
    resultado_json <- py$diversidade_lexical(texto)
    resultado <- jsonlite::fromJSON(resultado_json)
    
    output$resultado_diversidade <- renderPrint({
      cat(paste("Número total de palavras:", resultado$numero_palavras, "\n"))
      cat(paste("Número de palavras únicas:", resultado$numero_unicas, "\n"))
      cat(paste("Diversidade lexical:", resultado$diversidade_lexical, "\n"))
    })
    
    output$downloadJson_diversidade <- downloadHandler(
      filename = function() {
        paste("resultado_diversidade", ".json", sep = "")
      },
      content = function(file) {
        writeLines(resultado_json, file)
      }
    )}
  
  observeEvent(input$processar_diversidade, {
    texto <- NULL
    
    if (!is.null(input$file_diversidade)) {
      linhas <- readLines(input$file_diversidade$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")  # Mantém as quebras de linha
    } else if (nzchar(input$texto_diversidade)) {
      texto <- input$texto_diversidade
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      processar_texto_diversidade(texto)
    } else {
      output$resultado_diversidade <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
    }
  })
  
  processar_texto_densidade <- function(texto) {
    resultado_json <- py$densidade_lexical(texto)
    resultado <- jsonlite::fromJSON(resultado_json)
    
    output$resultado_densidade <- renderPrint({
      cat(paste("Número total de palavras:", resultado$numero_palavras, "\n"))
      cat(paste("Número de palavras de conteúdo:", resultado$numero_semantico, "\n"))
      cat(paste("Densidade lexical:", resultado$densidade_lexical, "\n"))
    })
    
    output$downloadJson_densidade <- downloadHandler(
      filename = function() {
        paste("resultado_densidade", ".json", sep = "")
      },
      content = function(file) {
        writeLines(resultado_json, file)
      }
    )}
  
  observeEvent(input$processar_densidade, {
    texto <- NULL
    
    if (!is.null(input$file_densidade)) {
      linhas <- readLines(input$file_densidade$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")  # Mantém as quebras de linha
    } else if (nzchar(input$texto_densidade)) {
      texto <- input$texto_densidade
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      processar_texto_densidade(texto)
    } else {
      output$resultado_densidade <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
    }
  })
  
  processar_texto_sofisticacao <- function(texto) {
    resultado_json <- py$sofisticacao_lexical(texto)
    resultado <- jsonlite::fromJSON(resultado_json)
    
    output$resultado_sofisticacao <- renderPrint({
      cat(paste("Número total de palavras:", resultado$numero_palavras, "\n"))
      cat(paste("Número total de palavras funcionais (únicas):", resultado$numero_funcionais, "\n"))
      cat(paste("Número total de palavras de conteúdo (únicas):", resultado$numero_semantico_unico, "\n"))
      cat(paste("Sofisticação lexical:", resultado$sofisticacao_lexical, "\n"))
      
    })
    
    output$downloadJson_sofisticacao <- downloadHandler(
      filename = function() {
        paste("resultado_sofisticacao", ".json", sep = "")
      },
      content = function(file) {
        writeLines(resultado_json, file)
      }
    )}
  
  observeEvent(input$processar_sofisticacao, {
    texto <- NULL
    
    if (!is.null(input$file_sofisticacao)) {
      linhas <- readLines(input$file_sofisticacao$datapath, warn = FALSE)
      texto <- paste(linhas, collapse = "\n")  # Mantém as quebras de linha
    } else if (nzchar(input$texto_sofisticacao)) {
      texto <- input$texto_sofisticacao
    }
    
    if (!is.null(texto) && nzchar(texto)) {
      processar_texto_sofisticacao(texto)
    } else {
      output$resultado_sofisticacao <- renderPrint({
        cat("Por favor, insira ou carregue um texto para análise.")
      })
    }
  })
}
shinyApp(ui, server)
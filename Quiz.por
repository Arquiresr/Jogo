programa
{



	inclua biblioteca Calendario --> calen
	inclua biblioteca Tipos --> tp
	inclua biblioteca Sons --> s
	inclua biblioteca Util --> ut
	inclua biblioteca Texto --> txt
	inclua biblioteca Arquivos --> arq

		 cadeia caminho_arquivo = "./quiz.txt"
		 inteiro arquivo = arq.abrir_arquivo(caminho_arquivo, arq.MODO_LEITURA)
		 
		 //Variável para música
		 cadeia musica2 = "./introducao.mp3"
		 cadeia musica1 = "./1.mp3"
		 cadeia musica = "./nao-fica-ansiosinho.mp3"
		 //Variáveis referente ao nome do jogador e resposta (do início do quiz)
		 cadeia nome
		 caracter resposta
		 
		 //Variáveis auxiliares
		 inteiro contador = 0, contador2 = 0, aux = 0
		 
		 //Variável para a contagem de caracteres de cada linha
		 inteiro contador_caracter[100]
		 
		 //Vetores para armazenar posições dos pipes
		 inteiro posicao_tema[100], posicao_resp_correta[100], posicao_alternativa1[100], posicao_alternativa2[100]
		 inteiro posicao_alternativa3[100], posicao_alternativa4[100]
		 
		 //Vetores guardar todas as informações de cada linha
		 cadeia linha[100], pergunta[100], tema_cadeia[100], resposta_correta[100]
		 cadeia alternativa1[100], alternativa2[100], alternativa3[100], alternativa4[100]
		 inteiro resposta_corretaI[100]
		 
		 //Variáveis referentes ao tema
		 inteiro temaI, qtde_perguntas
           cadeia linhas_selecionadas[10]
           
           //Variáveis referente ao sorteio das perguntas
		 inteiro numero_aleatorio, numeros_sorteados[10]
		 logico numeros_iguais = verdadeiro

		 //Variáveis que serão exibidas ao jogador
           cadeia perguntas[10], tema = "", alter1[10], alter2[10], alter3[10], alter4[10]
           inteiro resp_correta[10], resposta_usuario[10], contador_acertos = 0, contador_erros = 0
           real porcentagem_acertos = 0.0
           funcao arquirvo()
           {
           	   //Laço para armarzenar tudo presente dentro do arquivo texto
           enquanto(contador != 100){

           	//armazenar todos as linhas do arquivo no vetor 'linha'
 		     linha[contador] = arq.ler_linha(arquivo)
 		     contador_caracter[contador] = txt.numero_caracteres(linha[contador])

 		     se(contador_caracter[contador] != 0){
               
               //Obter a posição dos dois primeiros pipes
 		     posicao_tema[contador] = txt.posicao_texto("|", linha[contador], 0)
 		     posicao_resp_correta[contador] = txt.posicao_texto("|", linha[contador], posicao_tema[contador] + 1)

               //Armazenar a pergunta e o tema
 		     pergunta[contador] = txt.extrair_subtexto(linha[contador], 0, posicao_tema[contador])
 		     tema_cadeia[contador] = txt.extrair_subtexto(linha[contador], posicao_tema[contador]+1, posicao_resp_correta[contador])

               //Obter a posição do terceiro pipe e armazenar a resposta correta 
 		     posicao_alternativa1[contador] = txt.posicao_texto("|", linha[contador], posicao_resp_correta[contador]+1)
 		     resposta_correta[contador] = txt.extrair_subtexto(linha[contador], posicao_resp_correta[contador]+2, posicao_alternativa1[contador]-1)
               resposta_corretaI[contador] = tp.cadeia_para_inteiro(resposta_correta[contador], 10)
               
               //Obter a posição do quarto pipe e armazenar a primeira alternativa
 		     posicao_alternativa2[contador] = txt.posicao_texto("|", linha[contador], posicao_alternativa1[contador]+1)
 		     alternativa1[contador] = txt.extrair_subtexto(linha[contador], posicao_alternativa1[contador]+1, posicao_alternativa2[contador])

               //Obter a posição do quinto pipe e armazenar segunda alternativa
 		     posicao_alternativa3[contador] = txt.posicao_texto("|", linha[contador], posicao_alternativa2[contador]+1)
 		     alternativa2[contador] = txt.extrair_subtexto(linha[contador], posicao_alternativa2[contador]+1, posicao_alternativa3[contador])

               //Obter a posição do último pipe e armazenar terceira alternativa
 		     posicao_alternativa4[contador] = txt.posicao_texto("|", linha[contador], posicao_alternativa3[contador]+1)
 		     alternativa3[contador] = txt.extrair_subtexto(linha[contador], posicao_alternativa3[contador]+1, posicao_alternativa4[contador])

               //Armazenar a última alternativa
 		     alternativa4[contador] = txt.extrair_subtexto(linha[contador], posicao_alternativa4[contador]+1, contador_caracter[contador])   
 		     	}
 		     contador++
          	}
           	
           }
           funcao menu(){
           	       faca{
	     	
          	 escreva("\n( 1 ) ", tema_cadeia[0])
           	 escreva("\n( 2 ) ", tema_cadeia[10])
           	 escreva("\n( 3 ) ", tema_cadeia[20], "\n")
           	 
           	 leia(temaI)
	     	 }enquanto(temaI > 5 ou temaI < 1)
	      escreva("\nÓtima escolha!")
           }
	funcao inicio()
	{
		
	
           
           escreva("Deseja começar o quiz?(S/N): ")
           leia(resposta)
           
             arquirvo()
        
   	        
           //Laço principal do jogo
           enquanto(resposta == 'S' ou resposta == 's'){
            	
           nome = introducao()

           //Esvaziar todos os vetores finais
           para(contador = 0; contador!= 10; contador++){
           	perguntas[contador] = ""
           	alter1[contador] = ""
           	alter2[contador] = ""
           	alter3[contador] = ""
           	alter4[contador] = ""
           	resp_correta[contador] = 0
           	resposta_usuario[contador] = 0
           	}
           	contador_erros = 0
           	contador_acertos = 0

           //Música
           s.carregar_som(musica1)
           s.reproduzir_som(s.carregar_som(musica1), verdadeiro)
           s.definir_volume(90)
            s.reproduzir_som(s.carregar_som(musica1), falso)
           //Exibindo o tema
             menu()
           //Solicitando a quantidade de perguntas a serem feitas
           escreva("\nDigite a quantidade de perguntas desejadas para o tema escolhido\n ps:numeros gerado é 5 ate 10 ==>: ")
           leia(qtde_perguntas)
           
           se(qtde_perguntas <= 4 ou qtde_perguntas > 10){
           	enquanto(qtde_perguntas <= 4 ou qtde_perguntas > 10){
           		escreva("\nO mínimo é 5 e o máximo é 10!")
           		escreva("\nDigite novamente!\n")
           		leia(qtde_perguntas)
           		}
           	}

           limpa()
           
		//Selecionando o tema e armazenando todos os dados
		aux = 0
		contador2 = 100
           escolha(temaI){
           	
           	caso 1:
           		para(contador = 0; contador <= 9; contador++){
           			linhas_selecionadas[contador] = linha[contador]
           			perguntas[contador] = pergunta[contador]
           			tema = tema_cadeia[1]
           			resp_correta[contador] = resposta_corretaI[contador]
           			alter1[contador] = alternativa1[contador]
           			alter2[contador] = alternativa2[contador]
           			alter3[contador] = alternativa3[contador]
           			alter4[contador] = alternativa4[contador]
           			}
           	pare

           	caso 2:
           		para(contador = 10; contador <= 19; contador++){
           			linhas_selecionadas[aux] = linha[contador]
           			perguntas[aux] = pergunta[contador]
           			tema = tema_cadeia[11]
           			resp_correta[aux] = resposta_corretaI[contador]
           			alter1[aux] = alternativa1[contador]
           			alter2[aux] = alternativa2[contador]
           			alter3[aux] = alternativa3[contador]
           			alter4[aux] = alternativa4[contador]
           			aux++
           			}
           	pare

           	caso 3:
           		para(contador = 20; contador <= 29; contador++){
           			linhas_selecionadas[aux] = linha[contador]
           			perguntas[aux] = pergunta[contador]
           			tema = tema_cadeia[21]
           			resp_correta[aux] = resposta_corretaI[contador]
           			alter1[aux] = alternativa1[contador]
           			alter2[aux] = alternativa2[contador]
           			alter3[aux] = alternativa3[contador]
           			alter4[aux] = alternativa4[contador]
           			aux++
           			}
           	pare

           	caso 4:
           		para(contador = 30; contador <= 39; contador++){
           			linhas_selecionadas[aux] = linha[contador]
           			perguntas[aux] = pergunta[contador]
           			tema = tema_cadeia[31]
           			resp_correta[aux] = resposta_corretaI[contador]
           			alter1[aux] = alternativa1[contador]
           			alter2[aux] = alternativa2[contador]
           			alter3[aux] = alternativa3[contador]
           			alter4[aux] = alternativa4[contador]
           			aux++
           			}
           	pare

           	caso 5:
           		para(contador = 40; contador <= 49; contador++){
           			linhas_selecionadas[aux] = linha[contador]
           			perguntas[aux] = pergunta[contador]
           			tema = tema_cadeia[41]
           			resp_correta[aux] = resposta_corretaI[contador]
           			alter1[aux] = alternativa1[contador]
           			alter2[aux] = alternativa2[contador]
           			alter3[aux] = alternativa3[contador]
           			alter4[aux] = alternativa4[contador]
           			aux++
           			}
           	pare

           	caso 6:
           		para(contador = 50; contador <= 59; contador++){
           			linhas_selecionadas[aux] = linha[contador]
           			perguntas[aux] = pergunta[contador]
           			tema = tema_cadeia[51]
           			resp_correta[aux] = resposta_corretaI[contador]
           			alter1[aux] = alternativa1[contador]
           			alter2[aux] = alternativa2[contador]
           			alter3[aux] = alternativa3[contador]
           			alter4[aux] = alternativa4[contador]
           			aux++
           			}
           	pare

           	caso 7:
           		para(contador = 60; contador <= 69; contador++){
           			linhas_selecionadas[aux] = linha[contador]
           			perguntas[aux] = pergunta[contador]
           			tema = tema_cadeia[61]
           			resp_correta[aux] = resposta_corretaI[contador]
           			alter1[aux] = alternativa1[contador]
           			alter2[aux] = alternativa2[contador]
           			alter3[aux] = alternativa3[contador]
           			alter4[aux] = alternativa4[contador]
           			aux++
           			}
           	pare

           	caso 8:
           		para(contador = 70; contador <= 79; contador++){
           			linhas_selecionadas[aux] = linha[contador]
           			perguntas[aux] = pergunta[contador]
           			tema = tema_cadeia[71]
           			resp_correta[aux] = resposta_corretaI[contador]
           			alter1[aux] = alternativa1[contador]
           			alter2[aux] = alternativa2[contador]
           			alter3[aux] = alternativa3[contador]
           			alter4[aux] = alternativa4[contador]
           			aux++
           			}
           	pare

           	caso 9:
           		para(contador = 80; contador <= 89; contador++){
           			linhas_selecionadas[aux] = linha[contador]
           			perguntas[aux] = pergunta[contador]
           			tema = tema_cadeia[81]
           			resp_correta[aux] = resposta_corretaI[contador]
           			alter1[aux] = alternativa1[contador]
           			alter2[aux] = alternativa2[contador]
           			alter3[aux] = alternativa3[contador]
           			alter4[aux] = alternativa4[contador]
           			aux++
           			}
           	pare

           	caso 10:
           		para(contador = 90; contador <= 99; contador++){       			
           			linhas_selecionadas[aux] = linha[contador]
           			perguntas[aux] = pergunta[contador]
           			tema = tema_cadeia[91]
           			resp_correta[aux] = resposta_corretaI[contador]
           			alter1[aux] = alternativa1[contador]
           			alter2[aux] = alternativa2[contador]
           			alter3[aux] = alternativa3[contador]
           			alter4[aux] = alternativa4[contador]
           			aux++
           			}
           	pare
           	}
           	
           contador = 0
           
           enquanto(contador != qtde_perguntas){
               aux = 10
               contador2 = 0
               numeros_iguais = verdadeiro
               numero_aleatorio = ut.sorteia(0, 9)

             	//Laço para forçar a sortear números diferentes
               faca{
             	    
               	enquanto(contador2 + 1 != qtde_perguntas){
               		se(numero_aleatorio == numeros_sorteados[contador2]){
               			aux--
               		}
               	contador2++
               	}
               	se(contador2 + 1 == qtde_perguntas e aux == 10){
               		numeros_iguais = falso
               		}
               	se(aux < 10){
               		numero_aleatorio = ut.sorteia(0, 9)

             	          aux = 10
             	          contador2 = 0
               		}
               		
               }enquanto(numeros_iguais == verdadeiro)

               numeros_sorteados[contador] = numero_aleatorio
            
           	escolha(numero_aleatorio){

           		//Sortear pergunta 1
           		caso 0: escreva(perguntas[0])
                            escreva("\n", alter1[0])
                            escreva("\n", alter2[0])
                            escreva("\n", alter3[0])
                            escreva("\n", alter4[0])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[0])
                            se(resposta_usuario[0] > 4 ou resposta_usuario[0] <= 0){
                            	resposta_usuario[0] = validar_resposta(resposta_usuario[0])
                            	}
                            limpa()           		
           			pare

				//Sortear pergunta 2
           		caso 1: escreva(perguntas[1])
                            escreva("\n", alter1[1])
                            escreva("\n", alter2[1])
                            escreva("\n", alter3[1])
                            escreva("\n", alter4[1])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[1])
                            se(resposta_usuario[1] > 4 ou resposta_usuario[1] <= 0){
                            	resposta_usuario[1] = validar_resposta(resposta_usuario[1])
                            	}
                            limpa()
           			pare

				//Sortear pergunta 3
           		caso 2: escreva(perguntas[2])
                            escreva("\n", alter1[2])
                            escreva("\n", alter2[2])
                            escreva("\n", alter3[2])
                            escreva("\n", alter4[2])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[2])
                            se(resposta_usuario[2] > 4 ou resposta_usuario[2] <= 0){
                            	resposta_usuario[2] = validar_resposta(resposta_usuario[2])
                            	}
                            limpa()
           			pare

				//Sortear pergunta 4
           		caso 3: escreva(perguntas[3])
                            escreva("\n", alter1[3])
                            escreva("\n", alter2[3])
                            escreva("\n", alter3[3])
                            escreva("\n", alter4[3])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[3])
                            se(resposta_usuario[3] > 4 ou resposta_usuario[3] <= 0){
                            	resposta_usuario[3] = validar_resposta(resposta_usuario[3])
                            	}
                            limpa()
           			pare

				//Sortear pergunta 5
           		caso 4: escreva(perguntas[4])
                            escreva("\n", alter1[4])
                            escreva("\n", alter2[4])
                            escreva("\n", alter3[4])
                            escreva("\n", alter4[4])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[4])
                            se(resposta_usuario[4] > 4 ou resposta_usuario[4] <= 0){
                            	resposta_usuario[4] = validar_resposta(resposta_usuario[4])
                            	}
                            limpa()
           			pare
				
				//Sortear pergunta 6
           		caso 5: escreva(perguntas[5])
                            escreva("\n", alter1[5])
                            escreva("\n", alter2[5])
                            escreva("\n", alter3[5])
                            escreva("\n", alter4[5])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[5])
                            se(resposta_usuario[5] > 4 ou resposta_usuario[5] <= 0){
                            	resposta_usuario[5] = validar_resposta(resposta_usuario[5])
                            	}
                            limpa()
           			pare

				//Sortear pergunta 7
           		caso 6: escreva(perguntas[6])
                            escreva("\n", alter1[6])
                            escreva("\n", alter2[6])
                            escreva("\n", alter3[6])
                            escreva("\n", alter4[6])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[6])
                            se(resposta_usuario[6] > 4 ou resposta_usuario[6] <= 0){
                            	resposta_usuario[6] = validar_resposta(resposta_usuario[6])
                            	}
                            limpa()
           			pare

				//Sortear pergunta 8
           		caso 7: escreva(perguntas[7])
                            escreva("\n", alter1[7])
                            escreva("\n", alter2[7])
                            escreva("\n", alter3[7])
                            escreva("\n", alter4[7])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[7])
                            se(resposta_usuario[7] > 4 ou resposta_usuario[7] <= 0){
                            	resposta_usuario[7] = validar_resposta(resposta_usuario[7])
                            	}
                            limpa()
           			pare
				
				//Sortear pergunta 9
           		caso 8: escreva(perguntas[8])
                            escreva("\n", alter1[8])
                            escreva("\n", alter2[8])
                            escreva("\n", alter3[8])
                            escreva("\n", alter4[8])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[8])
                            se(resposta_usuario[8] > 4 ou resposta_usuario[8] <= 0){
                            	resposta_usuario[8] = validar_resposta(resposta_usuario[8])
                            	}
                            limpa()
           			pare
				
				//Sortear pergunta 10
           		caso 9: escreva(perguntas[9])
                            escreva("\n", alter1[9])
                            escreva("\n", alter2[9])
                            escreva("\n", alter3[9])
                            escreva("\n", alter4[9])

                            escreva("\nSua resposta: ")
                            leia(resposta_usuario[9])
                            se(resposta_usuario[9] > 4 ou resposta_usuario[9] <= 0){
                            	resposta_usuario[9] = validar_resposta(resposta_usuario[9])
                            	}
                            limpa()
           			pare
           		
           		}
           		//Caso a resposta do usuário esteja certa, incrementar na variável contador_acertos
           		verificar()
           			contador++
           			se(	contador_erros == 3){
			escreva("Acabou o jogo!!!!!")
			pare
		}
           }

   

           //Mostrar as estastísticas
           escreva("\nQuantidade de acertos: ", contador_acertos)
           escreva("\nQuantidade de erros: ", contador_erros)

           porcentagem_acertos = (tp.inteiro_para_real(contador_acertos)*100)/tp.inteiro_para_real(qtde_perguntas)
           escreva("\nPorcentagem de acertos: ", porcentagem_acertos, "%") 

      

           //Perguntar se o jogador deseja jogar novamente
           escreva("\nDeseja jogar novamente?(S/N): ")
           leia(resposta)
    
           }
          limpa()
          escreva("Até mais!") 
          arq.fechar_arquivo(arquivo)
	}
	funcao verificar(){
		se(resposta_usuario[numero_aleatorio] == resp_correta[numero_aleatorio]){
           			escreva("acertou!!!\n acerto: ",contador_acertos,"\n") 
           			contador_acertos++
           		
           			   s.carregar_som(musica2)
           			//Musica da vitoria
                            s.reproduzir_som(s.carregar_som(musica2), verdadeiro)
                               s.definir_volume(90)
                                 s.reproduzir_som(s.carregar_som(musica2), falso)
           			}
           		//Caso a resposta do usuário esteja errada, incrementar na variável contador_erros	
           		se(resposta_usuario[numero_aleatorio] != resp_correta[numero_aleatorio]){
           				
           				escreva("erro!!!\n acerto: ",contador_erros) 
           				contador_erros++
           				//musica da derrota
           				s.reproduzir_som(s.carregar_som(musica), verdadeiro)
                               s.definir_volume(100)
                                 s.reproduzir_som(s.carregar_som(musica), falso)
           		}
	}

     //Funcão que retorna o nome do jogador
	funcao cadeia introducao(){
		cadeia nome

		limpa()
		
		escreva("\nDigite seu nome: ")
		leia(nome)
	     escreva("\nO jogo irá começar!")        	 
	     ut.aguarde(2000)
	     limpa()
	        escreva("\t*==========================================================================================================*\n")
    escreva("\t|                     Seja bem-vindo ",nome," ao Quiz do xandão!                                           |\n")
    escreva("\t|  Este e um jogo divertido de perguntas e respostas.Em que o jogador poderá escolher o assunto desejado.  |\n")
    escreva("\t*==========================================================================================================*\n")
    escreva("\t|              Escolha o Assunto desejado e em seguida aperte enter.                                       |\n")
	
	
	     retorne nome
	}
     
     //Função para validar as respostas dentro de cada questão do Quiz
     funcao inteiro validar_resposta(inteiro resposta_usuario){
     	   	enquanto(resposta_usuario > 4 ou resposta_usuario <= 0){
     	   		escreva("\nRESPOSTA INVÁLIDA! Só é aceito respostas entre 1 e 4.")
     	   		escreva("\nSua nova resposta: ")
     	   		leia(resposta_usuario)
     	   		}
     	   	retorne resposta_usuario	
     	}
	
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 4494; 
 * @DOBRAMENTO-CODIGO = [53, 145, 157, 301];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
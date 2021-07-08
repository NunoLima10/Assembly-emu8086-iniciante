;DIEGO DONOVAN SILVA SOUSA LEIT 1 ANO 2 SEMESTRE
;NUNO JORGE GOMES LIMA     LEIT 1 ANO 2 SEMESTRE
; TERMINADO DIA 27/06/2021

ORG 100H
.STACK 100H
.DATA 


;opcoes de menu                                                       
    MSG_MENU        DB 10D,13D,"                     MENU             ",     "$"
    MSG_INSERIR     DB 10D,13D,"01.INSERIR NOTAS DOS ALUNOS",                "$"     ;inserir notas turmas
    MSG_MELHOR_PIOR DB 10D,13D,"02.VER MELHOR/PIOR NOTA",                    "$"     ;melhor e pior nota
    MSG_ETD_MP      DB 10D,13D,"03.VER ESTUDANTES NOTA MAIS ALTA/MAIS BAIXA","$"     ;ver numero de estudante nota mais alta/baixa
    MSG_NUM_APR     DB 10D,13D,"04.QUANTIDADE APROVADOS",                    "$"     ;quantidade aprovados 
    MSG_MEDIA_T     DB 10D,13D,"05.MEDIA DA TURMA",                          "$"     ;ver media da turma
    MSG_NUM         DB 10D,13D,"06.NUMERO DOS ESTUDANTES APROVADOS",         "$"     ;determinar numero de cada estudante aprovado
    MSG_PESQ_ALU    DB 10D,13D,"07.PESQUISAR ALUNO",                         "$"     ;pesquisar aluno mediante o numero
    MSG_DECRE       DB 10D,13D,"08.ORDENAR NOTAS POR ORDEM DECRESCENTE",     "$"     ;ver notas por ordem decrescente 
    MSG_IMPRI       DB 10D,13D,"09.ENVIAR LISTA IMPRESSORA",                 "$"     ;enviar lista estudantes para impressora
    MSG_SAIR        DB 10D,13D,"10.SAIR",                                    "$"     ;sair
    MSG_PESQ_ALU2   DB 10D,13D,"07.PESQUISAR ALUNO (01) A (10)",             "$"
    
;mensagens    
    MSG_CONT        DB 10D,13D,"CONTINUAR...<ENTER>"          ,             "$"     ;mostrar para continuar  
    MSG_MNOTA       DB 10D,13D,"MELHOR NOTA: "                ,             "$"     ;pior nota
    MSG_PNOTA       DB 10D,13D,"PIOR NOTA:   "                ,             "$"     ;mostrar para continuar
    MSG_NOTAPRO     DB 10D,13D,"NUMERO DE APROVADOS:"         ,             "$"    
    MSG_NUMPRO      DB 10D,13D,"NUMERO DOS APROVADOS:"        ,             "$"
    
    MSG_ESCOLHA_OP        DB 10D,13D,"ESCOLHA OPERACAO A REALIZAR: ",             "$"     ;escolher opcao  
    MSG_COM_TURMA   DB 10D,13D,"NENHUMA TURMA REGISTRADA",                  "$"      
    MSG_MEDIA       DB 10D,13D,"A MEDIA DA TURMA: ",                        "$"     ;media da turma
    MSG_LOCALIZAR   DB 10D,13D,"ENTRE NUMERO ALUNO:" ,                      "$"
    MSG_ALUN_PROCU  DB 10D,13D,"NOTA ALUNO PROCURADO:" ,                    "$"     ;aluno procurado 
    MSG_REPETIR     DB 10D,13D,"PROCURAR NOVO ALUNO [S]:"  ,                "$"                                   
    MSG_NUMERO_BN   DB 10D,13D,"ESTUDANTES COM NOTA MAIS ALTA:   " ,        "$"     ;numero de estudantes com nota mais alta
    MSG_NUMERO_WN   DB 10D,13D,"ESTUDANTES COM NOTA MAIS BAIXA:  " ,        "$"
    MSG_APROVADO    DB         " APROVADO"                         ,        "$"
    MSG_REPROVADO   DB         " REPROVADO"                        ,        "$"
    MSG_PROCESSANDO DB 10D,13D," PROCESSANDO"                      ,        "$"
    MSG_RNOTA       DB 10D,13D,"INSERIR NOTA: ",                            "$"
    MSG_INV         DB 10D,13D,"INVALIDO",                                  "$"
    
    
;"formatar"
    SEP             DB 10D,13D,"==============================================",      "$"   
    LINBRA          DB 10D,13D,"",                                                    "$"
    LIMPAR          DB 10D,13D,"                                                ",    "$"


;variaveis 

    NOTAS           DB 10 DUP(?)  ;vetor de notas
    ORDNOTA         DB 10 DUP(?)  ;notas ordenadas
    INDICE          DB 1D         ;indice usado para ordenacao 
    NALUNOS         EQU 10D       ;constante numero de alunos
    OPCAO           DB 1D
    MELHOR_NOTA     DB 1D         
    PIOR_NOTA       DB 1D  
    NUMERO_APROV    DB 1D         ;contador de numero de aprovados                              
    COM_TURMA       DB 1D         ;verificar se ja tem turma                                           
    SOMA_TOTAL      DW 1D         ;soma total das notas
    MEDIA           DB 1D 
    RESTO_MEDIA     DB 1D 
    ID_APROVADO     DW 1D
 
;fim variaveis 

.CODE                                                                          

MOV COM_TURMA,0H   ;inicialmente sem turma

JMP INICIO         ;mais ou menos na linha 1350
           
;Abaixo todos os procedimentos usados 

;menu mostra o menu
;pede a opecao
;verifica se valido e guarda 


    MENU PROC  
        ;Mostrar todo o menu
        
        CALL SEPARADOR 

        LEA DX,MSG_MENU
        MOV AH,09H
        INT 21H  
        
        CALL SEPARADOR
        
        LEA DX,MSG_INSERIR ;1
        MOV AH,09H
        INT 21H
        
        CALL ESPACO
        
        LEA DX,MSG_MELHOR_PIOR ;2
        MOV AH,09H
        INT 21H 
        
        CALL ESPACO
        
        LEA DX,MSG_ETD_MP ;3
        MOV AH,09H
        INT 21H  
        
        CALL ESPACO
        
        LEA DX,MSG_NUM_APR ;4
        MOV AH,09H
        INT 21H    
        
        CALL ESPACO
        
        LEA DX,MSG_MEDIA_T ;5
        MOV AH,09H
        INT 21H     
        
        CALL ESPACO
        
        LEA DX,MSG_NUM ;6
        MOV AH,09H
        INT 21H  
        
        CALL ESPACO
        
        LEA DX,MSG_PESQ_ALU ;7
        MOV AH,09H
        INT 21H   
        
        CALL ESPACO
        
        LEA DX,MSG_DECRE ;8
        MOV AH,09H
        INT 21H   
        
        CALL ESPACO
        
        LEA DX,MSG_IMPRI ;9
        MOV AH,09H
        INT 21H   
        
        CALL ESPACO
        
        LEA DX,MSG_SAIR ;10
        MOV AH,09H
        INT 21H
        
        CALL SEPARADOR
        
        ;receber opecao
        
        RECEBER_OP:
         
            LEA DX,MSG_ESCOLHA_OP ;escolher opcao
            MOV AH,09H
            INT 21H 
             
            ;receber opcao
            MOV BH,0AH
            MOV AH,01H
            INT 21H  
            
           
            ;verificar se e numero valido 
            
    
            CMP AL,30H
            JB  INVALIDO_MENU  ;se ascii menor que 0
           
            CMP AL,31H
            JA INVALIDO_MENU   ;se ascii maior que 1    obs:maximo de 01 a 10
    
    
            LIVRE_OPECAO_MENU:
               
               MOV CL,AL ;guardar digito 1 em cl
               
    
               MOV AH,01H  ;receber segundo
               INT 21H
               
               CMP AL,30H
               JB  INVALIDO_MENU
               
               CMP AL,39H
               JA INVALIDO_MENU          ;segundo ascii de ser menor que 9  
               
               
                CMP CL,31H              ;caso o primeiro digito e 1
                JE  OPECAO10 
                
                CMP AL,30H              ;caso nao e 1 entao e 0 e segundo digito nao pode ser 0
                JE INVALIDO_MENU
                
            
                JMP CONT
         
           OPECAO10:
               CMP AL,30H               ;caso primeiro digito e 1 e obrigatorio segundo ser 0 
               JNE INVALIDO_MENU
            
               JMP CONT
     
           INVALIDO_MENU:
               CALL INVAL
               JMP RECEBER_OP
 
        CONT:
        
        
             MOV CH,AL ;guardar segunda opecao
             
             SUB CL,30H  ;tansforma em hex
             SUB CH,30H 
             
             MOV AL,CL   
             
             MUL BH        ;multiplicar primeiro digito por 0Ah(10)
             
             ADD AL,CH     ;adicionar ao segundo digito
                        
       LEA BP,OPCAO        ;guardar a opecao 
       MOV [BP],AL
            
       RET
    MENU ENDP

;invalido
;e chamado quando usuario digite algo invalido

    
    INVAL PROC        
        CALL ESPACO
        
        LEA DX,MSG_INV
        MOV AH,09H
        INT 21H   
          
        CALL ESPACO
        RET  
    INVAL ENDP
   
   
;separador
;imprime uma linha de = na tela
 
    SEPARADOR PROC
        
        LEA DX,SEP
        MOV AH,09H
        INT 21H
        RET
        
    SEPARADOR ENDP
;espaco
;imprime uma linha em branca na tela
    
    ESPACO PROC
        LEA DX,LINBRA ;linha em branco
        MOV AH,09H
        INT 21H 
        RET
        
    ESPACO ENDP
    
;limpar
;limpa a tela

    LIMP PROC  
          
        MOV Cx ,19h  ;repetir ate limpar toda a tela (25 linhas)  

    LIMPAR_LINHA:
        ;movendo curso de posisao 
        
        MOV Ah,2h
        MOV Dl,0h  ;coluna 0
        MOV Dh,19h ;linha  25
        MOV Bl,0h  ;pagina 0

        INT 10h

        DEC DH     ;decrementa a linha todas as vezes (25-1)=24... 


        CALL ESPACO ;sobrepondo o que esta escrito com uma linha em branco


        LOOP LIMPAR_LINHA  


        CALL PRIMEIRA_LINHA ;colocar o cursor no inico    
   

       RET
        
    LIMP ENDP
    
    
;procesando 
;exibe messagem e volta a primeira linha
    
    MENSAGEM_PROCESANDO PROC
        
        
        LEA DX,MSG_PROCESSANDO
        MOV AH,09H 
        INT 21H
        CALL PRIMEIRA_LINHA
        
        RET
    MENSAGEM_PROCESANDO ENDP
;receber
;pede as notas
;faz verificasao se e valido
;guarda as notas


    
    RECEBER PROC      
        
        
        CALL SEPARADOR
        LEA DX,MSG_INSERIR ;1
        MOV AH,09H
        INT 21H
        CALL SEPARADOR
        
          
        MOV CX,0H
        MOV CX,NALUNOS    ;numero de alunos 10
        MOV BP,0H         ; indice atual do vetor notas

        RECEBENDO:
           
           LEA DX,MSG_RNOTA
           MOV AH, 09H
           INT 21H
           
           MOV BH,0AH
           MOV AH,01H
           INT 21H
                       
            ;verificar primeiro caracter nota 
        

           CMP AL,30H
           JB INVALIDONUMERO
           
           CMP AL,32H 
           JA INVALIDONUMERO
        
           
           SUB AL,30H 
           MOV BL,AL ;guardar digito 1 em bl
           
           
        PROX:             ;proximo caracter

           MOV AH,01H 
           INT 21H
           
           ;verificar segundo caracter da nota
           
           CMP AL,30H
            JB INVALIDONUMERO
           
        
           CMP AL,39H
            JA INVALIDONUMERO 
           
           CMP BL,2H       ;caso primeiro nao e 2
            JNE LIVRE
             
           
           COMPARA_DIG2:   ;caso for e obrigadorio o segundo ser 0
               CMP AL,30H
               JNE INVALIDONUMERO

               ;respeita as condicoes
               
           LIVRE:   
               SUB AL,30H ;segundo digito
               
               MOV BH,AL  ;salvar segund digito
               MOV AL,BL  ;pegar primeiro digito
               
               MOV BL,0AH
               
               MUL BL
               
               ADD BH,AL
               
               MOV NOTAS[BP],BH   ;salvar a nota o indicie atual de bp 
               MOV ORDNOTA[BP],BH 
               INC BP   
               
               CMP CL,0H
               JE FIM_RECEBER  
           
       LOOP RECEBENDO
       
       JMP FIM_RECEBER 
         
       INVALIDONUMERO:
          CALL INVAL
          JMP RECEBENDO
          
      FIM_RECEBER: 
      
      MOV COM_TURMA,01H   ;agora a turma ja foi inserida
           
       RET 
        
    RECEBER ENDP  
    
;mostrar    
;pega ms valores no vetor
;separa o resultado e  resto da divisao por 10
;mostra na impresora cada caracter    
    
    
    
    
    MOSTRAR PROC   

        CALL SEPARADOR
        
        LEA DX,MSG_IMPRI ;9
        MOV AH,09H
        INT 21H 
        

        CALL SEPARADOR 
        CALL ESPACO
        
        MOV DL,0AH
        MOV AH,02H
        INT 21H
        
        MOV DL,0DH
        MOV AH,02H
        INT 21H
        
        MOV CX,NALUNOS
        MOV BP,0H
         
        
        MOSTRAR2: 
                MOV AX,0H
                MOV BH,0AH
                MOV AL,NOTAS[BP] ;pegar a nota no indice de valor do bp
                DIV BH
                
                MOV BL,AH  ;resto
                MOV DL,AL
                ADD DL,30H
                
                MOV AH,05H  ;para mostrar na impressora
                INT 21H
                
                
                MOV DL,BL
                ADD DL,30H
                MOV AH,05H
                INT 21H
                         
                MOV DL,2DH
                MOV AH,05H
                INT 21H          
                          
                INC BP
                
 
           
        LOOP MOSTRAR2
        
        FIM_MOSTRAR:
        
            CALL ESPACO
        
            CALL ENTER
        
        RET
    MOSTRAR ENDP
;mostrar odenado
;similar ao procedimendo anterior
;pega valores do vetor ordenado 
;mostra na tela    
    
    
    
    MOSTRAR_ORDENADO PROC   
         
        
        CALL SEPARADOR
        
        LEA DX,MSG_DECRE 
        MOV AH,09H
        INT 21H    

        CALL SEPARADOR
        CALL ESPACO 
        
        MOV DL,0AH
        MOV AH,02H
        INT 21H
        
        MOV DL,0DH
        MOV AH,02H
        INT 21H
        
        MOV CX,0AH
        MOV BP,0H
        
        
        MOSTRAR_ORDENADO2: 
                MOV AX,0H
                MOV BH,0AH
                MOV AL,ORDNOTA[BP]
                DIV BH
                
                MOV BL,AH
                MOV DL,AL
                ADD DL,30H
                
                MOV AH,02H
                INT 21H
                
                
                MOV DL,BL
                ADD DL,30H
                MOV AH,02H
                INT 21H
                         
                MOV DL,2DH
                MOV AH,2H
                INT 21H          
                          
                INC BP
                CMP CL,0H ;??????????
                JE FIM_MOSTRAR
                
            
        LOOP MOSTRAR_ORDENADO2
        
        FIM_MOSTRAR_ORDENADO:
        
        CALL ESPACO
        
        CALL ENTER
        
        RET
    MOSTRAR_ORDENADO ENDP
;enter
;espera o usuario digitar algo
;depois continua   
   
       
    ENTER PROC
        CALL SEPARADOR
        
        LEA DX,MSG_CONT
        MOV AH,09H
        INT 21H
        
        MOV AH,01H
        INT 21H
        
        
        RET
    ENTER ENDP
;mp notas
;encontrar a melhor nota
;encontrar a pior nota 
;salvar na variavel



    
    
    MPNOTAS PROC 
        
        
                 
      MOV CX,NALUNOS
      MOV BP,0H
      MOV BL,NOTAS[BP]
      MOV MELHOR_NOTA,BL  ;melhor nota como primeiro
      MOV PIOR_NOTA,BL    ;pior nota como primeiro 
      
      
      ANALISE: 
        
        MOV BL,NOTAS[BP]
        MOV AL,MELHOR_NOTA
        MOV AH,PIOR_NOTA 
        
        CMP BL,AL      ;se bl e maior tem uma nova melhor nota
        JAE MAIOR_NOTA  
        
        JMP CMP_MENOR  
    
        MAIOR_NOTA:
         MOV MELHOR_NOTA,BL ;nova melhor nota passa a nota atual de bl
         
         CMP_MENOR:
         
        
         CMP BL,AH    ;se bl e menor tem uma nova menor nota
         JBE MENOR_NOTA 
         
         
         JMP SALTAR_NOTA 
         
         MENOR_NOTA: 
          MOV PIOR_NOTA,BL
         
         SALTAR_NOTA: 
         
         INC BP ;proximo elemento do vetor

     
      LOOP ANALISE
      RET
        
    MPNOTAS ENDP
 
;mostrar mp nota
;mostrar melhor nota 
;mostrar pior nota 

 
    
    
    MOSTRAR_MPNOTAS   PROC 
                 
                CALL SEPARADOR
                
                LEA DX,MSG_MELHOR_PIOR
                MOV AH,09H
                INT 21H
                
                CALL SEPARADOR
                CALL ESPACO
        
        
                LEA DX,MSG_MNOTA
                MOV AH,09H
                INT 21H
    
    
                MOV AX,0H 
                
               ;mostrar a melhor nota
                MOV BH,0AH
                MOV AL,MELHOR_NOTA
                DIV BH
                
                MOV BL,AH
                MOV DL,AL
                ADD DL,30H
                
                MOV AH,02H
                INT 21H
   
                
                MOV DL,BL
                ADD DL,30H
                MOV AH,02H
                INT 21H 
                
                CALL ESPACO 
                      
                ;mostrar pior nota
                LEA DX,MSG_PNOTA
                MOV AH,09H
                INT 21H
    
    
                MOV AX,0H
                
                
                MOV BH,0AH
                MOV AL,PIOR_NOTA
                DIV BH
                
                MOV BL,AH
                MOV DL,AL
                ADD DL,30H
                
                MOV AH,02H
                INT 21H
                
                
                MOV DL,BL
                ADD DL,30H
                MOV AH,02H
                INT 21H 
                
                CALL ESPACO
                       
      
      CALL ENTER
      RET  
      MOSTRAR_MPNOTAS  ENDP
;quanta
;calcula a quantidade de aprovados
;e mostra na tela



        
      QUANTA PROC     
        
          
        MOV BP,0H
        
        MOV NUMERO_APROV,0H
        MOV BH,NUMERO_APROV      ;numero  de aprovados
        MOV CX,NALUNOS 
        
        CONTAR:
        
             MOV BL,NOTAS[BP]
             CMP BL,0AH          ;notas maiores que 10
             JAE CONTA
             
             JMP SEM_QUANTA       
             
            CONTA:
             INC BH
             
             MOV NUMERO_APROV,BH
             
            SEM_QUANTA:
                INC BP
             
        LOOP CONTAR 
     
        
            CALL SEPARADOR
        
            LEA DX,MSG_NUM_APR
            MOV AH,09H
            INT 21H
            CALL SEPARADOR 
        
            CALL ESPACO
        
            LEA DX,MSG_NOTAPRO
            MOV AH,09H
            INT 21H 
        
            CMP BH,0AH   ;se todos passaram
            JE IGUAL10
       
        
        
            MOV DL,NUMERO_APROV
            ADD DL,30H
            MOV AH,02H
            INT 21H
        
            CALL ESPACO
        
            JMP FIMIGUAL10 
        
        IGUAL10:
            MOV DL,31H
            MOV AH,02H
            INT 21H
         
            MOV DL,30H
            MOV AH,02H
            INT 21H  
        
            CALL ESPACO 
         
         
         FIMIGUAL10:
        
        CALL ENTER  
        
        RET
    QUANTA ENDP 
      
;primeira linha
;coloca o cursor na primeira linha      
           
        
    PRIMEIRA_LINHA PROC
            
              MOV AX,0H 
              MOV BX,0H
              
              MOV AH,02H 
              MOV DL,0H ;coluna 0
              MOV DH,0H ;linha  0
              MOV BL,0H ;pagina 0
              
              INT 10H
              
              
              RET
            
            
     PRIMEIRA_LINHA ENDP
;ordena o vetor de notas
;usando algoritimo de selecao



        
     ORDENACAO Proc
                   
        CALL MENSAGEM_PROCESANDO           
                   
        MOV CX,NALUNOS 
        DEC CX      ;porque comesamos apartir do indice 1   
        MOV BP,0h   ;indice maior elemento
        MOV AH,0h
        MOV INDICE,AH
        MOV BX,1h  ;indice atual,comecar apartir do 1
    
        PERCORRER: 
    
    
           MOV AX,0h    
           MOV AL,INDICE  ;pegar valor do indice
           MOV BP ,AX     ;colocar em Bp ,que e indice menor elemento ja ordenado
              
           INC AX         ;adicionar 1 em ax
           MOV BX,AX      ;nao a nessecidade de compara indices iguais,comecar no proximo
             
           MOV DL,NALUNOS 
           MOV Dh,0h     ;garantir que dh esta em 0h
           SUB DX,AX     ;subtrair numero total de alunos pelo indice onde vai comecar a procurar
                         ;nao a nesseciade de passar por partes do vetor que ja estao ordenados para encontrar o novo o maior elemento
    
        ENCMENOR:
           ;passar pelo vetor e encontar o novo maior  elemento 
            
            
            
           ;bp tem inidice do maior elemento atual            caso de inicio bp=0
           ;bx tem o indice atual da comparacoa com o vetor   caso de inicio bx=1
    
           MOV AH,ORDNOTA[BP]  ;[0]000000000  no caso do inicio
           MOV AL,ORDNOTA[BX]  ;0[0]00000000
    
    
           CMP AL,AH          ;comparar indice atual com maior elemento caso for maior a uma troca  
           JAE TROCAR
    
           JMP SEMTROCA       ; caso nao sem troca
    
    
        TROCAR:
    
            MOV BP,BX         ;bp passa a ser o valor de atual de bx que e o novo maior encontrado 
    
        SEMTROCA: 
            INC BX            ;caso nao aja troca bx avanca para proxima posisao 
            DEC DL            
    
            CMP DL,0h         ;continua procurando o maior caso dl nao for 0 ou seja nao chegou no fim do vetor
             JNE ENCMENOR 
    
    
        ;encontrou o maior,agora fazer as trocas de posisao o maior elemento de todos sera colocado o indice 0
        
        
        TROCARPOS: 
    
            MOV AH,ORDNOTA[BP]  ;bp tem o inidice do maior valor
            MOV BX,0h
            MOV Bl,INDICE       ;indice guarda ate onde vetor ja foi ordenado,caso do inicio e 0 por ainda nao ordenou nada      
     
            MOV AL,ORDNOTA[BX]  ;bx tem valor do inidice atual caso do inicio e 0 
           
            MOV ORDNOTA[BX],AH  ;mover o valor do maior elemento para a posisao do inidice,(maior elemento do vetor e colocado no indice 0) 
            MOV ORDNOTA[BP],AL  ;mover o valor do indice onde colocado maior elemento  para o inidice onde o maior elemento estava   
    
    
            MOV AX,0h
            MOV AL,INDICE
            INC AL              ;caso do inidice inical e 0 agora passa ser 1,proximo maior elemento sera colocado em indice 1
            MOV INDICE, AL 
    

            LOOP PERCORRER     ;e percorido ate passar por todos os alunos
    
            CALL MOSTRAR_ORDENADO
    
        
            RET
      ORDENACAO ENDP   
;soma media
;percorre todo vetor
;soma todas as notas
;divide pelo numero de alunos
;mostra na tela



        
      SOMA_MEDIA  PROC 
            CALL SEPARADOR
     
            LEA DX,MSG_MEDIA_T
            MOV AH,09H
            INT 21H
     
            CALL SEPARADOR
            CALL ESPACO   
   
            MOV BP,0H
            MOV CX,NALUNOS
            MOV SOMA_TOTAL,0H
            MOV AX,0H 
            
            SOMA:
     
                MOV AL,NOTAS[BP]
     
                ADD SOMA_TOTAL,AX
     
                INC BP
     
            LOOP SOMA
     
                MOV BL,NALUNOS
     
                MOV AX,SOMA_TOTAL
                DIV BL
     
                MOV MEDIA,AL 
                MOV RESTO_MEDIA,AH
     
            MOSTRAR_MEDIA:
    
                LEA DX, MSG_MEDIA
                MOV AH,09H
                INT 21H
                MOV BL,0AH
                MOV AX,0H
                 
                MOV AL,MEDIA
                DIV BL
                MOV BH,AH
                
                MOV DL,AL
                ADD DL,30H
                MOV AH,02H
                INT 21H
                
                MOV DL,BH
                ADD DL,30H
                MOV AH,02H
                INT 21H
        
                ;parte decimal
        
                MOV DL,02CH ;virgula
                MOV AH,02H
                INT 21H
                
                MOV DL,RESTO_MEDIA
                ADD DL,30H
                MOV AH,02H
                INT 21H 
             
        CALL ESPACO 
        CALL ENTER 
            
        RET     
    SOMA_MEDIA ENDP

;localizar
;ultizado para pesquisar um aluno 
;procurado pelo id



    
    LOCALIZAR PROC
        CALL SEPARADOR 
        
        LEA DX,MSG_PESQ_ALU2 
        MOV AH,09H
        INT 21H
        
        
        RECEBER_LOCALIZAR:
        
           CALL SEPARADOR
           CALL ESPACO
        
           LEA DX,MSG_LOCALIZAR
           MOV AH,09H

           INT 21H
         
           MOV BH,0AH
           MOV AH,01H
           INT 21H
 
            ;verificar digito 1
        

           CMP AL,30H
           JB  INVALIDO_LOCALIZAR
           
           CMP AL,31H
           JA INVALIDO_LOCALIZAR
           
           LIVRE_LOCALIZAR:
           
                MOV CL,AL ;guardar digito 1 em cl
           

                MOV AH,01H  ;receber segundo
                INT 21H
           
                CMP AL,30H
                JB  INVALIDO_LOCALIZAR
           
                CMP AL,39H
                JA INVALIDO_LOCALIZAR          
           
           
                CMP CL,31H
                JE  NUMERO10 
            
                CMP AL,30H
                JE INVALIDO_LOCALIZAR
            
        
                JMP LOCALIZAR_CONT
             
            NUMERO10:
                CMP AL,30H
                JNE INVALIDO_LOCALIZAR
            

            
            LOCALIZAR_CONT:
           
                MOV CH,AL
                
                SUB CL,30H 
                SUB CH,30H 
             
                MOV AL,CL
             
                MUL BH
             
                ADD AL,CH
           
                DEC AL   ;diminuir 1 do indice recebido

           
            MOV AH,0H 
            MOV BP,0H
            
            MOV BP,AX  ;colocar o indice inseriod em bp
           
            CALL ESPACO
           
            LEA DX,MSG_ALUN_PROCU 
            MOV AH,09H
            INT 21H
          
          MOSTRAR_LOCALIZADO :
             
            MOV BL,0AH
            MOV AX,0H
             
            MOV AL,NOTAS[BP] ;pegar a nota do indice dado
            DIV BL
            MOV BH,AH
            
            MOV DL,AL
            ADD DL,30H
            MOV AH,02H
            INT 21H
            
            MOV DL,BH
            ADD DL,30H
            MOV AH,02H
            INT 21H
             
            MOV AL,NOTAS[BP]
            CMP AL,0AH
            JB  REPROVOU
            
            
            LEA DX,MSG_APROVADO
            MOV AH, 09H 
            INT 21H
            JMP PEDIR_REPETIR
             
            REPROVOU:
             
                LEA DX,MSG_REPROVADO
                MOV AH,09H
                INT 21H
          
            PEDIR_REPETIR:   
             ;continuar ou nao
                CALL ESPACO    
                LEA DX,MSG_REPETIR
                MOV AH,09H
                INT 21H
                   
                MOV AH,01H
                INT 21H
             
            
                CMP AL,53H
                    JE  RECEBER_LOCALIZAR
                    
                CMP AL,73H
                    JE  RECEBER_LOCALIZAR
       
       
                JMP FIM_LOCALIZAR 
         
       INVALIDO_LOCALIZAR:
          CALL INVAL
          JMP RECEBER_LOCALIZAR
        
      FIM_LOCALIZAR: 
       
      RET  
    LOCALIZAR ENDP 




    
    
    MP_NOTAS_ALU PROC
        
        CALL MPNOTAS
        
        CALL SEPARADOR
        
        LEA DX,MSG_ETD_MP
        MOV AH,09H
        INT 21H
        
        CALL SEPARADOR
        
        
        CALL ESPACO
         
        LEA DX,MSG_NUMERO_BN 
        MOV AH,09H 
        INT 21H
        
        MOV BH,0H
        MOV BP,0H
        MOV AH,MELHOR_NOTA 
        MOV CX,0AH 
        
        PERCORE_LISTAB:               ;percorrer lista para encontrar o numero de melhores notas
            MOV AL,NOTAS[BP]
            INC BP
            
            CMP AH,AL
            JE INCREMENTAR 
            
            JMP FIM_PERCORE_LISTAB
        INCREMENTAR:
            INC BH
        
        FIM_PERCORE_LISTAB:
       LOOP PERCORE_LISTAB:
        
            
            CMP BH,0AH
            JE IGUAL10_NOTA
            MOV DL,BH
            ADD DL,30H
            MOV AH,02H
            INT 21H
            
            JMP IGUAL10_NOTA_FIM
             
            IGUAL10_NOTA: 

            MOV DL,31H
            MOV AH,02H
            INT 21H
         
            MOV DL,30H
            MOV AH,02H
            INT 21H   
             
            IGUAL10_NOTA_FIM:
             
            CALL ESPACO
                                 ;para pior nota     
        MOST_PIOR:
            LEA DX,MSG_NUMERO_WN 
            MOV AH,09H 
            INT 21H
            
            MOV BH,0H
            MOV BP,0H
            MOV AH,PIOR_NOTA
            MOV CX,0AH 
        
        PERCORE_LISTABW:
            MOV AL,NOTAS[BP]
            INC BP
            
            CMP AH,AL
            JE INCREMENTARBW 
        
            JMP FIM_PERCORE_LISTABW
        INCREMENTARBW:
           INC BH
        
        FIM_PERCORE_LISTABW:
        
       LOOP PERCORE_LISTABW:
        
           CMP BH,0AH
           JE IGUAL_10_NOTA
        
           MOV DL,BH
           ADD DL,30H
           MOV AH,02H
           INT 21H 
           
           
           JMP IGUAL_10_NOTA_FIM
             
            IGUAL_10_NOTA: 

            MOV DL,31H
            MOV AH,02H
            INT 21H
         
            MOV DL,30H
            MOV AH,02H
            INT 21H   
             
            IGUAL_10_NOTA_FIM:
           
           
            
           CALL ESPACO

        FIM_MP_NOTASALU:   
            CALL ENTER    
        
        RET    
    MP_NOTAS_ALU ENDP 
;id aprovados
;percore o vetor
;econtra aprovados
;mostra na tela

    
    ID_APROVADOS PROC 
        
        CALL SEPARADOR
        
        LEA DX,MSG_NUM
        MOV AH,09H
        INT 21H
        
        CALL SEPARADOR
        CALL ESPACO
        
        LEA DX,MSG_NUMPRO
        MOV AH,09H
        INT 21H
        
    
        MOV BP,0H
        
        MOV CX,NALUNOS
        
        PROCURAR_ID: 
        
            MOV BL,NOTAS[BP] 
         
            CMP BL,0AH    ;notas maiores igual 10 mostra id
            JAE EXIBIR_ID
         
            JMP ID_SEGUINTE 
         
         EXIBIR_ID:
         
            MOV ID_APROVADO,BP 
         
            MOV BX,ID_APROVADO 
                
            CMP BL,9H
                JE ID10
       
        
        
            MOV DX,ID_APROVADO
            INC DX
            ADD DL,30H
            MOV AH,02H
            INT 21H 
            
            MOV DL,2DH
            MOV AH,02H
            INT 21H 
            
            
            JMP ID_SEGUINTE 
        
            ID10:
                MOV DL,31H
                MOV AH,02H
                INT 21H
         
                MOV DL,30H
                MOV AH,02H
                INT 21H 
         
         
                MOV DL,2DH
                MOV AH,02H
                INT 21H 
         
            ID_SEGUINTE:;continuar 
                 INC BP  ;proximo elemento  
 
            LOOP  PROCURAR_ID  
            
             CALL ESPACO
               
            RET

         ID_APROVADOS ENDP
;verificar com turma
;ver se tem turma
;se tem nao faz nada
;se nao tem volta para inicio



         
         VERIFICAR_COM_TURMA   PROC
            
           
            CMP COM_TURMA,1H
              JNE  NAO_A_TURMA 
           
            JMP TEM_TURMA
           
           
            NAO_A_TURMA:
         
              CALL ESPACO
            
            LEA DX,MSG_COM_TURMA
            MOV AH,09H
            INT 21H
            
            CALL ESPACO
           
            CALL ENTER
           
            JMP INICIO 
           
            TEM_TURMA: 
            
       
            RET
         
         VERIFICAR_COM_TURMA ENDP
         
    
   INICIO:
           
        
        MOV AX,0H  
           
           
        CALL MENU 
        
        CALL LIMP
        
        
        
        CMP OPCAO,01H
            JE OP1
        
        CMP OPCAO,02H
            JE OP2 
        
        CMP OPCAO,03H
            JE OP3 
        
        CMP OPCAO,04H
            JE OP4 
            
        CMP OPCAO,05H
            JE OP5 
            
        CMP OPCAO,06H
            JE OP6 
            
        CMP OPCAO,07H
            JE OP7 
            
        CMP OPCAO,08H
            JE OP8 
            
        CMP OPCAO,09H
            JE OP9 
            
        CMP OPCAO,0AH
            JE OP10
        

        JMP FIM
        
        OP1:      ;registrar turma
            CALL RECEBER
            CALL ENTER
            JMP INICIO

        OP2:       ;ver maior e menor nota
             CALL VERIFICAR_COM_TURMA
             CALL MPNOTAS
             CALL MOSTRAR_MPNOTAS 
             JMP INICIO
        
        OP3:        ;numero estudantes com nota mais alta/baixa
        
            CALL VERIFICAR_COM_TURMA
            CALL MP_NOTAS_ALU    
            JMP INICIO
        
        OP4:        ;ver numero aprovados
             CALL VERIFICAR_COM_TURMA
             CALL QUANTA               ;
             JMP INICIO
             
        OP5:        ;fazer media da turma
             CALL VERIFICAR_COM_TURMA
             CALL SOMA_MEDIA           ;
             JMP  INICIO
        
        OP6:        ;mostrar id dos aprovados
              CALL VERIFICAR_COM_TURMA
              CALL ID_APROVADOS 
              CALL ENTER
              JMP  INICIO   
             
        OP7:        ;encontrar aluno
            CALL VERIFICAR_COM_TURMA
            CALL LOCALIZAR 
            CALL ENTER
            JMP INICIO
        
        OP8:       ;ordenar notas por ordem crescente
            CALL VERIFICAR_COM_TURMA
            CALL ORDENACAO 
            JMP INICIO
        
        OP9:       ;enviar lista das notas
             CALL VERIFICAR_COM_TURMA
             CALL MOSTRAR
             JMP INICIO

        OP10:       ;terminar
    
        
   FIM: 
    END
    



    
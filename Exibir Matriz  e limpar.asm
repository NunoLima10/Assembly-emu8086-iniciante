org 100h
.stack 64h
.data 

MsgEspaco Db "      Limpo            $" ;texto "limpo" e opcional


.code

inicio: 


Mov Cx,4Ah ;tamanho 7Ah-30h|ascii de  [z]-[0]
Mov Bh,30h ;onde comecar [0]
Mov Bl,0h  ;numero de caracteres na linha 

Exibir:

Mov Dl, Bh ; caracter a exibir
Mov Ah,02h
Int 21h
Inc BH     ;proximo caracter
Inc Bl     ;numero de caracteres na linha +1

Cmp Bl,10h ;se for fim da linha entao ir a proxima linha
JNE NoFinal

Mov Ah,02h
Mov Dl,0Ah
Int 21h
Mov Dl,0Dh
Int 21h 
Mov Bl,0h


NoFinal:


Loop Exibir


;limpar algum valor  que esteja la
Mov Ax,0h
Mov Bx,0h

;colocar cursor no inico da  pagina

Mov Ah,2h
Mov Dl,0h
Mov Dh,0h
Mov Bl,0h

Int 10h



Mov Cx, 5h ;numero de linhas a limpar
Mov Bl,0h  ;linha limpada    

Limpar:

 
Cmp  bl,1h 
Jne Seguir ;Nao limpou essa linha jne salta se nao e igual

;bp=1 ir a proxima linha
Mov Ah,02h
Mov Dl,0Ah
Int 21h
Mov Dl,0Dh
Int 21h



Seguir:  
;limpando linha
Mov Bl,0h
Lea Dx,MsgEspaco
Mov Ah,09h
Int 21h

Inc Bl

Loop Limpar














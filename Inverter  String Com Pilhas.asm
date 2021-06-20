org 100h
.Stack 64h
.data

MsgPedir Db 10d,13d,"Insira a fase:   $"

.code  

Inicio:

Mov Ah ,09h       ;msg 1
Lea Dx, MsgPedir
Int 21h


Mov Bl,0h ;numero de caracteres que inserir

Pedir:
Mov Ah,1h
Int 21h
       
Cmp Al, 0dh ;caso inserir enter 
JE Terminou       
;nao e enter
       
Mov Ah,0h ;limpar Ah  
Push Ax   ;colocar Ax na stack
Inc Bl    ;caracter +1

Jmp Pedir

Terminou:
;colocar em cl numero de caracteres inserido
Mov Cl,Bl

;linha seguinte
Mov Ah,02h
Mov Dl, 0Ah
Int 21h
Mov Dl,0dh
Int 21h
 
exibir:
Mov Ax,0h
Pop Ax ;pegando da stack e colocando em Ax
Mov Dl,Al
Mov Ah,02h
Int 21h


loop  exibir

;linha seguinte
Mov Ah,02h
Mov Dl, 0Ah
Int 21h
Mov Dl,0dh
Int 21h

Mov Ah,01h
Int 21h





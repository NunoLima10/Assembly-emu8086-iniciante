org 100h

.STACK 64h
.DATA

MsgPedir    Db 10d,13d,"Insira um  hexa (A-F): $"
MsgResposta Db 10d,13d,"Correspondente e: $"
MsgInvalido Db 10d,13d,"Invalido Repetir digite(s): $"
MsgRepetir  DB 10d,13d,"Repetir (s)$"
.CODE 


Jmp Inico



Trasformar Proc
    
Lea Dx,MsgPedir
Mov Ah,09h 
Int 21h


Mov Ah,1h
Int 21h
;guardar o caracter
Mov Bl, Al

;segunda mensagem 
Lea Dx,MsgResposta
Mov Ah,09h 
Int 21h



;exibir o primeiro 1 que sempre aparecera
Mov Ah,2h
Mov Dl,31h
Int 21h

;trasformar em hexa -31
;obter so o primeiro numero -10

Sub Bl, 41h

;Trasfromando em ascii  
Add Bl, 30h



;exibir 
Mov Ah,2h
Mov Dl,Bl
Int 21h

ret

Trasformar EndP  


Inico:

Call Trasformar



Repetir:
Lea Dx,MsgRepetir
Mov Ah,09h
Int 21h 

Mov Ah,01h
Int 21h


Cmp Al,73h ; para s
JE Aceito

Cmp Al,53h ; para S
JE Aceito 

Jmp Fim    ;nao aceito
Aceito:

Jmp Inico




Fim:

End



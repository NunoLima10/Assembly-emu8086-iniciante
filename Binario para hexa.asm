org 100h
.Stack 64h
.Data 

MsgPedir      Db 10d,13d, "Inisra o numero Binario(0-15): $"
Msgresultado  Db 10d,13d, "Resultado e: $"
MsgInvalido   Db 10d,13d, "Invalido  $"
MsgRepetir    Db 10d,13d, "Repedir digite (s)$"
;Var
Binario Db  4 d 


.Code 




Jmp Inicio 

Invalido:
Mov Ah,2h
Mov Dl,07h
Int 21h

Lea Dx,MsgInvalido 
Mov ah,09h
Int 21h

PedirRepetir:
Lea Dx,MsgRepetir 
Mov Ah,09h
Int 21h 

Mov Ah,01h
Int 21h

Cmp Al,53h  ;ascii de s
JE Repetir

Cmp Al,73h  ;ascii de S
Je Repetir

Jmp Fim

Repetir:

Call Inicio

Jmp Terminar

;==========================

Inicio Proc 
 ;Salvar endereco
 Lea Bp,Binario

 
;Contador    
Mov Cx,04h


  
;Imprimir Mensagem Pedir
 
Lea Dx, MsgPedir
Mov Ah,09h
Int 21h

;Pedir
Pedir:
Mov Ah,01h
Int 21h


;Comparacoes
Cmp Al,30h
Jb Invalido

Cmp Al,31h
Ja Invalido 

Sub Al,30h
;Valido entao guardar

Mov [Bp],Al
Inc Bp 
Loop Pedir 
;================== 




trasformar:
Lea Bp,Binario

;cl como acumulador
;bl para multiplicar

;Primeiro digito [0]000
Mov Bl,08h ;multiplicar por 2^3 
Mov Ax,00h


Mov Al,[Bp] 

Mul Bl

Mov Cl,Al
;Proximo endereco de memoria
Inc Bp ; 0[0]00 

Mov Bl,04h ;multiplicar por 2^2
Mov Ax,00h


Mov Al,[Bp]
Mul Bl
Add Cl,Al

;Proximo endereco de memoria
Inc Bp ; 00[0]0

Mov Bl,02h ;multiplicar por 2^1
Mov Ax,00h


Mov Al,[Bp]

Mul Bl
Add Cl,Al

;Proximo endereco de memoria
Inc Bp ; 000[0]

Mov Bl,01h ;multiplicar por 2^0
Mov Ax,00h


Mov Al,[Bp]
Mul Bl
Add Cl,Al

;proxima linha
Mov Ah,02h
Mov Dl,0Ah
Int 21h
Mov Dl,0Dh
Int 21h

Exibir:

Cmp Cl,9h
JA Maior


Add Cl,30h
Jmp MovtoDl


Maior:
Add Cl,37h;trasformar em ascii



MovtoDl: 
Mov Dl,Cl
Mov Ah,02h
Int 21h


Inicio  Endp 


Terminar: 
Jmp PedirRepetir



Fim:
End











 



   
    
    
    

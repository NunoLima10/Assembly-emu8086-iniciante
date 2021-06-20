.Model Small
.Stack 100h
.Data
 Msg1  Db 'Entre sua  letra minuscula$'
 Msg2  Db 'Em letra maiuscula ela fica:$'
 .Code
 Main Proc  
    ; Carregar endereco
    Mov Ax,@Data
    Mov Ds,Ax
    
    
    ; Exibir Msg 1
    Lea  Dx, Msg1
    
    Mov AH,9h
    Int 21h
     
    ;Trocar de linha 
    Mov Ah,2h
    Mov Dl,0Ah
    Int 21h
    
    Mov Dl ,0Dh
    Int 21h
    
    ; Pedir letra
    Mov Ah,1h
    Int 21h
    Mov  Bl,Al
    
    ;trocar linha
    Mov Ah,2h
    Mov Dl,0Ah
    Int 21h
    
    Mov Dl ,0Dh
    Int 21h
    
    
    ;exibir msg 2
    
    
    Lea dx, Msg2
    Mov Ah, 9
    Int 21h
    
    
    ; Trocar de linha
    Mov Ah,2h
    Mov Dl,0Ah
    Int 21h
    
    Mov Dl ,0Dh
    Int 21h
    
    ;Subtrair
    Sub Bl,20h ;transformando em minusculo
    Mov Ah, 2h
    Mov Dl, Bl
    Int 21h
     
     
     
     
    Mov Ah,4Ch
    Int  21h 
     
    Main Endp
    End Main
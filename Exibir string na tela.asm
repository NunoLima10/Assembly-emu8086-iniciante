.Model Small
.Stack 100h
.Data
 Msg Db 'Alo! Sou eu$'
 Msg2 Db 'Nuno$'
 .Code
 Main Proc
    
    Mov Ax,@Data   ;Colocando o endereco de memoria no Ax
    Mov Ds, Ax  ; 
    
    Lea Dx,Msg ; carregar os dados de msg em dx
    Mov Ah,9h   ;funcao para exibir string
    Int 21h
    
     Mov Ah,2h
     Mov Dl,0Dh
     Int 21h
      
     Mov Ah,2h
     Mov Dl,0Ah
     Int 21h
    
     
    Lea Dx,Msg2 
     
    Mov Ah,9
    Int 21h
     
    
    Mov Ah,4ch
    Int 21h
    Main Endp
    End Main
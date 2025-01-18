.model small
.stack 100h
.data  
                                                                                            
     display db 13,10,"                  <<<<<<<<<<<<< TIC TAC TOE >>>>>>>>>>>>>$"
     floor db 13,10, "  -------------$"
     row1 db 13,10,"  | 1 | 2 | 3 |$"      
     row2 db 13,10, "  | 4 | 5 | 6 |$"
     row3 db 13,10, "  | 7 | 8 | 9 |$" 
     input1 db 13,10,"Player 1,Enter : $"
     input2 db 13,10,"Player 2,Enter : $"
     error1 db 13,10,"ERROR! Player 1 Re-enter : $" 
     error2 db 13,10,"ERROR! Player 2 Re-enter : $" 
     same db 13,10,"Value Already Entered! Re-enter : $"
     covered_box db 0Ah, 0Bh, 0Ch, 0Dh, 0Eh, 0Fh, 0Ah, 0Bh, 0Ch 
     win1 db 13,10,"Player 1,wins!!! $"
     win2 db 13,10,"Player 2,wins!!!$"  
     tie db 13,10,"It's a draw! No winner this time.$"               
     
     



.code
main proc    
    
    mov ax,@data
    mov ds,ax
    
    
    board: 
    
    lea dx, display
    mov ah,09h
    int 21h
    lea dx,floor
    mov ah,09h
    int 21h 
    lea dx,row1
    mov ah,09h
    int 21h  
    lea dx,floor
    lea dx,row2
    mov ah,09h
    int 21h      
    lea dx,floor
    lea dx,row3
    mov ah,09h
    int 21h
    lea dx,floor
    mov ah,09h
    int 21h     
    
    
    
    part1:
    lea dx,input1
    mov ah,09h
    int 21h
    mov ah,01h
    int 21h  
    sub al,30h 
    mov bl,al
    
    
      
    encounter1:
    mov cl,09h
    mov si,offset covered_box
    looping:
    cmp bl,[si]
    je reenter 
    dec cl
    inc si 
    cmp cl,0h
    jnz looping    
    jmp direct
    
    
    reenter:  
    mov ah, 02h
    mov dl, 07h
    int 21h
    lea dx,same
    mov ah,09h
    int 21h
    mov ah,01h
    int 21h
    mov bl,al
    sub bl,30h
    jmp encounter1
    
    
    
    direct:
    cmp bl,01h
    jl read1
    cmp bl,09h
    jg read1  
    mov si, bx
    dec si 
    mov covered_box[si],bl    
    
    
    
    change1:
    cmp bl,01h
    je one 
    cmp bl,02h
    je two 
    cmp bl,03h
    je three 
    cmp bl,04h
    je four 
    cmp bl,05h
    je five 
    cmp bl,06h
    je six 
    cmp bl,07h
    je seven 
    cmp bl,08h
    je eight 
    cmp bl,09h
    je nine       
    
    one:
    mov row1[6],'X' 
    jmp display_mid      
    
    two:
    mov row1[10],'X'
    jmp display_mid
    
    three:
    mov row1[14],'X'
    jmp display_mid
    
    four:
    mov row2[6],'X'
    jmp display_mid
     
    five:
    mov row2[10],'X' 
    jmp display_mid
    
    six:
    mov row2[14],'X'
    jmp display_mid
    
    seven:
    mov row3[6],'X'  
    jmp display_mid
    
    eight:
    mov row3[10],'X' 
    
    jmp display_mid
   
    nine:
    mov row3[14],'X' 
     
    display_mid:
    lea dx,floor
    mov ah,09h
    int 21h 
    lea dx,row1
    mov ah,09h
    int 21h  
    lea dx,floor
    lea dx,row2
    mov ah,09h
    int 21h      
    lea dx,floor
    lea dx,row3
    mov ah,09h
    int 21h
    lea dx,floor
    mov ah,09h
    int 21h
      
    win_check1: 
    
    checkrow1:
    cmp row1[6],'X'
    jne checkrow2
    cmp row1[10],'X'
    jne checkrow2
    cmp row1[14],'X'
    jne checkrow2     
    jmp declare_winner1  
    
    checkrow2:
    cmp row2[6],'X'
    jne checkrow3
    cmp row2[10],'X'
    jne checkrow3
    cmp row2[14],'X'
    jne checkrow3     
    jmp declare_winner1
    
    checkrow3:
    cmp row3[6],'X'
    jne checkcol1
    cmp row3[10],'X'
    jne checkcol1
    cmp row3[14],'X'
    jne checkcol1     
    jmp declare_winner1 
    
    checkcol1: 
    
     cmp row1[6],'X'
    jne checkcol2
    cmp row2[6],'X'
    jne checkcol2
    cmp row3[6],'X'
    jne checkcol2     
    jmp declare_winner1 
    
    checkcol2:
    
     cmp row1[10],'X'
    jne checkcol3
    cmp row2[10],'X'
    jne checkcol3
    cmp row3[10],'X'
    jne checkcol3     
    jmp declare_winner1 
    
    checkcol3:
    
    cmp row1[14],'X'
    jne checkdiag1
    cmp row2[14],'X'
    jne checkdiag1
    cmp row3[14],'X'
    jne checkdiag1     
    jmp declare_winner1  
    
    checkdiag1: 
    
    cmp row1[6],'X'
    jne checkdiag2
    cmp row2[10],'X'
    jne checkdiag2
    cmp row3[14],'X'
    jne checkdiag2     
    jmp declare_winner1
    
    
    checkdiag2:  
    
    cmp row1[14],'X'
    jne checktie
    cmp row2[10],'X'
    jne checktie
    cmp row3[6],'X'
    jne checktie     
    jmp declare_winner1  
    
    
    
    win_check2: 
    
    checkrow1_:
    cmp row1[6],'O'
    jne checkrow2_
    cmp row1[10],'O'
    jne checkrow2_
    cmp row1[14],'O'
    jne checkrow2_     
    jmp declare_winner2 
    
    checkrow2_:
    cmp row2[6],'O'
    jne checkrow3_
    cmp row2[10],'O'
    jne checkrow3_
    cmp row2[14],'O'
    jne checkrow3_     
    jmp declare_winner2
    
    checkrow3_:
    cmp row3[6],'O'
    jne checkcol1_
    cmp row3[10],'O'
    jne checkcol1_
    cmp row3[14],'O'
    jne checkcol1_     
    jmp declare_winner2 
    
    checkcol1_: 
    
     cmp row1[6],'O'
    jne checkcol2_
    cmp row2[6],'O'
    jne checkcol2_
    cmp row3[6],'O'
    jne checkcol2_     
    jmp declare_winner2 
    
    checkcol2_:
    
     cmp row1[10],'O'
    jne checkcol3_
    cmp row2[10],'O'
    jne checkcol3_
    cmp row3[10],'O'
    jne checkcol3_     
    jmp declare_winner2 
    
    checkcol3_:
    
     cmp row1[14],'O'
    jne checkdiag1_
    cmp row2[14],'O'
    jne checkdiag1_
    cmp row3[14],'O'
    jne checkdiag1_     
    jmp declare_winner2  
    
    checkdiag1_: 
    
    cmp row1[6],'O'
    jne checkdiag2_
    cmp row2[10],'O'
    jne checkdiag2_
    cmp row3[14],'O'
    jne checkdiag2_     
    jmp declare_winner2
    
    
    checkdiag2_:  
    
    cmp row1[14],'O'
    jne checktie_
    cmp row2[10],'O'
    jne checktie_
    cmp row3[6],'O'
    jne checktie_     
    jmp declare_winner2    
    
    
    checktie:
    cmp row1[6],'1'  
    je part2
    jne next2 
    
    next2:
    cmp row1[10],'2'
    je part2
    jne next3
     
    next3:
    cmp row1[14],'3' 
    je part2
    jne next4
     
    next4:
    cmp row2[6],'4'
    je part2
    jne next5
     
    next5:
    cmp row2[10],'5'
    je part2
    jne next6
     
    next6:
    cmp row2[14],'6'
    je part2
    jne next7
     
    next7:
    cmp row3[6],'7' 
    je part2
    jne next8
     
    next8:
    cmp row3[10],'8'
    je part2
    jne next9 
    
    next9:
    cmp row3[14],'9'
    je part2
    jne draw
    
    
    draw:   
    lea dx, display
    mov ah,09h
    int 21h
    lea dx,floor
    mov ah,09h
    int 21h 
    lea dx,row1
    mov ah,09h
    int 21h  
      
    lea dx,floor
    lea dx,row2
    mov ah,09h
    int 21h      
       
    lea dx,floor
    lea dx,row3
    mov ah,09h
    int 21h
    lea dx,floor
    mov ah,09h
    int 21h     
    
    lea dx,tie
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h
    hlt 
    
    
    
  
    
    
    
    jmp part2   
    
    declare_winner1:
    lea dx,win1
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h
    hlt
    
    declare_winner2:
    lea dx,win2
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h
    hlt
    
    
    
    
    
    
    
    
    
    read1:
    mov ah, 02h
    mov dl, 07h
    int 21h 
    lea dx,error1
    mov ah,09h
    int 21h
    mov ah,01h
    int 21h
    mov bl,al
    sub bl,30h
    
    jmp direct2
    
    
    reenter2:
    mov ah, 02h
    mov dl, 07h
    int 21h 
    lea dx,same
    mov ah,09h
    int 21h
    mov ah,01h
    int 21h
    mov bl,al
    sub bl,30h
    jmp encounter2   
    
    direct2:
    cmp bl,01h
    jl read1
    cmp bl,09h
    jg read1 
    mov si, bx
    dec si
    mov covered_box[si],bl         
    jmp change1
    
    part2:
    lea dx,input2
    mov ah,09h
    int 21h
    mov ah,01h
    int 21h  
    sub al,30h 
    mov bl,al 
    
    encounter2:
    mov cl,09h
    mov si,offset covered_box
    looping_:
    cmp bl,[si]
    je reenter2 
    dec cl
    inc si 
    cmp cl,0h
    jnz looping_  
    
    
    cmp bl,01h
    jl read2
    cmp bl,09h
    jg read2 
    mov si, bx
    dec si 
    mov covered_box[si],bl              
    change2:
    cmp bl,01h
    je one_ 
    cmp bl,02h
    je two_ 
    cmp bl,03h
    je three_ 
    cmp bl,04h
    je four_ 
    cmp bl,05h
    je five_ 
    cmp bl,06h
    je six_ 
    cmp bl,07h
    je seven_ 
    cmp bl,08h
    je eight_ 
    cmp bl,09h
    je nine_       
    
    one_:
    mov row1[6],'O' 
    jmp win_check2      
    
     
    two_:
    mov row1[10],'O'
    jmp win_check2
    
    
    three_:
    mov row1[14],'O'
    jmp win_check2
    
    four_:
    mov row2[6],'O'
    jmp win_check2
     
    five_:
    mov row2[10],'O' 
    jmp win_check2
    
    six_:
    mov row2[14],'O'
    jmp win_check2
    
    seven_:
    mov row3[6],'O'  
    jmp win_check2
    
    eight_:
    mov row3[10],'O' 
    jmp win_check2
   
    nine_:
    mov row3[14],'O'
    jmp win_check2 
      
    
    checktie_:
    cmp row1[6],'1'
    je board
    jne next2_
    next2_:
    cmp row1[10],'2'
    je board
    jne next3_ 
    next3_:
    cmp row1[14],'3'
    je board
    jne next4_ 
    next4_:
    cmp row2[6],'4'
    je board
    jne next5_ 
    next5_:
    cmp row2[10],'5'
    je board
    jne next6_ 
    next6_:
    cmp row2[14],'6'
    je board
    jne next7_ 
    next7_:
    cmp row3[6],'7'
    je board
    jne next8_ 
    next8_:
    cmp row3[10],'8'  
    je board
    jne next9_ 
    next9_:
    cmp row3[14],'9' 
    je board
    jne draw  
     
    jmp board
    
    
    read2:
    mov ah, 02h
    mov dl, 07h
    int 21h 
    lea dx,error2
    mov ah,09h
    int 21h
    mov ah,01h
    int 21h
    mov bl,al
    sub bl,30h 
    jmp encounter2
    cmp bl,01h
    jl read2
    cmp bl,09h
    jg read2
    mov si, bx
    dec si 
    mov covered_box[si],bl 
    jmp change2   
    
    
   

    mov ah,4ch
    int 21h
              
    
    
    
    
    
    
    
    
 
main endp
end main

; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
.MODEL SMALL  
.STACK 100H
  
.DATA   
STRING1 DB 'EVEN NUMBER', '$'
STRING2 DB ' ODD NUMBER', '$'
 
.CODE  
MOV SI,2000H     
TEST [SI],0001H
JZ ODD         
LEA DX,STRING2
MOV AH,09H      
INT 21H
JMP OVER
ODD:LEA DX,STRING1
MOV AH,09H      
INT 21H
OVER:HLT  
ret





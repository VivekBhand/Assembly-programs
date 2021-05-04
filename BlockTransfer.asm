
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
; MIS: 111903129  
  
org 100h

MOV SI,1000H
MOV DI,2000H
MOV CL,05H

AGAIN:MOV AL,[SI]
MOV [DI],AL
INC SI
INC DI
DEC CL
JNZ AGAIN
HLT

ret





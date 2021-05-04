
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt


; Vivek Vishwanath Bhand
; MIS: 111903129

org 100h

; (a + b) * (c + d) 
; (16bit + 16bit) * (16bit + 16bit) = 32bit
  
; a AT 1000H
; b AT 2000H
; c AT 3000H
; d AT 4000H
; RESULT AT 7000H ONWARDS

MOV SI, 1000H
MOV DI, 2000H

MOV AX, [SI]
MOV BX, [DI]
ADD AX, BX
MOV SI, 5000H
MOV [SI], AX
          
          
MOV SI, 3000H
MOV DI, 4000H
MOV AX, [SI]
MOV BX, [DI]
ADD AX, BX
MOV SI, 6000H
MOV [SI], AX


MOV AX, [SI]
MOV DI, 5000H
MOV BX, [DI]
MUL BX

MOV SI, 7000H
MOV [SI], AX
MOV [SI+02], DX
HLT 

ret





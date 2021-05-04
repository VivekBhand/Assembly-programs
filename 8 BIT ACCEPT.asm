
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
              ;8 BIT ACCEPT PROCEDURE
MOV CH,02H
MOV CL,04H
MOV BL,00H
BACK : SHL BL,CL
MOV AH,01H   ; BOTH CAN TAKE INPUT
INT 21H      ; WILL ACCEPT INPUT FROM KEYBOARD
; MOV AH,01H IS FUNCTION TO ACCEPT KEY VALUE
; AND INT21 IS DOS INTRRUPT
; ACCEPTED VALUE IS IN AL
CMP AL,41H
JB DOWN
SUB AL,07H
DOWN : SUB AL,30H

ADD BL,AL
DEC CH
JNZ BACK
MOV A1,BL
 
ret





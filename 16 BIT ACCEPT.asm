
org 100h
              ;16 BIT ACCEPT PROCEDURE
MOV CH,02H
MOV CL,04H
MOV BX,0000H
BACK : SHL BX,CL
MOV AH,01H   ; BOTH CAN TAKE INPUT
INT 21H      ; WILL ACCEPT INPUT FROM KEYBOARD
; MOV AH,01H IS FUNCTION TO ACCEPT KEY VALUE
; AND INT21 IS DOS INTRRUPT
; ACCEPTED VALUE IS IN AL
MOV AH,00H
CMP AL,41H
JB DOWNP
SUB AL,07H
DOWNP : SUB AL,30H

ADD BX,AX
DEC CH
JNZ BACK
MOV A2,BX
; NO IS B1C2    






;*************************
;16 BIT DISPLAY

MOV CH,04H
MOV CL,04H
MOV BX,A2

AGAIN : ROL BX,CL
MOV DX,BX
AND DX,000FH
CMP DX,000AH

JB DOWN

ADD DX,07H

DOWN : ADD DX,0030H

MOV AH,02H
INT 21H

DEC CH
JNZ AGAIN

 
ret







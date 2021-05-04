
;NAME - VIVEK VISHWANATH BHAND
;MIS - 111903129
;DIV - 2
;BATCH - S3
;Assignment : Finding the 1's and 2's complement of a given number using dos interrupt

.8086
    .model small
    .stack
    .DATA

msgnum DB 0AH, 0DH, "Enter the number : $" 
msgc1 DB 0AH, 0DH, "One's complement of the given number is  : $"
msgc2 DB 0AH, 0DH, "Two's complement of the given number is : $"    
msgassm DB 0DH, "It is assumed that input and output both are hexadecimal. $"  
msgthx DB 0AH, 0DH, "Thank you !!! $"
MSSG_NL DB 10,13, "$"

    .CODE

MOV AX, @DATA
MOV DS,AX

LEA DX,msgassm
MOV AH,09H
INT 21H    
   
LEA DX,msgnum
MOV AH,09H
INT 21H    
   
CALL INPUT
MOV DH,BL
PUSH DX

CALL INPUT
POP DX
MOV DL,BL

MOV BX,0FFFFH
SUB BX,DX
PUSH BX

LEA DX,msgc1
MOV AH,09H
INT 21H   

POP BX   
MOV AL,BH
PUSH BX
CALL OUTPUT
POP BX
MOV AL,BL
PUSH BX
CALL OUTPUT   
   
POP BX
ADD BX,0001H
PUSh BX   
   
LEA DX,msgc2
MOV AH,09H
INT 21H   

POP BX   
MOV AL,BH
PUSH BX
CALL OUTPUT
POP BX
MOV AL,BL
PUSH BX
CALL OUTPUT   
   
LEA DX,msgthx
MOV AH,09H
INT 21H 
   
MOV AX,4C00H
INT 21H   
   
  
;----------------------------------------------------

INPUT PROC
    MOV BL,00H
    MOV CX,02H
    M2: MOV AH,01H
    INT 21H
    SHL BL,04H
    CMP AL,41H
    JB M1
    SUB AL,07H
    M1: SUB AL,30H
    ADD BL,AL
    LOOP M2
    INPUT ENDP
ret

;-----------------------------------------------------

OUTPUT PROC

    MOV CL,02H
    MOV BL,AL
    R1: ROL BL,04H
    MOV DX,BX
    AND DX,000FH
    CMP DX,0AH
    JB R2
    ADD DX,07H
    R2: ADD DX,30H
    MOV AH,02H
    INT 21H
    DEC CL
    JNZ R1
    ret
    OUTPUT ENDP
ret
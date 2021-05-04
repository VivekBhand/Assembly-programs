
.8086
    .model small
    .stack
    .DATA

msgnum DB 0AH, 0DH, "Enter the number : $" 
msgp DB 0AH, 0DH, "The number in entered format is a palindrome.$"
msgnp DB 0AH, 0DH, "The number in the entered format is not a palindrome.$"    
msgthx DB 0AH, 0DH, "Thank you !!! $"
MSSG_NL DB 10,13, "$"

    .CODE

MOV AX, @DATA
MOV DS,AX

MOV AH,09H
LEA DX,msgnum
INT 21H

;Taking input from user
XOR DX,DX
CALL INPUT
MOV DH,BL 
CALL INPUT
MOV DL,BL 
 
;Checking if is palindrome

;ENTERED NUMBER IS IN DX
PUSH DX
AND DH,0F0H
ROL DH,04H
AND DL,0FH
CMP DH,DL
JNZ IS_NOT_PALINDROME 
POP DX
AND DH,0FH
ROL DH,04H
AND DL,0F0H
CMP DH,DL
JNZ IS_NOT_PALINDROME  
 
 
 
IS_PALINDROME:
MOV AH,09H
LEA DX,msgp
INT 21H 
JMP END
 
IS_NOT_PALINDROME:
MOV AH,09H
LEA DX,msgnp 
INT 21H
 
END:
LEA DX,msgthx
INT 21H 
MOV AX, 4C00H
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
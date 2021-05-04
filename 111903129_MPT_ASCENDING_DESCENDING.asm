;NAME - VIVEK VISHWANATH BHAND
;MIS - 111903129
;DIV - 2
;BATCH - S3


.8086
.model small
    .stack
.DATA
ARRAY DB 13H, 45H,12H,88H, 07H
STM1 DB 0AH, 0DH, "THE GIVEN ARRAY IS: $"   
ASC1 DB 0AH, 0DH, "GIVEN ARRAY IN ASCENDING ORDER : $"
DSC1 DB 0AH, 0DH, "GIVEN ARRAY IN DESCENDING ORDER : $"
NL   DB 0AH,0DH,"$" 
SPACE DB " $"

    .CODE

MOV AX, @DATA
MOV DS,AX           

LEA DX,STM1
MOV AH,09H
INT 21H

CALL DISPLAY_ARRAY

;----------CODE FOR ASCENDING ORDER------------------

MOV CH, 04H  ;FOR OUTER LOOP
MOV CL, 04H  ;FOR INNER LOOP
LEA BX, ARRAY

LP1: LEA BX, ARRAY
MOV CL,CH
LP2:
MOV DH, [BX+01H]
CMP [BX],DH
JB NOSWAP 
MOV AL,[BX]
MOV [BX],DH
MOV [BX+01H],AL
NOSWAP:    
INC BX
DEC CL
JNZ LP2
DEC CH
JNZ LP1

LEA DX,ASC1
MOV AH,09H
INT 21H

CALL DISPLAY_ARRAY

LEA DX,DSC1
MOV AH,09H
INT 21H


;-----------CODE FOR DESCENDING ORDER------------------

MOV CH, 04H  ;FOR OUTER LOOP
MOV CL, 04H  ;FOR INNER LOOP
LEA BX, ARRAY

LP3: LEA BX,ARRAY
MOV CL,CH
LP4:
MOV DH, [BX+01H]
CMP [BX], DH
JNB NO_SWAP
MOV AL, [BX]
MOV [BX],DH
MOV [BX+01H],AL
NO_SWAP:
INC BX
DEC CL
JNZ LP4
DEC CH
JNZ LP3

CALL DISPLAY_ARRAY
















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

;----------------------------------------------------------

DISPLAY_ARRAY PROC
    

    MOV CX,05H
    LEA BX,ARRAY
    LOOP1: MOV AL,BYTE PTR[BX]
    PUSH BX 
    PUSH CX
    CALL OUTPUT 
    LEA DX,SPACE
    MOV AH,09H
    INT 21H
    POP CX    
    POP BX
    INC BX
    DEC CX        
    JNZ LOOP1    
    DISPLAY_ARRAY ENDP
ret

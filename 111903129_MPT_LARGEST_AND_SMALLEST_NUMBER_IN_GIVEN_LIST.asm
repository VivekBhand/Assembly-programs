
SHOW MACRO STR
    LEA DX,STR
    MOV AH,09H
    INT 21H
ENDM
                                     

.8086
.model small
.stack
.DATA

ARRAY DB 66H, 60H,21H,88H, 11H
STM1 DB 0AH, 0DH, "THE GIVEN ARRAY IS: $"   
LARGEST DB 0AH, 0DH, "LARGEST ELEMENT IN THE GIVEN ARRAY : $"
SMALLEST DB 0AH, 0DH, "SMALLEST ELEMENT IN THE GIVEN ARRAY : $"
NL   DB 0AH,0DH,"$" 
SPACE DB " $"

.CODE

MOV AX, @DATA
MOV DS,AX           

SHOW STM1
LEA BX, ARRAY

CALL DISPLAY_ARRAY 

LEA BX, ARRAY  
SHOW LARGEST
CALL FIND_GREATEST_ELEMENT

LEA BX, ARRAY
SHOW SMALLEST
CALL FIND_SMALLEST_ELEMENT  
 

MOV AX, 4C00H
INT 21H 
 


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


  
DISPLAY_ARRAY PROC
    MOV CX,05H
    MOV CX,05H
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



FIND_GREATEST_ELEMENT PROC
   MOV CX,04H
   MOV DL,BYTE PTR [BX]
   INC BX
   LOOP2:
   CMP DL,BYTE PTR[BX]
   JNB H
   MOV DL,BYTE PTR[BX]   
   H:
   INC BX
   DEC CX
   JNZ LOOP2         
   MOV AL, DL
   CALL OUTPUT
   FIND_GREATEST_ELEMENT ENDP
ret            



FIND_SMALLEST_ELEMENT PROC
   MOV CX,04H
   MOV DL,BYTE PTR [BX]
   INC BX
   LOOP3:
   CMP DL,BYTE PTR[BX]
   JB H1
   MOV DL,BYTE PTR[BX]   
   H1:
   INC BX
   DEC CX
   JNZ LOOP3         
   MOV AL, DL
   CALL OUTPUT
   FIND_SMALLEST_ELEMENT ENDP
ret                
; Problem: Write an assembly program to perform - (a + b) * (c + d) and (a * b) + (c * d)

; Vivek Vishwanath Bhand
; MIS: 111903129

org 100h

; FOR (a + b) * (c + d)
MOV SI, 2000H   ; DATA SEGMENT ADDRESS
MOV DS, SI      ; DS INITIALIZATION
MOV SI, 1000H   ; OFFSET OF a

XOR AX, AX      ; CLEAR AX

MOV AL, [SI]    ; 'a' number
MOV BL, [SI+1]  ; 'b' number
ADC AL, BL      ; (a + b)

XOR BX, BX      ; CLEAR BX
                           
MOV BL, [SI+2]  ; 'c' number
MOV DL, [SI+3]  ; 'd' number
ADC BL, DL      ; (c + d)

XOR DX, DX      ; CLEAR DX

MUL BL          ; (a + b) * (c + d)


MOV [SI+4], AH  ; MSB of Result (a + b) * (c + d) at 21004H LOCATION
MOV [SI+5], AL  ; LSB of Result (a + b) * (c + d) at 21005H LOCATION

;RESULT IS AT 21004H (MSB) AND 21005H (LSB) LOCATION 




; FOR (a * b) + (c * d)

XOR AX, AX
XOR BX, BX
XOR DX, DX

MOV SI, 0010H

MOV AL, [SI]     ; 'a' number
MOV BL, [SI+1]   ; 'b' number

MUL BL           ; (a * b)

MOV [SI], AH     ; MSB of (a * b) at 20010 LOCATION
MOV [SI+1], AL   ; LSB of (a * b) at 20011 LOCATION


XOR AX, AX       ; CLEAR AX
XOR BX, BX       ; CLEAR BX

MOV AL, [SI+2]   ; 'c' number
MOV BL, [SI+3]   ; 'd' number

MUL BL           ; (c * d)

; AH contains MSB of (c * d)
; AL contains LSB of (c * d)

MOV DH, [SI]    ; MSB of (a * b)
MOV DL, [SI+1]  ; LSB of (a * b)

ADC DX, AX      ; (a * b) + (c * d)

MOV [SI+4], DH  ; MSB of (a * b) + (c * d) at 20014 LOCATION
MOV [SI+5], DL  ; LSB of (a * b) + (c * d) at 20015 LOCATION 

;RESULT IS AT 21014H (MSB) AND 21015H (LSB) LOCATION


HLT

ret





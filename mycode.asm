
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV SI,04000H
MOV DS,SI           
MOV SI,04000H
MOV ES,SI
MOV BX,01000H
LES BX,[SI]
ADD BX,05H


HLT






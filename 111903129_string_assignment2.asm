
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt


;Vivek Bhand
;111903129
org 100h



;macro for printing a string
print macro m
mov ah,09h
mov dx,offset m
int 21h
endm

.model small


;******  Data Segment ******
.data

menu db 10,13, "Menu: "
     db 10,13, "1.Enter the string "
     db 10,13, "2.Change case "
     db 10,13, "3.Check for palindrome "
	 db 10,13, "4.Concatenate "
     db 10,13, "5.Exit  "
     db 10,13, "  "
     db 10,13, "Your choice: $"
msg1 db 10,13, "Your choice is: $"
mc1 db 10,13, "case 1 $"
mc2 db 10,13, "case 2 $"
mc3 db 10,13, "case 3 $"
mc4 db 10,13, "case 4 $"
mc5 db 10,13, "case 5 $"
mc6 db 10,13, "Exiting the program $"
mc7 db 10,13, "Invalid choice....try again $"
empty db 10,13, "   $"
str1 db 25,?,25 dup('$')
str2 db 25,?,25 dup('$')
len db ?
mstring db 10,13, "Enter the string: $"
notpalin db 10,13, "String is not a palindrome. $"
palin db 10,13, "String is a palindrome. $"
mstring2 db 10,13, "Enter second string: $"
mconcat db 10,13, "Concatenated string: $"
mscount db 10,13, "Number of spaces: $"
mlength db 10,13, "Length is: $"
cMSG1 DB 'ENTER A LOWER CASE LETTER $'
cMSG2 DB 0DH,0AH, 'IN UPPER CASE ITS IS: '
CHAR DB ?,'$'
scount db ?



;********** Code Segment ************

.code

start:
mov ax,@data
mov ds,ax

again:

print menu
call accept  ;accept user choice
mov bl,al


case1:

        cmp bl,"1"    ;compare user choice with '1'
        jne case2     ;if not equal,check for case 2

        print mc1           
		print empty         
		print mstring
        call accept_string   ;function call to accept a string

        mov cl,str1+1        ;storing length in cl
        mov bl,cl             
		print mlength       
        call display1        ;printing the length
		print empty
        jmp again            ;printing the menu again

case2:cmp bl,"2"  ;print user prompt
      jne case3
      print empty
      print cMSG1
	   print empty
		print mstring

            ;input a char and cover to upper case
      MOV AH,1            ;read character function
      INT 21H             ;read a small letter into AL
      SUB AL, 20H         ;convert it to upper case
      MOV CHAR, AL        ;and store it
        
      ;display on the next line
      LEA DX,cMSG2         ;get second message
      MOV AH,9            ;display message and uppercase
      INT 21H             ;letter in front
       
      jmp again





case3:  cmp bl,"3"         ;checking for case 4
        jne case4          ;if not equal jump to case 5
        print mc4
		print empty
		print mstring
        call accept_string
        

        mov si,offset str1
		mov cl,str1+1        ;store the length
		mov ch,00h
		mov len,cl
		inc si
		add si,cx            ;si points to last
		        
		mov di,offset str1   ;di to start of string
		add di,0002h         ;di to actual start of string;
		
		;in string 0th byte->size
		;          1st byte->length of string
        ;          from 2nd byte->actual string 		
         
		mov cl,len ;load counter
 cmpagain: mov al,[si]
           mov ah,[di]
		   inc di
		   dec si
           cmp al,ah
           jne nopalin
		   dec cl
		   jnz cmpagain
          	
		print palin
		print empty
        jmp again		
nopalin: print notpalin		
		print empty
        jmp again

case4: cmp bl,"4"       ;check for case 4
       jne case5        ;if not equal check for case 5
       print mc5 
	   print empty
	   
	   print mstring
	   call accept_string     
	   
	   ;storing string in str2
	   print mstring2
	   mov ah,0ah
	   lea dx,str2
	   int 21h
	   
 	   
	   mov cl,str1+1         ;length of string1 in cl
	   mov si,offset str1
next:  inc si
	   dec cl
	   jnz next
	   inc si
	   
	   inc si
	   mov di,offset str2
	   inc di
	   inc di
	   
	   
	   mov cl,str2+1
move_next:
     	   
	       mov al,[di]
	       mov [si],al
		   inc si
		   inc di
		   dec cl
		   jnz move_next
		   
		   print mconcat
		   print str1+2
		   print empty	   
	   
	   jmp again
	   
	   
case5: cmp bl,"5"     ;check for case 6
       jne case6      ;if not equal,default to case 7 and print the error message
	   print mc6
	   jmp exit
        	   
case6: print mc7   ;print error message
       jmp again   ;display the menu again

exit:
mov ah,4ch       ;exit the program
int 21h


;accept procedure

accept proc near

mov ah,01
int 21h
ret
accept endp

display1 proc near

   mov al,bl
   mov bl,al
   and al,0f0h
   mov cl,04
   rol al,cl

   cmp al,09
   jbe number
   add al,07
number:  add al,30h
         mov dl,al
         mov ah,02
         int 21h

         mov al,bl
         and al,00fh
         cmp al,09
         jbe number2
         add al,07
number2:  add al,30h
          mov dl,al
          mov ah,02
          int 21h
ret
display1 endp



accept_string proc near

mov ah,0ah          ;accept string from user function
mov dx,offset str1  ; store the string in memory pointed by "DX"
int 21h
ret
accept_string endp

end start
end

ret





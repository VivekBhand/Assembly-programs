
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

   
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.model small
.data
 	msg1 db 10,13,"enter the First no:$"
 	msg2 db 10,13,"enter the second no :$"
 	msg3 db 10,13,"Result is :$"
 	a1 db 00h
 	a2 db 00h
 	res db 00h

.code
    mov ax,@data  ;initialising data segment
    mov ds,ax

    mov ah,09h
    lea dx,msg1
    int 21h

    call input
    mov a1,bl

    mov ah,09h
    lea dx,msg2
    int 21h

    call input
    mov a2, bl

    mov ah,09h
    lea dx,msg3
    int 21h

  
    call perform

    call disp

    mov ah,4ch
    int 21h

    input  proc
	mov ch,02h
     	mov cl,04h
     	mov bl,00h
      m3: 
	shl bl,cl
     	mov ah,01h
     	int 21h
     	cmp al,41h
     	jb m4
     	sub al,07h
     m4:
	sub al,30h
     	add bl,al
     	dec ch
     	jnz m3
     	ret
    input  endp

    perform proc 		;perform addition
    		mov ah,00h
    		mov al,a1
    		mov bl,a2
    		div bl
    		mov res,al
    		ret
    perform endp


	disp proc  		;procedure to display
		mov cl,04h
		mov ch,02h
		mov bl,res
	     r1: 
		rol bl,cl
    		mov dl,bl
    		and dl,0fh
    		cmp dl,0Ah
    		jb r2
    		add dl,07h
	     r2: 
		add dl,30h
    		mov ah,02h
    		int 21h
    		dec ch
    		jnz r1
    		ret
	disp  endp
end



ret






ret





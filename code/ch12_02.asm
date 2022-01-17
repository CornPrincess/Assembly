assume cs:code

code segment
start: ; copy interrupt program source code to memory
       mov ax,cs
       mov ds,ax
       mov si,offset do0 ; set source code address

       mov ax,0
       mov es,ax
       mov di,200h ; set target code address

       mov cx,offset do0end - offset do0

       cld ; set transform direction
       rep movsb ; copy

       ; set interrupt table
       mov ax,0
       mov es,ax
       mov word ptr es:[0*4],200h
       mov word ptr es:[0*4+2],0
       mov ax,4c00h
       int 21h

do0: jmp short do0start
     db "overflow!"
do0start: 
     ; show overflow!
     ; set ds:si refer to string address
     mov ax,cs
     mov ds,ax
     mov si,202h
     ; set es:di refer to graphic memory address
     mov ax,0b800h
     mov es,ax
     mov di,12*160+36*2

     mov cx,9 ; set string length
  s: mov al,[si]
     mov es:[di], al
     inc si
     add di,2
     loop s

     mov ax,4c00h
     int 21h

do0end: nop
code ends

end start
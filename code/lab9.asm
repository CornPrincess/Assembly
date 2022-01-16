assume cs:codesg

codesg segment
start: mov ax,0b800h
       mov ds,ax

       mov cx,40
       mov bx,1664
       s: mov al,41h
          mov ah,02h
          mov ds:[bx],ax
          add bx,2
       loop s

       mov ax,4c00h
       int 21h
codesg ends

end start
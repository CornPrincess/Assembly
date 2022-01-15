assume cs:code

a segment
    db 1,2,3,4,5,6,7,8
a ends

b segment
    db 1,2,3,4,5,6,7,8
b ends

c segment
    db 0,0,0,0,0,0,0,0
c ends

code segment
    start: mov cx,8
           mov bx,0
           mov ax,a
           mov ds,ax
           mov ax,b
           mov es,ax
           mov ax,c
           mov ss,ax
           s: mov al,ds:[bx]
              add al,es:[bx]
              mov ss:[bx],al
              inc bx
            loop s
            mov ax,4c00h
            int 21h
code ends

end start
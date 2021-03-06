assume cs:codesge,ss:stacksg,ds:datasg

stacksg segment
    dw 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
datasg ends

codesge segment ;076f
    start: mov ax,stacksg ;076a
           mov ss,ax
           mov sp,16

           mov ax,datasg ;076b
           mov ds,ax
           mov bx,0
           mov cx,4

           s0: push cx
               mov cx,3
               mov si,0

            s1: mov al,[bx+si+3]
                and al,11011111b
                mov [bx+si+3],al
                inc si
            loop s1

            add bx,16
            pop cx
            loop s0

            mov ax,4c00h
            int 21h ;076f:002e
codesge ends

end start
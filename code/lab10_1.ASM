assume cs:code, ss:stack

stack segment
    dw 16 dup (0)
stack ends

data segment
    db 'Welcome to masm!', 0
data ends

code segment
start:  mov dh, 8 ; row
        mov dl, 3 ; column
        mov cl, 2 ; color
        mov ax, data
        mov ds, ax
        mov ax, stack
        mov ss, ax
        mov sp, 32
        mov si, 0
        call show_str

        mov ax, 4c00h
        int 21h

show_str:
        ; saving cx, bx, ax, si, di, es
        push cx
        push bx
        push ax
        push si
        push di
        push es
        
        ; process
        mov ax,0b800h
        mov es,ax
        mov bx,0
        mov di,0
        mov al,160
        mul dh
        add bx,ax
        mov al,2
        mul dl
        add bx,ax ; bx stores address of  start character
        mov al,cl ; al stores the color of character

char: 
        mov ch,0
        mov cl,ds:[si]
        jcxz zero
        mov ch,al
        mov es:[bx+di],cx
        add di,2
        inc si
        jmp char
zero:
        ; recover
        pop di
        pop si
        pop ax
        pop bx
        pop cx
        ret
code ends

end start